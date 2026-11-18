#!/usr/bin/env node
// Shrinks oversized raster images in place (same path + format, so DB/CMS URLs keep working).
// Usage: node scripts/optimize-images.mjs [dir ...]   (default: public/uploads public/images)
// Optional: BACKUP_DIR=/path keeps a copy of every original it replaces.
import fs from "node:fs/promises";
import path from "node:path";
import sharp from "sharp";

const MAX_WIDTH = 1920;
const MIN_BYTES = 200 * 1024; // leave already-small files alone
const dirs = process.argv.slice(2).length ? process.argv.slice(2) : ["public/uploads", "public/images"];
const backupDir = process.env.BACKUP_DIR;

async function* walk(dir) {
    for (const entry of await fs.readdir(dir, { withFileTypes: true })) {
        const p = path.join(dir, entry.name);
        if (entry.isDirectory()) yield* walk(p);
        else yield p;
    }
}

let before = 0, after = 0, changed = 0;
for (const dir of dirs) {
    try { await fs.access(dir); } catch { continue; }
    for await (const file of walk(dir)) {
        const stat = await fs.stat(file);
        if (stat.size < MIN_BYTES) continue;
        let meta;
        try { meta = await sharp(file).metadata(); } catch { continue; }
        if (!["jpeg", "png", "webp"].includes(meta.format) || (meta.pages ?? 1) > 1) continue;

        let img = sharp(file).rotate().resize({ width: MAX_WIDTH, withoutEnlargement: true });
        if (meta.format === "jpeg") img = img.jpeg({ quality: 80, mozjpeg: true, progressive: true });
        else if (meta.format === "webp") img = img.webp({ quality: 80 });
        else img = img.png({ palette: true, quality: 90, effort: 10, compressionLevel: 9 });

        const out = await img.toBuffer();
        if (out.length >= stat.size * 0.9) continue; // not worth it

        if (backupDir) {
            const dest = path.join(backupDir, file);
            await fs.mkdir(path.dirname(dest), { recursive: true });
            await fs.copyFile(file, dest).catch(() => {});
        }
        await fs.writeFile(file, out);
        before += stat.size; after += out.length; changed++;
        console.log(`${file}: ${(stat.size / 1024).toFixed(0)}KB -> ${(out.length / 1024).toFixed(0)}KB`);
    }
}
console.log(`\nOptimized ${changed} files: ${(before / 1048576).toFixed(1)}MB -> ${(after / 1048576).toFixed(1)}MB`);
