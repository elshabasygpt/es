import { prisma } from "@/lib/prisma";
import { HomePageClient } from "./home-page-client";
import { getNewsList } from "@/lib/news-api";
import { getProducts } from "@/lib/products-api";

export const metadata = {
    title: "مصنع السلام للزيوت النباتية | الرئيسية",
    description: "مصنع السلام — الريادة في عصر وإنتاج الزيوت النباتية، السمن، والشورتنج. أكثر من 25 عاماً من الخبرة، شهادات ISO و HACCP، تصدير لأكثر من 15 دولة.",
    openGraph: {
        title: "مصنع السلام للزيوت النباتية",
        description: "الريادة في عصر وإنتاج الزيوت النباتية، السمن، والشورتنج للسوق المحلي والتصدير.",
        type: "website",
        locale: "ar_EG",
    },
};

// revalidate every 60 seconds to enable ISR and improve loading speed
export const revalidate = 60;

export default async function HomePage() {
    // Fetch CMS content from database (saved via admin panel)
    let cmsContent: Record<string, any> = {};
    try {
        const pageContent = await prisma.pageContent.findUnique({
            where: { pageSlug: "home" },
        });
        if (pageContent?.content) {
            cmsContent = JSON.parse(pageContent.content);
        }
    } catch (e) {
        // If DB fails, fall back to empty (i18n-only)
        console.error("Failed to load home page content:", e);
    }

    let newsData: any[] = [];
    try {
        const newsRes = await getNewsList({ page: 1 });
        newsData = newsRes?.data?.slice(0, 5) || [];
    } catch (e) {
        console.error("Failed to load news ticker:", e);
    }

    let productsData: any[] = [];
    try {
        const prodRes = await getProducts({ featured: true });
        productsData = prodRes?.data?.slice(0, 4) || [];
    } catch (e) {
        console.error("Failed to load featured products:", e);
    }

    return <HomePageClient cmsContent={cmsContent} initialNews={newsData} initialProducts={productsData} />;
}
