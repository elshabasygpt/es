"use client";

import React, { useState, useEffect } from "react";
import { DatabaseBackup, Download, Trash2, RotateCcw, Plus, Loader2, AlertTriangle, CheckCircle2, CloudUpload, ExternalLink } from "lucide-react";

export default function BackupsPage() {
    const [backups, setBackups] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [creating, setCreating] = useState(false);
    const [restoring, setRestoring] = useState<string | null>(null);
    const [deleting, setDeleting] = useState<string | null>(null);
    const [error, setError] = useState<string | null>(null);
    const [successMsg, setSuccessMsg] = useState<React.ReactNode>(null);
    const [uploading, setUploading] = useState<string | null>(null);

    useEffect(() => {
        fetchBackups();
    }, []);

    const fetchBackups = async () => {
        setLoading(true);
        setError(null);
        try {
            const res = await fetch("/api/admin/backups");
            if (res.ok) {
                const data = await res.json();
                setBackups(data);
            } else {
                const data = await res.json();
                setError(data.error || "فشل جلب النسخ الاحتياطية");
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setLoading(false);
        }
    };

    const handleCreateBackup = async () => {
        setCreating(true);
        setError(null);
        setSuccessMsg(null);
        try {
            const res = await fetch("/api/admin/backups", { method: "POST" });
            const data = await res.json();
            if (res.ok) {
                setSuccessMsg("تم إنشاء النسخة الاحتياطية بنجاح.");
                fetchBackups();
            } else {
                setError(data.error || "حدث خطأ أثناء إنشاء النسخة.");
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setCreating(false);
        }
    };

    const handleDelete = async (filename: string) => {
        if (!confirm(`هل أنت متأكد من حذف النسخة الاحتياطية "${filename}"؟ لا يمكن التراجع عن هذا الإجراء.`)) return;
        
        setDeleting(filename);
        setError(null);
        try {
            const res = await fetch(`/api/admin/backups?file=${encodeURIComponent(filename)}`, { method: "DELETE" });
            const data = await res.json();
            if (res.ok) {
                setSuccessMsg("تم حذف النسخة الاحتياطية بنجاح.");
                fetchBackups();
            } else {
                setError(data.error || "حدث خطأ أثناء الحذف.");
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setDeleting(null);
        }
    };

    const handleRestore = async (filename: string) => {
        const confirmed = confirm(
            "⚠️ تحذير خطير جداً ⚠️\n\n" +
            "استرجاع هذه النسخة سيؤدي إلى مسح قاعدة البيانات الحالية وجميع الملفات المرفوعة بالكامل، واستبدالها بهذه النسخة القديمة.\n\n" +
            "هل أنت متأكد 100% أنك تريد المتابعة؟"
        );
        if (!confirmed) return;

        // Double confirmation for safety
        const doubleCheck = prompt(`اكتب كلمة "استرجاع" لتأكيد العملية لملف ${filename}`);
        if (doubleCheck !== "استرجاع") {
            alert("تم إلغاء عملية الاسترجاع.");
            return;
        }

        setRestoring(filename);
        setError(null);
        setSuccessMsg(null);
        try {
            const res = await fetch("/api/admin/backups/restore", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ filename })
            });
            const data = await res.json();
            if (res.ok) {
                setSuccessMsg("تم استرجاع النظام بنجاح! يرجى إعادة تحميل الصفحة لضمان عمل كل شيء بشكل صحيح.");
                alert("تم استرجاع النظام بنجاح. سيتم الآن إعادة تحميل الصفحة.");
                window.location.reload();
            } else {
                setError(data.error || "حدث خطأ أثناء الاسترجاع.");
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setRestoring(null);
        }
    };

    const handleUploadToDrive = async (filename: string) => {
        setUploading(filename);
        setError(null);
        setSuccessMsg(null);
        try {
            const res = await fetch("/api/admin/backups/upload-to-drive", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ filename })
            });
            const data = await res.json();
            if (res.ok) {
                setSuccessMsg(
                    <span className="flex items-center gap-2">
                        تم الرفع إلى Google Drive بنجاح! 
                        <a href={data.link} target="_blank" className="underline font-black flex items-center gap-1">
                            عرض الملف <ExternalLink className="w-3 h-3" />
                        </a>
                    </span>
                );
            } else {
                setError(data.error || "حدث خطأ أثناء الرفع لـ Google Drive. تأكد من إعدادات حساب الخدمة (Service Account).");
            }
        } catch (e: any) {
            setError(e.message);
        } finally {
            setUploading(null);
        }
    };

    const formatBytes = (bytes: number) => {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    };

    return (
        <div className="space-y-6 pb-20 font-sans" dir="rtl">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-6 rounded-3xl border border-red-100 shadow-sm relative overflow-hidden">
                <div className="absolute top-0 right-0 w-2 h-full bg-red-500"></div>
                <div>
                    <h1 className="text-2xl font-black text-slate-800 flex items-center gap-2">
                        <DatabaseBackup className="w-6 h-6 text-red-500" /> النسخ الاحتياطي (Backup)
                    </h1>
                    <p className="text-sm text-slate-500 mt-1 font-medium">إدارة النسخ الاحتياطية لقاعدة البيانات والملفات المرفوعة (الطوارئ)</p>
                </div>
                <button 
                    onClick={handleCreateBackup} 
                    disabled={creating}
                    className="flex justify-center items-center gap-2 bg-gradient-to-r from-red-500 to-rose-600 text-white px-6 py-3 rounded-xl text-sm font-bold hover:shadow-lg hover:shadow-red-500/30 transition-all disabled:opacity-50"
                >
                    {creating ? <Loader2 className="w-5 h-5 animate-spin" /> : <Plus className="w-5 h-5" />}
                    {creating ? "جاري الإنشاء..." : "إنشاء نسخة احتياطية جديدة"}
                </button>
            </div>

            {/* Messages */}
            {error && (
                <div className="bg-red-50 text-red-600 p-4 rounded-xl border border-red-100 flex items-center gap-3 text-sm font-bold">
                    <AlertTriangle className="w-5 h-5" /> {error}
                </div>
            )}
            {successMsg && (
                <div className="bg-emerald-50 text-emerald-600 p-4 rounded-xl border border-emerald-100 flex items-center gap-3 text-sm font-bold">
                    <CheckCircle2 className="w-5 h-5" /> {successMsg}
                </div>
            )}

            {/* Warning Banner */}
            <div className="bg-amber-50 border border-amber-200 p-4 rounded-2xl flex gap-3 text-amber-800">
                <AlertTriangle className="w-6 h-6 shrink-0 mt-0.5 text-amber-600" />
                <div>
                    <h3 className="font-bold mb-1">ملاحظة هامة جداً</h3>
                    <p className="text-sm leading-relaxed">
                        النسخة الاحتياطية تشمل كامل بيانات الموقع (قاعدة البيانات والملفات المرفوعة). عملية **الاسترجاع** ستقوم بمسح جميع البيانات الحالية واستبدالها ببيانات النسخة المختارة. تأكد دائماً من أخذ نسخة احتياطية جديدة قبل إجراء أي استرجاع.
                    </p>
                </div>
            </div>

            {/* Backups List */}
            <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                <div className="p-5 border-b border-slate-100 flex items-center justify-between">
                    <h2 className="text-lg font-black text-slate-800">سجل النسخ الاحتياطية</h2>
                    <span className="bg-slate-100 text-slate-600 text-xs font-bold px-3 py-1 rounded-lg">{backups.length} نسخة</span>
                </div>
                
                {loading ? (
                    <div className="flex justify-center p-12"><Loader2 className="w-8 h-8 animate-spin text-slate-400" /></div>
                ) : backups.length === 0 ? (
                    <div className="p-12 text-center text-slate-400">
                        <DatabaseBackup className="w-12 h-12 mx-auto mb-3 opacity-20" />
                        <h3 className="text-lg font-bold text-slate-600 mb-1">لا توجد نسخ احتياطية</h3>
                        <p className="text-sm">لم تقم بإنشاء أي نسخة احتياطية حتى الآن.</p>
                    </div>
                ) : (
                    <div className="overflow-x-auto">
                        <table className="w-full text-sm text-right">
                            <thead className="bg-slate-50 text-slate-500 font-bold text-xs uppercase">
                                <tr>
                                    <th className="px-6 py-4 rounded-tr-2xl">اسم الملف</th>
                                    <th className="px-6 py-4">الحجم</th>
                                    <th className="px-6 py-4">تاريخ الإنشاء</th>
                                    <th className="px-6 py-4 rounded-tl-2xl text-center">الإجراءات</th>
                                </tr>
                            </thead>
                            <tbody className="divide-y divide-slate-100">
                                {backups.map((backup) => (
                                    <tr key={backup.name} className="hover:bg-slate-50 transition-colors">
                                        <td className="px-6 py-4 font-bold text-slate-700" dir="ltr">{backup.name}</td>
                                        <td className="px-6 py-4 text-slate-500 font-semibold" dir="ltr">{formatBytes(backup.size)}</td>
                                        <td className="px-6 py-4 text-slate-500 font-semibold" dir="ltr">
                                            {new Date(backup.createdAt).toLocaleString('ar-EG', { dateStyle: 'medium', timeStyle: 'short' })}
                                        </td>
                                        <td className="px-6 py-4">
                                            <div className="flex items-center justify-center gap-2">
                                                <a 
                                                    href={`/api/admin/backups/download?file=${encodeURIComponent(backup.name)}`}
                                                    download
                                                    className="p-2 text-slate-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                                                    title="تحميل"
                                                >
                                                    <Download className="w-5 h-5" />
                                                </a>
                                                <button 
                                                    onClick={() => handleRestore(backup.name)}
                                                    disabled={restoring === backup.name}
                                                    className="p-2 text-slate-400 hover:text-amber-600 hover:bg-amber-50 rounded-lg transition-colors disabled:opacity-50"
                                                    title="استرجاع"
                                                >
                                                    {restoring === backup.name ? <Loader2 className="w-5 h-5 animate-spin" /> : <RotateCcw className="w-5 h-5" />}
                                                </button>
                                                <button 
                                                    onClick={() => handleUploadToDrive(backup.name)}
                                                    disabled={uploading === backup.name}
                                                    className="p-2 text-slate-400 hover:text-emerald-600 hover:bg-emerald-50 rounded-lg transition-colors disabled:opacity-50"
                                                    title="رفع إلى Google Drive"
                                                >
                                                    {uploading === backup.name ? <Loader2 className="w-5 h-5 animate-spin" /> : <CloudUpload className="w-5 h-5" />}
                                                </button>
                                                <button 
                                                    onClick={() => handleDelete(backup.name)}
                                                    disabled={deleting === backup.name}
                                                    className="p-2 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors disabled:opacity-50"
                                                    title="حذف"
                                                >
                                                    {deleting === backup.name ? <Loader2 className="w-5 h-5 animate-spin" /> : <Trash2 className="w-5 h-5" />}
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                )}
            </div>
        </div>
    );
}
