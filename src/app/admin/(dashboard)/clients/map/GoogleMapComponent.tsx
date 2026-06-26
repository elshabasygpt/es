"use client";

import React, { useEffect, useRef, useState } from "react";
import { Building2, Phone, CreditCard, User } from "lucide-react";
import Link from "next/link";

const API_KEY = process.env.NEXT_PUBLIC_GOOGLE_MAPS_API_KEY || "";

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

// Load Google Maps script once
function loadGoogleMapsScript(): Promise<void> {
    return new Promise((resolve, reject) => {
        if (typeof window !== "undefined" && (window as any).google?.maps) {
            resolve();
            return;
        }
        const script = document.createElement("script");
        script.src = `https://maps.googleapis.com/maps/api/js?key=${API_KEY}&language=ar`;
        script.async = true;
        script.defer = true;
        script.onload = () => resolve();
        script.onerror = () => reject(new Error("Failed to load Google Maps"));
        document.head.appendChild(script);
    });
}

export default function GoogleMapComponent({ clients }: { clients: any[] }) {
    const mapRef = useRef<HTMLDivElement>(null);
    const [error, setError] = useState<string | null>(null);
    const mapInstanceRef = useRef<any>(null);

    useEffect(() => {
        if (!API_KEY) return;

        let isMounted = true;

        const initMap = async () => {
            try {
                await loadGoogleMapsScript();
                if (!isMounted || !mapRef.current) return;

                const google = (window as any).google;

                // Calculate center
                const center = clients.length > 0
                    ? {
                        lat: clients.reduce((sum: number, c: any) => sum + c.lat, 0) / clients.length,
                        lng: clients.reduce((sum: number, c: any) => sum + c.lng, 0) / clients.length,
                    }
                    : { lat: 30.0444, lng: 31.2357 };

                const map = new google.maps.Map(mapRef.current, {
                    center,
                    zoom: clients.length === 1 ? 14 : 7,
                    mapTypeControl: true,
                    streetViewControl: false,
                    fullscreenControl: true,
                    zoomControl: true,
                    styles: [
                        { featureType: "poi", elementType: "labels", stylers: [{ visibility: "off" }] },
                    ],
                });

                mapInstanceRef.current = map;

                // Create bounds to fit all markers
                const bounds = new google.maps.LatLngBounds();

                // Add markers
                clients.forEach((client) => {
                    const color = statusColors[client.status] || "#6b7280";
                    const position = { lat: client.lat, lng: client.lng };
                    bounds.extend(position);

                    const marker = new google.maps.Marker({
                        position,
                        map,
                        title: client.name,
                        icon: {
                            path: google.maps.SymbolPath.CIRCLE,
                            fillColor: color,
                            fillOpacity: 1,
                            strokeColor: "#ffffff",
                            strokeWeight: 3,
                            scale: 10,
                        },
                    });

                    // Info Window
                    const infoContent = `
                        <div style="font-family: Cairo, sans-serif; direction: rtl; padding: 8px; min-width: 200px; max-width: 280px;">
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

                    const infoWindow = new google.maps.InfoWindow({ content: infoContent });

                    marker.addListener("click", () => {
                        infoWindow.open(map, marker);
                    });
                });

                // Fit bounds if multiple clients
                if (clients.length > 1) {
                    map.fitBounds(bounds, { top: 50, right: 50, bottom: 50, left: 50 });
                }

            } catch (err: any) {
                if (isMounted) setError(err.message);
            }
        };

        initMap();

        return () => {
            isMounted = false;
        };
    }, [clients]);

    if (!API_KEY) {
        return (
            <div className="w-full h-full flex flex-col items-center justify-center bg-slate-50 text-slate-500 p-8">
                <div className="text-6xl mb-4">🗺️</div>
                <h3 className="text-xl font-black text-slate-700 mb-2">مفتاح Google Maps غير مضاف</h3>
                <p className="text-sm font-medium text-center max-w-md leading-relaxed">
                    يرجى إضافة مفتاح Google Maps API في ملف <code className="bg-slate-200 px-1.5 py-0.5 rounded text-xs font-mono">.env</code>:
                </p>
                <code className="mt-3 bg-slate-800 text-green-400 px-4 py-2 rounded-lg text-xs font-mono">
                    NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=your_key_here
                </code>
                <p className="text-xs text-slate-400 mt-4">
                    احصل على مفتاح مجاناً من{" "}
                    <a href="https://console.cloud.google.com/apis/credentials" target="_blank" className="text-blue-500 underline">
                        Google Cloud Console
                    </a>
                </p>
            </div>
        );
    }

    if (error) {
        return (
            <div className="w-full h-full flex flex-col items-center justify-center bg-red-50 text-red-500 p-8">
                <div className="text-4xl mb-4">⚠️</div>
                <h3 className="text-lg font-black">خطأ في تحميل الخريطة</h3>
                <p className="text-sm font-medium mt-2">{error}</p>
            </div>
        );
    }

    return <div ref={mapRef} className="w-full h-full" />;
}
