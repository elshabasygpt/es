"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { Home, ShoppingBag, Users, Package, MoreHorizontal, Settings, Newspaper, PackageOpen, Mail, MapPin, TicketPercent, ExternalLink, LogOut, DatabaseBackup } from "lucide-react";
import { useState, useEffect } from "react";

export function AdminMobileBottomNav() {
    const pathname = usePathname();
    const [moreOpen, setMoreOpen] = useState(false);

    // Close "More" sheet on navigation
    useEffect(() => {
        setMoreOpen(false);
    }, [pathname]);

    // Prevent body scroll when bottom sheet is open
    useEffect(() => {
        if (moreOpen) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = '';
        }
        return () => { document.body.style.overflow = ''; };
    }, [moreOpen]);

    const navItems = [
        { id: "home", label: "الرئيسية", href: "/admin", icon: Home, exact: true },
        { id: "web_orders", label: "الطلبات", href: "/admin/web-orders", icon: ShoppingBag },
        { id: "clients", label: "العملاء", href: "/admin/clients", icon: Users },
        { id: "products", label: "المنتجات", href: "/admin/products", icon: Package },
    ];

    const moreItems = [
        { label: "الأخبار", href: "/admin/news", icon: Newspaper, color: "bg-blue-50 text-blue-600" },
        { label: "البيع الميداني", href: "/admin/orders", icon: PackageOpen, color: "bg-purple-50 text-purple-600" },
        { label: "البريد الوارد", href: "/admin/inbox", icon: Mail, color: "bg-amber-50 text-amber-600" },
        { label: "مناطق الشحن", href: "/admin/shipping", icon: MapPin, color: "bg-rose-50 text-rose-600" },
        { label: "كوبونات الخصم", href: "/admin/promocodes", icon: TicketPercent, color: "bg-emerald-50 text-emerald-600" },
        { label: "النسخ الاحتياطي", href: "/admin/backups", icon: DatabaseBackup, color: "bg-red-50 text-red-600" },
        { label: "الإعدادات", href: "/admin/settings", icon: Settings, color: "bg-slate-100 text-slate-600" },
    ];

    const isActive = (href: string, exact?: boolean) => {
        if (exact) return pathname === href;
        return pathname.startsWith(href);
    };

    return (
        <>
            {/* The Bottom Nav Bar */}
            <div className="md:hidden fixed bottom-0 left-0 right-0 bg-white/95 backdrop-blur-xl border-t border-slate-200/80 px-1 pt-1.5 pb-[max(0.5rem,env(safe-area-inset-bottom))] flex justify-around items-center z-50 shadow-[0_-2px_16px_rgba(0,0,0,0.06)]">
                {navItems.map((item) => {
                    const active = isActive(item.href, item.exact);
                    return (
                        <Link
                            key={item.id}
                            href={item.href}
                            className={`flex flex-col items-center justify-center min-w-[56px] py-1 gap-0.5 transition-all duration-200 relative ${active ? "text-emerald-600" : "text-slate-400 active:text-slate-600"}`}
                        >
                            {active && <div className="absolute -top-1.5 left-1/2 -translate-x-1/2 w-6 h-0.5 bg-emerald-500 rounded-full" />}
                            <item.icon className={`w-[22px] h-[22px] transition-all duration-200 ${active ? "scale-105" : ""}`} strokeWidth={active ? 2.5 : 1.8} />
                            <span className={`text-[10px] leading-tight ${active ? "font-extrabold" : "font-semibold"}`}>{item.label}</span>
                        </Link>
                    );
                })}
                
                {/* More Button */}
                <button
                    onClick={() => setMoreOpen(true)}
                    className={`flex flex-col items-center justify-center min-w-[56px] py-1 gap-0.5 transition-all duration-200 ${moreOpen ? "text-emerald-600" : "text-slate-400 active:text-slate-600"}`}
                >
                    <MoreHorizontal className="w-[22px] h-[22px]" strokeWidth={1.8} />
                    <span className="text-[10px] font-semibold leading-tight">المزيد</span>
                </button>
            </div>

            {/* Bottom Sheet for "More" Menu */}
            {moreOpen && (
                <>
                    <div 
                        className="fixed inset-0 bg-black/30 backdrop-blur-[2px] z-[60] md:hidden transition-opacity duration-300" 
                        onClick={() => setMoreOpen(false)} 
                    />
                    <div className="fixed bottom-0 left-0 right-0 bg-white rounded-t-[28px] z-[70] md:hidden shadow-[0_-8px_40px_rgba(0,0,0,0.12)] pb-[max(1rem,env(safe-area-inset-bottom))] transform transition-transform duration-300 ease-out">
                        {/* Handle */}
                        <div className="flex justify-center pt-3 pb-2">
                            <div className="w-10 h-1 bg-slate-200 rounded-full" />
                        </div>
                        
                        {/* Title */}
                        <div className="px-6 pb-4 border-b border-slate-100">
                            <h3 className="text-lg font-black text-slate-800">الأقسام الأخرى</h3>
                        </div>

                        {/* Grid Items */}
                        <div className="grid grid-cols-3 gap-3 p-5">
                            {moreItems.map((item) => {
                                const active = isActive(item.href);
                                return (
                                    <Link 
                                        key={item.href} 
                                        href={item.href} 
                                        onClick={() => setMoreOpen(false)} 
                                        className={`flex flex-col items-center gap-2.5 p-4 rounded-2xl transition-all duration-200 active:scale-95 ${active ? "bg-emerald-50 ring-2 ring-emerald-200" : item.color + " hover:shadow-md"}`}
                                    >
                                        <item.icon className={`w-6 h-6 ${active ? "text-emerald-600" : ""}`} strokeWidth={2} />
                                        <span className={`text-[11px] font-bold text-center leading-tight ${active ? "text-emerald-700" : ""}`}>{item.label}</span>
                                    </Link>
                                );
                            })}
                        </div>

                        {/* Quick Actions */}
                        <div className="px-5 pt-2 pb-3 flex gap-3">
                            <a href="/" target="_blank" className="flex-1 flex items-center justify-center gap-2 py-3 bg-slate-50 text-slate-600 rounded-xl text-xs font-bold border border-slate-100 active:scale-95 transition-all">
                                <ExternalLink className="w-4 h-4" /> عرض الموقع
                            </a>
                            <a href="/api/auth/signout" className="flex-1 flex items-center justify-center gap-2 py-3 bg-red-50 text-red-500 rounded-xl text-xs font-bold border border-red-100 active:scale-95 transition-all">
                                <LogOut className="w-4 h-4" /> تسجيل خروج
                            </a>
                        </div>
                    </div>
                </>
            )}
        </>
    );
}
