"use client";

import React, { useEffect, useRef, useState } from "react";
import "leaflet/dist/leaflet.css";

const statusColors: Record<string, string> = {
    ACTIVE: "#22c55e",
    NEGOTIATION: "#3b82f6",
    INACTIVE: "#ef4444",
    LEAD: "#f59e0b",
};

const statusLabels: Record<string, string> = {
    ACTIVE: "دائم",
    NEGOTIATION: "مفاوضة",
    INACTIVE: "غير نشط",
    LEAD: "محتمل",
};

export default function MapComponent({ clients }: { clients: any[] }) {
    const containerRef = useRef<HTMLDivElement>(null);
    const mapInstanceRef = useRef<any>(null);

    useEffect(() => {
        // Only run on client
        if (typeof window === "undefined" || !containerRef.current) return;

        // Dynamically import leaflet to avoid SSR issues
        import("leaflet").then((L) => {
            // If there's already a map on this container, remove it first
            if (mapInstanceRef.current) {
                mapInstanceRef.current.remove();
                mapInstanceRef.current = null;
            }

            const center: [number, number] = clients.length > 0
                ? [
                    clients.reduce((s, c) => s + c.lat, 0) / clients.length,
                    clients.reduce((s, c) => s + c.lng, 0) / clients.length,
                ]
                : [30.0444, 31.2357];

            const map = L.map(containerRef.current!, {
                center,
                zoom: clients.length === 1 ? 14 : 7,
                zoomControl: true,
            });

            mapInstanceRef.current = map;

            L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
            }).addTo(map);

            const bounds = L.latLngBounds([]);

            clients.forEach((client) => {
                const color = statusColors[client.status] || "#6b7280";
                const position: [number, number] = [client.lat, client.lng];
                bounds.extend(position);

                const icon = L.divIcon({
                    html: `<div style="
                        width: 32px; height: 32px; border-radius: 50%; 
                        background: ${color}; border: 3px solid white; 
                        box-shadow: 0 2px 8px rgba(0,0,0,0.3);
                        display: flex; align-items: center; justify-content: center;
                        color: white; font-weight: 900; font-size: 12px; font-family: Cairo, sans-serif;
                    ">${client.name.charAt(0)}</div>`,
                    className: "",
                    iconSize: [32, 32],
                    iconAnchor: [16, 16],
                    popupAnchor: [0, -20],
                });

                const marker = L.marker(position, { icon }).addTo(map);

                const popupContent = `
                    <div style="font-family: Cairo, sans-serif; direction: rtl; padding: 4px; min-width: 200px; max-width: 280px;">
                        <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 8px;">
                            <div style="width: 10px; height: 10px; border-radius: 50%; background: ${color}; flex-shrink: 0;"></div>
                            <h3 style="font-weight: 900; color: #1e293b; font-size: 14px; margin: 0;">${client.name}</h3>
                        </div>
                        <span style="font-size: 10px; font-weight: 700; padding: 2px 8px; border-radius: 99px; background: ${color}20; color: ${color};">
                            ${statusLabels[client.status] || client.status}
                        </span>
                        <div style="margin-top: 10px; border-top: 1px solid #f1f5f9; padding-top: 8px;">
                            ${client.company ? `<div style="display: flex; align-items: center; gap: 6px; font-size: 12px; color: #475569; font-weight: 700; margin-bottom: 4px;">🏢 ${client.company}</div>` : ""}
                            ${client.mainPhone ? `<div style="display: flex; align-items: center; gap: 6px; font-size: 12px; color: #475569; font-weight: 700; margin-bottom: 4px;">📞 <a href="tel:${client.mainPhone}" style="color: #2563eb; text-decoration: none;" dir="ltr">${client.mainPhone}</a></div>` : ""}
                            ${client.rep?.name ? `<div style="display: flex; align-items: center; gap: 6px; font-size: 12px; color: #475569; font-weight: 700; margin-bottom: 4px;">👤 ${client.rep.name}</div>` : ""}
                            <div style="display: flex; align-items: center; gap: 6px; font-size: 12px; color: #ef4444; font-weight: 700; margin-top: 8px; padding-top: 8px; border-top: 1px solid #f1f5f9;">
                                💳 مديونية: <span dir="ltr">${client.outstandingBalance?.toLocaleString() || 0} ج.م</span>
                            </div>
                        </div>
                        <a href="/admin/clients/${client.id}" style="display: block; text-align: center; margin-top: 10px; background: #eef2ff; color: #4f46e5; padding: 8px; border-radius: 8px; font-size: 12px; font-weight: 700; text-decoration: none;">
                            عرض الملف الشامل
                        </a>
                    </div>
                `;

                marker.bindPopup(popupContent, { maxWidth: 300 });
            });

            // Fit bounds
            if (clients.length > 1 && bounds.isValid()) {
                map.fitBounds(bounds, { padding: [50, 50] });
            }

            // Force resize after render
            setTimeout(() => map.invalidateSize(), 200);
        });

        return () => {
            if (mapInstanceRef.current) {
                mapInstanceRef.current.remove();
                mapInstanceRef.current = null;
            }
        };
    }, [clients]);

    return <div ref={containerRef} className="w-full h-full" style={{ minHeight: "500px" }} />;
}
