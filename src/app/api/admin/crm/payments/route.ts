import { handleApiError } from "@/lib/error-handler";
import { NextRequest, NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function POST(req: NextRequest) {
    const session = await getServerSession(authOptions);
    if (!session) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    const role = session.user.role;
    if (role !== "ADMIN" && role !== "SALES_MANAGER" && role !== "SALES_REP") {
        return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    }

    try {
        const body = await req.json();
        const { clientId, amount, method, notes, paymentDate } = body;

        if (!clientId || !amount || amount <= 0) {
            return NextResponse.json({ error: "Invalid payment data" }, { status: 400 });
        }

        const repId = role === "SALES_REP" ? session.user.id : (body.repId || session.user.id);

        // Run transaction: create payment & update outstanding balance
        const result = await prisma.$transaction(async (tx) => {
            const payment = await tx.clientPayment.create({
                data: {
                    clientId,
                    amount: parseFloat(amount),
                    method: method || "CASH",
                    notes,
                    repId,
                    paymentDate: paymentDate ? new Date(paymentDate) : new Date()
                }
            });

            const client = await tx.client.update({
                where: { id: clientId },
                data: {
                    outstandingBalance: {
                        decrement: parseFloat(amount)
                    }
                }
            });

            return { payment, client };
        });

        return NextResponse.json(result);
    } catch (e: any) {
        return handleApiError(e, "Failed to record payment");
    }
}
