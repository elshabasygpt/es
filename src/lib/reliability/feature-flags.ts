import { logger } from "@/lib/logger";

/**
 * Enterprise Feature Flag Manager (Graceful Degradation)
 * Allows turning off heavy or non-critical features instantly.
 * Note: On cPanel shared hosting, this uses an in-memory fallback.
 * For persistent flags without Redis, you can query a Database table here.
 */
class FeatureFlagManager {
    private cache = new Map<string, boolean>();

    async isEnabled(flagName: string, fallback = true): Promise<boolean> {
        if (this.cache.has(flagName)) {
            return this.cache.get(flagName)!;
        }

        // Without Redis, we simply rely on the default fallback provided by the caller
        // (Or query the database if a FeatureFlag table is created).
        this.cache.set(flagName, fallback);
        return fallback;
    }

    // Ability to toggle flags in-memory via an admin API route
    setFlag(flagName: string, value: boolean) {
        this.cache.set(flagName, value);
    }
}

export const flags = new FeatureFlagManager();
