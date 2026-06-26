"use client";

import React, { useState } from "react";
import { Plus, CreditCard, X, Loader2, Calendar } from "lucide-react";
import { useRouter } from "next/navigation";

export default function ClientProfileActions({ clientId }: { clientId: number }) {
    const router = useRouter();
    const [showPaymentModal, setShowPaymentModal] = useState(false);
    const [showInteractionModal, setShowInteractionModal] = useState(false);
    const [saving, setSaving] = useState(false);
    
    // Payment Form
    const [paymentForm, setPaymentForm] = useState({
        amount: "",
        method: "CASH",
        notes: "",
        paymentDate: new Date().toISOString().split('T')[0]
    });

    const handleSavePayment = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const res = await fetch("/api/admin/crm/payments", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ ...paymentForm, clientId })
            });

            if (res.ok) {
                setShowPaymentModal(false);
                router.refresh();
            } else {
                alert("فشل تسجيل الدفعة");
            }
        } catch (error) {
            alert("حدث خطأ");
        } finally {
            setSaving(false);
        }
    };

    const [interactionForm, setInteractionForm] = useState({
        type: "VISIT",
        notes: "",
        date: new Date().toISOString().split('T')[0],
        nextFollowUp: ""
    });

    const handleSaveInteraction = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const res = await fetch("/api/admin/crm/interactions", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ ...interactionForm, clientId })
            });

            if (res.ok) {
                setShowInteractionModal(false);
                setInteractionForm({ type: "VISIT", notes: "", date: new Date().toISOString().split('T')[0], nextFollowUp: "" });
                router.refresh();
            } else {
                alert("فشل تسجيل المتابعة");
            }
        } catch (error) {
            alert("حدث خطأ");
        } finally {
            setSaving(false);
        }
    };

    return (
        <>
            <div className="flex flex-col sm:flex-row items-center gap-3 w-full sm:w-auto mt-4 sm:mt-0">
                <button 
                    onClick={() => setShowInteractionModal(true)}
                    className="w-full sm:w-auto flex items-center justify-center gap-2 bg-amber-50 hover:bg-amber-100 text-amber-600 border border-amber-200 px-5 py-3 rounded-xl text-sm font-bold transition-all"
                >
                    <Calendar className="w-4 h-4" /> إضافة متابعة / زيارة
                </button>
                <button 
                    onClick={() => setShowPaymentModal(true)}
                    className="w-full sm:w-auto flex items-center justify-center gap-2 bg-emerald-500 hover:bg-emerald-600 text-white px-5 py-3 rounded-xl text-sm font-bold shadow-md shadow-emerald-500/20 transition-all"
                >
                    <CreditCard className="w-4 h-4" /> تسجيل سند قبض
                </button>
            </div>

            {/* Payment Modal */}
            {showPaymentModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/40 backdrop-blur-sm">
                    <div className="bg-white rounded-3xl shadow-xl w-full max-w-lg overflow-hidden border border-slate-100" dir="rtl">
                        <div className="p-5 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                            <h2 className="text-xl font-black text-slate-800 flex items-center gap-2">
                                <CreditCard className="w-5 h-5 text-emerald-500" /> إضافة دفعة سداد (سند قبض)
                            </h2>
                            <button onClick={() => setShowPaymentModal(false)} className="w-8 h-8 flex items-center justify-center rounded-full bg-slate-200/50 text-slate-500 hover:bg-slate-200 hover:text-slate-800 transition-colors">
                                <X className="w-5 h-5" />
                            </button>
                        </div>
                        <div className="p-6">
                            <form onSubmit={handleSavePayment} className="space-y-5">
                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">المبلغ المدفوع (ج.م) *</label>
                                    <input required type="number" min="1" step="0.01" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 transition-all" value={paymentForm.amount} onChange={e => setPaymentForm({...paymentForm, amount: e.target.value})} placeholder="مثال: 5000" />
                                </div>
                                
                                <div className="grid grid-cols-2 gap-4">
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">طريقة الدفع *</label>
                                        <select required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-emerald-500" value={paymentForm.method} onChange={e => setPaymentForm({...paymentForm, method: e.target.value})}>
                                            <option value="CASH">نقدي (كاش)</option>
                                            <option value="TRANSFER">تحويل بنكي / محفظة</option>
                                            <option value="CHEQUE">شيك</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">تاريخ الدفع *</label>
                                        <input required type="date" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-emerald-500" value={paymentForm.paymentDate} onChange={e => setPaymentForm({...paymentForm, paymentDate: e.target.value})} />
                                    </div>
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">ملاحظات / رقم الإيصال</label>
                                    <textarea rows={2} className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-emerald-500 focus:ring-2 focus:ring-emerald-500/20 transition-all resize-none" value={paymentForm.notes} onChange={e => setPaymentForm({...paymentForm, notes: e.target.value})} placeholder="اكتب رقم الحوالة أو الإيصال أو تفاصيل الشيك..."></textarea>
                                </div>

                                <div className="flex gap-3 pt-2">
                                    <button type="submit" disabled={saving} className="flex-1 flex justify-center items-center gap-2 bg-emerald-500 hover:bg-emerald-600 text-white py-3.5 rounded-xl text-sm font-bold shadow-md shadow-emerald-500/20 transition-all disabled:opacity-50">
                                        {saving ? <Loader2 className="w-5 h-5 animate-spin"/> : "حفظ الدفعة"}
                                    </button>
                                    <button type="button" onClick={() => setShowPaymentModal(false)} className="px-6 py-3.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-sm font-bold transition-all">
                                        إلغاء
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}

            {/* Interaction Modal */}
            {showInteractionModal && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/40 backdrop-blur-sm">
                    <div className="bg-white rounded-3xl shadow-xl w-full max-w-lg overflow-hidden border border-slate-100" dir="rtl">
                        <div className="p-5 border-b border-slate-100 flex justify-between items-center bg-slate-50/50">
                            <h2 className="text-xl font-black text-slate-800 flex items-center gap-2">
                                <Calendar className="w-5 h-5 text-amber-500" /> تسجيل زيارة / متابعة
                            </h2>
                            <button onClick={() => setShowInteractionModal(false)} className="w-8 h-8 flex items-center justify-center rounded-full bg-slate-200/50 text-slate-500 hover:bg-slate-200 hover:text-slate-800 transition-colors">
                                <X className="w-5 h-5" />
                            </button>
                        </div>
                        <div className="p-6">
                            <form onSubmit={handleSaveInteraction} className="space-y-5">
                                <div className="grid grid-cols-2 gap-4">
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">نوع المتابعة *</label>
                                        <select required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-amber-500" value={interactionForm.type} onChange={e => setInteractionForm({...interactionForm, type: e.target.value})}>
                                            <option value="VISIT">زيارة ميدانية</option>
                                            <option value="CALL">مكالمة هاتفية</option>
                                            <option value="MEETING">اجتماع عمل</option>
                                            <option value="EMAIL">بريد إلكتروني</option>
                                        </select>
                                    </div>
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">تاريخ المتابعة *</label>
                                        <input required type="date" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-amber-500" value={interactionForm.date} onChange={e => setInteractionForm({...interactionForm, date: e.target.value})} />
                                    </div>
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">تاريخ المتابعة القادمة (اختياري)</label>
                                    <input type="date" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-amber-500" value={interactionForm.nextFollowUp} onChange={e => setInteractionForm({...interactionForm, nextFollowUp: e.target.value})} />
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">تفاصيل الزيارة أو المتابعة *</label>
                                    <textarea required rows={3} className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-amber-500 focus:ring-2 focus:ring-amber-500/20 transition-all resize-none" value={interactionForm.notes} onChange={e => setInteractionForm({...interactionForm, notes: e.target.value})} placeholder="اكتب تفاصيل الزيارة، ماذا حدث، وملاحظات العميل..."></textarea>
                                </div>

                                <div className="flex gap-3 pt-2">
                                    <button type="submit" disabled={saving} className="flex-1 flex justify-center items-center gap-2 bg-amber-500 hover:bg-amber-600 text-white py-3.5 rounded-xl text-sm font-bold shadow-md shadow-amber-500/20 transition-all disabled:opacity-50">
                                        {saving ? <Loader2 className="w-5 h-5 animate-spin"/> : "حفظ المتابعة"}
                                    </button>
                                    <button type="button" onClick={() => setShowInteractionModal(false)} className="px-6 py-3.5 bg-slate-100 hover:bg-slate-200 text-slate-700 rounded-xl text-sm font-bold transition-all">
                                        إلغاء
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </>
    );
}
