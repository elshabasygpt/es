"use client";

import React, { useState, useEffect } from "react";
import { Loader2, MapPin, Search, Store, ArrowRight } from "lucide-react";
import Link from "next/link";
// We use a dynamic import for Map component to avoid SSR issues with Leaflet
import dynamic from "next/dynamic";

const MapComponent = dynamic(() => import("./MapComponent"), { ssr: false });

export default function ClientsMapPage() {
    const [clients, setClients] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchClients = async () => {
            try {
                const res = await fetch(`/api/admin/crm/clients?t=${Date.now()}`);
                if (res.ok) {
                    const data = await res.json();
                    setClients(data.filter((c: any) => c.lat && c.lng)); // Only clients with coordinates
                }
            } catch (e) {
                console.error(e);
            } finally {
                setLoading(false);
            }
        };
        fetchClients();
    }, []);

    return (
        <div className="space-y-6 pb-20 font-sans h-full min-h-[85vh] flex flex-col" dir="rtl">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-5 rounded-3xl border border-gray-100 shadow-sm">
                <div className="flex items-center gap-3">
                    <Link href="/admin/clients" className="p-2 hover:bg-slate-100 rounded-xl transition-colors">
                        <ArrowRight className="w-5 h-5 text-slate-500" />
                    </Link>
                    <div>
                        <h1 className="text-2xl font-black text-slate-800 flex items-center gap-2">
                            <MapPin className="w-6 h-6 text-indigo-500" /> خريطة توزيع العملاء
                        </h1>
                        <p className="text-sm text-slate-500 mt-1 font-medium">عرض أماكن تواجد العملاء المسجلين بإحداثيات جغرافية (GPS)</p>
                    </div>
                </div>
                <div className="bg-indigo-50 text-indigo-700 px-4 py-2 rounded-xl text-sm font-bold flex items-center gap-2 border border-indigo-100">
                    <Store className="w-4 h-4" /> {clients.length} منفذ على الخريطة
                </div>
            </div>

            {/* Map Container */}
            <div className="flex-1 bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden h-[calc(100vh-200px)] min-h-[400px] relative">
                {loading ? (
                    <div className="absolute inset-0 flex items-center justify-center bg-slate-50">
                        <Loader2 className="w-10 h-10 animate-spin text-indigo-500" />
                    </div>
                ) : clients.length > 0 ? (
                    <MapComponent clients={clients} />
                ) : (
                    <div className="absolute inset-0 flex flex-col items-center justify-center bg-slate-50 text-slate-400">
                        <MapPin className="w-16 h-16 opacity-20 mb-4" />
                        <h2 className="text-xl font-black text-slate-600">لا يوجد عملاء بإحداثيات مسجلة</h2>
                        <p className="text-sm font-bold mt-2">يرجى التقاط الموقع الجغرافي للعملاء من شاشة إضافة/تعديل العميل.</p>
                    </div>
                )}
            </div>
        </div>
    );
}
