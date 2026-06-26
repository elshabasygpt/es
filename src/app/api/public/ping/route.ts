import { NextResponse } from "next/server";
import { outboxWorker } from "@/lib/reliability/outbox-worker";
import { logger } from "@/lib/logger";

/**
 * Enterprise Cold Start Mitigation & Cron Worker Trigger
 * Designed to be called by an external CRON job (e.g., UptimeRobot, Vercel Cron)
 * every 1-5 minutes to keep the Container warm AND process background DB jobs.
 */
export async function GET() {
    try {
        // Asynchronously process background DB queues (Fire and Forget)
        outboxWorker.processQueue(20).catch(err => {
            logger.error({ message: "Cron Worker failed", error: err });
        });
    } catch (e) {}

    return NextResponse.json({ 
        status: "alive", 
        timestamp: new Date().toISOString(),
        message: "Pong! Container is warm and Worker triggered." 
    });
}
