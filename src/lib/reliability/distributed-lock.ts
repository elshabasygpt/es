import { logger } from "@/lib/logger";
import crypto from "crypto";

export class DistributedLock {
    private locks = new Map<string, { token: string, expiresAt: number }>();

    async acquire(lockKey: string, ttlSeconds = 10): Promise<string | null> {
        const token = crypto.randomUUID();
        const now = Date.now();
        
        const existing = this.locks.get(lockKey);
        
        // If lock exists and hasn't expired, deny
        if (existing && existing.expiresAt > now) {
            return null;
        }

        // Clean up expired locks implicitly by overriding
        this.locks.set(lockKey, {
            token,
            expiresAt: now + (ttlSeconds * 1000)
        });
        
        return token;
    }

    async extend(lockKey: string, token: string, extraTtlSeconds: number): Promise<boolean> {
        const existing = this.locks.get(lockKey);
        const now = Date.now();
        
        if (existing && existing.token === token && existing.expiresAt > now) {
            existing.expiresAt += (extraTtlSeconds * 1000);
            return true;
        }
        
        return false;
    }

    async release(lockKey: string, token: string): Promise<boolean> {
        const existing = this.locks.get(lockKey);
        
        if (existing && existing.token === token) {
            this.locks.delete(lockKey);
            return true;
        }
        
        return false;
    }
}

export const lockManager = new DistributedLock();
