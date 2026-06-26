import { handleApiError } from "@/lib/error-handler";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function DELETE(req: NextRequest, { params }: { params: Promise<{ id: string }> }) {
    const session = await getServerSession(authOptions);
    if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const role = session.user.role;
    if (role !== "ADMIN" && role !== "SALES_MANAGER") {
        return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    try {
        const p = await params;
        const orderId = parseInt(p.id);

        const order = await prisma.clientOrder.findUnique({ where: { id: orderId } });
        if (!order) return NextResponse.json({ error: "Order not found" }, { status: 404 });

        await prisma.$transaction(async (tx) => {
            // Revert balance
            await tx.client.update({
                where: { id: order.clientId },
                data: { outstandingBalance: { decrement: order.totalAmount } }
            });

            await tx.clientOrder.delete({
                where: { id: orderId }
            });
        });

        return NextResponse.json({ success: true });
    } catch (e: any) {
        return handleApiError(e, "Failed to delete order");
    }
}

export async function PUT(req: NextRequest, { params }: { params: Promise<{ id: string }> }) {
    const session = await getServerSession(authOptions);
    if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const role = session.user.role;
    if (role !== "ADMIN" && role !== "SALES_MANAGER") {
        return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    try {
        const p = await params;
        const orderId = parseInt(p.id);
        const body = await req.json();

        const order = await prisma.clientOrder.findUnique({ where: { id: orderId } });
        if (!order) return NextResponse.json({ error: "Order not found" }, { status: 404 });

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

        const amountDifference = totalAmount - order.totalAmount;

        // Check credit limit if amount increased
        if (amountDifference > 0) {
            const client = await prisma.client.findUnique({ where: { id: order.clientId } });
            if (client && client.creditLimit > 0) {
                const newOutstanding = client.outstandingBalance + amountDifference;
                if (newOutstanding > client.creditLimit) {
                    return NextResponse.json({
                        error: `تجاوز حد الائتمان. الحد المتاح: ${client.creditLimit.toFixed(2)} ج.م، التجاوز المطلوب: ${amountDifference.toFixed(2)} ج.م`
                    }, { status: 400 });
                }
            }
        }

        const updatedOrder = await prisma.$transaction(async (tx) => {
            // Update balance
            await tx.client.update({
                where: { id: order.clientId },
                data: { outstandingBalance: { increment: amountDifference } }
            });

            // Delete old items
            await tx.orderItem.deleteMany({
                where: { orderId: orderId }
            });

            // Update order
            return await tx.clientOrder.update({
                where: { id: orderId },
                data: {
                    totalAmount: totalAmount,
                    createdAt: body.createdAt ? new Date(body.createdAt) : undefined,
                    invoiceFile: body.invoiceFile !== undefined ? body.invoiceFile : order.invoiceFile,
                    items: {
                        create: processedItems
                    }
                },
                include: { items: true }
            });
        });

        return NextResponse.json(updatedOrder);
    } catch (e: any) {
        return handleApiError(e, "Failed to update order");
    }
}
