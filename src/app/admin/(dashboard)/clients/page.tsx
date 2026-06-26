"use client";

import React, { useState, useEffect, useRef } from "react";
import { Plus, Search, MapPin, Camera, Building2, Store, Phone, PhoneCall, Loader2, Link2, X, Trash2, Edit, Eye, Mail, Send, CreditCard, Download, Filter } from "lucide-react";
import Link from "next/link";

export default function CRMClientsPage() {
    const [clients, setClients] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [searchTerm, setSearchTerm] = useState("");
    
    // Filters
    const [filterGov, setFilterGov] = useState("ALL");
    const [filterType, setFilterType] = useState("ALL");
    const [filterStatus, setFilterStatus] = useState("ALL");
    
    // Modal states
    const [showModal, setShowModal] = useState(false);
    const [saving, setSaving] = useState(false);
    const fileInputRef = useRef<HTMLInputElement>(null);
    const [uploadingImage, setUploadingImage] = useState(false);
    const [locating, setLocating] = useState(false);
    const [editId, setEditId] = useState<number | null>(null);
    const [viewClient, setViewClient] = useState<any | null>(null);
    
    // Manual Order States
    const [showAddOrderModal, setShowAddOrderModal] = useState(false);
    const [products, setProducts] = useState<any[]>([]);
    const [savingOrder, setSavingOrder] = useState(false);
    const [uploadingInvoice, setUploadingInvoice] = useState(false);
    const [orderForm, setOrderForm] = useState({
        id: null as number | null,
        clientId: null as number | null,
        createdAt: "",
        items: [] as { productId: string, quantity: number, price: number, productName: string }[],
        notes: "",
        invoiceFile: null as string | null
    });

    const [form, setForm] = useState({
        name: "",
        company: "",
        storeType: "سوبرماركت",
        mainPhone: "",
        secondaryPhone: "",
        storeImage: "" as string | null,
        lat: null as number | null,
        lng: null as number | null,
        locationUrl: "",
        governorate: "",
        notes: "",
        status: "LEAD",
        creditLimit: 0,
        outstandingBalance: 0,
        contacts: [] as { personName: string, department: string, email: string, phone: string }[]
    });

    useEffect(() => {
        fetchClients();
    }, []);

    const fetchClients = async () => {
        try {
            // Add cache bust parameter to prevent stale local fetch caching in Next.js
            const res = await fetch(`/api/admin/crm/clients?t=${Date.now()}`, { cache: "no-store" });
            if (res.ok) {
                const data = await res.json();
                setClients(data);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setLoading(false);
        }
    };

    const captureLocation = () => {
        if (!navigator.geolocation) {
            alert("خدمة تحديد الموقع غير مدعومة في جهازك.");
            return;
        }
        setLocating(true);
        navigator.geolocation.getCurrentPosition(
            (position) => {
                const { latitude, longitude } = position.coords;
                setForm(prev => ({
                    ...prev,
                    lat: latitude,
                    lng: longitude,
                    locationUrl: `https://www.google.com/maps?q=${latitude},${longitude}`
                }));
                setLocating(false);
            },
            (error) => {
                alert("تعذر الحصول على الموقع الجغرافي. تأكد من تفعيل إذن الـ GPS.");
                setLocating(false);
            },
            { enableHighAccuracy: true }
        );
    };

    const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        setUploadingImage(true);
        const formData = new FormData();
        formData.append("file", file);

        try {
            const res = await fetch("/api/admin/crm/upload", { method: "POST", body: formData });
            if (res.ok) {
                const data = await res.json();
                setForm(prev => ({ ...prev, storeImage: data.url }));
            } else {
                alert("فشل رفع الصورة.");
            }
        } catch (err) {
            alert("فشل التخاطب مع الخادم لرفع الصورة.");
        } finally {
            setUploadingImage(false);
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSaving(true);
        try {
            const url = editId ? `/api/admin/crm/clients/${editId}` : `/api/admin/crm/clients`;
            const method = editId ? "PUT" : "POST";

            const res = await fetch(url, {
                method,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(form)
            });

            if (res.ok) {
                await fetchClients();
                setShowModal(false);
                setEditId(null);
                setForm({
                    name: "", company: "", storeType: "سوبرماركت",
                    mainPhone: "", secondaryPhone: "", storeImage: null,
                    lat: null, lng: null, locationUrl: "", governorate: "", notes: "", status: "LEAD", creditLimit: 0, outstandingBalance: 0, contacts: []
                });
            } else {
                alert("حدث خطأ أثناء الحفظ");
            }
        } catch (e) {
            alert("حدث خطأ أثناء الحفظ");
        } finally {
            setSaving(false);
        }
    };

    const handleDelete = async (id: number) => {
        if (!window.confirm("هل أنت متأكد من حذف هذا العميل نهائياً؟ لا يمكن التراجع عن هذه الخطوة.")) return;
        try {
            const res = await fetch(`/api/admin/crm/clients/${id}`, { method: "DELETE" });
            if (res.ok) fetchClients();
            else alert("فشل الحذف");
        } catch (e) { alert("حدث خطأ"); }
    };

    const openEditModal = (client: any) => {
        setEditId(client.id);
        setForm({
            name: client.name || "",
            company: client.company || "",
            storeType: client.storeType || "سوبرماركت",
            mainPhone: client.mainPhone || "",
            secondaryPhone: client.secondaryPhone || "",
            storeImage: client.storeImage || null,
            lat: client.lat || null,
            lng: client.lng || null,
            locationUrl: client.locationUrl || "",
            governorate: client.governorate || "",
            notes: client.notes || "",
            status: client.status || "LEAD",
            creditLimit: client.creditLimit || 0,
            outstandingBalance: client.outstandingBalance || 0,
            contacts: client.contacts || []
        });
        setShowModal(true);
    };

    const openAddModal = () => {
        setEditId(null);
        setForm({
            name: "", company: "", storeType: "سوبرماركت", mainPhone: "", secondaryPhone: "", storeImage: null, lat: null, lng: null, locationUrl: "", governorate: "", notes: "", status: "LEAD", creditLimit: 0, outstandingBalance: 0, contacts: []
        });
        setShowModal(true);
    };

    const openViewModal = async (clientInfo: any) => {
        setViewClient({ ...clientInfo, loadingDetails: true });
        try {
            const res = await fetch(`/api/admin/crm/clients/${clientInfo.id}`);
            if (res.ok) {
                const data = await res.json();
                setViewClient(data);
            } else {
                setViewClient(clientInfo);
            }
        } catch (e) {
            setViewClient(clientInfo);
        }
    };

    const fetchProducts = async () => {
        if (products.length > 0) return;
        try {
            const res = await fetch("/api/admin/products");
            if (res.ok) {
                const pData = await res.json();
                setProducts(pData.data || pData.products || (Array.isArray(pData) ? pData : []));
            }
        } catch(e) {}
    };

    const openAddOrder = async (clientId: number) => {
        await fetchProducts();
        setOrderForm({
            id: null,
            clientId,
            createdAt: new Date().toISOString().split("T")[0],
            items: [{ productId: "", quantity: 1, price: 0, productName: "" }],
            notes: "",
            invoiceFile: null
        });
        setShowAddOrderModal(true);
    };

    const openEditOrder = async (order: any) => {
        await fetchProducts();
        setOrderForm({
            id: order.id,
            clientId: order.clientId,
            createdAt: new Date(order.createdAt).toISOString().split("T")[0],
            items: order.items?.map((i: any) => ({
                productId: i.productId ? i.productId.toString() : "custom",
                quantity: i.quantity,
                price: i.unitPrice,
                productName: i.customItemName || ""
            })) || [],
            notes: order.notes || "",
            invoiceFile: order.invoiceFile || null
        });
        setShowAddOrderModal(true);
    };

    const handleDeleteOrder = async (orderId: number) => {
        if (!confirm("هل أنت متأكد من حذف هذا الطلب بشكل نهائي؟ سيتم خصم مديونيته من حساب العميل.")) return;
        
        try {
            const res = await fetch(`/api/admin/crm/orders/${orderId}`, { method: "DELETE" });
            if (res.ok) {
                // Refresh client details
                if (viewClient) {
                    const fetchRes = await fetch(`/api/admin/crm/clients/${viewClient.id}`);
                    if (fetchRes.ok) {
                        const updatedClient = await fetchRes.json();
                        setViewClient(updatedClient);
                    }
                }
                fetchClients();
            } else {
                const data = await res.json();
                alert(data.message || data.error || "فشل الحذف");
            }
        } catch (e) {
            alert("حدث خطأ في الاتصال");
        }
    };

    const handleShareWhatsApp = (order: any) => {
        const waMessage = `*مصنع السلام للزيوت النباتية والسمن*
طلب رقم: #${order.id}
التاريخ: ${new Date(order.createdAt).toLocaleDateString("ar-EG")}

*المنتجات:*
${order.items?.map((i: any) => `- ${i.product?.name_ar || 'منتج'} (الكمية: ${i.quantity}) = ${i.subtotal} ج.م`).join('\n') || ''}

*الإجمالي المطلوب:* ${order.totalAmount} ج.م
*المديونية المتبقية:* ${viewClient?.outstandingBalance} ج.م

شكراً لتعاملكم معنا!`;

        let cleanPhone = viewClient?.mainPhone ? viewClient.mainPhone.replace(/\D/g, '') : '';
        if (cleanPhone && cleanPhone.length <= 11) {
            if (cleanPhone.startsWith('0')) cleanPhone = '2' + cleanPhone;
            else if (!cleanPhone.startsWith('20')) cleanPhone = '20' + cleanPhone;
        }
        
        const url = `https://wa.me/${cleanPhone || ''}?text=${encodeURIComponent(waMessage)}`;
        window.open(url, '_blank');
    };

    const handleInvoiceUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        setUploadingInvoice(true);
        const formData = new FormData();
        formData.append("file", file);

        try {
            const res = await fetch("/api/admin/crm/upload", { method: "POST", body: formData });
            if (res.ok) {
                const data = await res.json();
                setOrderForm(prev => ({ ...prev, invoiceFile: data.url }));
            } else {
                alert("فشل رفع المرفق.");
            }
        } catch (err) {
            alert("فشل التخاطب مع الخادم لرفع المرفق.");
        } finally {
            setUploadingInvoice(false);
        }
    };

    const handleOrderSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setSavingOrder(true);
        try {
            const url = orderForm.id ? `/api/admin/crm/orders/${orderForm.id}` : "/api/admin/crm/orders";
            const method = orderForm.id ? "PUT" : "POST";
            
            const res = await fetch(url, {
                method,
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(orderForm)
            });
            if (res.ok) {
                setShowAddOrderModal(false);
                if (viewClient && viewClient.id === orderForm.clientId) {
                    // Refetch the specific client to get updated orders
                    const fetchRes = await fetch(`/api/admin/crm/clients/${viewClient.id}`);
                    if (fetchRes.ok) {
                        const updatedClient = await fetchRes.json();
                        setViewClient(updatedClient);
                    }
                }
                fetchClients();
            } else {
                const data = await res.json();
                alert(data.message || data.error || "حدث خطأ");
            }
        } catch(e) {
            alert("حدث خطأ في الاتصال بالخادم");
        } finally {
            setSavingOrder(false);
        }
    };

    const updateOrderItem = (index: number, field: string, value: any) => {
        const updated = [...orderForm.items];
        if (field === 'productId') {
            const prod = products.find(p => p.id.toString() === value.toString());
            updated[index].productId = value;
            if (prod) {
                updated[index].price = prod.price || 0;
                updated[index].productName = prod.name_ar;
            }
        } else {
            (updated as any)[index][field] = value;
        }
        setOrderForm({ ...orderForm, items: updated });
    };

    const addOrderItem = () => {
        setOrderForm({ ...orderForm, items: [...orderForm.items, { productId: "", quantity: 1, price: 0, productName: "" }] });
    };

    const removeOrderItem = (index: number) => {
        const updated = [...orderForm.items];
        updated.splice(index, 1);
        setOrderForm({ ...orderForm, items: updated });
    };


    const filteredClients = clients.filter(c => {
        const matchesSearch = c.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
            (c.mainPhone || "").includes(searchTerm) ||
            (c.company || "").toLowerCase().includes(searchTerm.toLowerCase()) ||
            (c.rep?.name || "").toLowerCase().includes(searchTerm.toLowerCase());
            
        const matchesGov = filterGov === "ALL" || c.governorate === filterGov;
        const matchesType = filterType === "ALL" || c.storeType === filterType;
        const matchesStatus = filterStatus === "ALL" || c.status === filterStatus;
        
        return matchesSearch && matchesGov && matchesType && matchesStatus;
    });

    const exportToExcel = () => {
        const headers = ["الاسم", "الشركة/المتجر", "رقم الهاتف", "المنطقة/المحافظة", "نوع المنفذ", "الحالة", "المديونية", "الحد الائتماني", "المندوب"];
        const csvContent = [
            headers.join(","),
            ...filteredClients.map(c => [
                `"${c.name}"`, 
                `"${c.company || ''}"`, 
                `"${c.mainPhone || ''}"`, 
                `"${c.governorate || ''}"`, 
                `"${c.storeType || ''}"`, 
                `"${c.status}"`, 
                c.outstandingBalance, 
                c.creditLimit, 
                `"${c.rep?.name || ''}"`
            ].join(","))
        ].join("\n");

        const blob = new Blob(["\uFEFF" + csvContent], { type: "text/csv;charset=utf-8;" });
        const link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = `clients_export_${new Date().toISOString().split('T')[0]}.csv`;
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        URL.revokeObjectURL(link.href);
    };

    // Extract unique values for filters
    const uniqueGovs = Array.from(new Set(clients.map(c => c.governorate).filter(Boolean)));
    const uniqueTypes = Array.from(new Set(clients.map(c => c.storeType).filter(Boolean)));

    return (
        <div className="space-y-6 pb-20">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-5 rounded-3xl border border-gray-100 shadow-sm">
                <div>
                    <h1 className="text-2xl font-black text-slate-800">قائمة العملاء والمنافذ</h1>
                    <p className="text-sm text-slate-500 mt-1 font-medium">سجل عملاءك الميدانيين لتسهيل إنشاء الطلبيات لاحقاً</p>
                </div>
                <div className="flex flex-col sm:flex-row w-full sm:w-auto gap-3 mt-4 sm:mt-0">
                    <a href="/admin/clients/reports" className="flex justify-center items-center gap-2 bg-white text-blue-600 border border-blue-200 px-6 py-3 rounded-xl text-sm font-bold hover:bg-blue-50 transition-all shadow-sm">
                        📊 شاشة التقارير
                    </a>
                    <button onClick={openAddModal} className="flex justify-center items-center gap-2 bg-gradient-to-r from-green-500 to-emerald-600 text-white px-6 py-3 rounded-xl text-sm font-bold hover:shadow-lg hover:shadow-green-500/30 transition-all">
                        <Plus className="w-5 h-5"/> إضافة منفذ جديد
                    </button>
                </div>
            </div>

            {/* Filters & Actions */}
            <div className="bg-white p-4 rounded-3xl border border-gray-100 shadow-sm flex flex-col gap-4">
                <div className="flex flex-col md:flex-row gap-4 items-center justify-between">
                    <div className="relative flex-1 w-full">
                        <input 
                            type="text" 
                            placeholder="ابحث بالاسم، المندوب، أو رقم الجوال..." 
                            className="w-full pr-12 pl-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 focus:ring-4 focus:ring-green-500/10 transition-all"
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                        <Search className="absolute right-4 top-1/2 -translate-y-1/2 w-5 h-5 text-slate-400" />
                    </div>
                    <button onClick={exportToExcel} className="w-full md:w-auto flex justify-center items-center gap-2 bg-emerald-50 text-emerald-600 border border-emerald-100 px-5 py-3 rounded-xl text-sm font-bold hover:bg-emerald-100 transition-all">
                        <Download className="w-4 h-4" /> تصدير لإكسيل (CSV)
                    </button>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 border-t border-slate-100 pt-4">
                    <div className="flex items-center gap-2 bg-slate-50 px-3 py-2 rounded-xl border border-slate-100">
                        <Filter className="w-4 h-4 text-slate-400" />
                        <select className="flex-1 bg-transparent text-sm font-semibold text-slate-700 outline-none" value={filterGov} onChange={e => setFilterGov(e.target.value)}>
                            <option value="ALL">كل المحافظات/المناطق</option>
                            {uniqueGovs.map((gov: any, i) => <option key={i} value={gov}>{gov}</option>)}
                        </select>
                    </div>
                    <div className="flex items-center gap-2 bg-slate-50 px-3 py-2 rounded-xl border border-slate-100">
                        <Filter className="w-4 h-4 text-slate-400" />
                        <select className="flex-1 bg-transparent text-sm font-semibold text-slate-700 outline-none" value={filterType} onChange={e => setFilterType(e.target.value)}>
                            <option value="ALL">كل أنواع المنافذ</option>
                            {uniqueTypes.map((type: any, i) => <option key={i} value={type}>{type}</option>)}
                        </select>
                    </div>
                    <div className="flex items-center gap-2 bg-slate-50 px-3 py-2 rounded-xl border border-slate-100">
                        <Filter className="w-4 h-4 text-slate-400" />
                        <select className="flex-1 bg-transparent text-sm font-semibold text-slate-700 outline-none" value={filterStatus} onChange={e => setFilterStatus(e.target.value)}>
                            <option value="ALL">كل الحالات</option>
                            <option value="LEAD">عميل محتمل (Lead)</option>
                            <option value="NEGOTIATION">قيد التفاوض</option>
                            <option value="ACTIVE">نشط ودائم</option>
                            <option value="INACTIVE">غير نشط</option>
                        </select>
                    </div>
                </div>
            </div>

            {/* List */}
            {loading ? (
                <div className="flex justify-center p-12"><Loader2 className="w-8 h-8 animate-spin text-green-500" /></div>
            ) : filteredClients.length === 0 ? (
                <div className="bg-white p-12 rounded-3xl border border-gray-100 text-center shadow-sm">
                    <Store className="w-16 h-16 text-slate-200 mx-auto mb-4" />
                    <h3 className="text-xl font-black text-slate-700">لا يوجد بيانات حتى الآن</h3>
                    <p className="text-sm font-medium text-slate-500 mt-2">اضغط على زر الإضافة لتسجيل العميل الأول</p>
                </div>
            ) : (
                <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                    {filteredClients.map((client) => (
                        <div key={client.id} className="bg-white rounded-[24px] border border-slate-100/80 shadow-sm overflow-hidden flex flex-col transition-all duration-300 hover:shadow-xl hover:shadow-green-500/5 hover:-translate-y-1 hover:border-green-200/60 group relative">
                            {/* Card Extras / Actions menu */}
                            <div className="absolute top-3 left-3 md:top-4 md:left-4 z-40 flex flex-row-reverse items-center gap-1.5 md:gap-2 transition-opacity duration-300">
                                <button onClick={() => openViewModal(client)} className="w-9 h-9 md:w-10 md:h-10 rounded-xl bg-white/95 backdrop-blur shadow-sm border border-slate-100 flex items-center justify-center text-blue-600 hover:bg-blue-600 hover:border-blue-600 hover:text-white transition-all active:scale-90" title="التفاصيل">
                                    <Eye className="w-4 h-4 md:w-5 md:h-5" />
                                </button>
                                <button onClick={() => openEditModal(client)} className="w-9 h-9 md:w-10 md:h-10 rounded-xl bg-white/95 backdrop-blur shadow-sm border border-slate-100 flex items-center justify-center text-amber-600 hover:bg-amber-600 hover:border-amber-600 hover:text-white transition-all active:scale-90" title="تعديل">
                                    <Edit className="w-4 h-4 md:w-5 md:h-5" />
                                </button>
                                <button onClick={() => handleDelete(client.id)} className="w-9 h-9 md:w-10 md:h-10 rounded-xl bg-white/95 backdrop-blur shadow-sm border border-slate-100 flex items-center justify-center text-red-500 hover:bg-red-600 hover:border-red-600 hover:text-white transition-all active:scale-90" title="حذف">
                                    <Trash2 className="w-4 h-4 md:w-5 md:h-5" />
                                </button>
                            </div>

                            {/* Card Image / Header */}
                            <div className="h-40 md:h-60 w-full relative overflow-hidden bg-slate-900 group">
                                <div className="absolute inset-0 bg-gradient-to-t from-slate-900/95 via-slate-900/30 to-transparent z-10 transition-opacity duration-300 group-hover:from-slate-900/90" />
                                <img src={client.storeImage || "https://images.unsplash.com/photo-1604719312566-8fa2065b2167?w=600&q=80"} onError={(e) => { e.currentTarget.src = "https://images.unsplash.com/photo-1604719312566-8fa2065b2167?w=600&q=80" }} alt={client.name} className="w-full h-full object-cover opacity-90 transition-transform duration-700 group-hover:scale-110 group-hover:opacity-100" />
                                <div className="absolute top-4 right-4 z-20">
                                    <div className="flex gap-1.5">
                                        <span className="bg-white/95 backdrop-blur-md text-slate-800 text-[10px] font-black px-3 py-1.5 rounded-full shadow-sm">
                                            {client.storeType}
                                        </span>
                                        <span className={`text-white text-[10px] font-black px-3 py-1.5 rounded-full shadow-sm ${client.status === "ACTIVE" ? "bg-green-500" : client.status === "NEGOTIATION" ? "bg-blue-500" : client.status === "INACTIVE" ? "bg-red-500" : "bg-amber-500"}`}>
                                            {client.status === "LEAD" ? "محتمل" : client.status === "NEGOTIATION" ? "مفاوضة" : client.status === "ACTIVE" ? "دائم" : "غير نشط"}
                                        </span>
                                    </div>
                                </div>
                                <div className="absolute bottom-5 right-5 left-5 z-20 text-white transform transition-all duration-300">
                                    <h3 className="text-xl font-black drop-shadow-md truncate">{client.name}</h3>
                                    <div className="flex items-center gap-1.5 mt-1.5 opacity-90 text-slate-200">
                                        <Building2 className="w-3.5 h-3.5" />
                                        <p className="text-xs font-medium drop-shadow-sm truncate">{client.company || "عميل ميداني"}</p>
                                    </div>
                                </div>
                            </div>

                            {/* Card Body */}
                            <div className="p-6 flex-1 flex flex-col bg-white relative z-10">
                                
                                <div className="space-y-3.5 mt-auto">
                                    {/* Contact Block */}
                                    {client.mainPhone && (
                                        <div className="flex items-center gap-3.5 p-3.5 bg-slate-50/80 rounded-2xl border border-slate-100/50 hover:bg-green-50/50 hover:border-green-100 transition-colors duration-300">
                                            <div className="w-11 h-11 rounded-xl bg-white flex items-center justify-center shadow-sm border border-slate-200/50 shrink-0">
                                                <Phone className="w-5 h-5 text-green-600" />
                                            </div>
                                            <div className="flex flex-col flex-1">
                                                <span className="text-xs text-slate-400 font-bold mb-0.5">رقم التواصل</span>
                                                <span className="text-[15px] font-bold text-slate-700 leading-none" dir="ltr">{client.mainPhone}</span>
                                            </div>
                                            
                                            <a href={`tel:${client.mainPhone}`} title="اتصال مباشر" className="w-11 h-11 rounded-full bg-slate-100 hover:bg-green-500 hover:text-white text-slate-400 flex flex-col items-center justify-center transition-all shadow-sm">
                                                 <PhoneCall className="w-5 h-5" />
                                            </a>
                                        </div>
                                    )}
                                    
                                    {/* View Profile Button */}
                                    <div className="pt-2 pb-1">
                                        <Link href={`/admin/clients/${client.id}`} className="w-full flex items-center justify-center gap-2 bg-indigo-50 hover:bg-indigo-600 text-indigo-600 hover:text-white px-4 py-2.5 rounded-xl text-sm font-bold transition-all border border-indigo-100">
                                            ملف العميل الشامل (360°)
                                        </Link>
                                    </div>

                                    {/* Actions Block */}
                                    <div className="flex items-stretch gap-2 pt-3 border-t border-dashed border-slate-100">
                                        {client.locationUrl ? (
                                            <a href={client.locationUrl} target="_blank" className="flex items-center justify-center flex-[2] gap-2.5 bg-slate-900 hover:bg-green-600 text-white px-4 py-3.5 rounded-[14px] text-sm font-bold transition-all shadow-md shadow-slate-900/10 hover:shadow-green-500/25">
                                                <MapPin className="w-5 h-5" /> عرض الخريطة
                                            </a>
                                        ) : (
                                            <div className="flex items-center justify-center flex-[2] gap-2.5 bg-slate-50 text-slate-400 px-4 py-3.5 rounded-[14px] text-sm font-bold cursor-not-allowed border border-slate-100/50">
                                                <MapPin className="w-5 h-5 opacity-50" /> بدون خريطة
                                            </div>
                                        )}
                                        
                                        {client.rep && (
                                            <div className="flex-[1] flex flex-col justify-center items-center px-1 py-2 bg-slate-50 rounded-[14px] border border-slate-100/50">
                                                <span className="text-[9px] text-slate-400 font-bold mb-1">المندوب</span>
                                                <span className="text-[11px] font-extrabold text-slate-700 line-clamp-1 w-full text-center px-1">{client.rep.name}</span>
                                            </div>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* PWA Friendly Add Modal */}
            {showModal && (
                <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-[100] flex flex-col items-center justify-end sm:justify-center p-0 sm:p-4 animate-in fade-in duration-200">
                    <div className="bg-white w-full sm:max-w-xl sm:rounded-3xl rounded-t-3xl shadow-2xl flex flex-col max-h-[92vh] animate-in slide-in-from-bottom-10 sm:slide-in-from-bottom-0 sm:zoom-in-95 duration-300">
                        <div className="px-5 py-4 border-b border-gray-100 flex items-center justify-between sticky top-0 bg-white/80 backdrop-blur z-10 rounded-t-3xl">
                            <h2 className="text-xl font-black text-slate-800">{editId ? "تعديل بيانات المنفذ" : "تسجيل منفذ جديد"}</h2>
                            <button onClick={() => setShowModal(false)} className="bg-slate-100 text-slate-500 hover:text-red-500 p-2 rounded-full transition-colors"><X className="w-5 h-5"/></button>
                        </div>
                        
                        <div className="overflow-y-auto p-5 hover-scrollbar pb-24 sm:pb-6">
                            <form id="mobileForm" onSubmit={handleSubmit} className="space-y-5">
                                {/* Image Capture */}
                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-2">صورة لافتة / واجهة المحل</label>
                                    <div 
                                        onClick={() => fileInputRef.current?.click()}
                                        className={`w-full aspect-[21/9] rounded-2xl border-2 border-dashed flex flex-col items-center justify-center gap-2 cursor-pointer transition-all overflow-hidden bg-slate-50 ${form.storeImage ? "border-green-500" : "border-slate-300 hover:bg-slate-100 hover:border-slate-400"}`}
                                    >
                                        {uploadingImage ? (
                                            <Loader2 className="w-8 h-8 text-green-500 animate-spin" />
                                        ) : form.storeImage ? (
                                            <img src={form.storeImage} className="w-full h-full object-cover" alt="Store Front" />
                                        ) : (
                                            <>
                                                <div className="w-12 h-12 bg-white rounded-full flex items-center justify-center shadow-sm">
                                                    <Camera className="w-6 h-6 text-slate-400" />
                                                </div>
                                                <span className="text-xs font-bold text-slate-500">التقاط صورة بالكاميرا</span>
                                            </>
                                        )}
                                    </div>
                                    {/* hidden file input allowing camera capture on mobile */}
                                    <input type="file" ref={fileInputRef} className="hidden" accept="image/*" capture="environment" onChange={handleImageUpload} />
                                </div>

                                {/* Location */}
                                <div className="bg-blue-50/50 border border-blue-100 p-4 rounded-2xl">
                                    <label className="flex items-center justify-between text-xs font-bold text-slate-700 mb-2">
                                        الموقع الجغرافي (GPS)
                                        {form.lat && <span className="text-[10px] bg-green-500 text-white px-2 py-0.5 rounded-full flex items-center gap-1">تم الالتقاط ✓</span>}
                                    </label>
                                    <button type="button" onClick={captureLocation} disabled={locating} className="w-full flex items-center justify-center gap-2 bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-xl text-sm font-bold transition-all disabled:opacity-50">
                                        {locating ? <Loader2 className="w-5 h-5 animate-spin"/> : <MapPin className="w-5 h-5" />}
                                        {form.lat ? "تحديث الموقع الجغرافي" : "التقاط موقع المحل الحالي"}
                                    </button>
                                    {form.lat && <a href={form.locationUrl} target="_blank" className="block text-center text-xs text-blue-600 mt-2 font-semibold hover:underline">معاينة على خريطة جوجل</a>}
                                </div>

                                {/* Details */}
                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">أسم المحل / العميل *</label>
                                    <input required type="text" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 focus:ring-2 focus:ring-green-500/20 transition-all" value={form.name} onChange={e => setForm({...form, name: e.target.value})} placeholder="مثال: سوبرماركت زمزم" />
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">المحافظة / المنطقة</label>
                                    <input type="text" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 focus:ring-2 focus:ring-green-500/20 transition-all" value={form.governorate} onChange={e => setForm({...form, governorate: e.target.value})} placeholder="مثال: القاهرة، الجيزة، أو اسم المنطقة" />
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">تصنيف المنفذ *</label>
                                    <select className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-green-500" value={form.storeType} onChange={e => setForm({...form, storeType: e.target.value})}>
                                        <option value="سوبرماركت">سوبرماركت</option>
                                        <option value="بقالة ومحل غذائي">بقالة ومحل غذائي</option>
                                        <option value="عطارة">عطارة</option>
                                        <option value="مطعم">مطعم</option>
                                        <option value="جملة">تاجر جملة</option>
                                        <option value="أخرى">أخرى</option>
                                    </select>
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">حالة العميل (مرحلة البيع) *</label>
                                    <select className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:border-green-500" value={form.status} onChange={e => setForm({...form, status: e.target.value})}>
                                        <option value="LEAD">عميل محتمل (Lead)</option>
                                        <option value="NEGOTIATION">قيد التفاوض (Negotiation)</option>
                                        <option value="ACTIVE">عميل نشط ودائم (Active)</option>
                                        <option value="INACTIVE">عميل غير نشط (Inactive)</option>
                                    </select>
                                </div>

                                <div className="grid grid-cols-2 gap-4">
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">الحد الائتماني المسموح به</label>
                                        <input type="number" step="0.01" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 transition-all" value={form.creditLimit} onChange={e => setForm({...form, creditLimit: Number(e.target.value)})} placeholder="0" />
                                    </div>
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">المديونية (الرصيد المستحق)</label>
                                        <input type="number" step="0.01" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 transition-all" value={form.outstandingBalance} onChange={e => setForm({...form, outstandingBalance: Number(e.target.value)})} placeholder="0" />
                                    </div>
                                </div>

                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">رقم الهاتف (الأساسي) *</label>
                                    <input required type="tel" dir="ltr" className="w-full text-right px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-semibold outline-none focus:bg-white focus:border-green-500 focus:ring-2 focus:ring-green-500/20 transition-all" value={form.mainPhone} onChange={e => setForm({...form, mainPhone: e.target.value})} placeholder="01xxxxxxxxx" />
                                </div>

                                {/* Emails / Departments */}
                                <div className="space-y-3 pt-4 border-t border-slate-100">
                                    <div className="flex items-center justify-between">
                                        <label className="text-xs font-bold text-slate-700">البريد الإلكتروني للجهات المختلفة</label>
                                        <button type="button" onClick={() => setForm({...form, contacts: [...form.contacts, {personName: "", department: "المشتريات", email: "", phone: ""}]})} className="text-[11px] font-bold text-green-600 bg-green-50 px-4 py-2 rounded-full hover:bg-green-100 border border-green-200 transition-colors shadow-sm">+ إضافة بريد</button>
                                    </div>
                                    <div className="space-y-2">
                                        {form.contacts.map((c, i) => (
                                            <div key={i} className="flex flex-col sm:flex-row gap-3 bg-white p-3 rounded-[16px] border border-slate-200 shadow-sm relative group transition-all hover:border-green-300">
                                                <button type="button" onClick={() => {
                                                    const a = [...form.contacts];
                                                    a.splice(i, 1);
                                                    setForm({...form, contacts: a});
                                                }} className="absolute -top-2 -left-2 text-white bg-red-500 hover:bg-red-600 rounded-full p-1.5 shadow-md opacity-0 group-hover:opacity-100 transition-opacity"><Trash2 className="w-3.5 h-3.5"/></button>
                                                <div className="flex-1 space-y-2">
                                                    <input required type="email" placeholder="البريد الإلكتروني *" value={c.email} onChange={e => {
                                                        const a = [...form.contacts]; a[i].email = e.target.value; setForm({...form, contacts: a});
                                                    }} className="w-full text-xs font-medium px-4 py-3 bg-slate-50 rounded-xl border border-slate-200 outline-none focus:bg-white focus:border-green-500 transition-colors"/>
                                                    <div className="flex gap-2">
                                                        <select className="flex-[1.5] text-xs font-bold px-4 py-3 bg-slate-50 rounded-xl border border-slate-200 outline-none focus:bg-white focus:border-green-500 transition-colors text-slate-700" value={c.department} onChange={e => {
                                                            const a = [...form.contacts]; a[i].department = e.target.value; setForm({...form, contacts: a});
                                                        }}>
                                                            <option value="المشتريات">المشتريات</option>
                                                            <option value="الإدارة">الإدارة</option>
                                                            <option value="المالية">المالية</option>
                                                            <option value="المبيعات">المبيعات</option>
                                                            <option value="الإستقبال">الإستقبال</option>
                                                            <option value="عام">عام</option>
                                                        </select>
                                                        <input type="text" placeholder="الاسم (اختياري)" value={c.personName} onChange={e => {
                                                            const a = [...form.contacts]; a[i].personName = e.target.value; setForm({...form, contacts: a});
                                                        }} className="flex-[2] text-xs font-medium px-4 py-3 bg-slate-50 rounded-xl border border-slate-200 outline-none focus:bg-white focus:border-green-500 transition-colors"/>
                                                    </div>
                                                </div>
                                            </div>
                                        ))}
                                    </div>
                                </div>

                                <div className="pt-4 border-t border-slate-100 flex gap-3">
                                    <button type="button" onClick={() => setShowModal(false)} className="flex-1 px-4 py-3 bg-slate-100 text-slate-600 rounded-xl font-bold hover:bg-slate-200">إلغاء</button>
                                    <button type="submit" disabled={saving || uploadingImage} className="flex-[2] flex justify-center items-center gap-2 px-4 py-3 bg-gradient-to-l from-green-500 to-green-600 text-white rounded-xl font-bold shadow-lg shadow-green-500/20 disabled:opacity-50">
                                        {saving ? <Loader2 className="w-5 h-5 animate-spin" /> : "حفظ بيانات العميل"}
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}

            {/* View Details Modal */}
            {viewClient && (
                <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-[100] flex flex-col items-center justify-end sm:justify-center p-0 sm:p-4 animate-in fade-in duration-200">
                    <div className="bg-slate-50 w-full sm:max-w-xl sm:rounded-[36px] rounded-t-3xl shadow-2xl flex flex-col max-h-[92vh] overflow-hidden animate-in slide-in-from-bottom-10 sm:slide-in-from-bottom-0 sm:zoom-in-95 duration-300">
                        
                        {/* Huge Header Image */}
                        <div className="relative w-full h-[320px] bg-slate-900 shrink-0">
                            <img src={viewClient.storeImage || "https://images.unsplash.com/photo-1604719312566-8fa2065b2167?w=1000&q=80"} onError={(e) => { e.currentTarget.src = "https://images.unsplash.com/photo-1604719312566-8fa2065b2167?w=1000&q=80" }} alt={viewClient.name} className="w-full h-full object-cover opacity-90" />
                            <div className="absolute inset-0 bg-gradient-to-t from-slate-900/95 via-slate-900/20 to-transparent" />
                            
                            {/* Close Button */}
                            <button onClick={() => setViewClient(null)} className="absolute top-5 left-5 bg-white/10 hover:bg-red-500 hover:text-white border border-white/20 text-white backdrop-blur-md p-3 rounded-full transition-all z-20 shadow-lg">
                                <X className="w-6 h-6"/>
                            </button>

                            {/* Header Info Over Image */}
                            <div className="absolute bottom-6 right-6 left-6 z-20 text-white">
                                <div className="flex gap-2 mb-3">
                                    <span className="bg-green-500 text-white text-xs font-black px-4 py-1.5 rounded-xl shadow-sm border border-green-400">
                                        {viewClient.storeType}
                                    </span>
                                </div>
                                <h2 className="text-3xl font-black drop-shadow-xl">{viewClient.name}</h2>
                                {viewClient.company && (
                                    <div className="flex items-center gap-2 mt-2 opacity-90 text-green-100">
                                        <Building2 className="w-5 h-5" />
                                        <p className="text-sm font-bold drop-shadow-md">{viewClient.company}</p>
                                    </div>
                                )}
                            </div>
                        </div>

                        {/* Highly Organized Data Body */}
                        <div className="overflow-y-auto p-5 sm:p-7 pb-12 sm:pb-8 hover-scrollbar">
                            
                            {/* Call Cards */}
                            <div className="grid grid-cols-2 gap-4 mb-6">
                                {/* Financial & Credit Limits */}
                                <div className="col-span-2 bg-gradient-to-r from-slate-900 to-slate-800 p-5 rounded-[28px] shadow-sm flex flex-col justify-between items-center sm:flex-row gap-4 border border-slate-700">
                                    <div className="flex items-center gap-4">
                                        <div className={`w-14 h-14 rounded-full flex items-center justify-center shadow-inner ${viewClient.outstandingBalance >= viewClient.creditLimit && viewClient.creditLimit > 0 ? "bg-red-500/20 text-red-400" : "bg-green-500/20 text-green-400"}`}>
                                            <CreditCard className="w-7 h-7" />
                                        </div>
                                        <div>
                                            <div className="text-[12px] text-slate-400 font-bold mb-0.5">الحالة الائتمانية والمديونية</div>
                                            <div className="flex items-baseline gap-2">
                                                <span className={`text-[20px] font-black tracking-wide ${viewClient.outstandingBalance >= viewClient.creditLimit && viewClient.creditLimit > 0 ? "text-red-400" : "text-white"}`} dir="ltr">{viewClient.outstandingBalance?.toLocaleString()} EGP</span>
                                                <span className="text-slate-500 text-[11px] font-bold">/ {viewClient.creditLimit?.toLocaleString()} EGP (الحد)</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div className={`px-4 py-2 rounded-xl text-xs font-black shadow-sm flex-shrink-0 ${viewClient.outstandingBalance >= viewClient.creditLimit && viewClient.creditLimit > 0 ? "bg-red-500 text-white" : "bg-white/10 text-slate-300"}`}>
                                        {viewClient.outstandingBalance >= viewClient.creditLimit && viewClient.creditLimit > 0 ? "متجاوز للحد ⚠️" : "ضمن الحد المسموح"}
                                    </div>
                                </div>
                                <div className="bg-white p-5 rounded-[28px] border border-slate-100/80 shadow-sm flex flex-col items-center justify-center text-center transition-all hover:border-green-200">
                                    <div className="w-14 h-14 bg-green-50 text-green-600 rounded-full flex items-center justify-center mb-3 shadow-inner">
                                        <Phone className="w-7 h-7" />
                                    </div>
                                    <div className="text-[11px] text-slate-400 font-bold mb-1">الرقم الأساسي</div>
                                    <div className="text-[17px] font-black text-slate-800 tracking-wide" dir="ltr">{viewClient.mainPhone || "-"}</div>
                                </div>

                                <div className="bg-white p-5 rounded-[28px] border border-slate-100/80 shadow-sm flex flex-col items-center justify-center text-center transition-all hover:border-slate-300">
                                    <div className="w-14 h-14 bg-slate-50 text-slate-400 rounded-full flex items-center justify-center mb-3 shadow-inner">
                                        <PhoneCall className="w-7 h-7" />
                                    </div>
                                    <div className="text-[11px] text-slate-400 font-bold mb-1">رقم إضافي</div>
                                    <div className="text-[17px] font-black text-slate-800 tracking-wide" dir="ltr">{viewClient.secondaryPhone || "-"}</div>
                                </div>
                            </div>

                            {/* Emails Section */}
                            {viewClient.contacts && viewClient.contacts.length > 0 && (
                                <div className="bg-slate-900 rounded-[28px] p-5 mb-6 shadow-md shadow-slate-900/10">
                                    <div className="text-white text-sm font-black mb-4 flex items-center gap-2">
                                        <Mail className="w-5 h-5 text-green-400"/> البريد الإلكتروني للمراسلة
                                    </div>
                                    <div className="space-y-3">
                                        {viewClient.contacts.map((c: any, i: number) => (
                                            <div key={i} className="bg-white/10 p-4 rounded-[20px] flex sm:items-center flex-col sm:flex-row justify-between gap-3 group hover:bg-white/15 transition-colors border border-white/5">
                                                <div>
                                                    <div className="text-green-300 text-[11px] font-bold mb-1 flex items-center gap-1.5">
                                                        <span className="bg-green-500/20 text-green-300 px-2 py-0.5 rounded-md">{c.department}</span>
                                                        {c.personName && <span className="text-slate-300">/ {c.personName}</span>}
                                                    </div>
                                                    <div className="text-white font-medium text-sm tracking-wide mt-1.5">{c.email}</div>
                                                </div>
                                                <a href={`mailto:${c.email}`} className="bg-green-600 hover:bg-green-500 text-white text-xs font-bold px-4 py-2.5 rounded-xl flex items-center justify-center gap-2 transition-all shadow-lg shadow-green-900/50">
                                                    إرسال رسالة <Send className="w-3.5 h-3.5"/>
                                                </a>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                            )}

                            {/* Location Section */}
                            {viewClient.locationUrl && (
                                <a href={viewClient.locationUrl} target="_blank" className="flex items-center justify-between bg-slate-900 group hover:bg-green-600 transition-colors p-5 rounded-[24px] mb-6 shadow-md shadow-slate-900/5">
                                    <div className="flex items-center gap-4">
                                        <div className="w-12 h-12 bg-white/10 rounded-full flex items-center justify-center text-white">
                                            <MapPin className="w-6 h-6"/>
                                        </div>
                                        <div>
                                            <div className="text-white font-bold text-lg">الموقع الجغرافي</div>
                                            <div className="text-green-300 group-hover:text-green-100 text-xs font-bold mt-0.5">فتح في خرائط جوجل</div>
                                        </div>
                                    </div>
                                    <Link2 className="w-6 h-6 text-white opacity-50 group-hover:opacity-100" />
                                </a>
                            )}

                            {/* Notes Section */}
                            {viewClient.notes && (
                                <div className="bg-amber-50 p-6 rounded-[24px] border border-amber-100/60 mb-6 relative overflow-hidden">
                                    <div className="absolute -left-6 -top-6 w-24 h-24 bg-amber-500/10 rounded-full blur-xl" />
                                    <div className="text-amber-800 font-black text-sm mb-3 flex items-center gap-2 relative z-10">
                                        ملاحظات مسجلة
                                    </div>
                                    <p className="text-slate-700 text-[15px] whitespace-pre-wrap font-medium leading-relaxed relative z-10">
                                        {viewClient.notes}
                                    </p>
                                </div>
                            )}

                            {/* Orders History Section */}
                            {viewClient.loadingDetails ? (
                                <div className="flex justify-center py-6"><Loader2 className="w-6 h-6 animate-spin text-slate-400" /></div>
                            ) : (
                                <div className="bg-slate-900 rounded-[28px] p-5 mb-6 shadow-md shadow-slate-900/10">
                                    <div className="flex items-center justify-between mb-4">
                                        <div className="text-white text-sm font-black flex items-center gap-2">
                                            <Store className="w-5 h-5 text-blue-400"/> سجل المسحوبات
                                        </div>
                                        <button onClick={() => openAddOrder(viewClient.id)} className="bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold px-4 py-2 rounded-xl transition-colors">
                                            + تسجيل طلب يدوي
                                        </button>
                                    </div>
                                    
                                    {viewClient.orders && viewClient.orders.length > 0 ? (
                                        <div className="space-y-3">
                                            <div className="flex justify-between items-center bg-white/5 p-3 rounded-2xl mb-2 text-xs font-bold text-slate-300">
                                                <span>إجمالي المسحوبات: {viewClient.orders.length}</span>
                                                <span className="text-green-400">{viewClient.orders.reduce((acc: number, o: any) => acc + o.totalAmount, 0).toLocaleString()} ج.م</span>
                                            </div>
                                            {viewClient.orders.map((o: any) => (
                                                <div key={o.id} className="bg-white/10 p-4 rounded-[20px] border border-white/5 group hover:bg-white/15 transition-colors">
                                                    <div className="flex justify-between items-start mb-3">
                                                        <div>
                                                            <div className="text-slate-300 text-xs font-bold">{new Date(o.createdAt).toLocaleDateString("ar-EG")}</div>
                                                            <div className="text-white text-sm font-black mt-1">طلب #{o.id}</div>
                                                        </div>
                                                        <div className="text-left flex flex-col items-end">
                                                            <div className="text-green-400 font-black" dir="ltr">{o.totalAmount.toLocaleString()} ج.م</div>
                                                            <div className="text-[10px] text-slate-400 mt-1">{o.status === 'DELIVERED' ? 'تم التوصيل' : 'جديد'}</div>
                                                            <div className="flex gap-1 mt-2">
                                                                <button type="button" onClick={() => openEditOrder(o)} className="text-[10px] bg-white/10 text-slate-300 hover:bg-white/20 hover:text-white px-2 py-1 rounded transition-colors" title="تعديل">
                                                                    ✏️
                                                                </button>
                                                                <button type="button" onClick={() => handleDeleteOrder(o.id)} className="text-[10px] bg-red-500/10 text-red-400 hover:bg-red-500/30 hover:text-red-300 px-2 py-1 rounded transition-colors" title="حذف">
                                                                    🗑️
                                                                </button>
                                                                <button type="button" onClick={() => handleShareWhatsApp(o)} className="text-[10px] bg-green-500/10 text-green-400 hover:bg-green-500/30 hover:text-green-300 px-2 py-1 rounded transition-colors" title="مشاركة عبر واتساب">
                                                                    💬 واتساب
                                                                </button>
                                                                <a href={`/admin/invoice/${o.id}`} target="_blank" rel="noopener noreferrer" className="inline-block text-[10px] bg-emerald-500/10 text-emerald-400 hover:bg-emerald-500/30 hover:text-emerald-300 px-2 py-1 rounded transition-colors cursor-pointer" title="إنشاء وطباعة فاتورة PDF">
                                                                    🖨️ طباعة
                                                                </a>
                                                                {o.invoiceFile ? (
                                                                    <a href={o.invoiceFile} target="_blank" rel="noopener noreferrer" onClick={(e) => e.stopPropagation()} className="inline-block text-[10px] bg-blue-500/20 text-blue-300 hover:bg-blue-500/40 px-2 py-1 rounded transition-colors cursor-pointer" title="عرض الفاتورة المرفقة">
                                                                        📄 عرض المرفق
                                                                    </a>
                                                                ) : (
                                                                    <span className="inline-block text-[10px] bg-slate-500/10 text-slate-400 px-2 py-1 rounded cursor-not-allowed" title="لا يوجد مرفق خارجي">
                                                                        📄 لا يوجد مرفق
                                                                    </span>
                                                                )}
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div className="space-y-1.5 mt-3 pt-3 border-t border-white/10">
                                                        {o.items?.map((item: any, i: number) => (
                                                            <div key={i} className="flex justify-between text-xs text-slate-300">
                                                                <span>{item.quantity}x {item.product?.name_ar}</span>
                                                                <span dir="ltr">{item.subtotal.toLocaleString()} ج.م</span>
                                                            </div>
                                                        ))}
                                                    </div>
                                                </div>
                                            ))}
                                        </div>
                                    ) : (
                                        <div className="text-center py-6 text-slate-500 text-xs font-bold">لا يوجد مسحوبات مسجلة لهذا العميل</div>
                                    )}
                                </div>
                            )}

                            {/* Representative Info */}
                            <div className="bg-white px-5 py-4 rounded-[20px] flex items-center justify-between border border-slate-100 shadow-sm mt-auto">
                                <span className="text-xs text-slate-400 font-bold">مُسجل المنفذ (المندوب)</span>
                                <span className="text-base font-black text-slate-800 bg-slate-50 px-3 py-1 rounded-lg">{viewClient.rep?.name || "غير محدد"}</span>
                            </div>

                        </div>
                    </div>
                </div>
            )}

            {/* Add Manual Order Modal */}
            {showAddOrderModal && (
                <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-[110] flex justify-center items-center p-4 animate-in fade-in">
                    <div className="bg-white w-[95vw] lg:max-w-5xl rounded-[28px] shadow-2xl flex flex-col max-h-[90vh]">
                        <div className="px-6 py-4 border-b border-gray-100 flex items-center justify-between">
                            <h2 className="text-xl font-black text-slate-800">{orderForm.id ? "تعديل طلب / مسحوب يدوي" : "تسجيل طلب / مسحوب يدوي"}</h2>
                            <button onClick={() => setShowAddOrderModal(false)} className="text-slate-400 hover:text-red-500 p-2 rounded-full transition-colors"><X className="w-5 h-5"/></button>
                        </div>
                        <div className="p-6 overflow-y-auto hover-scrollbar">
                            <form onSubmit={handleOrderSubmit} className="space-y-5">
                                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">تاريخ الطلب (اختر تاريخ قديم إذا كان الطلب سابقاً)</label>
                                        <input required type="date" className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-bold outline-none focus:border-blue-500" value={orderForm.createdAt} onChange={e => setOrderForm({...orderForm, createdAt: e.target.value})} />
                                    </div>
                                    <div>
                                        <label className="block text-xs font-bold text-slate-700 mb-1.5">إرفاق فاتورة (صورة أو PDF)</label>
                                        <div className="flex gap-2 items-center">
                                            <input type="file" id="invoiceUpload" className="hidden" accept="image/*,.pdf" onChange={handleInvoiceUpload} />
                                            <label htmlFor="invoiceUpload" className={`flex-1 flex justify-center items-center gap-2 px-4 py-3 border border-slate-200 rounded-xl text-sm font-bold cursor-pointer transition-colors ${orderForm.invoiceFile ? 'bg-green-50 text-green-700 border-green-200' : 'bg-slate-50 text-slate-600 hover:bg-slate-100'}`}>
                                                {uploadingInvoice ? <Loader2 className="w-5 h-5 animate-spin" /> : (orderForm.invoiceFile ? "تم الإرفاق ✓" : "اختيار ملف المرفق")}
                                            </label>
                                            {orderForm.invoiceFile && (
                                                <button type="button" onClick={() => setOrderForm({...orderForm, invoiceFile: null})} className="p-3 text-red-500 bg-red-50 hover:bg-red-100 rounded-xl border border-red-100"><Trash2 className="w-4 h-4"/></button>
                                            )}
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <div className="flex justify-between items-center mb-2">
                                        <label className="text-xs font-bold text-slate-700">المنتجات المباعة</label>
                                        <button type="button" onClick={addOrderItem} className="text-[11px] font-bold text-blue-600 bg-blue-50 px-3 py-1.5 rounded-lg hover:bg-blue-100">+ منتج آخر</button>
                                    </div>
                                    <div className="space-y-3">
                                        {orderForm.items.map((item, index) => (
                                            <div key={index} className="flex gap-3 items-center bg-slate-50 p-3 rounded-xl border border-slate-100">
                                                <div className="flex-[3] flex flex-col gap-2">
                                                    <select required className="w-full text-sm font-bold px-4 py-3 bg-white rounded-xl border border-slate-200 outline-none focus:border-blue-500 transition-colors" value={item.productId} onChange={(e) => updateOrderItem(index, 'productId', e.target.value)}>
                                                        <option value="" disabled>اختر المنتج...</option>
                                                        {products.map(p => <option key={p.id} value={p.id}>{p.name_ar} - السعر الحالي: {p.price} ج.م</option>)}
                                                        <option value="custom">✍️ منتج غير مسجل بالكتالوج...</option>
                                                    </select>
                                                    {item.productId === 'custom' && (
                                                        <input required type="text" className="w-full text-sm font-bold px-4 py-3 bg-white rounded-xl border border-slate-200 outline-none focus:border-blue-500 transition-colors" placeholder="اكتب اسم المنتج هنا..." value={item.productName || ""} onChange={(e) => updateOrderItem(index, 'productName', e.target.value)} />
                                                    )}
                                                </div>
                                                <div className="flex-[1] min-w-[120px] relative">
                                                    <label className="absolute -top-2.5 right-3 bg-white px-1 text-[10px] font-bold text-slate-400 border border-slate-100 rounded">سعر الوحدة</label>
                                                    <input required type="number" min="0" step="0.01" className="w-full text-sm font-black text-blue-600 px-4 py-3 bg-white rounded-xl border border-slate-200 outline-none focus:border-blue-500 transition-colors" placeholder="سعر الوحدة" value={item.price === undefined ? "" : item.price} onChange={e => updateOrderItem(index, 'price', parseFloat(e.target.value) || 0)} title="سعر الوحدة" />
                                                </div>
                                                <div className="flex-[1] min-w-[100px] relative">
                                                    <label className="absolute -top-2.5 right-3 bg-white px-1 text-[10px] font-bold text-slate-400 border border-slate-100 rounded">الكمية</label>
                                                    <input required type="number" min="1" className="w-full text-sm font-black text-slate-700 px-4 py-3 bg-white rounded-xl border border-slate-200 outline-none focus:border-blue-500 transition-colors" placeholder="الكمية" value={item.quantity || ""} onChange={e => updateOrderItem(index, 'quantity', parseInt(e.target.value) || 1)} title="الكمية" />
                                                </div>
                                                <button type="button" onClick={() => removeOrderItem(index)} className="p-3 text-red-500 hover:text-white bg-white hover:bg-red-500 rounded-xl border border-red-100 shadow-sm transition-colors" title="حذف المنتج"><X className="w-5 h-5"/></button>
                                            </div>
                                        ))}
                                    </div>
                                </div>
                                <div>
                                    <label className="block text-xs font-bold text-slate-700 mb-1.5">ملاحظات (اختياري)</label>
                                    <textarea className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-bold outline-none focus:border-blue-500" rows={2} value={orderForm.notes} onChange={e => setOrderForm({...orderForm, notes: e.target.value})} placeholder="تفاصيل إضافية عن الدفع أو الشحن..."></textarea>
                                </div>
                                <div className="pt-2">
                                    <button type="submit" disabled={savingOrder || orderForm.items.length === 0} className="w-full flex justify-center items-center gap-2 py-3 bg-blue-600 hover:bg-blue-700 text-white rounded-xl text-sm font-bold shadow-lg shadow-blue-500/20 disabled:opacity-50">
                                        {savingOrder ? <Loader2 className="w-5 h-5 animate-spin" /> : (orderForm.id ? "حفظ التعديلات وتحديث المديونية" : "حفظ الطلب وتسجيل المديونية")}
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
