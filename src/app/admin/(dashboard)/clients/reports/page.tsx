import { prisma } from "@/lib/prisma";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { redirect } from "next/navigation";
import { 
    Users, CreditCard, TrendingUp, Package, Clock, 
    ArrowRight, Activity, DollarSign, ShoppingCart, Award, MapPin
} from "lucide-react";
import Link from "next/link";

export default async function ClientReportsPage() {
    const session = await getServerSession(authOptions);
    if (!session || (session.user.role !== "ADMIN" && session.user.role !== "SALES_MANAGER")) {
        redirect("/admin/login");
    }

    // 1. Summary Cards Data
    const totalClients = await prisma.client.count();
    
    const debtAggregation = await prisma.client.aggregate({
        _sum: { outstandingBalance: true }
    });
    const totalDebt = debtAggregation._sum.outstandingBalance || 0;

    const salesAggregation = await prisma.clientOrder.aggregate({
        _sum: { totalAmount: true }
    });
    const totalSales = salesAggregation._sum.totalAmount || 0;

    const orderCount = await prisma.clientOrder.count();

    // 2. Recent Orders
    const recentOrders = await prisma.clientOrder.findMany({
        take: 5,
        orderBy: { createdAt: "desc" },
        include: { client: true, rep: true }
    });

    // 3. Top Clients by Total Purchases
    const topClientSales = await prisma.clientOrder.groupBy({
        by: ['clientId'],
        _sum: { totalAmount: true },
        orderBy: { _sum: { totalAmount: 'desc' } },
        take: 5
    });

    const topClientsData = await Promise.all(topClientSales.map(async (tc) => {
        const client = await prisma.client.findUnique({ where: { id: tc.clientId } });
        return {
            client,
            totalSales: tc._sum.totalAmount || 0
        };
    }));

    // 4. Top Products by Quantity Sold
    const topProductsRaw = await prisma.orderItem.groupBy({
        by: ['productId', 'customItemName'],
        _sum: { quantity: true, subtotal: true },
        orderBy: { _sum: { quantity: 'desc' } },
        take: 8
    });

    const topProductsData = await Promise.all(topProductsRaw.map(async (tp) => {
        let name = tp.customItemName || "منتج مخصص";
        let image = null;
        if (tp.productId) {
            const prod = await prisma.product.findUnique({ where: { id: tp.productId } });
            if (prod) {
                name = prod.name_ar;
                image = prod.featured_image;
            }
        }
        return {
            name,
            image,
            quantity: tp._sum?.quantity || 0,
            revenue: tp._sum?.subtotal || 0
        };
    }));

    // 5. Regional Sales (Governorates)
    const clientsWithOrders = await prisma.client.findMany({
        select: {
            governorate: true,
            orders: { select: { totalAmount: true } }
        }
    });

    const regionSales: Record<string, { totalSales: number; clientsCount: number }> = {};
    for (const c of clientsWithOrders) {
        const gov = c.governorate || "غير محدد";
        if (!regionSales[gov]) regionSales[gov] = { totalSales: 0, clientsCount: 0 };
        
        regionSales[gov].clientsCount++;
        const sales = c.orders.reduce((sum: number, order: any) => sum + order.totalAmount, 0);
        regionSales[gov].totalSales += sales;
    }

    const topRegions = Object.entries(regionSales)
        .map(([name, data]) => ({ name, ...data }))
        .sort((a, b) => b.totalSales - a.totalSales)
        .slice(0, 10);

    return (
        <div className="space-y-6 pb-20 font-sans" dir="rtl">
            {/* Header */}
            <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4 bg-white p-5 rounded-3xl border border-gray-100 shadow-sm">
                <div>
                    <div className="flex items-center gap-3">
                        <Link href="/admin/clients" className="p-2 hover:bg-slate-100 rounded-xl transition-colors">
                            <ArrowRight className="w-5 h-5 text-slate-500" />
                        </Link>
                        <h1 className="text-2xl font-black text-slate-800">تقارير مبيعات العملاء</h1>
                    </div>
                    <p className="text-sm text-slate-500 mt-1 font-medium pr-12">نظرة شاملة على حركة المبيعات الميدانية والمديونيات</p>
                </div>
                <div className="bg-blue-50 text-blue-700 px-4 py-2 rounded-xl text-sm font-bold flex items-center gap-2 border border-blue-100">
                    <Activity className="w-4 h-4" /> يتم التحديث مباشرة
                </div>
            </div>

            {/* KPI Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between relative overflow-hidden group">
                    <div className="absolute -right-6 -top-6 w-24 h-24 bg-blue-50 rounded-full opacity-50 group-hover:scale-150 transition-transform duration-500" />
                    <div className="flex justify-between items-start mb-4 relative z-10">
                        <div>
                            <p className="text-slate-500 font-bold text-sm">إجمالي العملاء</p>
                            <h3 className="text-3xl font-black text-slate-800 mt-1">{totalClients}</h3>
                        </div>
                        <div className="w-12 h-12 bg-blue-100 text-blue-600 rounded-2xl flex items-center justify-center shadow-inner">
                            <Users className="w-6 h-6" />
                        </div>
                    </div>
                    <p className="text-xs font-bold text-slate-400 relative z-10">العملاء الميدانيين المسجلين بالنظام</p>
                </div>

                <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between relative overflow-hidden group">
                    <div className="absolute -right-6 -top-6 w-24 h-24 bg-emerald-50 rounded-full opacity-50 group-hover:scale-150 transition-transform duration-500" />
                    <div className="flex justify-between items-start mb-4 relative z-10">
                        <div>
                            <p className="text-slate-500 font-bold text-sm">إجمالي المبيعات الميدانية</p>
                            <h3 className="text-2xl font-black text-emerald-600 mt-1" dir="ltr">{totalSales.toLocaleString()} <span className="text-sm">ج.م</span></h3>
                        </div>
                        <div className="w-12 h-12 bg-emerald-100 text-emerald-600 rounded-2xl flex items-center justify-center shadow-inner">
                            <TrendingUp className="w-6 h-6" />
                        </div>
                    </div>
                    <p className="text-xs font-bold text-slate-400 relative z-10">قيمة جميع الطلبات المنفذة</p>
                </div>

                <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between relative overflow-hidden group">
                    <div className="absolute -right-6 -top-6 w-24 h-24 bg-red-50 rounded-full opacity-50 group-hover:scale-150 transition-transform duration-500" />
                    <div className="flex justify-between items-start mb-4 relative z-10">
                        <div>
                            <p className="text-slate-500 font-bold text-sm">مديونيات السوق</p>
                            <h3 className="text-2xl font-black text-red-500 mt-1" dir="ltr">{totalDebt.toLocaleString()} <span className="text-sm">ج.م</span></h3>
                        </div>
                        <div className="w-12 h-12 bg-red-100 text-red-500 rounded-2xl flex items-center justify-center shadow-inner">
                            <DollarSign className="w-6 h-6" />
                        </div>
                    </div>
                    <p className="text-xs font-bold text-slate-400 relative z-10">إجمالي المبالغ المستحقة للتحصيل</p>
                </div>

                <div className="bg-white p-6 rounded-3xl border border-slate-100 shadow-sm flex flex-col justify-between relative overflow-hidden group">
                    <div className="absolute -right-6 -top-6 w-24 h-24 bg-purple-50 rounded-full opacity-50 group-hover:scale-150 transition-transform duration-500" />
                    <div className="flex justify-between items-start mb-4 relative z-10">
                        <div>
                            <p className="text-slate-500 font-bold text-sm">إجمالي الطلبيات</p>
                            <h3 className="text-3xl font-black text-slate-800 mt-1">{orderCount}</h3>
                        </div>
                        <div className="w-12 h-12 bg-purple-100 text-purple-600 rounded-2xl flex items-center justify-center shadow-inner">
                            <ShoppingCart className="w-6 h-6" />
                        </div>
                    </div>
                    <p className="text-xs font-bold text-slate-400 relative z-10">عدد الفواتير المصدرة من المندوبين</p>
                </div>
            </div>

            {/* Main Content Grid */}
            <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
                
                {/* Column 1: Top Clients & Recent Orders */}
                <div className="lg:col-span-2 space-y-6">
                    
                    {/* Top Clients */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                        <div className="p-6 border-b border-slate-50 flex justify-between items-center">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <Award className="w-5 h-5 text-amber-500" /> كبار العملاء (أعلى مسحوبات)
                            </h2>
                        </div>
                        <div className="p-0">
                            <table className="w-full">
                                <thead>
                                    <tr className="bg-slate-50/50 text-slate-500 text-xs font-bold">
                                        <th className="py-3 px-6 text-right">العميل</th>
                                        <th className="py-3 px-6 text-right">المتجر</th>
                                        <th className="py-3 px-6 text-center">إجمالي المسحوبات</th>
                                        <th className="py-3 px-6 text-center">المديونية الحالية</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {topClientsData.length > 0 ? topClientsData.map((data, i) => (
                                        <tr key={i} className="hover:bg-slate-50/50 transition-colors">
                                            <td className="py-4 px-6">
                                                <div className="font-bold text-slate-800">{data.client?.name || "عميل محذوف"}</div>
                                                <div className="text-xs text-slate-500 mt-0.5">{data.client?.mainPhone}</div>
                                            </td>
                                            <td className="py-4 px-6 text-sm font-bold text-slate-600">{data.client?.company || "-"}</td>
                                            <td className="py-4 px-6 text-center font-black text-blue-600 bg-blue-50/30" dir="ltr">{data.totalSales.toLocaleString()} ج.م</td>
                                            <td className="py-4 px-6 text-center font-bold text-red-500" dir="ltr">{data.client?.outstandingBalance.toLocaleString()} ج.م</td>
                                        </tr>
                                    )) : (
                                        <tr><td colSpan={4} className="py-8 text-center text-slate-400 font-bold">لا يوجد بيانات</td></tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Recent Orders */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden">
                        <div className="p-6 border-b border-slate-50 flex justify-between items-center">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <Clock className="w-5 h-5 text-blue-500" /> أحدث الطلبيات
                            </h2>
                            <Link href="/admin/clients" className="text-xs font-bold text-blue-600 hover:text-blue-700 bg-blue-50 px-3 py-1.5 rounded-lg">عرض الكل</Link>
                        </div>
                        <div className="p-0">
                            <table className="w-full">
                                <thead>
                                    <tr className="bg-slate-50/50 text-slate-500 text-xs font-bold">
                                        <th className="py-3 px-6 text-right">رقم الفاتورة</th>
                                        <th className="py-3 px-6 text-right">العميل</th>
                                        <th className="py-3 px-6 text-right">المندوب</th>
                                        <th className="py-3 px-6 text-center">القيمة</th>
                                        <th className="py-3 px-6 text-center">التاريخ</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {recentOrders.length > 0 ? recentOrders.map(order => (
                                        <tr key={order.id} className="hover:bg-slate-50/50 transition-colors">
                                            <td className="py-3 px-6 font-black text-slate-700">#{order.id}</td>
                                            <td className="py-3 px-6 font-bold text-slate-800">{order.client?.name || "محذوف"}</td>
                                            <td className="py-3 px-6 text-sm font-bold text-slate-500">{order.rep?.name || "-"}</td>
                                            <td className="py-3 px-6 text-center font-black text-emerald-600" dir="ltr">{order.totalAmount.toLocaleString()} ج.م</td>
                                            <td className="py-3 px-6 text-center text-xs font-bold text-slate-400">{new Date(order.createdAt).toLocaleDateString("ar-EG")}</td>
                                        </tr>
                                    )) : (
                                        <tr><td colSpan={5} className="py-8 text-center text-slate-400 font-bold">لا يوجد طلبيات</td></tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {/* Regional Sales */}
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden mt-6">
                        <div className="p-6 border-b border-slate-50 flex justify-between items-center bg-gradient-to-l from-emerald-50/50 to-transparent">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <MapPin className="w-5 h-5 text-emerald-500" /> أعلى المسحوبات الجغرافية (بالمحافظة/المنطقة)
                            </h2>
                        </div>
                        <div className="p-0">
                            <table className="w-full">
                                <thead>
                                    <tr className="bg-slate-50/50 text-slate-500 text-xs font-bold">
                                        <th className="py-3 px-6 text-right">المحافظة / المنطقة</th>
                                        <th className="py-3 px-6 text-center">عدد العملاء</th>
                                        <th className="py-3 px-6 text-center">إجمالي المسحوبات</th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-slate-50">
                                    {topRegions.length > 0 ? topRegions.map((region, i) => (
                                        <tr key={i} className="hover:bg-slate-50/50 transition-colors">
                                            <td className="py-4 px-6 font-bold text-slate-800 flex items-center gap-2">
                                                <div className="w-8 h-8 rounded-lg bg-emerald-100 flex items-center justify-center text-emerald-600">
                                                    <MapPin className="w-4 h-4" />
                                                </div>
                                                {region.name}
                                            </td>
                                            <td className="py-4 px-6 text-center text-sm font-bold text-slate-600">{region.clientsCount} عملاء</td>
                                            <td className="py-4 px-6 text-center font-black text-emerald-600 bg-emerald-50/30" dir="ltr">{region.totalSales.toLocaleString()} ج.م</td>
                                        </tr>
                                    )) : (
                                        <tr><td colSpan={3} className="py-8 text-center text-slate-400 font-bold">لا يوجد مسحوبات جغرافية</td></tr>
                                    )}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                {/* Column 2: Top Products */}
                <div className="space-y-6">
                    <div className="bg-white rounded-3xl border border-slate-100 shadow-sm overflow-hidden h-full">
                        <div className="p-6 border-b border-slate-50">
                            <h2 className="text-lg font-black text-slate-800 flex items-center gap-2">
                                <Package className="w-5 h-5 text-indigo-500" /> أكثر المنتجات سحباً
                            </h2>
                            <p className="text-xs text-slate-400 font-bold mt-1">مرتبة حسب الكمية المباعة</p>
                        </div>
                        <div className="p-4 space-y-3">
                            {topProductsData.length > 0 ? topProductsData.map((prod, i) => (
                                <div key={i} className="flex items-center justify-between p-3 bg-slate-50 rounded-2xl hover:bg-slate-100 transition-colors">
                                    <div className="flex items-center gap-3">
                                        <div className="w-12 h-12 bg-white rounded-xl flex items-center justify-center text-xl shadow-sm overflow-hidden">
                                            {prod.image ? (
                                                <img src={prod.image} alt={prod.name} className="w-full h-full object-cover" />
                                            ) : (
                                                "📦"
                                            )}
                                        </div>
                                        <div>
                                            <div className="font-bold text-slate-800 text-sm line-clamp-1">{prod.name}</div>
                                            <div className="text-xs font-bold text-indigo-600 mt-0.5" dir="ltr">{prod.revenue.toLocaleString()} ج.م</div>
                                        </div>
                                    </div>
                                    <div className="text-center bg-white px-3 py-1.5 rounded-lg shadow-sm border border-slate-100">
                                        <div className="text-[10px] text-slate-400 font-bold">الكمية</div>
                                        <div className="font-black text-slate-700">{prod.quantity}</div>
                                    </div>
                                </div>
                            )) : (
                                <div className="py-8 text-center text-slate-400 font-bold">لا يوجد منتجات مباعة</div>
                            )}
                        </div>
                    </div>
                </div>

            </div>
        </div>
    );
}
