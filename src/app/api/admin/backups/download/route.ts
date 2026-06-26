import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import fs from "fs";
import path from "path";

const BACKUPS_DIR = path.join(process.cwd(), "backups");

export async function GET(req: Request) {
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
        
        if (!fs.existsSync(filePath)) {
            return NextResponse.json({ error: "File not found" }, { status: 404 });
        }

        const stat = fs.statSync(filePath);
        const stream = fs.createReadStream(filePath);

        // Convert Node.js Readable stream to Web ReadableStream
        const webStream = new ReadableStream({
            start(controller) {
                stream.on('data', (chunk) => controller.enqueue(chunk));
                stream.on('end', () => controller.close());
                stream.on('error', (err) => controller.error(err));
            }
        });

        return new NextResponse(webStream, {
            headers: {
                "Content-Disposition": `attachment; filename="${filename}"`,
                "Content-Type": "application/gzip",
                "Content-Length": stat.size.toString(),
            },
        });
    } catch (error: any) {
        return NextResponse.json({ error: "Failed to download backup: " + error.message }, { status: 500 });
    }
}
