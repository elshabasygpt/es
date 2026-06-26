import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { googleDriveService } from "@/lib/backup/google-drive.service";
import path from "path";
import fs from "fs/promises";
import { prisma } from "@/lib/prisma";

const BACKUPS_DIR = path.join(process.cwd(), "backups");

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

        const filePath = path.join(BACKUPS_DIR, filename);

        try {
            await fs.access(filePath);
        } catch {
            return NextResponse.json({ error: "Backup file not found" }, { status: 404 });
        }

        // Fetch custom folder ID from settings if available
        const settings = await prisma.siteSettings.findFirst();
        const customFolderId = settings?.googleDriveFolderId;

        // Call the Google Drive service to upload the file
        const driveLink = await googleDriveService.uploadBackup(filePath, filename, customFolderId);

        return NextResponse.json({ 
            success: true, 
            message: "Backup uploaded to Google Drive successfully",
            link: driveLink 
        });

    } catch (error: any) {
        console.error("Drive upload failed:", error);
        return NextResponse.json({ error: "Failed to upload to Google Drive: " + error.message }, { status: 500 });
    }
}
