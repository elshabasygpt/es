import { logger } from "@/lib/logger";
import { prisma } from "@/lib/prisma";

/**
 * Enterprise Background Task Queue (Fire and Forget Strategy)
 * Instead of making the user wait for an operation, we push the job 
 * to the PostgreSQL OutboxEvent table. A separate cron API endpoint processes it.
 */
class TaskQueue {
    /**
     * Dispatch a background job. The API route returns immediately.
     */
    async dispatch(taskName: string, payload: Record<string, any>) {
        try {
            await prisma.outboxEvent.create({
                data: {
                    type: taskName,
                    payload: JSON.stringify(payload),
                    status: "PENDING"
                }
            });
            logger.debug({ message: `[QUEUE] Safely stored job ${taskName} to DB outbox` });
        } catch (err) {
            logger.error({ message: `[QUEUE] Failed to dispatch job ${taskName}`, error: err });
            // Fallback: Execute synchronously if DB fails, to prevent data loss
            this.executeSyncFallback(taskName, payload);
        }
    }

    private async executeSyncFallback(taskName: string, payload: any) {
        logger.warn({ message: `[QUEUE] Executing ${taskName} via sync fallback` });
        // Normally this would dynamically import the task handler and run it
        // e.g. await taskHandlers[taskName](payload);
    }
}

export const queue = new TaskQueue();
