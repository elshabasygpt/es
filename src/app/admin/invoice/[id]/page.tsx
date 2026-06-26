import { prisma } from "@/lib/prisma";
import { notFound, redirect } from "next/navigation";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import Image from "next/image";
import InvoiceActions from "./InvoiceActions";

export default async function InvoicePage({ params }: { params: Promise<{ id: string }> }) {
    const session = await getServerSession(authOptions);
    if (!session) {
        redirect("/admin/login");
    }

    const p = await params;
    const orderId = parseInt(p.id);
    if (isNaN(orderId)) return notFound();

    const order = await prisma.clientOrder.findUnique({
        where: { id: orderId },
        include: {
            client: true,
            rep: true,
            items: {
                include: {
                    product: true
                }
            }
        }
    });

    if (!order) return notFound();

    const waMessage = `*مصنع السلام للزيوت النباتية والسمن*
طلب رقم: #${order.id}
التاريخ: ${new Date(order.createdAt).toLocaleDateString("ar-EG")}

*المنتجات:*
${order.items.map(i => `- ${i.product ? i.product.name_ar : i.customItemName} (الكمية: ${i.quantity}) = ${i.subtotal} ج.م`).join('\n')}

*الإجمالي المطلوب:* ${order.totalAmount} ج.م
*المديونية المتبقية:* ${order.client.outstandingBalance} ج.م

شكراً لتعاملكم معنا!`;

    return (
        <div className="min-h-screen bg-slate-100 print:bg-white p-4 sm:p-8 font-sans" dir="rtl">
            <InvoiceActions phone={order.client.mainPhone || ''} message={waMessage} />

            {/* A4 Printable Sheet */}
            <div className="max-w-4xl mx-auto bg-white p-8 sm:p-12 shadow-xl print:shadow-none print:p-0 print:max-w-none rounded-[32px] print:rounded-none border border-slate-100 print:border-none">
                
                {/* Header */}
                <div className="flex flex-col sm:flex-row justify-between items-start border-b-2 border-slate-100 pb-8 mb-8 gap-6">
                    <div className="flex items-center gap-4">
                        <div className="w-24 h-24 bg-gradient-to-br from-green-50 to-emerald-100/50 rounded-2xl flex items-center justify-center p-3 shadow-inner">
                            <Image src="/logo.png" alt="Logo" width={80} height={80} className="object-contain drop-shadow-sm" />
                        </div>
                        <div>
                            <h1 className="text-3xl font-black text-slate-800 tracking-tight">مصنع السلام</h1>
                            <p className="text-slate-500 font-bold text-sm mt-1 bg-slate-50 inline-block px-3 py-1 rounded-lg">للزيوت النباتية والسمن</p>
                        </div>
                    </div>
                    <div className="text-right sm:text-left bg-slate-50 sm:bg-transparent p-4 sm:p-0 rounded-2xl w-full sm:w-auto">
                        <h2 className="text-4xl font-black text-slate-200 uppercase tracking-widest mb-3 print:text-slate-300">فاتورة</h2>
                        <div className="flex flex-col gap-1">
                            <div className="text-slate-700 font-bold text-lg bg-white sm:bg-transparent px-3 sm:px-0 py-1 rounded-lg">رقم الطلب: #{order.id}</div>
                            <div className="text-slate-500 text-sm font-bold px-3 sm:px-0">التاريخ: {new Date(order.createdAt).toLocaleDateString("ar-EG")}</div>
                        </div>
                    </div>
                </div>

                {/* Info Cards */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-10">
                    <div className="bg-blue-50/50 p-6 rounded-2xl border border-blue-100/50">
                        <h3 className="text-xs font-black text-blue-400 uppercase tracking-wider mb-4">فاتورة إلى:</h3>
                        <div className="text-2xl font-black text-slate-800 mb-1">{order.client.name}</div>
                        <div className="text-slate-600 font-bold bg-white inline-block px-3 py-1 rounded-lg text-sm mb-3 shadow-sm">{order.client.company || "عميل تجزئة/جملة"}</div>
                        <div className="text-slate-600 text-sm font-bold flex items-center gap-2">
                            <span className="bg-white p-1.5 rounded-md shadow-sm">📞</span> 
                            <span dir="ltr">{order.client.mainPhone || "لا يوجد رقم"}</span>
                        </div>
                    </div>
                    
                    <div className="bg-slate-50 p-6 rounded-2xl border border-slate-100 flex flex-col justify-center gap-4">
                        <div className="flex justify-between items-center bg-white px-4 py-3 rounded-xl shadow-sm">
                            <span className="text-slate-500 text-sm font-bold">المندوب المسئول</span>
                            <span className="text-slate-800 font-black">{order.rep?.name || "غير محدد"}</span>
                        </div>
                        <div className="flex justify-between items-center bg-white px-4 py-3 rounded-xl shadow-sm">
                            <span className="text-slate-500 text-sm font-bold">حالة الطلب</span>
                            <span className="text-green-600 font-black bg-green-50 px-3 py-1 rounded-lg">{order.status === "DELIVERED" ? "تم التوصيل" : "جديد"}</span>
                        </div>
                        <div className="flex justify-between items-center bg-red-50 px-4 py-3 rounded-xl border border-red-100">
                            <span className="text-red-500 text-sm font-bold">رصيد المديونية</span>
                            <span className="text-red-600 font-black" dir="ltr">{order.client.outstandingBalance.toLocaleString()} ج.م</span>
                        </div>
                    </div>
                </div>

                {/* Items Table */}
                <div className="overflow-hidden rounded-2xl border border-slate-200 mb-10">
                    <table className="w-full border-collapse">
                        <thead>
                            <tr className="bg-slate-800 text-white">
                                <th className="py-4 px-6 text-right font-bold w-1/2">المنتج</th>
                                <th className="py-4 px-4 text-center font-bold">الكمية</th>
                                <th className="py-4 px-4 text-center font-bold">سعر الوحدة</th>
                                <th className="py-4 px-6 text-left font-bold bg-slate-900">الإجمالي</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100 text-slate-800 bg-white">
                            {order.items.map((item, index) => (
                                <tr key={index} className="hover:bg-slate-50 transition-colors">
                                    <td className="py-5 px-6 font-bold">{item.product ? item.product.name_ar : item.customItemName}</td>
                                    <td className="py-5 px-4 text-center font-black bg-slate-50/50">{item.quantity}</td>
                                    <td className="py-5 px-4 text-center font-bold text-slate-600" dir="ltr">{item.unitPrice.toLocaleString()} ج.م</td>
                                    <td className="py-5 px-6 text-left font-black text-blue-700 bg-blue-50/30" dir="ltr">{item.subtotal.toLocaleString()} ج.م</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                {/* Totals */}
                <div className="flex justify-end mb-12">
                    <div className="w-full sm:w-2/3 md:w-1/2 bg-gradient-to-r from-blue-600 to-blue-800 p-8 rounded-3xl shadow-lg print:shadow-none print:border print:border-slate-800 text-white">
                        <div className="flex justify-between items-center">
                            <span className="text-lg font-bold text-blue-100">إجمالي الفاتورة المطلوب:</span>
                            <span className="text-4xl font-black tracking-tight" dir="ltr">{order.totalAmount.toLocaleString()} ج.م</span>
                        </div>
                    </div>
                </div>

                {/* Footer Notes */}
                <div className="border-t-2 border-dashed border-slate-200 pt-8 text-slate-500 text-sm leading-relaxed">
                    <h4 className="font-bold text-slate-700 mb-3 flex items-center gap-2">
                        <span className="w-2 h-2 rounded-full bg-slate-400"></span> ملاحظات الطلب
                    </h4>
                    {order.notes ? (
                        <p className="mb-6 text-slate-600 font-medium bg-slate-50 p-4 rounded-xl">{order.notes}</p>
                    ) : (
                        <p className="mb-6 italic text-slate-400">لا توجد ملاحظات إضافية لهذا الطلب.</p>
                    )}
                    
                    <div className="flex flex-col sm:flex-row justify-between items-center bg-slate-800 text-slate-300 p-6 rounded-2xl mt-8 text-xs font-bold gap-4 print:bg-white print:text-slate-800 print:border print:border-slate-300">
                        <p className="text-white print:text-slate-800 text-sm">شكراً لتعاملكم وثقتكم في مصنع السلام.</p>
                        <p className="text-center sm:text-left opacity-80">يُرجى مراجعة البضاعة قبل استلامها، البضاعة المباعة لا ترد ولا تستبدل بعد استلامها بحالة جيدة.</p>
                    </div>
                </div>

            </div>
        </div>
    );
}
