import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import fs from "fs/promises";
import path from "path";
import { exec } from "child_process";
import util from "util";

const execPromise = util.promisify(exec);
const BACKUPS_DIR = path.join(process.cwd(), "backups");
const UPLOADS_DIR = path.join(process.cwd(), "public", "uploads");

export async function POST(req: Request) {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SUPER_ADMIN")) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 403 });
    }

    try {
        const body = await req.json();
        const { filename } = body;

        if (!filename || !filename.endsWith(".tar.gz")) {
            return NextResponse.json({ error: "Invalid filename" }, { status: 400 });
        }

        const backupPath = path.join(BACKUPS_DIR, filename);
        
        try {
            await fs.access(backupPath);
        } catch {
            return NextResponse.json({ error: "Backup file not found" }, { status: 404 });
        }

        const tmpDirName = `tmp_restore_${Date.now()}`;
        const tmpDirPath = path.join(BACKUPS_DIR, tmpDirName);
        
        // 1. Create temporary directory and extract backup
        await fs.mkdir(tmpDirPath, { recursive: true });
        await execPromise(`tar -xzvf "${backupPath}" -C "${tmpDirPath}"`);

        // 2. Restore Database
        const dbUrl = process.env.DATABASE_URL;
        if (!dbUrl) throw new Error("DATABASE_URL is not set.");
        
        const dbDumpPath = path.join(tmpDirPath, "database.dump");
        try {
            await fs.access(dbDumpPath);
            // Run pg_restore with --clean to drop existing objects before recreating them
            console.log("Restoring database...");
            await execPromise(`pg_restore --clean --if-exists -d "${dbUrl}" "${dbDumpPath}"`);
            console.log("Database restored successfully.");
        } catch (e) {
            console.log("No database dump found in backup or restore failed.", e);
            throw new Error("Failed to restore database: " + (e as Error).message);
        }

        // 3. Restore Uploads
        const tmpUploadsPath = path.join(tmpDirPath, "uploads");
        try {
            await fs.access(tmpUploadsPath);
            console.log("Restoring uploads...");
            
            // Ensure uploads directory exists
            try { await fs.access(UPLOADS_DIR); } catch { await fs.mkdir(UPLOADS_DIR, { recursive: true }); }
            
            // Remove existing uploads
            await execPromise(`rm -rf "${UPLOADS_DIR}/"*`);
            
            // Copy from backup
            await execPromise(`cp -a "${tmpUploadsPath}/"* "${UPLOADS_DIR}/" || true`);
            console.log("Uploads restored successfully.");
        } catch (e) {
            console.log("No uploads directory found in backup, skipping uploads restore.");
        }

        // 4. Cleanup temporary directory
        await fs.rm(tmpDirPath, { recursive: true, force: true });

        return NextResponse.json({ success: true, message: "Backup restored successfully. Data and files have been reverted." });
    } catch (error: any) {
        console.error("Restore failed:", error);
        return NextResponse.json({ error: "Failed to restore backup: " + error.message }, { status: 500 });
    }
}
