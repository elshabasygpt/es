"use client";

import React from "react";
import { motion, type Variants } from "framer-motion";

interface ScrollRevealProps {
    children: React.ReactNode;
    className?: string;
    delay?: number;
    duration?: number;
    direction?: "up" | "down" | "left" | "right";
    once?: boolean;
}

const getVariants = (direction: string): Variants => {
    const offsets: Record<string, { x: number; y: number }> = {
        up: { x: 0, y: 24 },
        down: { x: 0, y: -24 },
        left: { x: 24, y: 0 },
        right: { x: -24, y: 0 },
    };
    const { x, y } = offsets[direction] || offsets.up;

    return {
        hidden: { opacity: 0, x, y },
        visible: { opacity: 1, x: 0, y: 0 },
    };
};

export const ScrollReveal: React.FC<ScrollRevealProps> = ({
    children,
    className,
    delay = 0,
    duration = 0.45,
    direction = "up",
    once = true,
}) => {
    return (
        <motion.div
            className={className}
            initial="hidden"
            whileInView="visible"
            viewport={{ once, margin: "0px 0px -40px 0px" }}
            variants={getVariants(direction)}
            transition={{
                duration,
                delay,
                ease: [0.25, 0.1, 0.25, 1],
            }}
        >
            {children}
        </motion.div>
    );
};

interface StaggerContainerProps {
    children: React.ReactNode;
    className?: string;
    staggerDelay?: number;
    once?: boolean;
}

export const StaggerContainer: React.FC<StaggerContainerProps> = ({
    children,
    className,
    staggerDelay = 0.1,
    once = true,
}) => {
    return (
        <motion.div
            className={className}
            initial="hidden"
            whileInView="visible"
            viewport={{ once, margin: "-60px" }}
            variants={{
                hidden: {},
                visible: {
                    transition: {
                        staggerChildren: staggerDelay,
                    },
                },
            }}
        >
            {children}
        </motion.div>
    );
};

interface StaggerItemProps {
    children: React.ReactNode;
    className?: string;
}

export const StaggerItem: React.FC<StaggerItemProps> = ({
    children,
    className,
}) => {
    return (
        <motion.div
            className={className}
            variants={{
                hidden: { opacity: 0, y: 30 },
                visible: {
                    opacity: 1,
                    y: 0,
                    transition: { duration: 0.5, ease: [0.25, 0.1, 0.25, 1] },
                },
            }}
        >
            {children}
        </motion.div>
    );
};
