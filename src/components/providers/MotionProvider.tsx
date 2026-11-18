"use client";

import { MotionConfig } from "framer-motion";
import { useEffect, useState } from "react";

/** Phones get opacity-only animations (no transforms); larger screens respect the OS "reduce motion" setting. */
export function MotionProvider({ children }: { children: React.ReactNode }) {
    const [reduce, setReduce] = useState<"user" | "always">("user");

    useEffect(() => {
        const mq = window.matchMedia("(max-width: 767px)");
        const update = () => setReduce(mq.matches ? "always" : "user");
        update();
        mq.addEventListener("change", update);
        return () => mq.removeEventListener("change", update);
    }, []);

    return <MotionConfig reducedMotion={reduce}>{children}</MotionConfig>;
}
