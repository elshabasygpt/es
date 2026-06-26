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
        const { clientId, type, notes, date, nextFollowUp } = body;

        if (!clientId || !type || !notes) {
            return NextResponse.json({ error: "Missing required fields" }, { status: 400 });
        }

        const repId = role === "SALES_REP" ? session.user.id : (body.repId || session.user.id);

        const interaction = await prisma.clientInteraction.create({
            data: {
                clientId,
                type,
                notes,
                repId,
                date: date ? new Date(date) : new Date(),
                nextFollowUp: nextFollowUp ? new Date(nextFollowUp) : null,
            }
        });

        return NextResponse.json(interaction);
    } catch (e: any) {
        return handleApiError(e, "Failed to record interaction");
    }
}
