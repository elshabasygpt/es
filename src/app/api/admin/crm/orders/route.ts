import { handleApiError } from "@/lib/error-handler";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET(req: NextRequest) {
    const session = await getServerSession(authOptions);
    if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const role = session.user.role;
    if (role !== "ADMIN" && role !== "SALES_MANAGER" && role !== "SALES_REP") {
        return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    try {
        let where: any = {};
        
        // SALES_REP can only see their own orders
        if (role === "SALES_REP") {
            where.repId = session.user.id;
        }

        const orders = await prisma.clientOrder.findMany({
            where,
            include: {
                client: { select: { id: true, name: true, storeType: true } },
                rep: { select: { name: true, email: true } },
                items: {
                    include: {
                        product: { select: { name_ar: true, name_en: true, featured_image: true, price: true } }
                    }
                }
            },
            orderBy: { createdAt: "desc" }
        });

        return NextResponse.json(orders);
    } catch (e: any) {
        return handleApiError(e, "Failed to fetch orders");
    }
}

export async function POST(req: NextRequest) {
    const session = await getServerSession(authOptions);
    if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const role = session.user.role;
    if (role !== "ADMIN" && role !== "SALES_MANAGER" && role !== "SALES_REP") {
        return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    try {
        const body = await req.json();

        if (!body.clientId || !body.items || !body.items.length) {
             return NextResponse.json({ error: "Missing required fields (clientId, items)" }, { status: 400 });
        }

        const client = await prisma.client.findUnique({ where: { id: parseInt(body.clientId) } });
        if (!client) return NextResponse.json({ error: "Client not found" }, { status: 404 });

        // Admin can create orders for any client, assigning the order to the client's rep.
        // Sales Reps can only create orders for their own clients.
        const repId = role === "SALES_REP" ? session.user.id : (body.repId || client.repId || session.user.id);

        // Validate client belongs to rep (if role is SALES_REP)
        if (role === "SALES_REP") {
            if (!client || client.repId !== session.user.id) {
                return NextResponse.json({ error: "Client not found or unassigned to you." }, { status: 403 });
            }
        }

        // Calculate totals from latest product prices (so the rep cannot tamper with prices)
        let totalAmount = 0;
        const processedItems: any[] = [];

        for (const item of body.items) {
            if (item.productId === "custom") {
                const unitPrice = item.price !== undefined ? parseFloat(item.price) : 0;
                const subtotal = unitPrice * parseInt(item.quantity);
                totalAmount += subtotal;

                processedItems.push({
                    customItemName: item.productName || "منتج مخصص",
                    quantity: parseInt(item.quantity),
                    unitPrice: unitPrice,
                    subtotal: subtotal
                });
            } else {
                const product = await prisma.product.findUnique({ where: { id: parseInt(item.productId) } });
                if (!product) continue;

                const unitPrice = item.price !== undefined ? parseFloat(item.price) : (product.price || 0);
                const subtotal = unitPrice * parseInt(item.quantity);
                totalAmount += subtotal;

                processedItems.push({
                    productId: product.id,
                    quantity: parseInt(item.quantity),
                    unitPrice: unitPrice,
                    subtotal: subtotal
                });
            }
        }

        // ✅ Enforce Credit Limit — reject if new order would exceed it
        if (client.creditLimit > 0) {
            const newOutstanding = client.outstandingBalance + totalAmount;
            if (newOutstanding > client.creditLimit) {
                return NextResponse.json({
                    error: `تجاوز حد الائتمان. الحد المتاح: ${client.creditLimit.toFixed(2)} ج.م، الرصيد الحالي: ${client.outstandingBalance.toFixed(2)} ج.م، قيمة الطلب: ${totalAmount.toFixed(2)} ج.م`
                }, { status: 400 });
            }
        }

        const newOrder = await prisma.$transaction(async (tx) => {
            const order = await tx.clientOrder.create({
                data: {
                    clientId: parseInt(body.clientId),
                    repId: repId,
                    status: body.createdAt ? "DELIVERED" : "NEW", // If backdated manual order, usually it's already delivered
                    totalAmount: totalAmount,
                    notes: body.notes || null,
                    expectedDate: body.expectedDate ? new Date(body.expectedDate) : null,
                    createdAt: body.createdAt ? new Date(body.createdAt) : undefined,
                    invoiceFile: body.invoiceFile || null,
                    items: {
                        create: processedItems
                    }
                },
                include: {
                    items: true
                }
            });

            // ✅ Auto-update outstanding balance
            await tx.client.update({
                where: { id: parseInt(body.clientId) },
                data: { outstandingBalance: { increment: totalAmount } }
            });

            return order;
        });

        return NextResponse.json(newOrder);
    } catch (e: any) {
        return handleApiError(e, "Failed to create order");
    }
}
