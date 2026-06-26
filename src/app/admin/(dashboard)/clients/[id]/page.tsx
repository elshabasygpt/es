import { prisma } from "@/lib/prisma";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { redirect } from "next/navigation";
import { 
    Building2, MapPin, Phone, CreditCard, ShoppingBag, 
    Calendar, TrendingUp, DollarSign, Wallet, ArrowRight, PackageOpen
} from "lucide-react";
import Link from "next/link";
import ClientProfileActions from "./ClientProfileActions";

export default async function ClientProfilePage({ params }: { params: Promise<{ id: string }> }) {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SALES_MANAGER" && session.user.role !== "SALES_REP")) {
        redirect("/admin/login");
    }

    const { id } = await params;
    const clientId = parseInt(id);

    // Fetch full client details
    const client = await prisma.client.findUnique({
        where: { id: clientId },
        include: {
            rep: true,
            contacts: true,
            orders: {
                orderBy: { createdAt: "desc" },
                include: { items: true }
            },
            payments: {
                orderBy: { paymentDate: "desc" }
            },
            interactions: {
                orderBy: { date: "desc" }
            }
        }
    });

    if (!client) {
        redirect("/admin/clients");
    }

    // Security: Only rep can see their own clients unless admin/manager
    if (session.user.role === "SALES_REP" && client.repId !== session.user.id) {
        redirect("/admin/clients");
    }

    const totalOrdersValue = client.orders.reduce((sum: number, order: any) => sum + order.totalAmount, 0);
    const totalPaymentsValue = client.payments.reduce((sum: number, pay: any) => sum + pay.amount, 0);

    return (
        <div className="space-y-6 pb-20 font-sans" dir="rtl">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-5 rounded-3xl border border-gray-100 shadow-sm relative overflow-hidden">
                <div className="absolute left-0 top-0 w-32 h-32 bg-green-50 rounded-br-full opacity-50 pointer-events-none" />
                <div className="flex items-center gap-4 relative z-10">
                    <Link href="/admin/clients" className="p-2.5 bg-slate-50 hover:bg-slate-100 rounded-xl transition-colors">
                        <ArrowRight className="w-5 h-5 text-slate-600" />
                    </Link>
                    <div className="w-14 h-14 rounded-2xl bg-gradient-to-br from-green-500 to-emerald-600 text-white flex items-center justify-center text-xl font-black shadow-lg shadow-green-500/30">
                        {client.name.charAt(0)}
                    </div>
                    <div>
                        <h1 className="text-2xl font-black text-slate-800 flex items-center gap-2">
                            {client.name}
                            <span className={`text-[10px] px-2 py-1 rounded-md font-bold ${client.status === 'ACTIVE' ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}`}>
                                {client.status}
                            </span>
                        </h1>
                        <div className="flex items-center gap-3 mt-1.5 text-xs font-bold text-slate-500">
                            {client.company && <span className="flex items-center gap-1"><Building2 className="w-3.5 h-3.5"/> {client.company}</span>}
                            {client.governorate && <span className="flex items-center gap-1"><MapPin className="w-3.5 h-3.5"/> {client.governorate}</span>}
                        </div>
                    </div>
                </div>

                {/* Interactive Client Actions Component (Client Component) */}
                <div className="relative z-10 w-full sm:w-auto">
                    <ClientProfileActions clientId={client.id} />
                </div>
            </div>

            {/* Financial Highlights */}
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="bg-white p-6 rounded-3xl border border-red-100 shadow-sm flex items-center gap-4 relative overflow-hidden group hover:border-red-200 transition-colors">
                    <div className="w-14 h-14 bg-red-50 text-red-500 rounded-2xl flex items-center justify-center group-hover:scale-110 transition-transform">
                        <DollarSign className="w-7 h-7" />
                    </div>
                    <div>
                        <p className="text-xs font-bold text-slate-500 mb-1">المديونية الحالية</p>
                        <h3 className="text-2xl font-black text-red-600" dir="ltr">{client.outstandingBalance.toLocaleString()} <span className="text-sm">ج.م</span></h3>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-3xl border border-emerald-100 shadow-sm flex items-center gap-4 relative overflow-hidden group hover:border-emerald-200 transition-colors">
                    <div className="w-14 h-14 bg-emerald-50 text-emerald-500 rounded-2xl flex items-center justify-center group-hover:scale-110 transition-transform">
                        <Wallet className="w-7 h-7" />
                    </div>
                    <div>
                        <p className="text-xs font-bold text-slate-500 mb-1">إجمالي المدفوعات (السداد)</p>
                        <h3 className="text-2xl font-black text-emerald-600" dir="ltr">{totalPaymentsValue.toLocaleString()} <span className="text-sm">ج.م</span></h3>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-3xl border border-blue-100 shadow-sm flex items-center gap-4 relative overflow-hidden group hover:border-blue-200 transition-colors">
                    <div className="w-14 h-14 bg-blue-50 text-blue-500 rounded-2xl flex items-center justify-center group-hover:scale-110 transition-transform">
                        <TrendingUp className="w-7 h-7" />
                    </div>
                    <div>
                        <p className="text-xs font-bold text-slate-500 mb-1">إجمالي المسحوبات (المبيعات)</p>
                        <h3 className="text-2xl font-black text-blue-600" dir="ltr">{totalOrdersValue.toLocaleString()} <span className="text-sm">ج.م</span></h3>
                    </div>
                </div>
            </div>

            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                
                {/* Right Column: Information & Interactions */}
                <div className="space-y-6 lg:col-span-1">
                    {/* General Info */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm p-6">
                        <h3 className="text-base font-black text-slate-800 mb-4 flex items-center gap-2">
                            <Building2 className="w-5 h-5 text-indigo-500" /> معلومات المنفذ
                        </h3>
                        <div className="space-y-4">
                            <div className="flex justify-between items-center py-2 border-b border-slate-50">
                                <span className="text-xs font-bold text-slate-500">رقم الهاتف</span>
                                <span className="text-sm font-black text-slate-700" dir="ltr">{client.mainPhone || "-"}</span>
                            </div>
                            <div className="flex justify-between items-center py-2 border-b border-slate-50">
                                <span className="text-xs font-bold text-slate-500">نوع المنفذ</span>
                                <span className="text-sm font-black text-slate-700">{client.storeType || "-"}</span>
                            </div>
                            <div className="flex justify-between items-center py-2 border-b border-slate-50">
                                <span className="text-xs font-bold text-slate-500">الحد الائتماني المسموح</span>
                                <span className="text-sm font-black text-slate-700" dir="ltr">{client.creditLimit.toLocaleString()} ج.م</span>
                            </div>
                            <div className="flex justify-between items-center py-2 border-b border-slate-50">
                                <span className="text-xs font-bold text-slate-500">المندوب المسئول</span>
                                <span className="text-sm font-black text-blue-600 bg-blue-50 px-2 py-1 rounded-md">{client.rep?.name || "-"}</span>
                            </div>
                        </div>
                    </div>

                    {/* Follow ups / Interactions */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm p-6">
                        <div className="flex justify-between items-center mb-4">
                            <h3 className="text-base font-black text-slate-800 flex items-center gap-2">
                                <Calendar className="w-5 h-5 text-amber-500" /> سجل الزيارات والمتابعة
                            </h3>
                        </div>
                        {client.interactions.length > 0 ? (
                            <div className="space-y-4 relative before:absolute before:inset-0 before:ml-5 before:-translate-x-px md:before:mx-auto md:before:translate-x-0 before:h-full before:w-0.5 before:bg-gradient-to-b before:from-transparent before:via-slate-200 before:to-transparent pr-4 border-r-2 border-slate-100">
                                {client.interactions.map((interaction: any) => (
                                    <div key={interaction.id} className="relative">
                                        <div className="absolute -right-6 top-1.5 w-3 h-3 bg-amber-400 rounded-full border-4 border-white shadow-sm" />
                                        <div className="bg-slate-50 p-3 rounded-2xl">
                                            <div className="flex justify-between items-center mb-2">
                                                <span className="text-xs font-black text-slate-700">{interaction.type === "VISIT" ? "زيارة ميدانية" : "اتصال هاتفي"}</span>
                                                <span className="text-[10px] font-bold text-slate-400">{new Date(interaction.date).toLocaleDateString('ar-EG')}</span>
                                            </div>
                                            <p className="text-xs font-bold text-slate-500 leading-relaxed">{interaction.notes}</p>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        ) : (
                            <div className="text-center py-6 text-slate-400 font-bold text-sm bg-slate-50 rounded-2xl border border-dashed border-slate-200">
                                لم يتم تسجيل أي متابعة أو زيارة بعد
                            </div>
                        )}
                    </div>
                </div>

                {/* Left Column: Orders & Payments */}
                <div className="lg:col-span-2 space-y-6">
                    
                    {/* Orders History */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                        <div className="p-6 border-b border-slate-50 flex justify-between items-center">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <PackageOpen className="w-5 h-5 text-blue-500" /> الفواتير والمسحوبات
                            </h2>
                            <span className="text-xs font-bold text-blue-600 bg-blue-50 px-3 py-1.5 rounded-lg">{client.orders.length} طلبات</span>
                        </div>
                        <div className="p-0">
                            <table className="w-full">
                                <thead>
                                    <tr className="bg-slate-50/50 text-slate-500 text-xs font-bold">
                                        <th className="py-3 px-6 text-right">رقم الفاتورة</th>
                                        <th className="py-3 px-6 text-right">التاريخ</th>
                                        <th className="py-3 px-6 text-center">عدد الأصناف</th>
                                        <th className="py-3 px-6 text-center">الإجمالي</th>
                                        <th className="py-3 px-6 text-center">خيارات</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {client.orders.length > 0 ? client.orders.map((order: any) => (
                                        <tr key={order.id} className="hover:bg-slate-50/50 transition-colors">
                                            <td className="py-4 px-6 font-black text-slate-700">#{order.id}</td>
                                            <td className="py-4 px-6 text-xs font-bold text-slate-500">{new Date(order.createdAt).toLocaleDateString("ar-EG")}</td>
                                            <td className="py-4 px-6 text-center text-sm font-bold text-slate-600">{order.items?.length || 0} صنف</td>
                                            <td className="py-4 px-6 text-center font-black text-blue-600" dir="ltr">{order.totalAmount.toLocaleString()} ج.م</td>
                                            <td className="py-4 px-6 text-center">
                                                <Link href={`/admin/invoice/${order.id}`} className="text-xs font-bold text-indigo-600 hover:underline">
                                                    عرض وطباعة
                                                </Link>
                                            </td>
                                        </tr>
                                    )) : (
                                        <tr><td colSpan={5} className="py-8 text-center text-slate-400 font-bold">لا توجد مسحوبات للعميل</td></tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Payments Ledger */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                        <div className="p-6 border-b border-slate-50 flex justify-between items-center bg-gradient-to-l from-emerald-50/50 to-transparent">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <CreditCard className="w-5 h-5 text-emerald-500" /> سجل سداد الدفعات (سندات القبض)
                            </h2>
                        </div>
                        <div className="p-0">
                            <table className="w-full">
                                <thead>
                                    <tr className="bg-slate-50/50 text-slate-500 text-xs font-bold">
                                        <th className="py-3 px-6 text-right">رقم السند</th>
                                        <th className="py-3 px-6 text-right">التاريخ</th>
                                        <th className="py-3 px-6 text-right">طريقة الدفع</th>
                                        <th className="py-3 px-6 text-center">المبلغ المسدد</th>
                                        <th className="py-3 px-6 text-right">ملاحظات</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {client.payments.length > 0 ? client.payments.map((payment: any) => (
                                        <tr key={payment.id} className="hover:bg-slate-50/50 transition-colors">
                                            <td className="py-4 px-6 font-black text-slate-700">#{payment.id}</td>
                                            <td className="py-4 px-6 text-xs font-bold text-slate-500">{new Date(payment.paymentDate).toLocaleDateString("ar-EG")}</td>
                                            <td className="py-4 px-6 text-xs font-bold text-emerald-700">
                                                <span className="bg-emerald-50 px-2 py-1 rounded-md">
                                                    {payment.method === "CASH" ? "نقدي" : payment.method === "TRANSFER" ? "تحويل بنكي" : "شيك"}
                                                </span>
                                            </td>
                                            <td className="py-4 px-6 text-center font-black text-emerald-600" dir="ltr">+{payment.amount.toLocaleString()} ج.م</td>
                                            <td className="py-4 px-6 text-xs font-bold text-slate-500 max-w-[150px] truncate">{payment.notes || "-"}</td>
                                        </tr>
                                    )) : (
                                        <tr><td colSpan={5} className="py-8 text-center text-slate-400 font-bold">لم يتم تسجيل أي دفعات سداد</td></tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    );
}
