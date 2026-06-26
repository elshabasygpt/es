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

// Helper to ensure backups directory exists
async function ensureBackupsDir() {
    try {
        await fs.access(BACKUPS_DIR);
    } catch {
        await fs.mkdir(BACKUPS_DIR, { recursive: true });
    }
}

export async function GET(req: Request) {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SUPER_ADMIN")) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 403 });
    }

    try {
        await ensureBackupsDir();
        const files = await fs.readdir(BACKUPS_DIR);
        const backups = [];

        for (const file of files) {
            if (file.endsWith(".tar.gz")) {
                const stat = await fs.stat(path.join(BACKUPS_DIR, file));
                backups.push({
                    name: file,
                    size: stat.size,
                    createdAt: stat.birthtime,
                });
            }
        }

        // Sort newest first
        backups.sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime());

        return NextResponse.json(backups);
    } catch (error: any) {
        return NextResponse.json({ error: "Failed to list backups: " + error.message }, { status: 500 });
    }
}

export async function POST(req: Request) {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SUPER_ADMIN")) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 403 });
    }

    try {
        await ensureBackupsDir();
        
        const timestamp = new Date().toISOString().replace(/[:.]/g, "-");
        const tmpDirName = `tmp_backup_${timestamp}`;
        const tmpDirPath = path.join(BACKUPS_DIR, tmpDirName);
        const finalBackupName = `backup_${timestamp}.tar.gz`;
        const finalBackupPath = path.join(BACKUPS_DIR, finalBackupName);
        
        // 1. Create temporary directory
        await fs.mkdir(tmpDirPath, { recursive: true });

        // 2. Dump Database
        const dbUrl = process.env.DATABASE_URL;
        if (!dbUrl) throw new Error("DATABASE_URL is not set.");
        
        const dbDumpPath = path.join(tmpDirPath, "database.dump");
        // We use Custom format (-Fc) which is recommended for pg_restore
        await execPromise(`pg_dump "${dbUrl}" -F c -f "${dbDumpPath}"`);

        // 3. Copy Uploads (if exists)
        const tmpUploadsPath = path.join(tmpDirPath, "uploads");
        try {
            await fs.access(UPLOADS_DIR);
            // using cp -r for linux/mac compatibility
            await execPromise(`cp -r "${UPLOADS_DIR}" "${tmpUploadsPath}"`);
        } catch (e) {
            console.log("No uploads directory found, skipping uploads backup.");
        }

        // 4. Compress into tar.gz
        // Run tar command. -C changes directory to tmpDirPath before archiving.
        await execPromise(`tar -czvf "${finalBackupPath}" -C "${tmpDirPath}" .`);

        // 5. Cleanup temporary directory
        await fs.rm(tmpDirPath, { recursive: true, force: true });

        return NextResponse.json({ success: true, message: "Backup created successfully", filename: finalBackupName });
    } catch (error: any) {
        console.error("Backup creation failed:", error);
        return NextResponse.json({ error: "Failed to create backup: " + error.message }, { status: 500 });
    }
}

export async function DELETE(req: Request) {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SUPER_ADMIN")) {
        return NextResponse.json({ error: "Unauthorized" }, { status: 403 });
    }

    try {
        const { searchParams } = new URL(req.url);
        const filename = searchParams.get("file");

        if (!filename || !filename.endsWith(".tar.gz")) {
            return NextResponse.json({ error: "Invalid filename" }, { status: 400 });
        }

        const filePath = path.join(BACKUPS_DIR, filename);
        await fs.unlink(filePath);

        return NextResponse.json({ success: true, message: "Backup deleted" });
    } catch (error: any) {
        return NextResponse.json({ error: "Failed to delete backup: " + error.message }, { status: 500 });
    }
}
