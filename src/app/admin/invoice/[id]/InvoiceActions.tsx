"use client";

import { Printer, X, MessageCircle } from "lucide-react";

export default function InvoiceActions({ phone, message }: { phone?: string, message: string }) {
    const handleWhatsApp = () => {
        let cleanPhone = phone ? phone.replace(/\D/g, '') : '';
        // If it's an Egyptian number missing the country code, add it
        if (cleanPhone && cleanPhone.length <= 11) {
            if (cleanPhone.startsWith('0')) cleanPhone = '2' + cleanPhone;
            else if (!cleanPhone.startsWith('20')) cleanPhone = '20' + cleanPhone;
        }
        
        const url = `https://wa.me/${cleanPhone || ''}?text=${encodeURIComponent(message)}`;
        window.open(url, '_blank');
    };

    return (
        <div className="max-w-4xl mx-auto mb-6 flex justify-between items-center print:hidden bg-white p-4 rounded-xl shadow-sm">
            <button onClick={() => window.close()} className="text-slate-500 hover:text-slate-800 font-bold px-4 py-2 bg-slate-100 rounded-lg transition-colors flex items-center gap-2">
                <X className="w-4 h-4"/> إغلاق
            </button>
            <div className="flex gap-3">
                <button onClick={handleWhatsApp} className="bg-emerald-500 hover:bg-emerald-600 text-white font-bold px-4 py-2 rounded-lg transition-colors flex items-center gap-2 shadow-lg shadow-emerald-500/30">
                    <MessageCircle className="w-5 h-5"/> مشاركة واتساب
                </button>
                <button onClick={() => window.print()} className="bg-blue-600 hover:bg-blue-700 text-white font-bold px-6 py-2 rounded-lg transition-colors flex items-center gap-2 shadow-lg shadow-blue-500/30">
                    <Printer className="w-5 h-5"/> طباعة / حفظ كـ PDF
                </button>
            </div>
        </div>
    );
}
