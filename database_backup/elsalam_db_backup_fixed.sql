--
-- PostgreSQL database dump
--


-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';


--
-- Name: Cart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cart" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Cart" OWNER TO postgres;

--
-- Name: CartItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CartItem" (
    id text NOT NULL,
    "cartId" text NOT NULL,
    "productId" integer NOT NULL,
    quantity integer NOT NULL,
    "weightVariant" text DEFAULT ''::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."CartItem" OWNER TO postgres;

--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name_ar text NOT NULL,
    name_en text NOT NULL,
    slug text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "imageUrl" text,
    "sortOrder" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Client" (
    id integer NOT NULL,
    name text NOT NULL,
    company text,
    industry text,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    lat double precision,
    lng double precision,
    "locationUrl" text,
    "mainPhone" text,
    "repId" text,
    "secondaryPhone" text,
    "storeImage" text,
    "storeType" text,
    "creditLimit" double precision DEFAULT 0 NOT NULL,
    "outstandingBalance" double precision DEFAULT 0 NOT NULL,
    status text DEFAULT 'LEAD'::text NOT NULL,
    governorate text
);


ALTER TABLE public."Client" OWNER TO postgres;

--
-- Name: ClientContact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClientContact" (
    id integer NOT NULL,
    "clientId" integer NOT NULL,
    "personName" text,
    department text NOT NULL,
    email text NOT NULL,
    phone text
);


ALTER TABLE public."ClientContact" OWNER TO postgres;

--
-- Name: ClientContact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ClientContact_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ClientContact_id_seq" OWNER TO postgres;

--
-- Name: ClientContact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ClientContact_id_seq" OWNED BY public."ClientContact".id;


--
-- Name: ClientInteraction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClientInteraction" (
    id integer NOT NULL,
    "clientId" integer NOT NULL,
    type text DEFAULT 'VISIT'::text NOT NULL,
    notes text NOT NULL,
    date timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "nextFollowUp" timestamp(3) without time zone,
    "repId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ClientInteraction" OWNER TO postgres;

--
-- Name: ClientInteraction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ClientInteraction_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ClientInteraction_id_seq" OWNER TO postgres;

--
-- Name: ClientInteraction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ClientInteraction_id_seq" OWNED BY public."ClientInteraction".id;


--
-- Name: ClientOrder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClientOrder" (
    id integer NOT NULL,
    "clientId" integer NOT NULL,
    "repId" text NOT NULL,
    status text DEFAULT 'NEW'::text NOT NULL,
    "totalAmount" double precision DEFAULT 0 NOT NULL,
    notes text,
    "rejectionReason" text,
    "expectedDate" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "invoiceFile" text
);


ALTER TABLE public."ClientOrder" OWNER TO postgres;

--
-- Name: ClientOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ClientOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ClientOrder_id_seq" OWNER TO postgres;

--
-- Name: ClientOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ClientOrder_id_seq" OWNED BY public."ClientOrder".id;


--
-- Name: ClientPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ClientPayment" (
    id integer NOT NULL,
    "clientId" integer NOT NULL,
    amount double precision NOT NULL,
    "paymentDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    method text DEFAULT 'CASH'::text NOT NULL,
    notes text,
    "repId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ClientPayment" OWNER TO postgres;

--
-- Name: ClientPayment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ClientPayment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ClientPayment_id_seq" OWNER TO postgres;

--
-- Name: ClientPayment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ClientPayment_id_seq" OWNED BY public."ClientPayment".id;


--
-- Name: Client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Client_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Client_id_seq" OWNER TO postgres;

--
-- Name: Client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Client_id_seq" OWNED BY public."Client".id;


--
-- Name: Message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Message" (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text,
    company text,
    subject text NOT NULL,
    body text NOT NULL,
    type text DEFAULT 'inquiry'::text NOT NULL,
    status text DEFAULT 'new'::text NOT NULL,
    priority text DEFAULT 'normal'::text NOT NULL,
    reply text,
    "repliedAt" timestamp(3) without time zone,
    "repliedBy" text,
    notes text,
    "isStarred" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Message" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Message_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Message_id_seq" OWNER TO postgres;

--
-- Name: Message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Message_id_seq" OWNED BY public."Message".id;


--
-- Name: News; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."News" (
    id integer NOT NULL,
    slug text NOT NULL,
    title_ar text NOT NULL,
    title_en text NOT NULL,
    excerpt_ar text,
    excerpt_en text,
    content_ar text,
    content_en text,
    category text DEFAULT 'news'::text NOT NULL,
    tags text,
    featured_image text,
    image_alt text,
    meta_title text,
    meta_description text,
    is_featured boolean DEFAULT false NOT NULL,
    is_published boolean DEFAULT false NOT NULL,
    published_at timestamp(3) without time zone,
    scheduled_at timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    gallery text[] DEFAULT ARRAY[]::text[]
);


ALTER TABLE public."News" OWNER TO postgres;

--
-- Name: News_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."News_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."News_id_seq" OWNER TO postgres;

--
-- Name: News_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."News_id_seq" OWNED BY public."News".id;


--
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderItem" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "productId" integer,
    quantity integer NOT NULL,
    "unitPrice" double precision DEFAULT 0 NOT NULL,
    subtotal double precision DEFAULT 0 NOT NULL,
    "customItemName" text
);


ALTER TABLE public."OrderItem" OWNER TO postgres;

--
-- Name: OrderItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."OrderItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."OrderItem_id_seq" OWNER TO postgres;

--
-- Name: OrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."OrderItem_id_seq" OWNED BY public."OrderItem".id;


--
-- Name: OutboxEvent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OutboxEvent" (
    id text NOT NULL,
    type text NOT NULL,
    payload text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."OutboxEvent" OWNER TO postgres;

--
-- Name: PageContent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PageContent" (
    id text NOT NULL,
    "pageSlug" text NOT NULL,
    content text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    version integer DEFAULT 1 NOT NULL
);


ALTER TABLE public."PageContent" OWNER TO postgres;

--
-- Name: PageContentHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PageContentHistory" (
    id text NOT NULL,
    "pageSlug" text NOT NULL,
    content text NOT NULL,
    "savedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    label text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."PageContentHistory" OWNER TO postgres;

--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    slug text NOT NULL,
    name_ar text NOT NULL,
    name_en text NOT NULL,
    short_description_ar text,
    short_description_en text,
    description_ar text,
    description_en text,
    long_description_ar text,
    long_description_en text,
    featured_image text,
    price double precision,
    price_unit_ar text,
    price_unit_en text,
    is_exportable boolean DEFAULT false NOT NULL,
    is_featured boolean DEFAULT false NOT NULL,
    icon text,
    gradient_from text,
    gradient_to text,
    "categoryId" integer,
    "activePromotionId" integer,
    pdf_datasheet text,
    meta_title text,
    meta_description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    stock integer DEFAULT 100 NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: ProductCertification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductCertification" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."ProductCertification" OWNER TO postgres;

--
-- Name: ProductCertification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductCertification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductCertification_id_seq" OWNER TO postgres;

--
-- Name: ProductCertification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductCertification_id_seq" OWNED BY public."ProductCertification".id;


--
-- Name: ProductFeature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductFeature" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    feature_ar text NOT NULL,
    feature_en text NOT NULL
);


ALTER TABLE public."ProductFeature" OWNER TO postgres;

--
-- Name: ProductFeature_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductFeature_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductFeature_id_seq" OWNER TO postgres;

--
-- Name: ProductFeature_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductFeature_id_seq" OWNED BY public."ProductFeature".id;


--
-- Name: ProductImage; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductImage" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    url text NOT NULL,
    alt_text text
);


ALTER TABLE public."ProductImage" OWNER TO postgres;

--
-- Name: ProductImage_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductImage_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductImage_id_seq" OWNER TO postgres;

--
-- Name: ProductImage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductImage_id_seq" OWNED BY public."ProductImage".id;


--
-- Name: ProductPackaging; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductPackaging" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    size_ar text NOT NULL,
    size_en text NOT NULL,
    price double precision
);


ALTER TABLE public."ProductPackaging" OWNER TO postgres;

--
-- Name: ProductPackaging_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductPackaging_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductPackaging_id_seq" OWNER TO postgres;

--
-- Name: ProductPackaging_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductPackaging_id_seq" OWNED BY public."ProductPackaging".id;


--
-- Name: ProductSpec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductSpec" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    label_ar text NOT NULL,
    label_en text NOT NULL,
    value_ar text NOT NULL,
    value_en text NOT NULL
);


ALTER TABLE public."ProductSpec" OWNER TO postgres;

--
-- Name: ProductSpec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductSpec_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductSpec_id_seq" OWNER TO postgres;

--
-- Name: ProductSpec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductSpec_id_seq" OWNED BY public."ProductSpec".id;


--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_id_seq" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: PromoCode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PromoCode" (
    id integer NOT NULL,
    code text NOT NULL,
    type text NOT NULL,
    value double precision NOT NULL,
    "minOrderValue" double precision,
    "maxUses" integer,
    "usedCount" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "expiresAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."PromoCode" OWNER TO postgres;

--
-- Name: PromoCode_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PromoCode_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PromoCode_id_seq" OWNER TO postgres;

--
-- Name: PromoCode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PromoCode_id_seq" OWNED BY public."PromoCode".id;


--
-- Name: Promotion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Promotion" (
    id integer NOT NULL,
    "productId" integer,
    title_ar text NOT NULL,
    title_en text NOT NULL,
    description_ar text,
    description_en text,
    discount_type text NOT NULL,
    discount_value double precision NOT NULL,
    original_price double precision,
    promo_price double precision,
    badge_ar text,
    badge_en text,
    featured_image text,
    starts_at timestamp(3) without time zone,
    ends_at timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL
);


ALTER TABLE public."Promotion" OWNER TO postgres;

--
-- Name: Promotion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Promotion_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Promotion_id_seq" OWNER TO postgres;

--
-- Name: Promotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Promotion_id_seq" OWNED BY public."Promotion".id;


--
-- Name: Quotation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Quotation" (
    id text NOT NULL,
    "userId" text NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "discountAmount" double precision DEFAULT 0 NOT NULL,
    "totalAmount" double precision DEFAULT 0 NOT NULL,
    "adminNotes" text,
    "clientNotes" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Quotation" OWNER TO postgres;

--
-- Name: QuotationItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."QuotationItem" (
    id text NOT NULL,
    "quotationId" text NOT NULL,
    "productId" integer NOT NULL,
    quantity integer NOT NULL,
    price double precision NOT NULL,
    "weightVariant" text DEFAULT ''::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."QuotationItem" OWNER TO postgres;

--
-- Name: ShippingZone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ShippingZone" (
    id integer NOT NULL,
    name_ar text NOT NULL,
    name_en text NOT NULL,
    fee double precision DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."ShippingZone" OWNER TO postgres;

--
-- Name: ShippingZone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ShippingZone_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ShippingZone_id_seq" OWNER TO postgres;

--
-- Name: ShippingZone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ShippingZone_id_seq" OWNED BY public."ShippingZone".id;


--
-- Name: SiteSettings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SiteSettings" (
    id text NOT NULL,
    "siteNameAr" text DEFAULT 'مصنع السلام للزيوت النباتية'::text NOT NULL,
    "siteNameEn" text DEFAULT 'Elsalam Vegetable Oils Factory'::text NOT NULL,
    "siteDescriptionAr" text,
    "siteDescriptionEn" text,
    "contactEmail" text,
    "contactPhone" text,
    "addressAr" text,
    "addressEn" text,
    "facebookUrl" text,
    "twitterUrl" text,
    "instagramUrl" text,
    "linkedinUrl" text,
    "smtpHost" text,
    "smtpPort" integer DEFAULT 587,
    "smtpUser" text,
    "smtpPass" text,
    "smtpFrom" text,
    "smtpFromName" text,
    "smtpSecure" text DEFAULT 'tls'::text,
    "logoUrl" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "googleAnalyticsId" text,
    "imapHost" text,
    "imapPass" text,
    "imapPort" integer DEFAULT 993,
    "imapSecure" text DEFAULT 'tls'::text,
    "imapUser" text,
    "invoiceNotesAr" text,
    "invoiceNotesEn" text,
    "invoiceShowLogo" boolean DEFAULT true NOT NULL,
    "invoiceLogoUrl" text,
    "invoiceColor" text DEFAULT '#15803d'::text,
    "invoiceCompanyDetails" text,
    "invoiceLogoSize" integer DEFAULT 64,
    "invoiceSubtitle" text DEFAULT 'Industrial High-Quality Oils & Fats'::text,
    "invoiceWebsiteUrl" text DEFAULT 'www.elsalamoils.com'::text,
    "geminiApiKey" text,
    "stabilityApiKey" text,
    "huggingFaceApiKey" text,
    "imageAiProvider" text DEFAULT 'pollinations'::text,
    "textAiProvider" text DEFAULT 'gemini'::text,
    "googleDriveFolderId" text
);


ALTER TABLE public."SiteSettings" OWNER TO postgres;

--
-- Name: TechnicalSpec; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TechnicalSpec" (
    id integer NOT NULL,
    "productId" integer NOT NULL,
    property_ar text NOT NULL,
    property_en text NOT NULL,
    value_ar text NOT NULL,
    value_en text NOT NULL,
    unit_ar text,
    unit_en text
);


ALTER TABLE public."TechnicalSpec" OWNER TO postgres;

--
-- Name: TechnicalSpec_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."TechnicalSpec_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TechnicalSpec_id_seq" OWNER TO postgres;

--
-- Name: TechnicalSpec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."TechnicalSpec_id_seq" OWNED BY public."TechnicalSpec".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text,
    email text,
    "emailVerified" timestamp(3) without time zone,
    image text,
    password text,
    role text DEFAULT 'USER'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: WebOrder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."WebOrder" (
    id integer NOT NULL,
    "customerName" text NOT NULL,
    "customerEmail" text,
    "customerPhone" text NOT NULL,
    governorate text NOT NULL,
    city text,
    "shippingAddress" text NOT NULL,
    "totalAmount" double precision DEFAULT 0 NOT NULL,
    status text DEFAULT 'PENDING'::text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "paymentMethod" text DEFAULT 'COD'::text NOT NULL,
    "shippingFee" double precision DEFAULT 0 NOT NULL,
    "userId" text,
    "discountAmount" double precision DEFAULT 0 NOT NULL,
    "promoCode" text,
    notes text,
    "isQuotation" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."WebOrder" OWNER TO postgres;

--
-- Name: WebOrderItem; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."WebOrderItem" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "productId" integer NOT NULL,
    quantity integer NOT NULL,
    "unitPrice" double precision DEFAULT 0 NOT NULL,
    subtotal double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public."WebOrderItem" OWNER TO postgres;

--
-- Name: WebOrderItem_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."WebOrderItem_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."WebOrderItem_id_seq" OWNER TO postgres;

--
-- Name: WebOrderItem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."WebOrderItem_id_seq" OWNED BY public."WebOrderItem".id;


--
-- Name: WebOrder_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."WebOrder_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."WebOrder_id_seq" OWNER TO postgres;

--
-- Name: WebOrder_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."WebOrder_id_seq" OWNED BY public."WebOrder".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client" ALTER COLUMN id SET DEFAULT nextval('public."Client_id_seq"'::regclass);


--
-- Name: ClientContact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientContact" ALTER COLUMN id SET DEFAULT nextval('public."ClientContact_id_seq"'::regclass);


--
-- Name: ClientInteraction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientInteraction" ALTER COLUMN id SET DEFAULT nextval('public."ClientInteraction_id_seq"'::regclass);


--
-- Name: ClientOrder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientOrder" ALTER COLUMN id SET DEFAULT nextval('public."ClientOrder_id_seq"'::regclass);


--
-- Name: ClientPayment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientPayment" ALTER COLUMN id SET DEFAULT nextval('public."ClientPayment_id_seq"'::regclass);


--
-- Name: Message id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message" ALTER COLUMN id SET DEFAULT nextval('public."Message_id_seq"'::regclass);


--
-- Name: News id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."News" ALTER COLUMN id SET DEFAULT nextval('public."News_id_seq"'::regclass);


--
-- Name: OrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem" ALTER COLUMN id SET DEFAULT nextval('public."OrderItem_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductCertification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCertification" ALTER COLUMN id SET DEFAULT nextval('public."ProductCertification_id_seq"'::regclass);


--
-- Name: ProductFeature id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductFeature" ALTER COLUMN id SET DEFAULT nextval('public."ProductFeature_id_seq"'::regclass);


--
-- Name: ProductImage id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductImage" ALTER COLUMN id SET DEFAULT nextval('public."ProductImage_id_seq"'::regclass);


--
-- Name: ProductPackaging id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductPackaging" ALTER COLUMN id SET DEFAULT nextval('public."ProductPackaging_id_seq"'::regclass);


--
-- Name: ProductSpec id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductSpec" ALTER COLUMN id SET DEFAULT nextval('public."ProductSpec_id_seq"'::regclass);


--
-- Name: PromoCode id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PromoCode" ALTER COLUMN id SET DEFAULT nextval('public."PromoCode_id_seq"'::regclass);


--
-- Name: Promotion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Promotion" ALTER COLUMN id SET DEFAULT nextval('public."Promotion_id_seq"'::regclass);


--
-- Name: ShippingZone id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingZone" ALTER COLUMN id SET DEFAULT nextval('public."ShippingZone_id_seq"'::regclass);


--
-- Name: TechnicalSpec id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TechnicalSpec" ALTER COLUMN id SET DEFAULT nextval('public."TechnicalSpec_id_seq"'::regclass);


--
-- Name: WebOrder id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrder" ALTER COLUMN id SET DEFAULT nextval('public."WebOrder_id_seq"'::regclass);


--
-- Name: WebOrderItem id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrderItem" ALTER COLUMN id SET DEFAULT nextval('public."WebOrderItem_id_seq"'::regclass);


--
-- Data for Name: Cart; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: CartItem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Category" VALUES (5, 'زيت أولين', 'Palm olein oil', 'palm-olein-oil', '2026-04-20 01:24:04.594', '2026-04-20 02:01:36.564', '/uploads/upload_1776648243745_0nuqyg.jfif', 1);
INSERT INTO public."Category" VALUES (6, 'زيت صويا', 'Soybean oil ', 'soybean-oil-', '2026-04-20 01:26:12.015', '2026-04-20 02:01:36.564', '/uploads/upload_1776648369226_tppnix.jfif', 2);
INSERT INTO public."Category" VALUES (7, 'زيت خليط', 'Blended oil', 'blended-oil', '2026-04-20 01:28:59.038', '2026-04-20 02:01:36.564', '/uploads/upload_1776648537799_epl8v7.jfif', 3);
INSERT INTO public."Category" VALUES (8, 'سمنة', 'Ghee', 'ghee', '2026-04-20 01:31:15.097', '2026-04-20 02:01:36.564', '/uploads/upload_1776648674142_42e1po.jfif', 4);
INSERT INTO public."Category" VALUES (9, 'شورتنج', 'Shortening', 'shortening', '2026-04-20 01:35:47.207', '2026-04-20 02:01:36.564', '/uploads/upload_1776648945856_fvidso.jfif', 5);
INSERT INTO public."Category" VALUES (10, 'المارجرين', 'Margarine', 'margarine', '2026-04-20 01:38:53.005', '2026-04-20 02:01:36.564', '/uploads/upload_1776649131885_dhtxzt.jfif', 6);


--
-- Data for Name: Client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Client" VALUES (3, 'محل الصقور ', '', NULL, '', '2026-04-18 17:28:29.387', '2026-05-16 13:45:30.336', NULL, NULL, 'https://www.google.com/maps?q=31.034061,30.467496', '0150175002', NULL, '', '/uploads/crm/1776534488851-images_(2).jfif', 'سوبرماركت', 0, 0, 'LEAD', NULL);
INSERT INTO public."Client" VALUES (4, 'سوبر ماركت البركة', '', NULL, '', '2026-05-16 13:41:32.413', '2026-05-16 19:32:05.285', 31.0311277, 30.460912, 'https://www.google.com/maps?q=31.0311277,30.460912', '01013713596', NULL, '', '/uploads/crm/1778938770697-Screenshot_2026-05-13_21-07-17.png', 'سوبرماركت', 0, 1455, 'LEAD', NULL);


--
-- Data for Name: ClientContact; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ClientInteraction; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ClientInteraction" VALUES (1, 4, 'VISIT', 'تم زيارة العميل ومناقشة تفاصيل طلبيته القادمة وعرض الأسعار الجديد. العميل أبدى اهتماماً كبيراً', '2026-05-17 00:00:00', NULL, 'cmmokssfm0001rtf0sdndqttp', '2026-05-17 12:53:40.598', '2026-05-17 12:53:40.598');


--
-- Data for Name: ClientOrder; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ClientOrder" VALUES (3, 4, 'cmmokssfm0001rtf0sdndqttp', 'DELIVERED', 1455, '366', NULL, NULL, '2026-05-16 00:00:00', '2026-05-16 19:17:30.69', NULL);


--
-- Data for Name: ClientPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Message; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Message" VALUES (4, 'أحمد محمد', 'ahmed@example.com', '+201234567890', 'شركة الفجر', 'استفسار عن زيت الطبخ بالجملة', 'السلام عليكم، أرغب في الاستفسار عن أسعار زيت الطبخ بالجملة وإمكانية التوريد لمحلات السوبر ماركت. نحتاج كميات كبيرة شهرياً.', 'inquiry', 'replied', 'normal', 'اهلا وسهلا', '2026-03-13 22:48:15.728', 'Admin User', NULL, false, '2026-03-13 22:45:24.999', '2026-03-13 22:48:17.685');
INSERT INTO public."Message" VALUES (5, 'سارة علي', 'sara@company.com', NULL, NULL, 'شكوى بخصوص عبوة تالفة', 'مرحباً، اشتريت عبوة زيت بتاريخ 1 مارس ولكن وجدت أن العبوة مثقوبة من الأسفل. أرجو الاهتمام بمراقبة الجودة.', 'complaint', 'replied', 'high', 'ddd', '2026-03-13 22:51:50.051', 'Admin User', NULL, false, '2026-03-13 22:45:25.066', '2026-03-13 22:51:51.88');
INSERT INTO public."Message" VALUES (6, 'محمود حسن', 'mahmoud@factory.eg', NULL, 'مصنع النور للتوزيع', 'طلب شراكة للتوزيع في الصعيد', 'نود مناقشة فرص الشراكة في توزيع منتجاتكم في محافظات الصعيد. لدينا شبكة توزيع واسعة تغطي 5 محافظات.', 'partnership', 'read', 'normal', NULL, NULL, NULL, NULL, false, '2026-03-13 22:45:25.132', '2026-03-13 23:03:24.386');
INSERT INTO public."Message" VALUES (7, 'Ahmed Customer', 'ahmed@test.com', '+201010101010', 'Food Traders LLC', 'B2B Quote Request', 'We need 40 tons of Soybean oil.', 'quote', 'replied', 'normal', 'Hello Ahmed, our quote is $40,000.', '2026-04-18 12:49:08.188', NULL, NULL, false, '2026-04-18 12:49:06.201', '2026-04-18 12:49:08.189');
INSERT INTO public."Message" VALUES (8, ' احمد ', 'outcontrol54@gmail.com', '01013713596', 'شركة بسميبمن', 'B2B Quote Request', 'Requirements: سمن نباتي
Volume: 5
Packaging: براميل (200 لتر)
Country: مصر
Notes: ببسييب', 'quote', 'replied', 'normal', 'تمام', '2026-05-03 08:06:44.194', 'Admin User', NULL, false, '2026-05-03 08:04:10.18', '2026-05-03 08:06:45.871');
INSERT INTO public."Message" VALUES (9, 'Test User', 'test@example.com', '+201234567890', NULL, 'New Inquiry', 'This is an end-to-end test message from the contact form.', 'inquiry', 'read', 'normal', NULL, NULL, NULL, NULL, false, '2026-05-04 04:27:58.417', '2026-05-04 07:02:03.358');


--
-- Data for Name: News; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."News" VALUES (2, 'cairo-food-exhibition-2026', 'مصنع السلام يشارك في معرض القاهرة الدولي للصناعات الغذائية', 'Elsalam Factory Participates in Cairo International Food Exhibition', 'شارك مصنع السلام في معرض القاهرة الدولي للصناعات الغذائية لعام 2026', 'Elsalam participated in the Cairo International Food Exhibition 2026', '# المشاركة في معرض القاهرة الدولي

شارك مصنع السلام في **معرض القاهرة الدولي** للصناعات الغذائية.

> نفخر بمشاركتنا في هذا الحدث الدولي الكبير', '# Cairo Food Exhibition

Elsalam Factory participated in **Cairo International Food Exhibition**.', 'exhibitions', 'معارض, تصدير', NULL, NULL, NULL, NULL, false, true, '2026-03-13 20:47:08.76', NULL, '2026-03-13 20:47:08.761', '2026-03-13 20:47:08.761', '{}');
INSERT INTO public."News" VALUES (1, 'new-production-line-2026', 'مصنع السلام يفتتح خط إنتاج جديد بأحدث التقنيات العالمية', 'Elsalam Factory Opens New Production Line with Latest Global Technologies', 'أعلن مصنع السلام للزيوت النباتية عن افتتاح خط إنتاج جديد بأحدث التقنيات العالمية لتلبية احتياجات السوق المتزايدة', 'Elsalam Factory for Vegetable Oils announced the opening of a new production line with the latest global technologies', '# افتتاح خط إنتاج جديد

أعلن مصنع السلام للزيوت النباتية عن افتتاح **خط إنتاج جديد** بأحدث التقنيات العالمية.

## أبرز مميزات خط الإنتاج الجديد

- طاقة إنتاجية تصل إلى 500 طن يومياً
- تقنيات تكرير متقدمة تضمن أعلى معايير الجودة
- نظام تعبئة آلي بالكامل
- مراقبة جودة رقمية على مدار الساعة', '# New Production Line Opening

Elsalam Factory announced the opening of a **new production line** with latest global technologies.

## Key Features

- Production capacity up to 500 tons daily
- Advanced refining technology ensuring highest quality standards
- Fully automated packaging system
- 24/7 digital quality monitoring', 'news', 'إنتاج, تكنولوجيا, توسع', NULL, NULL, 'مصنع السلام يفتتح خط إنتاج جديد | أخبار المصنع', 'أعلن مصنع السلام للزيوت النباتية عن افتتاح خط إنتاج جديد بطاقة 500 طن يومياً بأحدث التقنيات العالمية', true, true, '2026-04-17 15:39:45.108', NULL, '2026-03-13 20:47:08.592', '2026-04-17 15:39:45.249', '{}');
INSERT INTO public."News" VALUES (3, 'quality-certification-iso', 'مصنع السلام يحصل على شهادة الأيزو لأول مرة', 'Elsalam Factory Receives ISO Certification for First Time', 'حصل مصنع السلام على شهادة ISO 22000 لسلامة الغذاء', NULL, NULL, NULL, 'news', 'جودة, أيزو, شهادات', NULL, NULL, NULL, NULL, false, true, '2026-04-17 15:39:45.108', NULL, '2026-03-13 20:47:08.871', '2026-04-17 15:39:45.249', '{}');
INSERT INTO public."News" VALUES (4, 'iso-22000-certification', 'حصول مصنع السلام على شهادة أيزو 22000 في سلامة الغذاء', 'Elsalam Factory achieves ISO 22000 certification in food safety', 'إنجاز جديد يضاف لسجل مصنع السلام بالحصول على أرفع الشهادات الدولية في إدارة سلامة الغذاء، مما يؤكد التزامنا المطلق بالجودة.', 'A new achievement added to Elsalam Factory’s record by obtaining the highest international certifications in food safety management.', '<p>في إطار سعينا المستمر نحو التميز وتقديم منتجات ترقى لأعلى المعايير العالمية، نفخر بالإعلان عن حصول مصنع السلام للزيوت النباتية على شهادة <strong>الأيزو 22000</strong> لإدارة سلامة الغذاء.</p><p>هذه الشهادة ليست مجرد ورقة، بل هي تكليل لجهود فريق العمل في تطبيق أقصى معايير الرقابة الصارمة في كل مراحل الإنتاج بدءاً من اختيار البذور وحتى تعبئة المنتج النهائي.</p>', '<p>As part of our continuous pursuit of excellence, we are proud to announce that Elsalam Vegetable Oils Factory has obtained the <strong>ISO 22000</strong> certification for food safety management.</p><p>This certification is a culmination of our team’s efforts in applying the strictest control standards at every stage of production.</p>', 'quality', NULL, 'https://images.unsplash.com/photo-1518349619113-03114f06ac3a?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, true, true, '2026-05-01 10:00:00', NULL, '2026-05-04 04:03:49.926', '2026-05-04 04:03:49.926', '{}');
INSERT INTO public."News" VALUES (5, 'global-expansion-europe-africa', 'توسع عالمي: مصنع السلام يفتتح أسواقاً جديدة في أوروبا وإفريقيا', 'Global Expansion: Elsalam opens new markets in Europe and Africa', 'استكمالاً لرؤية 2030، نجحنا في توقيع عقود تصديرية ضخمة للوصول بمنتجاتنا إلى 5 دول أوروبية وإفريقية جديدة.', 'In line with our 2030 vision, we have successfully signed massive export contracts to reach 5 new European and African countries.', '<p>استكمالاً لرؤيتنا الاستراتيجية في التوسع العالمي، يسرنا الإعلان عن نجاح مصنع السلام في اختراق أسواق جديدة في كل من قارتي أوروبا وإفريقيا.</p><p>يعكس هذا التوسع ثقة المستهلكين والمستوردين في جودة الزيوت المصرية ومطابقتها للمواصفات الدولية المعتمدة.</p>', '<p>In continuation of our strategic vision for global expansion, we are pleased to announce Elsalam’s success in penetrating new markets in Europe and Africa.</p><p>This expansion reflects the confidence of importers in the quality of Egyptian oils.</p>', 'export', NULL, 'https://images.unsplash.com/photo-1586528116311-ad8ed7c80a30?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, false, true, '2026-04-28 09:30:00', NULL, '2026-05-04 04:03:50.048', '2026-05-04 04:03:50.048', '{}');
INSERT INTO public."News" VALUES (6, 'green-industry-initiative', 'مبادرة "صناعة خضراء": كيف يساهم مصنع السلام في تقليل الانبعاثات الكربونية؟', '"Green Industry" initiative: How Elsalam reduces carbon emissions', 'تعرف على التحديثات التقنية الجديدة في خطوط الإنتاج والتي خفضت استهلاك الطاقة بنسبة 30٪ كجزء من مسؤوليتنا البيئية.', 'Learn about the new technical updates in production lines that reduced energy consumption by 30% as part of our environmental responsibility.', '<p>إيماناً منا بدور الصناعة في الحفاظ على كوكب الأرض، أطلق مصنع السلام مبادرة <strong>صناعة خضراء</strong>.</p><p>حيث قمنا بتحديث منظومة الغلايات ومحطات توليد البخار بأحدث التقنيات الموفرة للطاقة، ما أثمر عن خفض الانبعاثات الكربونية بشكل ملحوظ.</p>', '<p>Believing in the role of industry in protecting the planet, Elsalam has launched the <strong>Green Industry</strong> initiative.</p><p>We have updated our boiler systems with the latest energy-saving technologies, significantly reducing our carbon footprint.</p>', 'sustainability', NULL, 'https://images.unsplash.com/photo-1473448912268-2022ce9509d8?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, true, true, '2026-04-25 11:00:00', NULL, '2026-05-04 04:03:50.051', '2026-05-04 04:03:50.051', '{}');
INSERT INTO public."News" VALUES (7, 'new-production-line', 'افتتاح خط إنتاج جديد لتعبئة زيوت الطعام بطاقة مضاعفة', 'Opening a new cooking oil bottling line with double capacity', 'لضمان تلبية الطلب المتزايد محلياً وعالمياً، دشن مصنع السلام خط إنتاج آلي بالكامل يعمل وفق أحدث التكنولوجيا الألمانية.', 'To meet growing local and global demand, Elsalam inaugurated a fully automated production line using the latest German technology.', '<p>في حفل كبير حضره رواد الصناعة، تم الإعلان رسمياً عن بدء تشغيل خط التعبئة الآلي الجديد والذي يعمل بطاقة إنتاجية مضاعفة.</p><p>هذا الخط يضمن تدخلاً بشرياً منعدماً (Zero Human Contact) مما يحقق أقصى درجات النظافة والتعقيم لكل عبوة.</p>', '<p>In a grand ceremony attended by industry leaders, we officially announced the start of our new automated bottling line with double the production capacity.</p><p>This line ensures zero human contact, achieving maximum hygiene and sterilization.</p>', 'production', NULL, 'https://images.unsplash.com/photo-1596524430615-b46475ddff6e?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, false, true, '2026-04-20 14:15:00', NULL, '2026-05-04 04:03:50.052', '2026-05-04 04:03:50.052', '{}');
INSERT INTO public."News" VALUES (8, 'gulfood-dubai-2026', 'مشاركة بارزة لمصنع السلام في معرض جلفود دبي 2026', 'Prominent participation of Elsalam Factory in Gulfood Dubai 2026', 'تألق جناحنا في معرض جلفود دبي عبر عرض مجموعة متنوعة من الزيوت والسمن، ولقاءات مثمرة مع مستثمرين من جميع أنحاء العالم.', 'Our pavilion shined at Gulfood Dubai by displaying a variety of oils and ghee, with fruitful meetings with investors worldwide.', '<p>اختتم مصنع السلام مشاركته الناجحة في معرض <strong>جلفود دبي 2026</strong>، المعرض الأضخم في قطاع الأغذية والمشروبات.</p><p>وقد استقبل جناحنا مئات الزوار يومياً، وعُقدت صفقات مبدئية مع مستوردين من دول الخليج وشرق آسيا.</p>', '<p>Elsalam Factory concluded its successful participation in <strong>Gulfood Dubai 2026</strong>, the largest F&B exhibition.</p><p>Our pavilion welcomed hundreds of visitors daily, securing initial deals with importers from the Gulf and East Asia.</p>', 'events', NULL, 'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, true, true, '2026-04-15 12:00:00', NULL, '2026-05-04 04:03:50.055', '2026-05-04 04:03:50.055', '{}');
INSERT INTO public."News" VALUES (9, 'launch-trans-fat-free-ghee', 'إطلاق منتج "سمن السلام" الجديد بتقنية خالية من الدهون المتحولة', 'Launch of the new "Elsalam Ghee" with trans-fat-free technology', 'استجابة لمتطلبات الصحة الحديثة، نفخر بتقديم الجيل الجديد من السمن النباتي الصحي والخالي تماماً من الدهون المتحولة.', 'In response to modern health demands, we are proud to introduce the new generation of healthy, trans-fat-free vegetable ghee.', '<p>حرصاً على صحة عملائنا، قام قسم البحث والتطوير (R&D) لدينا بابتكار تركيبة فريدة لمنتج <strong>سمن السلام</strong> ليكون خالي تماماً من الدهون المتحولة (Trans-fat Free).</p><p>المنتج الجديد يوفر نفس الطعم الرائع والقوام الممتاز للطبخ والحلويات ولكن بفوائد صحية أكبر.</p>', '<p>Caring for our customers’ health, our R&D department has innovated a unique formula for <strong>Elsalam Ghee</strong> to be completely Trans-fat Free.</p><p>The new product offers the same great taste and texture for cooking and baking but with greater health benefits.</p>', 'news', NULL, 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, false, true, '2026-04-10 08:45:00', NULL, '2026-05-04 04:03:50.057', '2026-05-04 04:03:50.057', '{}');
INSERT INTO public."News" VALUES (10, 'strategic-partnership-b2b', 'شراكة استراتيجية مع كبرى مصانع الأغذية لتوريد شورتنج المخابز', 'Strategic partnership with major food factories to supply bakery shortening', 'تتويجاً لجهود قطاع المبيعات البينية (B2B)، تم توقيع عقد شراكة طويلة الأمد مع مجموعة من كبرى مصانع الحلويات والمخبوزات.', 'Crowning the efforts of our B2B sector, a long-term partnership contract was signed with a group of major confectionery and bakery factories.', '<p>أعلن قطاع المبيعات في مصنع السلام عن توقيع عقود توريد ضخمة لمنتجات <strong>الشورتنج المتخصص</strong> المستخدم في صناعة المخبوزات والحلويات.</p><p>تأتي هذه الخطوة لتؤكد أن السلام هو الشريك المفضل للكيانات الصناعية الكبرى التي تبحث عن الجودة المستدامة والاعتمادية.</p>', '<p>The sales sector at Elsalam announced the signing of massive supply contracts for <strong>Specialized Shortening</strong> used in the bakery and confectionery industry.</p><p>This step confirms that Elsalam is the preferred partner for large industrial entities seeking sustainable quality and reliability.</p>', 'news', NULL, 'https://images.unsplash.com/photo-1556761175-5973dc0f32b7?q=80&w=1200&auto=format&fit=crop', NULL, NULL, NULL, true, true, '2026-04-05 15:30:00', NULL, '2026-05-04 04:03:50.06', '2026-05-04 04:03:50.06', '{}');
INSERT INTO public."News" VALUES (13, 'industrial-excellence-award', 'فوز مصنع السلام بجائزة التميز الصناعي للعام الثاني على التوالي', 'Elsalam Factory wins the Industrial Excellence Award for the second consecutive year', 'تكريم جديد يضاف لمسيرتنا من غرفة الصناعات الغذائية تقديراً لجهودنا في تطوير قطاع الزيوت النباتية في مصر.', 'A new honor added to our journey by the Chamber of Food Industries in recognition of our efforts to develop the vegetable oils sector in Egypt.', '<p>في حفل بهيج، تسلمت إدارة مصنع السلام <strong>جائزة التميز الصناعي</strong> لعام 2025/2026.</p><p>يعد هذا الفوز للعام الثاني على التوالي دليلاً قاطعاً على التزامنا برؤية مستدامة، وجودة لا تتزعزع، ومساهمة فعالة في الاقتصاد الوطني.</p>', '<p>In a joyful ceremony, Elsalam’s administration received the <strong>Industrial Excellence Award</strong> for the year 2025/2026.</p><p>Winning this for the second consecutive year is conclusive evidence of our sustainable vision, unwavering quality, and effective contribution to the national economy.</p>', 'news', NULL, '/uploads/modern_oil_factory.png', NULL, NULL, NULL, true, true, '2026-03-01 20:00:00', NULL, '2026-05-04 04:03:50.065', '2026-05-04 14:43:05.806', '{}');
INSERT INTO public."News" VALUES (11, 'elsalam-for-good-ramadan', 'حملة "السلام للخير" لدعم المجتمع المحلي في شهر رمضان', '"Elsalam for Good" campaign to support the local community during Ramadan', 'توزيع الآلاف من كراتين المواد الغذائية التي تتضمن منتجاتنا على الأسر الأكثر احتياجاً كجزء من دورنا المجتمعي.', 'Distributing thousands of food boxes featuring our products to families in need as part of our corporate social responsibility.', '<p>استمراراً لنهج العطاء، أطلقت إدارة المصنع حملة <strong>السلام للخير</strong> بمناسبة شهر رمضان المبارك.</p><p>حيث شارك موظفونا في تعبئة وتوزيع آلاف الكراتين التموينية، مؤكدين أن نجاحنا الحقيقي يكمن في إحداث تأثير إيجابي في مجتمعنا المحيط.</p>', '<p>Continuing our tradition of giving, the factory administration launched the <strong>Elsalam for Good</strong> campaign on the occasion of the holy month of Ramadan.</p><p>Our employees participated in packing and distributing thousands of food boxes, proving our commitment to positive social impact.</p>', 'events', NULL, '/uploads/global_logistics_export.png', NULL, NULL, NULL, false, true, '2026-03-25 13:20:00', NULL, '2026-05-04 04:03:50.062', '2026-05-04 14:43:06.027', '{}');
INSERT INTO public."News" VALUES (12, 'technology-in-labs', 'التكنولوجيا في خدمة الجودة: أحدث أجهزة الفحص في معامل السلام', 'Technology at the service of quality: Latest inspection devices in Elsalam labs', 'استثمارات بملايين الجنيهات لتجهيز معامل المصنع بأحدث أجهزة الكروماتوجرافيا لضمان نقاء الزيوت وخلوها من الشوائب.', 'Multi-million investments to equip the factory’s labs with the latest chromatography devices to ensure oil purity.', '<p>لضمان بقائنا في صدارة المنافسة، قمنا مؤخراً بتحديث شامل لمعامل الجودة المركزية داخل المصنع.</p><p>تم تزويد المعامل بأجهزة كروماتوجرافيا الغاز والسائل المتطورة جداً، والتي تستطيع تحليل مكونات الزيت بدقة متناهية والتأكد من مطابقتها القياسية.</p>', '<p>To ensure we remain at the forefront of competition, we recently undertook a comprehensive upgrade of our central quality labs.</p><p>The labs were equipped with highly advanced gas and liquid chromatography devices, analyzing oil components with extreme precision.</p>', 'quality', NULL, '/uploads/premium_oil_raw_materials.png', NULL, NULL, NULL, false, true, '2026-03-15 09:00:00', NULL, '2026-05-04 04:03:50.063', '2026-05-04 14:43:05.923', '{}');
INSERT INTO public."News" VALUES (14, '33fsdf', 'يسسسي', '33fsdf', 'يسسي', 'dddd', '<p>يسسي</p>', NULL, 'news', NULL, '/uploads/upload_1779024551238_6jr0ac.png', NULL, NULL, NULL, false, true, '2026-05-17 13:29:46.347', NULL, '2026-05-17 13:29:46.35', '2026-05-17 13:29:46.35', '{/uploads/upload_1779024547447_355pdu.png}');


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."OrderItem" VALUES (7, 3, 14, 1, 745, 745, NULL);
INSERT INTO public."OrderItem" VALUES (8, 3, 17, 1, 710, 710, NULL);


--
-- Data for Name: OutboxEvent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: PageContent; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PageContent" VALUES ('cmo61zehm0000rta8xxihot4c', 'about', '{
  "hero": {
    "title_ar": "عن مصنع السلام",
    "title_en": "About Elsalam Factory",
    "subtitle_ar": "أكثر من 25 عاماً من الريادة في صناعة الزيوت النباتية والسمن والشورتنج",
    "subtitle_en": "Over 25 years of leadership in the vegetable oils, margarine & shortening industry",
    "badge_ar": "من نحن",
    "badge_en": "About Us",
    "backgroundImage": "/uploads/upload_1776643103718_x1k9vw.jfif"
  },
  "story": {
    "title_ar": "قصتنا",
    "title_en": "Our Story",
    "paragraph1_ar": "تأسس مصنع السلام لعصر واستخلاص الزيوت النباتية عام 2000 في المنطقة الصناعية بمصر. بدأنا بخط إنتاج واحد ورؤية واضحة: تقديم زيوت نباتية بجودة عالمية وأسعار منافسة. واليوم، نفخر بامتلاك 8 خطوط إنتاج بطاقة 500 طن يومياً، ونصدّر إلى أكثر من 15 دولة.",
    "paragraph1_en": "Elsalam Factory for Extracting and Refining Vegetable Oils was established in 2000 in the Industrial Zone, Egypt. We started with a single production line and a clear vision: to provide world-class vegetable oils at competitive prices. Today, we proudly operate 8 production lines with a daily capacity of 500 MT, exporting to over 15 countries.",
    "paragraph2_ar": "نحن ملتزمون بالاستدامة والابتكار المستمر، مع استثمارات مستمرة في تطوير خطوط الإنتاج ومعامل الجودة لضمان مطابقة منتجاتنا لأعلى المواصفات القياسية المحلية والدولية.",
    "paragraph2_en": "We are committed to sustainability and continuous innovation, consistently investing in our production lines and quality laboratories to ensure our products meet the highest local and international standards."
  },
  "timeline": {
    "items": [
      {
        "year": "2000",
        "title_ar": "التأسيس والانطلاق",
        "title_en": "Foundation & Launch",
        "description_ar": "بدأنا رحلتنا بخط إنتاج واحد للزيوت النباتية مع التركيز على تلبية احتياجات السوق المحلي بأعلى معايير الجودة.",
        "description_en": "Began our journey with a single vegetable oil production line, focusing on meeting local market needs with the highest quality standards."
      },
      {
        "year": "2008",
        "title_ar": "توسعة خطوط التكرير",
        "title_en": "Refinery Expansion",
        "description_ar": "افتتاح خط التكرير المتطور لضمان النقاء التام والشفافية العالية لزيوتنا بمعايير أوروبية.",
        "description_en": "Inaugurated a state-of-the-art refining line to ensure absolute purity and high transparency of our oils under European standards."
      },
      {
        "year": "2015",
        "title_ar": "دخول أسواق التصدير",
        "title_en": "Entering Export Markets",
        "description_ar": "حصولنا على شهادات الجودة العالمية وبلوغ طاقة إنتاجية سمحت لنا ببدء التصدير الناجح لدول أفريقيا والشرق الأوسط.",
        "description_en": "Achieved international quality certifications and production capacity that enabled successful exports to Africa and the Middle East."
      },
      {
        "year": "2020",
        "title_ar": "إطلاق السمن والشورتنج",
        "title_en": "Ghee & Shortening Launch",
        "description_ar": "تنويع محفظة المنتجات لتشمل السمن النباتي الممتاز وشورتنج المخابز المتخصص لتلبية القطاع الصناعي.",
        "description_en": "Diversified the product portfolio to include premium vegetable ghee and specialized bakery shortening to supply the industrial sector."
      },
      {
        "year": "2025",
        "title_ar": "الريادة والاستدامة",
        "title_en": "Leadership & Sustainability",
        "description_ar": "الوصول لطاقة 500 طن يومياً مع تصدير مستمر لـ 15 دولة وتطبيق سياسات إنتاج خضراء ومستدامة.",
        "description_en": "Reached 500 MT daily capacity with continuous exports to 15+ countries, implementing green and sustainable production policies."
      }
    ]
  },
  "ceo": {
    "name_ar": "محمد إسماعيل إدريس",
    "name_en": "Mohamed Ismail Idris",
    "role_ar": "رئيس مجلس إدارة مصنع السلام لعصر واستخلاص الزيوت النباتية",
    "role_en": "Chairman of the Board, Elsalam Factory for Vegetable Oils and Refining",
    "quote_ar": "نؤمن أن الجودة ليست خياراً بل هي التزام. رؤيتنا أن نكون الشريك الأول لكل مصنع ومطعم وموزع يبحث عن زيوت نباتية بمعايير عالمية مصنوعة في مصر.",
    "quote_en": "We believe quality is an obligation, not an option. Our vision is to be the premier partner for every factory, restaurant, and distributor seeking world-class vegetable oils made in Egypt.",
    "educationDesc_ar": "تخرج السيد محمد إسماعيل إدريس من جامعة الإسكندرية عام 1990، وبدأ مسيرته المهنية في مجال المبيعات، حيث أظهر منذ بداياته شغفًا واضحًا بمجال التسويق وبناء العلامات التجارية وتعزيز الحصة السوقية للشركات.",
    "educationDesc_en": "Mr. Mohamed Ismail Idris graduated from Alexandria University in 1990 and began his professional career in sales, where he demonstrated a clear passion for marketing, brand building, and expanding market share from the very beginning.",
    "careerStations": [
      {
        "title_ar": "شركة كوكاكولا – الإسكندرية (1990–1992)",
        "title_en": "Coca-Cola Company – Alexandria (1990–1992)",
        "role_ar": "مشرف مبيعات",
        "role_en": "Sales Supervisor",
        "desc_ar": "توسيع الحصة السوقية، زيادة المبيعات، تطبيق تقنيات تسويق مبتكرة",
        "desc_en": "Expanded market share, increased sales, implemented innovative marketing techniques",
        "image": "/uploads/upload_1776634969823_pkokrf.jpg"
      },
      {
        "title_ar": "شركة العوجان – المملكة العربية السعودية (1993–1995)",
        "title_en": "Aujan Industries – Saudi Arabia (1993–1995)",
        "role_ar": "مشرف التموين",
        "role_en": "Catering Supervisor",
        "desc_ar": "أسّس قسم التموين بالشركة، وساهم في إدخال منتجات (راني، فيمتو، شوكولاتة كادبوري) إلى قطاعات الفنادق والمطاعم والمستشفيات والقطاع العسكري، والخطوط الجوية السعودية.",
        "desc_en": "Founded the company''s Catering Department, successfully introducing products (Rani, Vimto, Cadbury chocolate) to hotels, restaurants, hospitals, the military sector, and Saudi Arabian Airlines.",
        "image": "/uploads/upload_1776634996004_uviykm.webp"
      },
      {
        "title_ar": "شركة باعشن – السعودية (1995–1997)",
        "title_en": "Baeshen Company – Saudi Arabia (1995–1997)",
        "role_ar": "مدير المنطقة الشمالية",
        "role_en": "Northern Region Manager",
        "desc_ar": "قاد جهود تسويق علامة شاي ربيع، وأسهم في إطلاق وتوسيع انتشار المنتج في السوق السعودي.",
        "desc_en": "Led the marketing efforts for Rabea Tea brand, contributing to the launch and extensive expansion of the product in the Saudi market.",
        "image": "/uploads/upload_1776635060394_u8uwk5.jfif"
      },
      {
        "title_ar": "شركة نستله مصر (1998)",
        "title_en": "Nestle Egypt (1998)",
        "role_ar": "مدير المبيعات - الإسكندرية",
        "role_en": "Sales Manager - Alexandria",
        "desc_ar": "أشرف على توزيع المنتجات الجافة (نسكافيه، نيدو، سيريلاك، شوكولاتة نستله) وعزز انتشار العلامة محليًا.",
        "desc_en": "Supervised the distribution of dry products (Nescafe, Nido, Cerelac, Nestle chocolate) and enhanced the brand''s local presence.",
        "image": "/uploads/upload_1776635088623_5j5aj6.png"
      },
      {
        "title_ar": "شركة صافولا سايم داربي (1999–2001)",
        "title_en": "Savola Sime Darby (1999–2001)",
        "role_ar": "مدير مبيعات القطاع الصناعي",
        "role_en": "Industrial Sector Sales Manager",
        "desc_ar": "ركز على توزيع زيت النخيل للصناعات الغذائية وقدم حلولًا صناعية مبتكرة من خلال إعادة تدوير مشتقات الزيت.",
        "desc_en": "Focused on distributing palm oil to the food industry and introduced innovative industrial solutions by recycling oil derivatives.",
        "image": "/uploads/upload_1776635112855_q157ia.webp"
      }
    ],
    "entrepreneurshipDesc_ar": "في عام 2002، اتخذ السيد محمد إدريس خطوة جريئة بتأسيس شركة السلام كشركة متخصصة في تجارة وتكرير الزيوت النباتية وتوريد المواد الخام للمصانع الكبرى والمطاعم.",
    "entrepreneurshipDesc_en": "In 2002, Mr. Mohamed Idris took a bold step by founding Elsalam Company as a specialized entity in trading and refining vegetable oils and supplying raw materials to major factories and restaurants.",
    "expansionDesc_ar": "توسعت الشركة في توزيع زيت النخيل والشورتنج والمارجرين، وخدمة أكثر من 135 مصنعًا في مصر. وفي عام 2020، تم افتتاح مصنع حديث بدمنهور مزود بأحدث خطوط الإنتاج.",
    "expansionDesc_en": "The company expanded into distributing palm oil, shortening, and margarine, serving over 135 factories in Egypt. In 2020, a modern factory was inaugurated in Damanhour, equipped with the latest production lines.",
    "innovationPoints": [
      {
        "text_ar": "إدخال الشورتنج في إنتاج الأجبان",
        "text_en": "Introducing shortening in cheese production"
      },
      {
        "text_ar": "تطوير حلول صناعية لصناعة الأغذية",
        "text_en": "Developing industrial solutions for the food industry"
      },
      {
        "text_ar": "استثمار مخلفات زيت النخيل في صناعة الصابون",
        "text_en": "Investing palm oil derivatives in soap manufacturing"
      },
      {
        "text_ar": "تطبيق نظام رقابة جودة صارم في كل مراحل الإنتاج",
        "text_en": "Implementing strictly monitored quality control across all production stages"
      }
    ],
    "visionDesc_ar": "يهدف إلى الريادة في صناعة الزيوت والدهون الطبيعية في مصر والشرق الأوسط، معتمداً على بناء شراكات استراتيجية طويلة الأمد، دعم الصناعات الصغيرة، والالتزام بالمسؤولية المجتمعية.",
    "visionDesc_en": "His vision is to lead the vegetable oils and natural fats industry in Egypt and the Middle East, relying on building long-term strategic partnerships, supporting small industries, and committing to social responsibility.",
    "leadershipPoints": [
      {
        "text_ar": "خبرة تتجاوز 30 عامًا في قطاع الأغذية",
        "text_en": "Over 30 years of experience in the food sector"
      },
      {
        "text_ar": "خلفية قوية في المبيعات الصناعية",
        "text_en": "Strong background in industrial sales"
      },
      {
        "text_ar": "قدرة على بناء شراكات استراتيجية",
        "text_en": "Ability to build strategic partnerships"
      },
      {
        "text_ar": "توجه ابتكاري في تطوير المنتجات",
        "text_en": "Innovative approach to product development"
      },
      {
        "text_ar": "دعم حقيقي للصناعات الصغيرة والمتوسطة",
        "text_en": "Genuine support for small and medium-sized industries"
      }
    ],
    "image": "/uploads/upload_1777799973239_8vhq9o.png"
  },
  "gallery": {
    "title_ar": "جولة في المصنع",
    "title_en": "Factory Tour",
    "subtitle_ar": "نظرة على خطوط الإنتاج ومرافق الجودة",
    "subtitle_en": "A look at our production lines and quality facilities",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت الآلي",
        "title_en": "Automated Oil Production Line",
        "url": "/uploads/upload_1776643156622_joaqhw.jfif"
      },
      {
        "title_ar": "معامل رقابة الجودة",
        "title_en": "Quality Control Labs",
        "url": "/uploads/upload_1776643556377_mlqu6e.jfif"
      },
      {
        "title_ar": "خزانات التخزين",
        "title_en": "Storage Tanks",
        "url": "/uploads/upload_1776643692457_kvhcm0.jfif"
      },
      {
        "title_ar": "خط تعبئة العبوات",
        "title_en": "Bottle Filling Line",
        "url": "/uploads/upload_1776643846245_gg2zai.jfif"
      },
      {
        "title_ar": "مستودعات الشحن",
        "title_en": "Shipping Warehouses",
        "url": "/uploads/upload_1776643951492_u4bpcp.jfif"
      },
      {
        "title_ar": "منطقة استقبال المواد الخام",
        "title_en": "Raw Material Reception Area",
        "url": "/uploads/upload_1776644148629_oi3c0v.jfif"
      },
      {
        "title_ar": "غرفة التحكم المركزية",
        "title_en": "Central Control Room",
        "url": "/uploads/upload_1776644200524_obw0ri.jfif"
      },
      {
        "title_ar": "خط إنتاج السمن",
        "title_en": "Ghee Production Line",
        "url": "/uploads/upload_1776644483092_5m2czr.jfif"
      }
    ]
  },
  "team": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Partners in Success",
    "title_ar": "فريق الإدارة العليا",
    "title_en": "Executive Leadership",
    "subtitle_ar": "نخبة من الكفاءات المتميزة التي تقود رؤيتنا نحو العالمية، وتضمن أعلى معايير الجودة والتميز في كافة قطاعات الشركة.",
    "subtitle_en": "Our distinguished leadership driving our global vision and ensuring the highest standards of quality.",
    "members": [
      {
        "name_ar": "ذكى السيد ذكي",
        "name_en": "Zaki El-Sayed Zaki",
        "role_ar": "مشرف المبيعات ",
        "role_en": "Sales Supervisor",
        "image": "/uploads/upload_1776621029870_2h0jss.jfif"
      },
      {
        "name_ar": "وليد بيومي",
        "name_en": "Walid Bayoumi ",
        "role_ar": "مدير المبيعات ",
        "role_en": "Sales Manager",
        "image": "/uploads/upload_1776621270095_axlqdh.jfif"
      },
      {
        "name_ar": "منة الله زكريا ",
        "name_en": "Menat Allah Zakaria",
        "role_ar": "مديرة الحسابات",
        "role_en": "Accounts Manager",
        "image": "/uploads/upload_1776629197489_t4qeu8.jfif"
      },
      {
        "name_ar": "محمد عاطف",
        "name_en": "Mohamed Atef",
        "role_ar": "مدير الإنتاج",
        "role_en": "Production Manager",
        "image": "/uploads/upload_1776629419135_hu8pen.jfif"
      },
      {
        "name_ar": "محمد الريفي",
        "name_en": "Mohamed Elrifi",
        "role_ar": "مدير الجودة",
        "role_en": "Quality Manager",
        "image": "/uploads/upload_1776630914066_sad8o6.jfif"
      }
    ]
  }
}', '2026-04-19 17:41:54.575', '2026-05-03 09:19:35.04', 1);
INSERT INTO public."PageContent" VALUES ('cmopfa1gy000krtosmw64vvv8', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck",
        "image": "/uploads/upload_1777791867288_pyu8ag.jfif"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter",
        "image": "/uploads/upload_1777792085916_gdu075.jfif"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical",
        "image": "/uploads/upload_1777792345594_zdyi0v.jfif"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope",
        "image": "/uploads/upload_1777792360172_180jue.jfif"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package",
        "image": "/uploads/upload_1777792560651_wd3kh3.jfif"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck",
        "image": "/uploads/upload_1777792715598_ym5wrt.jfif"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:01:43.282', '2026-05-03 07:18:38.377', 1);
INSERT INTO public."PageContent" VALUES ('cmoph0wi3000urtosx3l29xw5', 'b2b', '{
  "hero": {
    "title_ar": "بوابة الشراكات الصناعية",
    "title_en": "Industrial Partnerships Hub",
    "subtitle_ar": "مصنع السلام — شريكك الاستراتيجي في توريد الزيوت النباتية والسمن والشورتنج بكميات صناعية وأسعار مباشرة من المصنع.",
    "subtitle_en": "Elsalam Factory — Your strategic partner in supplying vegetable oils, margarine & shortening in industrial quantities at factory-direct prices.",
    "ctaQuote_ar": "طلب عرض سعر",
    "ctaQuote_en": "Request a Quote",
    "ctaCatalog_ar": "تحميل الكتالوج PDF",
    "ctaCatalog_en": "Download PDF Catalog",
    "backgroundImage": "/uploads/upload_1777794631585_9j7hfe.png"
  },
  "benefits": {
    "title_ar": "لماذا مصنع السلام؟",
    "title_en": "Why Elsalam Factory?",
    "subtitle_ar": "6 أسباب تجعلنا الخيار الأول للمصانع والموزعين",
    "subtitle_en": "6 reasons that make us the first choice for factories and distributors",
    "items": [
      {
        "title_ar": "طاقة إنتاجية عالية",
        "title_en": "High Production Capacity",
        "description_ar": "500 طن يومياً عبر 8 خطوط إنتاج مجهزة بأحدث التقنيات الأوروبية.",
        "description_en": "500 tons daily across 8 production lines equipped with the latest European technology."
      },
      {
        "title_ar": "مختبرات جودة متقدمة",
        "title_en": "Advanced Quality Labs",
        "description_ar": "رقابة صارمة على كل مرحلة من مراحل الإنتاج مع تقارير مخبرية لكل شحنة.",
        "description_en": "Strict quality control at every production stage with lab reports for each shipment."
      },
      {
        "title_ar": "تعبئة مخصصة",
        "title_en": "Custom Packaging",
        "description_ar": "من العبوات الصغيرة للتجزئة إلى الفليكسي تانك للتصدير — حسب احتياجاتك.",
        "description_en": "From small retail bottles to flexitank for export — tailored to your needs."
      },
      {
        "title_ar": "أسعار تنافسية",
        "title_en": "Competitive Pricing",
        "description_ar": "أسعار مباشرة من المصنع مع شروط دفع مرنة للعملاء الصناعيين.",
        "description_en": "Direct factory prices with flexible payment terms for industrial clients."
      },
      {
        "title_ar": "لوجستيات متكاملة",
        "title_en": "Integrated Logistics",
        "description_ar": "شحن محلي ودولي مع تتبع الشحنات وضمان التوصيل في الموعد.",
        "description_en": "Local and international shipping with shipment tracking and on-time delivery guarantee."
      },
      {
        "title_ar": "شريك استراتيجي",
        "title_en": "Strategic Partner",
        "description_ar": "فريق مبيعات مخصص وحلول مصممة حسب احتياجات عملك.",
        "description_en": "Dedicated sales team and solutions designed for your business needs."
      }
    ]
  },
  "quoteForm": {
    "title_ar": "طلب عرض سعر بالجملة",
    "title_en": "Bulk Quote Request",
    "subtitle_ar": "املأ البيانات التالية وسيتواصل معك فريق المبيعات خلال 24 ساعة",
    "subtitle_en": "Fill in the details below and our sales team will contact you within 24 hours",
    "moq_ar": "الحد الأدنى للطلب (MOQ): 5 أطنان — سيتم الرد خلال 24 ساعة عمل",
    "moq_en": "Minimum Order Quantity (MOQ): 5 tons — Response within 24 business hours",
    "products": [
      {
        "name_ar": "زيت صويا مكرر",
        "name_en": "Refined Soybean Oil"
      },
      {
        "name_ar": "زيت عباد الشمس",
        "name_en": "Sunflower Oil"
      },
      {
        "name_ar": "زيت نخيل",
        "name_en": "Palm Oil"
      },
      {
        "name_ar": "سمن نباتي",
        "name_en": "Vegetable Ghee"
      },
      {
        "name_ar": "شورتنج",
        "name_en": "Shortening"
      },
      {
        "name_ar": "زيت خلطات مخصصة",
        "name_en": "Custom Oil Blends"
      },
      {
        "name_ar": "Private Label",
        "name_en": "Private Label"
      }
    ],
    "packaging": [
      {
        "name_ar": "براميل (200 لتر)",
        "name_en": "Drums (200L)"
      },
      {
        "name_ar": "تنكات (18 لتر)",
        "name_en": "Tins (18L)"
      },
      {
        "name_ar": "عبوات (5 لتر)",
        "name_en": "Bottles (5L)"
      },
      {
        "name_ar": "عبوات (1 لتر)",
        "name_en": "Bottles (1L)"
      },
      {
        "name_ar": "Flexitank",
        "name_en": "Flexitank"
      },
      {
        "name_ar": "تعبئة مخصصة",
        "name_en": "Custom Packaging"
      }
    ]
  },
  "ctaSection": {
    "title_ar": "هل أنت مستعد لبدء شراكة؟",
    "title_en": "Ready to Start a Partnership?",
    "subtitle_ar": "تواصل مع فريق المبيعات الصناعية للحصول على عرض سعر مخصص",
    "subtitle_en": "Contact our industrial sales team for a custom quote",
    "buttonText_ar": "تواصل معنا الآن",
    "buttonText_en": "Contact Us Now",
    "buttonLink": "/contact"
  }
}', '2026-05-03 07:50:36.05', '2026-05-03 07:50:36.05', 1);
INSERT INTO public."PageContent" VALUES ('cmopb2icr0000rtosvu55qy7r', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production",
    "image": "/uploads/upload_1777786711159_cq1rea.jfif"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "/uploads/upload_1777785873750_m96wrq.jfif"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "/uploads/upload_1777785999364_jko31z.jfif"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": "/uploads/upload_1777786877298_6npbxa.jfif"
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": "/uploads/upload_1777786959393_rhvk3d.jfif"
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": "/uploads/upload_1777787032721_kb3fcy.jfif"
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:03:53.41', '2026-05-03 05:43:59.331', 1);
INSERT INTO public."PageContent" VALUES ('cmoqoh5o20000rtns530hrxsw', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769 ",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "phone": "+201050051851"
      },
      {
        "name_ar": "فرع كفر الدوار ",
        "name_en": "Kafr El-Dawar branch",
        "address_ar": "البحيرة - كفر الدوار - منشأة الأوقاف - أرض العمدة - 1 شارع والي",
        "address_en": "Beheira – Kafr El-Dawar – Mansha’at Al-Awqaf – Ard El-Omda – 1 Wali Street ",
        "phone": "+201222455205",
        "mapLink": "https://maps.app.goo.gl/MKoK2BWMNLXMDeWq8"
      }
    ]
  }
}', '2026-05-04 04:06:58.034', '2026-05-04 05:15:26.899', 1);
INSERT INTO public."PageContent" VALUES ('cmo3hgh5a0000rtls7rtsudmo', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج ",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": true
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-04-17 22:31:46.893', '2026-05-16 13:48:58.107', 1);


--
-- Data for Name: PageContentHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PageContentHistory" VALUES ('cmog95qyo0001rtt0ewm9cugq', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": false
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png"
  }
}', '2026-04-26 21:00:29.76', '٢٧‏/٤‏/٢٠٢٦ ١٢:٠٠:٢٩ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmog96loq0003rtt0jr2r1e9c', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": false
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية "
  }
}', '2026-04-26 21:01:09.578', '٢٧‏/٤‏/٢٠٢٦ ١٢:٠١:٠٩ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmog9941g0005rtt0c6qoqw05', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": false
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-04-26 21:03:06.676', '٢٧‏/٤‏/٢٠٢٦ ١٢:٠٣:٠٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopb2j6a0001rtosiobs9xwb', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "https://images.unsplash.com/photo-1582719478250-c89e82c5a013?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "https://images.unsplash.com/photo-1579154204601-39769d4b0f09?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:03:54.514', '٣‏/٥‏/٢٠٢٦ ٨:٠٣:٥٣ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopb5pkv0003rtos7n9k6rwm', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "https://images.unsplash.com/photo-1579154204601-39769d4b0f09?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:06:22.783', '٣‏/٥‏/٢٠٢٦ ٨:٠٦:٢٢ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopbb8qw0005rtosvojamldp', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "https://images.unsplash.com/photo-1579154204601-39769d4b0f09?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:10:40.905', '٣‏/٥‏/٢٠٢٦ ٨:١٠:٤٠ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopbdexa0007rtosz9afy8pb', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:12:22.223', '٣‏/٥‏/٢٠٢٦ ٨:١٢:٢٢ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmp8ei19l0000i0fmhy6qufzf', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": false
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-05-16 13:47:33.994', 'Auto-save before update');
INSERT INTO public."PageContentHistory" VALUES ('cmp8ei3a20002i0fmg68adzqf', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": true
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-05-16 13:47:36.602', '١٦‏/٥‏/٢٠٢٦، ٤:٤٧:٣٤ م');
INSERT INTO public."PageContentHistory" VALUES ('cmp8eju5h0003i0fm63k92pz0', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": true
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-05-16 13:48:58.086', 'Auto-save before update');
INSERT INTO public."PageContentHistory" VALUES ('cmp8ejw8m0005i0fmg7ccrtuf', 'home', '{
  "heroSlides": {
    "slides": [
      {
        "tabName_ar": "الجودة والإنتاج ",
        "tabName_en": "Quality & Production",
        "badge_ar": "أكثر من 25 عاماً من الخبرة في عصر الزيوت",
        "badge_en": "Over 25 years of experience in oil pressing",
        "titleLine1_ar": "الريادة في عصر",
        "titleLine1_en": "Leading in",
        "titleLine2_ar": "الزيوت النباتية",
        "titleLine2_en": "Vegetable Oils",
        "subtitle_ar": "مصنع السلام يلتزم بتقديم أعلى معايير الجودة في إنتاج الزيوت، السمن والشورتنج للسوق المصري والعالمي بأحدث التقنيات الأوروبية.",
        "subtitle_en": "Elsalam Factory is committed to the highest quality standards in producing oils, margarine & shortening for the Egyptian and international markets using the latest European technologies.",
        "ctaPrimary_ar": "اكتشف منتجاتنا",
        "ctaPrimary_en": "Explore Products",
        "ctaPrimaryLink": "/products",
        "ctaSecondary_ar": "شراكات التصدير",
        "ctaSecondary_en": "Export Partnerships",
        "ctaSecondaryLink": "/export",
        "image": "/uploads/upload_1776465099444_4hgvjl.jfif"
      },
      {
        "tabName_ar": "التصدير العالمي",
        "tabName_en": "Global Export",
        "badge_ar": "نصدر لأكثر من 15 دولة حول العالم",
        "badge_en": "Exporting to 15+ countries worldwide",
        "titleLine1_ar": "شريكك الموثوق في",
        "titleLine1_en": "Your Trusted Partner in",
        "titleLine2_ar": "التجارة الدولية",
        "titleLine2_en": "Global Trade",
        "subtitle_ar": "منتجات جاهزة للتصدير بأعلى المواصفات القياسية، مع لوجستيات متكاملة لتلبية متطلبات الأسواق العالمية بمرونة وكفاءة.",
        "subtitle_en": "Export-ready products meeting the highest international standards, backed by integrated logistics to serve global markets with flexibility and efficiency.",
        "ctaPrimary_ar": "دليل التصدير",
        "ctaPrimary_en": "Export Guide",
        "ctaPrimaryLink": "/export",
        "ctaSecondary_ar": "تواصل معنا",
        "ctaSecondary_en": "Contact Us",
        "ctaSecondaryLink": "/contact",
        "image": "/uploads/upload_1776467998203_e7lcwm.jfif"
      },
      {
        "tabName_ar": "شراكات الجملة B2B",
        "tabName_en": "B2B Partnerships",
        "badge_ar": "طاقة إنتاجية تصل إلى 500 طن يومياً",
        "badge_en": "Production capacity up to 500 tons/day",
        "titleLine1_ar": "حلول صناعية",
        "titleLine1_en": "Industrial Solutions at",
        "titleLine2_ar": "بأسعار المصنع",
        "titleLine2_en": "Factory Prices",
        "subtitle_ar": "نوفر الزيوت، السمن، والشورتنج بكميات ضخمة وتعبئات مخصصة للمصانع، المخابز، وسلاسل المطاعم الكبرى.",
        "subtitle_en": "We supply oils, margarine, and shortening in bulk quantities with custom packaging for factories, bakeries, and major restaurant chains.",
        "ctaPrimary_ar": "طلب عرض سعر بالجملة",
        "ctaPrimary_en": "Request Bulk Quote",
        "ctaPrimaryLink": "/b2b/quote",
        "ctaSecondary_ar": "مزايا الشراكة",
        "ctaSecondary_en": "Partnership Benefits",
        "ctaSecondaryLink": "/b2b",
        "image": "/uploads/upload_1776468282395_galmqr.jfif"
      }
    ]
  },
  "stats": {
    "items": [
      {
        "value": "25+",
        "label_ar": "سنوات الخبرة",
        "label_en": "Years of Experience"
      },
      {
        "value": "500",
        "label_ar": "طن إنتاج يومياً",
        "label_en": "Tons Daily Production"
      },
      {
        "value": "15+",
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries"
      },
      {
        "value": "200+",
        "label_ar": "عميل صناعي",
        "label_en": "Industrial Clients"
      },
      {
        "value": "8",
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines"
      },
      {
        "value": "6",
        "label_ar": "شهادات جودة",
        "label_en": "Quality Certifications"
      }
    ]
  },
  "whyChooseUs": {
    "badge_ar": "لماذا نحن؟",
    "badge_en": "Why Us?",
    "title_ar": "لماذا تختار",
    "title_en": "Why Choose",
    "titleHighlight_ar": "مصنع السلام",
    "titleHighlight_en": "Elsalam Factory",
    "subtitle_ar": "نبني شراكات استراتيجية موثوقة تعتمد على الجودة والالتزام المطلق",
    "subtitle_en": "We build reliable strategic partnerships based on quality and absolute commitment",
    "reasons": [
      {
        "title_ar": "طاقة إنتاجية ضخمة",
        "title_en": "Massive Production Capacity",
        "description_ar": "بقدرة إنتاجية تصل إلى 500 طن يومياً، نضمن تلبية كافة الطلبيات الكبرى للقطاع الصناعي والتجاري دون تأخير.",
        "description_en": "With a production capacity of up to 500 tons per day, we guarantee fulfilling all major orders for the industrial and commercial sectors without delay."
      },
      {
        "title_ar": "معايير جودة عالمية",
        "title_en": "Global Quality Standards",
        "description_ar": "حاصلون على أعلى شهادات الجودة وسلامة الغذاء الدولية، مما يضمن تصدير منتجاتنا لأكثر من 15 دولة.",
        "description_en": "Certified with the highest international quality and food safety standards, ensuring our products are exported to over 15 countries."
      },
      {
        "title_ar": "تقنيات تكرير متطورة",
        "title_en": "Advanced Refining Technology",
        "description_ar": "نستخدم أحدث تكنولوجيا التكرير لتحقيق أعلى درجات النقاء والشفافية، مع الحفاظ على القيمة الغذائية.",
        "description_en": "We use the latest refining technology to achieve the highest levels of purity and transparency while preserving nutritional value."
      },
      {
        "title_ar": "طبيعي 100%",
        "title_en": "100% Natural",
        "description_ar": "منتجاتنا خالية تماماً من المواد الحافظة والإضافات الكيميائية الضارة، لنقدم لك زيوتاً صحية وآمنة تماماً.",
        "description_en": "Our products are completely free from preservatives and harmful chemical additives, offering you healthy and safe oils."
      }
    ]
  },
  "segments": {
    "title_ar": "كيف يمكننا خدمتك؟",
    "title_en": "How Can We Serve You?",
    "subtitle_ar": "نقدم حلولاً مخصصة لكل قطاع",
    "subtitle_en": "Customized solutions for every sector",
    "items": [
      {
        "title_ar": "مصانع الأغذية",
        "title_en": "Food Manufacturers",
        "desc_ar": "حلول بالجملة مع مواصفات مخصصة لخطوط إنتاجك",
        "desc_en": "Wholesale solutions with custom specs for your production lines",
        "cta_ar": "طلب عرض سعر",
        "cta_en": "Request Quote",
        "image": "/uploads/upload_1776475289226_xm1xs1.jfif"
      },
      {
        "title_ar": "فنادق ومطاعم",
        "title_en": "Hotels & Restaurants",
        "desc_ar": "منتجات HoReCa بتعبئات مناسبة ومواصفات عالمية",
        "desc_en": "HoReCa products with suitable packaging & global specs",
        "cta_ar": "تواصل معنا",
        "cta_en": "Contact Us",
        "image": "/uploads/upload_1776475687003_yhtbtt.jfif"
      },
      {
        "title_ar": "التصدير العالمي",
        "title_en": "Global Export",
        "desc_ar": "منتجات جاهزة للتصدير بمطابقة كاملة للمعايير الدولية",
        "desc_en": "Export-ready products fully compliant with international standards",
        "cta_ar": "استفسار تصدير",
        "cta_en": "Export Inquiry",
        "image": "/uploads/upload_1776476028139_k7nnht.jfif"
      },
      {
        "title_ar": "التجزئة والتوزيع",
        "title_en": "Retail & Distribution",
        "desc_ar": "أسعار تنافسية وتوصيل مباشر لنقاط البيع",
        "desc_en": "Competitive prices with direct delivery to points of sale",
        "cta_ar": "تسوق الآن",
        "cta_en": "Shop Now",
        "image": "/uploads/upload_1776477111361_80f9nd.jfif"
      }
    ]
  },
  "featuredProducts": {
    "badge_ar": "أفضل المنتجات",
    "badge_en": "Top Products",
    "title_ar": "منتجاتنا الرائدة",
    "title_en": "Our Leading Products",
    "subtitle_ar": "تلبية لاحتياجات السوق المحلي والتصدير",
    "subtitle_en": "Meeting local market and export needs",
    "viewAll_ar": "عرض كل المنتجات",
    "viewAll_en": "View All Products",
    "products": [
      {
        "title_ar": "زيت صويا مكرر",
        "title_en": "Refined Soybean Oil",
        "subtitle": "Refined Soybean Oil",
        "description_ar": "زيت صويا نقي وعالي الجودة مناسب للطهي والقلي المتكرر.",
        "description_en": "Pure and high-quality soybean oil suitable for cooking and repeated frying.",
        "slug": "http://localhost:3000/products?category=soybean-oil-",
        "image": "/uploads/upload_1776470693226_ch171n.jfif"
      },
      {
        "title_ar": "سمن نباتي ممتاز",
        "title_en": "Premium Vegetable Ghee",
        "subtitle": "Vegetable Ghee",
        "description_ar": "سمن نباتي بقوام كريمي ونكهة غنية تضفي طعماً مميزاً.",
        "description_en": "Vegetable ghee with a creamy texture and rich flavor that adds a distinct taste.",
        "slug": "vegetable-ghee",
        "image": "/uploads/upload_1776470997067_72x4rn.jfif"
      },
      {
        "title_ar": "زيت عباد الشمس",
        "title_en": "Sunflower Oil",
        "subtitle": "Sunflower Oil",
        "description_ar": "زيت خفيف وصحي مثالي للاستخدام اليومي والسلطات.",
        "description_en": "Light and healthy oil ideal for daily use and salads.",
        "slug": "sunflower-oil",
        "image": "/uploads/upload_1776471333243_erxh32.jfif"
      },
      {
        "title_ar": "شورتنج المخابز",
        "title_en": "Bakery Shortening",
        "subtitle": "Bakery Shortening",
        "description_ar": "شورتنج متخصص للحلويات والمخبوزات يعطي هشاشة فائقة.",
        "description_en": "Specialized shortening for sweets and baked goods providing superior crispness.",
        "slug": "bakery-shortening",
        "image": "/uploads/upload_1776471821886_33wzg9.jfif"
      }
    ]
  },
  "ourProcess": {
    "badge_ar": "آلية الإنتاج والجودة",
    "badge_en": "Our Process",
    "title_ar": "من البذرة إلى المائدة.. رحلة الجودة",
    "title_en": "From Seed to Shelf",
    "subtitle_ar": "نميز أنفسنا بتشغيل أحد أكثر المنشآت تطوراً وأتمتة في المنطقة، لنضمن أن كل قطرة مطابقة للمعايير العالمية.",
    "subtitle_en": "We operate one of the most technologically advanced automated facilities in the region, ensuring every drop meets global benchmarks.",
    "steps": [
      {
        "image": "/uploads/upload_1776472340208_t9dmw2.jfif",
        "title_en": "Careful Seed Selection",
        "title_ar": "اختيار أفضل البذور",
        "description_en": "We source only the highest quality, non-GMO seeds from trusted global partners to ensure the foundation of our oils is flawless.",
        "description_ar": "نعتمد على أجود أنواع البذور غير المعدلة وراثياً من موردين عالميين موثوقين، لنضمن أن أساس زيوتنا مثالي."
      },
      {
        "image": "/uploads/upload_1776472924543_3v286e.jfif",
        "title_en": "Advanced Double Refining",
        "title_ar": "تكرير متميز ومزدوج",
        "description_en": "Utilizing state-of-the-art European machinery, our oil undergoes multiple stages of refining, neutralizing, and deodorizing for ultimate purity.",
        "description_ar": "باستخدام أحدث الآلات الأوروبية، يمر زيتها بمراحل دقيقة من التكرير والتعادل وإزالة الرائحة لضمان النقاء المطلق."
      },
      {
        "image": "/uploads/upload_1776473188317_uw6tsp.jfif",
        "title_en": "Rigorous Labs & QC",
        "title_ar": "فحوصات الجودة الصارمة",
        "description_en": "Every batch is meticulously analyzed in our on-site laboratories against strict international ISO & HACCP standards.",
        "description_ar": "تُحلل كل دفعة إنتاجية بدقة متناهية في مختبراتنا المجهزة، وفقاً لأعلى معايير الأيزو ونظام الهاسب (HACCP)."
      },
      {
        "image": "/uploads/upload_1776473676483_gg90tq.jfif",
        "title_en": "Hygienic Packaging in Compliance with Quality Standards",
        "title_ar": "تعبئة صحية وفق معايير الجودة",
        "description_en": "Hygienic Packaging According to the Highest Standards",
        "description_ar": "تعبئة صحية وفق أعلى المعايير"
      }
    ]
  },
  "globalFootprint": {
    "title_ar": "البصمة العالمية",
    "title_en": "Global Footprint",
    "subtitle_ar": "نصدر لأكثر من 15 دولة حول العالم",
    "subtitle_en": "We export to over 15 countries worldwide"
  },
  "sustainability": {
    "title_ar": "الاستدامة والمسؤولية البيئية",
    "title_en": "Sustainability & Environmental Responsibility",
    "subtitle_ar": "نلتزم بأعلى معايير الاستدامة في عمليات الإنتاج",
    "subtitle_en": "We are committed to the highest sustainability standards in our production processes",
    "image": "/uploads/upload_1776477923691_sm53cx.jfif"
  },
  "virtualTour": {
    "title_ar": "الجولة الافتراضية",
    "title_en": "Virtual Tour",
    "subtitle_ar": "تعرف على مصنعنا من الداخل",
    "subtitle_en": "Explore our factory from the inside",
    "isVisible": true
  },
  "packaging": {
    "badge_ar": "خيارات التعبئة",
    "badge_en": "Packaging Options",
    "title_ar": "عبوات تلبي كافة احتياجاتك",
    "title_en": "Packaging for Every Need",
    "subtitle_ar": "نوفر خيارات تعبئة مرنة ومتنوعة تناسب جميع القطاعات من التجزئة وحتى الشحن البحري للصناعات الكبرى.",
    "subtitle_en": "We provide flexible and diverse packaging options suitable for all sectors, from retail to bulk maritime shipping for major industries.",
    "types": [
      {
        "title_ar": "عبوات بلاستيكية (PET)",
        "title_en": "PET Plastic Bottles",
        "sizes_ar": "1، 2، 5 لتر",
        "sizes_en": "1, 2, 5 liters",
        "description_ar": "مثالية لتطبيقات التجزئة والأسواق الاستهلاكية والاستخدام المنزلي.",
        "description_en": "Ideal for retail applications, consumer markets, and household use.",
        "image": "/uploads/upload_1776481345801_9ja2xu.jfif"
      },
      {
        "title_ar": "تنكات صفيح",
        "title_en": "Tin Cans",
        "sizes_ar": "16 لتـر، 18 لتـر",
        "sizes_en": "16L, 18L",
        "description_ar": "الخيار الأمثل للمطاعم والفنادق (HoReCa) المعتمدة على الاستهلاك الكثيف.",
        "description_en": "The optimal choice for restaurants and hotels (HoReCa) with heavy consumption.",
        "image": "/uploads/upload_1776481632761_jc667m.jfif"
      },
      {
        "title_ar": "براميـل حديدية",
        "title_en": "Steel Drums",
        "sizes_ar": "200 لتـر",
        "sizes_en": "200L",
        "description_ar": "تعبئة اقتصادية للمصانع الغذائية ومصانع الحلويات والمخابز الكبرى.",
        "description_en": "Economical packaging for food factories, confectioneries, and large bakeries.",
        "image": "/uploads/upload_1776481868312_fno49e.jfif"
      },
      {
        "title_ar": "فليكسي تانك",
        "title_en": "Flexitank",
        "sizes_ar": "22,000 لتـر",
        "sizes_en": "22,000L",
        "description_ar": "الحل الاستراتيجي لتصدير كميات ضخمة للشحن البحري بأقل تكلفة لوجستية.",
        "description_en": "The strategic solution for exporting large quantities via maritime shipping at the lowest logistics cost.",
        "image": "/uploads/upload_1776482319857_icf4mt.jfif"
      }
    ]
  },
  "certifications": {
    "badge_ar": "الجودة والامتثال",
    "badge_en": "Quality & Compliance",
    "title_ar": "شهادات الجودة والاعتمادات الدولية",
    "title_en": "Quality Certifications & International Accreditations",
    "subtitle_ar": "نفخر بحصولنا على أعلى الشهادات العالمية التي تضمن جودة وسلامة منتجاتنا",
    "subtitle_en": "We are proud to hold the highest international certifications ensuring the quality and safety of our products",
    "certs": [
      {
        "name_ar": "ISO 9001",
        "name_en": "ISO 9001",
        "desc_ar": "إدارة الجودة الشاملة",
        "desc_en": "Total Quality Management"
      },
      {
        "name_ar": "ISO 22000",
        "name_en": "ISO 22000",
        "desc_ar": "سلامة الغذاء الدولية",
        "desc_en": "International Food Safety"
      },
      {
        "name_ar": "HACCP",
        "name_en": "HACCP",
        "desc_ar": "تحليل المخاطر ونقاط التحكم",
        "desc_en": "Hazard Analysis & Critical Control"
      },
      {
        "name_ar": "Halal",
        "name_en": "Halal",
        "desc_ar": "شهادة الحلال المعتمدة",
        "desc_en": "Certified Halal"
      },
      {
        "name_ar": "GMP",
        "name_en": "GMP",
        "desc_ar": "ممارسات التصنيع الجيدة",
        "desc_en": "Good Manufacturing Practices"
      },
      {
        "name_ar": "FDA",
        "name_en": "FDA",
        "desc_ar": "معتمد من إدارة الغذاء والدواء",
        "desc_en": "FDA Approved"
      }
    ]
  },
  "testimonials": {
    "title_ar": "ماذا يقول عملاؤنا",
    "title_en": "What Our Clients Say",
    "subtitle_ar": "ثقة تمتد لأكثر من 25 عاماً مع آلاف العملاء في مصر والعالم",
    "subtitle_en": "Trust spanning over 25 years with thousands of clients in Egypt and worldwide",
    "items": [
      {
        "name_ar": "م. خالد عبد الرحمن",
        "name_en": "Eng. Khaled Abdel Rahman",
        "role_ar": "مدير مشتريات — مصنع بسكويت النجمة",
        "role_en": "Purchasing Manager — Star Biscuit Factory",
        "content_ar": "نتعامل مع مصنع السلام منذ أكثر من 8 سنوات. جودة الشورتنج ثابتة في كل شحنة، وخدمة ما بعد البيع ممتازة.",
        "content_en": "We''ve been working with Elsalam Factory for over 8 years. The shortening quality is consistent in every shipment, and the after-sales service is excellent."
      },
      {
        "name_ar": "أ. سارة المصري",
        "name_en": "Ms. Sara Al-Masry",
        "role_ar": "مالكة سلسلة مطاعم الأصالة",
        "role_en": "Owner of Al-Asala Restaurant Chain",
        "content_ar": "زيت عباد الشمس من السلام هو اختيارنا الأول. لا يغير نكهة الطعام ويتحمل القلي المتكرر بشكل ممتاز.",
        "content_en": "Elsalam''s sunflower oil is our first choice. It doesn''t alter food flavor and handles repeated frying excellently."
      },
      {
        "name_ar": "Mr. Ahmed Hassan",
        "name_en": "Mr. Ahmed Hassan",
        "role_ar": "مدير الاستيراد — شركة Global Foods Trading, الإمارات",
        "role_en": "Import Manager — Global Foods Trading, UAE",
        "content_ar": "مصنع السلام هو موردنا الموثوق للزيوت النباتية. شهادات ISO والحلال مع أسعار تنافسية تجعلهم الخيار الأفضل في مصر.",
        "content_en": "Elsalam is our trusted supplier for vegetable oils. Their ISO and Halal certifications, combined with competitive pricing, make them the best choice in Egypt."
      },
      {
        "name_ar": "أ. محمد يوسف",
        "name_en": "Mr. Mohamed Youssef",
        "role_ar": "موزع معتمد — القاهرة الكبرى",
        "role_en": "Authorized Distributor — Greater Cairo",
        "content_ar": "التعامل مع مصنع السلام سهل واحترافي. الأسعار تنافسية والتسليم دائماً في الموعد. أنصح بالتعامل معهم.",
        "content_en": "Working with Elsalam Factory is easy and professional. Prices are competitive and delivery is always on time. Highly recommended."
      }
    ]
  },
  "timeline": {
    "badge_ar": "مراحل الإنتاج",
    "badge_en": "Production Process",
    "title_ar": "مسار الإنتاج",
    "title_en": "Production Journey",
    "subtitle_ar": "من الطبيعة إلى مائدتك، رحلة موثقة بأعلى معايير الجودة العالمية",
    "subtitle_en": "From nature to your table, a journey documented with the highest global quality standards",
    "steps": [
      {
        "title_ar": "استلام وتجهيز البذور",
        "title_en": "Seed Reception & Preparation",
        "description_ar": "استلام البذور الزراعية (صويا، عباد شمس) وتمريرها على أجهزة التنظيف المغناطيسية والغربلة.",
        "description_en": "Receiving agricultural seeds (soybean, sunflower) and passing them through magnetic cleaning and sieving equipment."
      },
      {
        "title_ar": "العصر والاستخلاص",
        "title_en": "Pressing & Extraction",
        "description_ar": "تكسير وتسخين البذور لزيادة المردود الزيتي، ثم عصرها آلياً واستخلاص الزيت الخام.",
        "description_en": "Crushing and heating seeds to increase oil yield, then mechanically pressing and extracting crude oil."
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "إزالة الصمغ، التبييض، ونزع الرائحة للوصول للزيت النقي عالي الشفافية.",
        "description_en": "Degumming, bleaching, and deodorizing to achieve pure, highly transparent oil."
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية تحت ظروف صحية تامة لضمان الحفاظ على الخواص الطبيعية للمنتج.",
        "description_en": "Automated filling under full sanitary conditions to preserve the natural properties of the product."
      }
    ]
  },
  "faq": {
    "title_ar": "الأسئلة الشائعة",
    "title_en": "Frequently Asked Questions",
    "subtitle_ar": "إجابات على أكثر الأسئلة شيوعاً من عملائنا",
    "subtitle_en": "Answers to the most common questions from our clients",
    "items": [
      {
        "question_ar": "ما هي أنواع الزيوت التي ينتجها مصنع السلام؟",
        "question_en": "What types of oils does Elsalam Factory produce?",
        "answer_ar": "ينتج مصنع السلام تشكيلة واسعة تشمل: زيت صويا مكرر، زيت عباد الشمس، زيت نخيل مكرر، سمن نباتي ممتاز، سمن نباتي صناعي، شورتنج المخابز، وشورتنج القلي العميق. كما نقدم خلطات زيوت مخصصة حسب مواصفات العميل.",
        "answer_en": "Elsalam Factory produces a wide range including: refined soybean oil, sunflower oil, refined palm oil, premium vegetable ghee, industrial margarine, bakery shortening, and deep frying shortening. We also offer custom oil blends per client specifications."
      },
      {
        "question_ar": "هل منتجاتكم حاصلة على شهادات جودة؟",
        "question_en": "Are your products quality certified?",
        "answer_ar": "نعم، جميع منتجاتنا حاصلة على شهادات ISO 9001 و ISO 22000 و HACCP وشهادة الحلال. نلتزم بأعلى معايير الجودة والسلامة الغذائية في كل مراحل الإنتاج.",
        "answer_en": "Yes, all our products hold ISO 9001, ISO 22000, HACCP, and Halal certifications. We adhere to the highest quality and food safety standards at every production stage."
      },
      {
        "question_ar": "ما هي الحد الأدنى لكمية الطلب؟",
        "question_en": "What is the minimum order quantity?",
        "answer_ar": "للسوق المحلي: يختلف الحد الأدنى حسب نوع المنتج والتعبئة. للتصدير: الحد الأدنى هو 20 طن (حاوية 20 قدم). يمكنك التواصل معنا للحصول على تفاصيل أكثر حسب احتياجك.",
        "answer_en": "For local market: the minimum varies by product type and packaging. For export: the minimum is 20 tons (1x20'' FCL). Contact us for more details based on your needs."
      },
      {
        "question_ar": "هل تصدرون لخارج مصر؟",
        "question_en": "Do you export outside Egypt?",
        "answer_ar": "نعم، نصدّر لأكثر من 15 دولة حول العالم تشمل الشرق الأوسط، أفريقيا، أوروبا، وآسيا. نوفر جميع الوثائق اللازمة للتخليص الجمركي.",
        "answer_en": "Yes, we export to over 15 countries worldwide including the Middle East, Africa, Europe, and Asia. We provide all documentation required for customs clearance."
      },
      {
        "question_ar": "ما هي خيارات التعبئة المتاحة؟",
        "question_en": "What packaging options are available?",
        "answer_ar": "نقدم تعبئات متنوعة: عبوات استهلاكية (1 لتر، 2 لتر، 5 لتر)، عبوات صناعية (18 لتر، براميل 200 لتر)، وفليكسي تانك للشحن بالجملة. يمكننا أيضاً توفير تعبئة مخصصة بعلامتك التجارية.",
        "answer_en": "We offer diverse packaging: consumer bottles (1L, 2L, 5L), industrial packaging (18L, 200L drums), and flexitanks for bulk shipping. We can also provide private label packaging with your brand."
      },
      {
        "question_ar": "كم يستغرق تنفيذ الطلب والتسليم؟",
        "question_en": "How long does order fulfillment and delivery take?",
        "answer_ar": "للطلبات المحلية: من 3 إلى 7 أيام عمل. لطلبات التصدير: من 14 إلى 21 يوم عمل حسب الوجهة. نلتزم دائماً بمواعيد التسليم المتفق عليها.",
        "answer_en": "For local orders: 3-7 business days. For export orders: 14-21 business days depending on destination. We always commit to agreed delivery schedules."
      }
    ]
  },
  "ctaPartnership": {
    "title_ar": "هل تبحث عن شريك صناعي موثوق؟",
    "title_en": "Looking for a Reliable Industrial Partner?",
    "subtitle_ar": "سواء كنت مصنعاً للأغذية، سلسلة مطاعم، أو موزعاً عالمياً — مصنع السلام يوفر لك حلولاً مخصصة بأعلى معايير الجودة وأسعار تنافسية.",
    "subtitle_en": "Whether you''re a food manufacturer, restaurant chain, or global distributor — Elsalam Factory provides customized solutions with the highest quality standards and competitive prices.",
    "ctaPrimary_ar": "طلب عرض سعر",
    "ctaPrimary_en": "Request a Quote",
    "ctaSecondary_ar": "تواصل مع فريق المبيعات",
    "ctaSecondary_en": "Contact Sales Team"
  },
  "clientLogos": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Success Partners",
    "titleBefore_ar": "يثق بنا أكثر من",
    "titleBefore_en": "Trusted by over",
    "titleCount": "200+",
    "titleAfter_ar": "شريك صناعي",
    "titleAfter_en": "industrial partners",
    "names": [
      {
        "name_ar": "شركة الجوهرة",
        "name_en": "Delta Industrial Co.",
        "logo": "/uploads/upload_1776484795352_pokpsp.jpg"
      },
      {
        "name_ar": "شركة فرج الله ",
        "name_en": "",
        "logo": "/uploads/upload_1776485103132_2d8mjh.webp"
      },
      {
        "name_ar": "امكو فودز (Amco Foods) – بسكويت ",
        "name_en": "",
        "logo": "/uploads/upload_1776485156629_hqjcxr.png"
      },
      {
        "name_ar": "ريفر فودز – كيك وبسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776485203590_worl7u.png"
      },
      {
        "name_ar": "أوشن فودز – لمبادا",
        "name_en": "",
        "logo": "/uploads/upload_1776485255889_01oirv.webp"
      },
      {
        "name_ar": "الصقر – جبنة وزبدة",
        "name_en": "",
        "logo": "/uploads/upload_1776485317963_jjbu5i.png"
      },
      {
        "name_ar": "المتحدة للبويات",
        "name_en": "",
        "logo": "/uploads/upload_1776485390285_99h5hx.jfif"
      },
      {
        "name_ar": "بروتال",
        "name_en": "",
        "logo": "/uploads/upload_1776485440047_kcy1jp.png"
      },
      {
        "name_ar": "بسكويت سلوى",
        "name_en": "",
        "logo": "/uploads/upload_1776485674465_jgqpkd.jfif"
      },
      {
        "name_ar": "بسكويت دهب",
        "name_en": "",
        "logo": "/uploads/upload_1776485845529_jnynrg.jfif"
      },
      {
        "name_ar": "ملكو – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776485891891_1uq6ch.jpg"
      },
      {
        "name_ar": "يوني فودز – بطاطس",
        "name_en": "",
        "logo": "/uploads/upload_1776485948714_zfp50s.png"
      },
      {
        "name_ar": "كيرو فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776485979118_f3c5xo.png"
      },
      {
        "name_ar": "بير فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486032484_iidbgs.png"
      },
      {
        "name_ar": "فودا فودز – بسكويت",
        "name_en": "",
        "logo": "/uploads/upload_1776486118759_q5n133.jfif"
      },
      {
        "name_ar": "إيجيبت مان – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486169484_dz3jv4.png"
      },
      {
        "name_ar": "رايت فودز – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486195275_agnma7.jfif"
      },
      {
        "name_ar": "فوكس – شيبسي",
        "name_en": "",
        "logo": "/uploads/upload_1776486216074_2rj1j3.jfif"
      },
      {
        "name_ar": "جبنة المصريين",
        "name_en": "",
        "logo": "/uploads/upload_1776486278709_dzbrdf.png"
      },
      {
        "name_ar": "كورونا ",
        "name_en": "",
        "logo": "/uploads/upload_1776486320461_ipcp1t.jfif"
      },
      {
        "name_ar": "كلوكوز نودلز (إندومي) ",
        "name_en": "",
        "logo": "/uploads/upload_1776486351969_vtogob.png"
      },
      {
        "name_ar": "ماسي فودز",
        "name_en": "",
        "logo": "/uploads/upload_1776486386750_ovc4b2.png"
      },
      {
        "name_ar": "مصنع الطارق – جبنة",
        "name_en": "",
        "logo": "/uploads/upload_1776486629948_63xzeq.jfif"
      },
      {
        "name_ar": "جاد",
        "name_en": "",
        "logo": "/uploads/upload_1776486660531_2jnymh.webp"
      },
      {
        "name_ar": "أبو ربيع",
        "name_en": "",
        "logo": "/uploads/upload_1776486705898_0t2kqp.webp"
      },
      {
        "name_ar": "الفلاح",
        "name_en": "",
        "logo": "/uploads/upload_1776486738907_e7pxoo.jfif"
      },
      {
        "name_ar": "المدهش ",
        "name_en": "",
        "logo": "/uploads/upload_1776486760854_bkavyk.png"
      },
      {
        "name_ar": "زفير للأسماك",
        "name_en": "",
        "logo": "/uploads/upload_1776486838088_o24p63.jfif"
      },
      {
        "name_ar": "عروس البحر",
        "name_en": "",
        "logo": "/uploads/upload_1776486859854_37op37.png"
      },
      {
        "name_ar": "كبدة العربي",
        "name_en": "",
        "logo": "/uploads/upload_1776486925916_z5lytx.jfif"
      },
      {
        "name_ar": "رغيف شاورما",
        "name_en": "",
        "logo": "/uploads/upload_1776486945944_kexjrp.png"
      },
      {
        "name_ar": "بلبع للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487023971_2hgwob.jfif"
      },
      {
        "name_ar": "هرم الحمام",
        "name_en": "",
        "logo": "/uploads/upload_1776487042491_9j5cxy.jfif"
      },
      {
        "name_ar": "قرية عبدالوهاب للمشويات",
        "name_en": "",
        "logo": "/uploads/upload_1776487066475_72fbz5.jfif"
      },
      {
        "name_ar": "أبو عوض",
        "name_en": "",
        "logo": "/uploads/upload_1776487088718_9ofoyk.jfif"
      },
      {
        "name_ar": "ويف",
        "name_en": "",
        "logo": "/uploads/upload_1776487176927_o9zo3v.jfif"
      }
    ]
  },
  "footer": {
    "description_ar": "الريادة في عصر الزيوت النباتية وإنتاج الزيوت، السمن والشورتنج منذ عام 2000. موثوق من أكثر من 200 شريك صناعي حول العالم.",
    "description_en": "Leading in vegetable oil pressing and production of oils, margarine & shortening since 2000. Trusted by over 200 industrial partners worldwide.",
    "address_ar": "الأبعادية عند مجمع الكليات، البحيرة، دمنهور، مصر",
    "address_en": "“Al-Abadiya near the Colleges Complex, Beheira, Damanhur, Egypt.”",
    "phone": "+201050051851",
    "email": "info@elsalamoil.com",
    "copyright_en": "Copyright ITechonlogy ",
    "copyright_ar": "Copyright ITechonlogy ",
    "logo": "/uploads/upload_1777237219581_etnn18.png",
    "brandName": "مصنع السلام لعصر وإستخلاص الزيوت النباتية ",
    "brandEn": "El-Salam Factory for Pressing and Extracting Vegetable Oils"
  }
}', '2026-05-16 13:49:00.79', '١٦‏/٥‏/٢٠٢٦، ٤:٤٨:٥٨ م');
INSERT INTO public."PageContentHistory" VALUES ('cmopbh1ks0009rtos2ek2bjlm', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "https://images.unsplash.com/photo-1532094349884-543bc11b234d?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:15:11.548', '٣‏/٥‏/٢٠٢٦ ٨:١٥:١١ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopbmyo6000brtosf183co00', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?q=80&w=800&auto=format&fit=crop"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:19:47.718', '٣‏/٥‏/٢٠٢٦ ٨:١٩:٤٧ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopbt5ls000drtosukvuppkp', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "/uploads/upload_1777785873750_m96wrq.jfif"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "https://images.unsplash.com/photo-1576086213369-8b806f7df282?q=80&w=800&auto=format&fit=crop"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:24:36.64', '٣‏/٥‏/٢٠٢٦ ٨:٢٤:٣٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopbvvu9000frtosmu3je4y6', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "/uploads/upload_1777785873750_m96wrq.jfif"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "/uploads/upload_1777785999364_jko31z.jfif"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:26:43.954', '٣‏/٥‏/٢٠٢٦ ٨:٢٦:٤٣ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopcb67l000hrtos4h4oki34', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production",
    "image": "/uploads/upload_1777786711159_cq1rea.jfif"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "/uploads/upload_1777785873750_m96wrq.jfif"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "/uploads/upload_1777785999364_jko31z.jfif"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": ""
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": ""
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": ""
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:38:37.234', '٣‏/٥‏/٢٠٢٦ ٨:٣٨:٣٥ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopci2s5000jrtos15v92oj6', 'quality', '{
  "hero": {
    "title_ar": "معايير الجودة",
    "title_en": "Quality Standards",
    "subtitle_ar": "نلتزم بأعلى معايير الجودة والسلامة الغذائية العالمية في كل مرحلة من مراحل الإنتاج",
    "subtitle_en": "We adhere to the highest global quality and food safety standards at every stage of production",
    "image": "/uploads/upload_1777786711159_cq1rea.jfif"
  },
  "qcChecks": {
    "title_ar": "نقاط رقابة الجودة",
    "title_en": "Quality Control Checkpoints",
    "subtitle_ar": "8 نقاط فحص صارمة في كل دورة إنتاج",
    "subtitle_en": "8 strict inspection points in every production cycle",
    "items": [
      {
        "text_ar": "فحص المواد الخام عند الاستلام",
        "text_en": "Raw material inspection upon receipt",
        "image": "/uploads/upload_1777784627223_3l7vxz.jfif"
      },
      {
        "text_ar": "تحليل نسبة الحموضة والرطوبة",
        "text_en": "Acidity and moisture analysis",
        "image": "/uploads/upload_1777784779820_g94s0s.jfif"
      },
      {
        "text_ar": "اختبار اللون والشفافية",
        "text_en": "Color and transparency testing",
        "image": "/uploads/upload_1777785037555_ha975f.jfif"
      },
      {
        "text_ar": "تحليل نقطة الدخان ونقطة الذوبان",
        "text_en": "Smoke point and melting point analysis",
        "image": "/uploads/upload_1777785139397_rc5kbp.jfif"
      },
      {
        "text_ar": "فحص المعادن الثقيلة والملوثات",
        "text_en": "Heavy metals and contaminants testing",
        "image": "/uploads/upload_1777785309219_nr5jtd.jfif"
      },
      {
        "text_ar": "اختبار الثبات الأكسيدي",
        "text_en": "Oxidative stability testing",
        "image": "/uploads/upload_1777785582741_26fzcd.jfif"
      },
      {
        "text_ar": "فحص التعبئة والتغليف",
        "text_en": "Packaging and labeling inspection",
        "image": "/uploads/upload_1777785873750_m96wrq.jfif"
      },
      {
        "text_ar": "تحليل العمر الافتراضي المتسارع",
        "text_en": "Accelerated shelf life analysis",
        "image": "/uploads/upload_1777785999364_jko31z.jfif"
      }
    ]
  },
  "lab": {
    "title_ar": "معامل فحص الجودة",
    "title_en": "Quality Control Laboratories",
    "description_ar": "مختبرات مجهزة بأحدث أجهزة التحليل والفحص لضمان مطابقة منتجاتنا لأعلى المعايير الدولية",
    "description_en": "Laboratories equipped with the latest analysis and testing equipment to ensure our products meet the highest international standards",
    "images": [
      {
        "title_ar": "فريق الجودة",
        "title_en": "Quality Team",
        "url": "/uploads/upload_1777786877298_6npbxa.jfif"
      },
      {
        "title_ar": "فحص الجودة",
        "title_en": "Quality Check",
        "url": "/uploads/upload_1777786959393_rhvk3d.jfif"
      },
      {
        "title_ar": "اختبار المعمل",
        "title_en": "Lab Test",
        "url": "/uploads/upload_1777787032721_kb3fcy.jfif"
      }
    ]
  },
  "downloads": {
    "title_ar": "تحميل شهادات الجودة والمواصفات الفنية",
    "title_en": "Download Quality Certificates & Technical Specifications",
    "items": [
      {
        "label_ar": "تحميل شهادة ISO 9001",
        "label_en": "Download ISO 9001 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة ISO 22000",
        "label_en": "Download ISO 22000 Certificate",
        "url": ""
      },
      {
        "label_ar": "تحميل شهادة Halal",
        "label_en": "Download Halal Certificate",
        "url": ""
      }
    ]
  }
}', '2026-05-03 05:43:59.382', '٣‏/٥‏/٢٠٢٦ ٨:٤٣:٥٩ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopfa32v000lrtosfv9g3r4c', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:01:45.368', '٣‏/٥‏/٢٠٢٦ ١٠:٠١:٤٣ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopfe6oa000nrtosckyh91ll', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck",
        "image": "/uploads/upload_1777791867288_pyu8ag.jfif"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:04:56.65', '٣‏/٥‏/٢٠٢٦ ١٠:٠٤:٥٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopfidkp000prtosl0ff5i9t', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck",
        "image": "/uploads/upload_1777791867288_pyu8ag.jfif"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter",
        "image": "/uploads/upload_1777792085916_gdu075.jfif"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:08:12.217', '٣‏/٥‏/٢٠٢٦ ١٠:٠٨:١٢ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopfpc78000rrtosn7a5lesl', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck",
        "image": "/uploads/upload_1777791867288_pyu8ag.jfif"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter",
        "image": "/uploads/upload_1777792085916_gdu075.jfif"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical",
        "image": "/uploads/upload_1777792345594_zdyi0v.jfif"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope",
        "image": "/uploads/upload_1777792360172_180jue.jfif"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:13:37.029', '٣‏/٥‏/٢٠٢٦ ١٠:١٣:٣٧ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopfvsrq000trtospzfss8ou', 'production', '{
  "hero": {
    "title_ar": "مراحل الإنتاج",
    "title_en": "Production Stages",
    "subtitle_ar": "نتبع أحدث التقنيات العالمية في تصنيع الزيوت النباتية والسمن والشورتنينج عبر 8 خطوط إنتاج متطورة",
    "subtitle_en": "We follow the latest global technologies in manufacturing vegetable oils, margarine & shortening across 8 advanced production lines",
    "backgroundImage": "/uploads/upload_1777791699375_pdj53m.jfif"
  },
  "steps": {
    "title_ar": "خطوات عملية الإنتاج",
    "title_en": "Production Process Steps",
    "subtitle_ar": "من استلام المواد الخام حتى التعبئة والتغليف",
    "subtitle_en": "From raw material receipt to packaging and labeling",
    "items": [
      {
        "title_ar": "استلام وفحص المواد الخام",
        "title_en": "Raw Material Receipt & Inspection",
        "description_ar": "نستقبل أجود أنواع الزيوت الخام من مصادر معتمدة عالمياً ونجري فحوصات شاملة للتأكد من جودتها ومطابقتها للمواصفات",
        "description_en": "We receive the finest crude oils from globally certified sources and conduct comprehensive inspections to ensure quality and specification compliance",
        "icon": "PackageCheck",
        "image": "/uploads/upload_1777791867288_pyu8ag.jfif"
      },
      {
        "title_ar": "التكرير والتنقية",
        "title_en": "Refining & Purification",
        "description_ar": "تمر الزيوت الخام بعمليات تكرير متعددة تشمل إزالة الصمغ، والتبييض، وإزالة الروائح للحصول على زيت نقي عالي الجودة",
        "description_en": "Crude oils undergo multiple refining processes including degumming, bleaching, and deodorizing to produce high-quality pure oil",
        "icon": "Filter",
        "image": "/uploads/upload_1777792085916_gdu075.jfif"
      },
      {
        "title_ar": "الهدرجة والتحويل",
        "title_en": "Hydrogenation & Processing",
        "description_ar": "يتم تحويل الزيوت السائلة إلى سمن وشورتنينج من خلال عمليات هدرجة محكمة تحت إشراف فني متخصص",
        "description_en": "Liquid oils are converted into margarine and shortening through precise hydrogenation processes under specialized technical supervision",
        "icon": "FlaskConical",
        "image": "/uploads/upload_1777792345594_zdyi0v.jfif"
      },
      {
        "title_ar": "مراقبة الجودة المخبرية",
        "title_en": "Laboratory Quality Control",
        "description_ar": "يتم إجراء تحاليل مخبرية دقيقة في كل مرحلة لضمان مطابقة المنتج للمواصفات القياسية المحلية والدولية",
        "description_en": "Precise laboratory analyses are conducted at every stage to ensure product compliance with local and international standards",
        "icon": "Microscope",
        "image": "/uploads/upload_1777792360172_180jue.jfif"
      },
      {
        "title_ar": "التعبئة والتغليف",
        "title_en": "Filling & Packaging",
        "description_ar": "تعبئة آلية بالكامل في عبوات متنوعة الأحجام مع طباعة بيانات المنتج وتاريخ الإنتاج والصلاحية بأعلى معايير النظافة",
        "description_en": "Fully automated filling in various container sizes with product data, production date, and expiry date printing under the highest hygiene standards",
        "icon": "Package",
        "image": "/uploads/upload_1777792560651_wd3kh3.jfif"
      },
      {
        "title_ar": "التخزين والتوزيع",
        "title_en": "Storage & Distribution",
        "description_ar": "مستودعات مجهزة بأنظمة تحكم في درجة الحرارة وأسطول نقل متكامل لضمان وصول المنتجات بأفضل حالة",
        "description_en": "Temperature-controlled warehouses and a comprehensive transport fleet to ensure products arrive in optimal condition",
        "icon": "Truck",
        "image": "/uploads/upload_1777792715598_ym5wrt.jfif"
      }
    ]
  },
  "capacity": {
    "title_ar": "الطاقة الإنتاجية",
    "title_en": "Production Capacity",
    "subtitle_ar": "أرقام تعكس حجم وقدرات مصنع السلام",
    "subtitle_en": "Numbers reflecting the scale and capabilities of Elsalam Factory",
    "items": [
      {
        "label_ar": "خطوط إنتاج",
        "label_en": "Production Lines",
        "value": "8"
      },
      {
        "label_ar": "طن يومياً",
        "label_en": "Tons Daily",
        "value": "500"
      },
      {
        "label_ar": "دولة تصدير",
        "label_en": "Export Countries",
        "value": "15+"
      },
      {
        "label_ar": "منتج متنوع",
        "label_en": "Diverse Products",
        "value": "50+"
      }
    ]
  },
  "gallery": {
    "title_ar": "جولة في خطوط الإنتاج",
    "title_en": "Production Lines Tour",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت",
        "title_en": "Oil Production Line",
        "url": ""
      },
      {
        "title_ar": "خط التكرير",
        "title_en": "Refining Line",
        "url": ""
      },
      {
        "title_ar": "خط التعبئة",
        "title_en": "Filling Line",
        "url": ""
      },
      {
        "title_ar": "مستودعات التخزين",
        "title_en": "Storage Warehouses",
        "url": ""
      }
    ]
  }
}', '2026-05-03 07:18:38.438', '٣‏/٥‏/٢٠٢٦ ١٠:١٨:٣٨ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoph0ycv000vrtoshbhbqtsu', 'b2b', '{
  "hero": {
    "title_ar": "بوابة الشراكات الصناعية",
    "title_en": "Industrial Partnerships Hub",
    "subtitle_ar": "مصنع السلام — شريكك الاستراتيجي في توريد الزيوت النباتية والسمن والشورتنج بكميات صناعية وأسعار مباشرة من المصنع.",
    "subtitle_en": "Elsalam Factory — Your strategic partner in supplying vegetable oils, margarine & shortening in industrial quantities at factory-direct prices.",
    "ctaQuote_ar": "طلب عرض سعر",
    "ctaQuote_en": "Request a Quote",
    "ctaCatalog_ar": "تحميل الكتالوج PDF",
    "ctaCatalog_en": "Download PDF Catalog",
    "backgroundImage": "/uploads/upload_1777794631585_9j7hfe.png"
  },
  "benefits": {
    "title_ar": "لماذا مصنع السلام؟",
    "title_en": "Why Elsalam Factory?",
    "subtitle_ar": "6 أسباب تجعلنا الخيار الأول للمصانع والموزعين",
    "subtitle_en": "6 reasons that make us the first choice for factories and distributors",
    "items": [
      {
        "title_ar": "طاقة إنتاجية عالية",
        "title_en": "High Production Capacity",
        "description_ar": "500 طن يومياً عبر 8 خطوط إنتاج مجهزة بأحدث التقنيات الأوروبية.",
        "description_en": "500 tons daily across 8 production lines equipped with the latest European technology."
      },
      {
        "title_ar": "مختبرات جودة متقدمة",
        "title_en": "Advanced Quality Labs",
        "description_ar": "رقابة صارمة على كل مرحلة من مراحل الإنتاج مع تقارير مخبرية لكل شحنة.",
        "description_en": "Strict quality control at every production stage with lab reports for each shipment."
      },
      {
        "title_ar": "تعبئة مخصصة",
        "title_en": "Custom Packaging",
        "description_ar": "من العبوات الصغيرة للتجزئة إلى الفليكسي تانك للتصدير — حسب احتياجاتك.",
        "description_en": "From small retail bottles to flexitank for export — tailored to your needs."
      },
      {
        "title_ar": "أسعار تنافسية",
        "title_en": "Competitive Pricing",
        "description_ar": "أسعار مباشرة من المصنع مع شروط دفع مرنة للعملاء الصناعيين.",
        "description_en": "Direct factory prices with flexible payment terms for industrial clients."
      },
      {
        "title_ar": "لوجستيات متكاملة",
        "title_en": "Integrated Logistics",
        "description_ar": "شحن محلي ودولي مع تتبع الشحنات وضمان التوصيل في الموعد.",
        "description_en": "Local and international shipping with shipment tracking and on-time delivery guarantee."
      },
      {
        "title_ar": "شريك استراتيجي",
        "title_en": "Strategic Partner",
        "description_ar": "فريق مبيعات مخصص وحلول مصممة حسب احتياجات عملك.",
        "description_en": "Dedicated sales team and solutions designed for your business needs."
      }
    ]
  },
  "quoteForm": {
    "title_ar": "طلب عرض سعر بالجملة",
    "title_en": "Bulk Quote Request",
    "subtitle_ar": "املأ البيانات التالية وسيتواصل معك فريق المبيعات خلال 24 ساعة",
    "subtitle_en": "Fill in the details below and our sales team will contact you within 24 hours",
    "moq_ar": "الحد الأدنى للطلب (MOQ): 5 أطنان — سيتم الرد خلال 24 ساعة عمل",
    "moq_en": "Minimum Order Quantity (MOQ): 5 tons — Response within 24 business hours",
    "products": [
      {
        "name_ar": "زيت صويا مكرر",
        "name_en": "Refined Soybean Oil"
      },
      {
        "name_ar": "زيت عباد الشمس",
        "name_en": "Sunflower Oil"
      },
      {
        "name_ar": "زيت نخيل",
        "name_en": "Palm Oil"
      },
      {
        "name_ar": "سمن نباتي",
        "name_en": "Vegetable Ghee"
      },
      {
        "name_ar": "شورتنج",
        "name_en": "Shortening"
      },
      {
        "name_ar": "زيت خلطات مخصصة",
        "name_en": "Custom Oil Blends"
      },
      {
        "name_ar": "Private Label",
        "name_en": "Private Label"
      }
    ],
    "packaging": [
      {
        "name_ar": "براميل (200 لتر)",
        "name_en": "Drums (200L)"
      },
      {
        "name_ar": "تنكات (18 لتر)",
        "name_en": "Tins (18L)"
      },
      {
        "name_ar": "عبوات (5 لتر)",
        "name_en": "Bottles (5L)"
      },
      {
        "name_ar": "عبوات (1 لتر)",
        "name_en": "Bottles (1L)"
      },
      {
        "name_ar": "Flexitank",
        "name_en": "Flexitank"
      },
      {
        "name_ar": "تعبئة مخصصة",
        "name_en": "Custom Packaging"
      }
    ]
  },
  "ctaSection": {
    "title_ar": "هل أنت مستعد لبدء شراكة؟",
    "title_en": "Ready to Start a Partnership?",
    "subtitle_ar": "تواصل مع فريق المبيعات الصناعية للحصول على عرض سعر مخصص",
    "subtitle_en": "Contact our industrial sales team for a custom quote",
    "buttonText_ar": "تواصل معنا الآن",
    "buttonText_en": "Contact Us Now",
    "buttonLink": "/contact"
  }
}', '2026-05-03 07:50:38.575', '٣‏/٥‏/٢٠٢٦ ١٠:٥٠:٣٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmopjxoh3000xrtosu5p3by0q', 'about', '{
  "hero": {
    "title_ar": "عن مصنع السلام",
    "title_en": "About Elsalam Factory",
    "subtitle_ar": "أكثر من 25 عاماً من الريادة في صناعة الزيوت النباتية والسمن والشورتنج",
    "subtitle_en": "Over 25 years of leadership in the vegetable oils, margarine & shortening industry",
    "badge_ar": "من نحن",
    "badge_en": "About Us",
    "backgroundImage": "/uploads/upload_1776643103718_x1k9vw.jfif"
  },
  "story": {
    "title_ar": "قصتنا",
    "title_en": "Our Story",
    "paragraph1_ar": "تأسس مصنع السلام لعصر واستخلاص الزيوت النباتية عام 2000 في المنطقة الصناعية بمصر. بدأنا بخط إنتاج واحد ورؤية واضحة: تقديم زيوت نباتية بجودة عالمية وأسعار منافسة. واليوم، نفخر بامتلاك 8 خطوط إنتاج بطاقة 500 طن يومياً، ونصدّر إلى أكثر من 15 دولة.",
    "paragraph1_en": "Elsalam Factory for Extracting and Refining Vegetable Oils was established in 2000 in the Industrial Zone, Egypt. We started with a single production line and a clear vision: to provide world-class vegetable oils at competitive prices. Today, we proudly operate 8 production lines with a daily capacity of 500 MT, exporting to over 15 countries.",
    "paragraph2_ar": "نحن ملتزمون بالاستدامة والابتكار المستمر، مع استثمارات مستمرة في تطوير خطوط الإنتاج ومعامل الجودة لضمان مطابقة منتجاتنا لأعلى المواصفات القياسية المحلية والدولية.",
    "paragraph2_en": "We are committed to sustainability and continuous innovation, consistently investing in our production lines and quality laboratories to ensure our products meet the highest local and international standards."
  },
  "timeline": {
    "items": [
      {
        "year": "2000",
        "title_ar": "التأسيس والانطلاق",
        "title_en": "Foundation & Launch",
        "description_ar": "بدأنا رحلتنا بخط إنتاج واحد للزيوت النباتية مع التركيز على تلبية احتياجات السوق المحلي بأعلى معايير الجودة.",
        "description_en": "Began our journey with a single vegetable oil production line, focusing on meeting local market needs with the highest quality standards."
      },
      {
        "year": "2008",
        "title_ar": "توسعة خطوط التكرير",
        "title_en": "Refinery Expansion",
        "description_ar": "افتتاح خط التكرير المتطور لضمان النقاء التام والشفافية العالية لزيوتنا بمعايير أوروبية.",
        "description_en": "Inaugurated a state-of-the-art refining line to ensure absolute purity and high transparency of our oils under European standards."
      },
      {
        "year": "2015",
        "title_ar": "دخول أسواق التصدير",
        "title_en": "Entering Export Markets",
        "description_ar": "حصولنا على شهادات الجودة العالمية وبلوغ طاقة إنتاجية سمحت لنا ببدء التصدير الناجح لدول أفريقيا والشرق الأوسط.",
        "description_en": "Achieved international quality certifications and production capacity that enabled successful exports to Africa and the Middle East."
      },
      {
        "year": "2020",
        "title_ar": "إطلاق السمن والشورتنج",
        "title_en": "Ghee & Shortening Launch",
        "description_ar": "تنويع محفظة المنتجات لتشمل السمن النباتي الممتاز وشورتنج المخابز المتخصص لتلبية القطاع الصناعي.",
        "description_en": "Diversified the product portfolio to include premium vegetable ghee and specialized bakery shortening to supply the industrial sector."
      },
      {
        "year": "2025",
        "title_ar": "الريادة والاستدامة",
        "title_en": "Leadership & Sustainability",
        "description_ar": "الوصول لطاقة 500 طن يومياً مع تصدير مستمر لـ 15 دولة وتطبيق سياسات إنتاج خضراء ومستدامة.",
        "description_en": "Reached 500 MT daily capacity with continuous exports to 15+ countries, implementing green and sustainable production policies."
      }
    ]
  },
  "ceo": {
    "name_ar": "محمد إسماعيل إدريس",
    "name_en": "Mohamed Ismail Idris",
    "role_ar": "رئيس مجلس إدارة مصنع السلام لعصر واستخلاص الزيوت النباتية",
    "role_en": "Chairman of the Board, Elsalam Factory for Vegetable Oils and Refining",
    "quote_ar": "نؤمن أن الجودة ليست خياراً بل هي التزام. رؤيتنا أن نكون الشريك الأول لكل مصنع ومطعم وموزع يبحث عن زيوت نباتية بمعايير عالمية مصنوعة في مصر.",
    "quote_en": "We believe quality is an obligation, not an option. Our vision is to be the premier partner for every factory, restaurant, and distributor seeking world-class vegetable oils made in Egypt.",
    "educationDesc_ar": "تخرج السيد محمد إسماعيل إدريس من جامعة الإسكندرية عام 1990، وبدأ مسيرته المهنية في مجال المبيعات، حيث أظهر منذ بداياته شغفًا واضحًا بمجال التسويق وبناء العلامات التجارية وتعزيز الحصة السوقية للشركات.",
    "educationDesc_en": "Mr. Mohamed Ismail Idris graduated from Alexandria University in 1990 and began his professional career in sales, where he demonstrated a clear passion for marketing, brand building, and expanding market share from the very beginning.",
    "careerStations": [
      {
        "title_ar": "شركة كوكاكولا – الإسكندرية (1990–1992)",
        "title_en": "Coca-Cola Company – Alexandria (1990–1992)",
        "role_ar": "مشرف مبيعات",
        "role_en": "Sales Supervisor",
        "desc_ar": "توسيع الحصة السوقية، زيادة المبيعات، تطبيق تقنيات تسويق مبتكرة",
        "desc_en": "Expanded market share, increased sales, implemented innovative marketing techniques",
        "image": "/uploads/upload_1776634969823_pkokrf.jpg"
      },
      {
        "title_ar": "شركة العوجان – المملكة العربية السعودية (1993–1995)",
        "title_en": "Aujan Industries – Saudi Arabia (1993–1995)",
        "role_ar": "مشرف التموين",
        "role_en": "Catering Supervisor",
        "desc_ar": "أسّس قسم التموين بالشركة، وساهم في إدخال منتجات (راني، فيمتو، شوكولاتة كادبوري) إلى قطاعات الفنادق والمطاعم والمستشفيات والقطاع العسكري، والخطوط الجوية السعودية.",
        "desc_en": "Founded the company''s Catering Department, successfully introducing products (Rani, Vimto, Cadbury chocolate) to hotels, restaurants, hospitals, the military sector, and Saudi Arabian Airlines.",
        "image": "/uploads/upload_1776634996004_uviykm.webp"
      },
      {
        "title_ar": "شركة باعشن – السعودية (1995–1997)",
        "title_en": "Baeshen Company – Saudi Arabia (1995–1997)",
        "role_ar": "مدير المنطقة الشمالية",
        "role_en": "Northern Region Manager",
        "desc_ar": "قاد جهود تسويق علامة شاي ربيع، وأسهم في إطلاق وتوسيع انتشار المنتج في السوق السعودي.",
        "desc_en": "Led the marketing efforts for Rabea Tea brand, contributing to the launch and extensive expansion of the product in the Saudi market.",
        "image": "/uploads/upload_1776635060394_u8uwk5.jfif"
      },
      {
        "title_ar": "شركة نستله مصر (1998)",
        "title_en": "Nestle Egypt (1998)",
        "role_ar": "مدير المبيعات - الإسكندرية",
        "role_en": "Sales Manager - Alexandria",
        "desc_ar": "أشرف على توزيع المنتجات الجافة (نسكافيه، نيدو، سيريلاك، شوكولاتة نستله) وعزز انتشار العلامة محليًا.",
        "desc_en": "Supervised the distribution of dry products (Nescafe, Nido, Cerelac, Nestle chocolate) and enhanced the brand''s local presence.",
        "image": "/uploads/upload_1776635088623_5j5aj6.png"
      },
      {
        "title_ar": "شركة صافولا سايم داربي (1999–2001)",
        "title_en": "Savola Sime Darby (1999–2001)",
        "role_ar": "مدير مبيعات القطاع الصناعي",
        "role_en": "Industrial Sector Sales Manager",
        "desc_ar": "ركز على توزيع زيت النخيل للصناعات الغذائية وقدم حلولًا صناعية مبتكرة من خلال إعادة تدوير مشتقات الزيت.",
        "desc_en": "Focused on distributing palm oil to the food industry and introduced innovative industrial solutions by recycling oil derivatives.",
        "image": "/uploads/upload_1776635112855_q157ia.webp"
      }
    ],
    "entrepreneurshipDesc_ar": "في عام 2002، اتخذ السيد محمد إدريس خطوة جريئة بتأسيس شركة السلام كشركة متخصصة في تجارة وتكرير الزيوت النباتية وتوريد المواد الخام للمصانع الكبرى والمطاعم.",
    "entrepreneurshipDesc_en": "In 2002, Mr. Mohamed Idris took a bold step by founding Elsalam Company as a specialized entity in trading and refining vegetable oils and supplying raw materials to major factories and restaurants.",
    "expansionDesc_ar": "توسعت الشركة في توزيع زيت النخيل والشورتنج والمارجرين، وخدمة أكثر من 135 مصنعًا في مصر. وفي عام 2020، تم افتتاح مصنع حديث بدمنهور مزود بأحدث خطوط الإنتاج.",
    "expansionDesc_en": "The company expanded into distributing palm oil, shortening, and margarine, serving over 135 factories in Egypt. In 2020, a modern factory was inaugurated in Damanhour, equipped with the latest production lines.",
    "innovationPoints": [
      {
        "text_ar": "إدخال الشورتنج في إنتاج الأجبان",
        "text_en": "Introducing shortening in cheese production"
      },
      {
        "text_ar": "تطوير حلول صناعية لصناعة الأغذية",
        "text_en": "Developing industrial solutions for the food industry"
      },
      {
        "text_ar": "استثمار مخلفات زيت النخيل في صناعة الصابون",
        "text_en": "Investing palm oil derivatives in soap manufacturing"
      },
      {
        "text_ar": "تطبيق نظام رقابة جودة صارم في كل مراحل الإنتاج",
        "text_en": "Implementing strictly monitored quality control across all production stages"
      }
    ],
    "visionDesc_ar": "يهدف إلى الريادة في صناعة الزيوت والدهون الطبيعية في مصر والشرق الأوسط، معتمداً على بناء شراكات استراتيجية طويلة الأمد، دعم الصناعات الصغيرة، والالتزام بالمسؤولية المجتمعية.",
    "visionDesc_en": "His vision is to lead the vegetable oils and natural fats industry in Egypt and the Middle East, relying on building long-term strategic partnerships, supporting small industries, and committing to social responsibility.",
    "leadershipPoints": [
      {
        "text_ar": "خبرة تتجاوز 30 عامًا في قطاع الأغذية",
        "text_en": "Over 30 years of experience in the food sector"
      },
      {
        "text_ar": "خلفية قوية في المبيعات الصناعية",
        "text_en": "Strong background in industrial sales"
      },
      {
        "text_ar": "قدرة على بناء شراكات استراتيجية",
        "text_en": "Ability to build strategic partnerships"
      },
      {
        "text_ar": "توجه ابتكاري في تطوير المنتجات",
        "text_en": "Innovative approach to product development"
      },
      {
        "text_ar": "دعم حقيقي للصناعات الصغيرة والمتوسطة",
        "text_en": "Genuine support for small and medium-sized industries"
      }
    ],
    "image": "/uploads/upload_1777799515583_t6iflh.png"
  },
  "gallery": {
    "title_ar": "جولة في المصنع",
    "title_en": "Factory Tour",
    "subtitle_ar": "نظرة على خطوط الإنتاج ومرافق الجودة",
    "subtitle_en": "A look at our production lines and quality facilities",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت الآلي",
        "title_en": "Automated Oil Production Line",
        "url": "/uploads/upload_1776643156622_joaqhw.jfif"
      },
      {
        "title_ar": "معامل رقابة الجودة",
        "title_en": "Quality Control Labs",
        "url": "/uploads/upload_1776643556377_mlqu6e.jfif"
      },
      {
        "title_ar": "خزانات التخزين",
        "title_en": "Storage Tanks",
        "url": "/uploads/upload_1776643692457_kvhcm0.jfif"
      },
      {
        "title_ar": "خط تعبئة العبوات",
        "title_en": "Bottle Filling Line",
        "url": "/uploads/upload_1776643846245_gg2zai.jfif"
      },
      {
        "title_ar": "مستودعات الشحن",
        "title_en": "Shipping Warehouses",
        "url": "/uploads/upload_1776643951492_u4bpcp.jfif"
      },
      {
        "title_ar": "منطقة استقبال المواد الخام",
        "title_en": "Raw Material Reception Area",
        "url": "/uploads/upload_1776644148629_oi3c0v.jfif"
      },
      {
        "title_ar": "غرفة التحكم المركزية",
        "title_en": "Central Control Room",
        "url": "/uploads/upload_1776644200524_obw0ri.jfif"
      },
      {
        "title_ar": "خط إنتاج السمن",
        "title_en": "Ghee Production Line",
        "url": "/uploads/upload_1776644483092_5m2czr.jfif"
      }
    ]
  },
  "team": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Partners in Success",
    "title_ar": "فريق الإدارة العليا",
    "title_en": "Executive Leadership",
    "subtitle_ar": "نخبة من الكفاءات المتميزة التي تقود رؤيتنا نحو العالمية، وتضمن أعلى معايير الجودة والتميز في كافة قطاعات الشركة.",
    "subtitle_en": "Our distinguished leadership driving our global vision and ensuring the highest standards of quality.",
    "members": [
      {
        "name_ar": "ذكى السيد ذكي",
        "name_en": "Zaki El-Sayed Zaki",
        "role_ar": "مشرف المبيعات ",
        "role_en": "Sales Supervisor",
        "image": "/uploads/upload_1776621029870_2h0jss.jfif"
      },
      {
        "name_ar": "وليد بيومي",
        "name_en": "Walid Bayoumi ",
        "role_ar": "مدير المبيعات ",
        "role_en": "Sales Manager",
        "image": "/uploads/upload_1776621270095_axlqdh.jfif"
      },
      {
        "name_ar": "منة الله زكريا ",
        "name_en": "Menat Allah Zakaria",
        "role_ar": "مديرة الحسابات",
        "role_en": "Accounts Manager",
        "image": "/uploads/upload_1776629197489_t4qeu8.jfif"
      },
      {
        "name_ar": "محمد عاطف",
        "name_en": "Mohamed Atef",
        "role_ar": "مدير الإنتاج",
        "role_en": "Production Manager",
        "image": "/uploads/upload_1776629419135_hu8pen.jfif"
      },
      {
        "name_ar": "محمد الريفي",
        "name_en": "Mohamed Elrifi",
        "role_ar": "مدير الجودة",
        "role_en": "Quality Manager",
        "image": "/uploads/upload_1776630914066_sad8o6.jfif"
      }
    ]
  }
}', '2026-05-03 09:12:04.648', '٣‏/٥‏/٢٠٢٦ ١٢:١٢:٠٣ م');
INSERT INTO public."PageContentHistory" VALUES ('cmopk1jgh000zrtos8wmfyp2d', 'about', '{
  "hero": {
    "title_ar": "عن مصنع السلام",
    "title_en": "About Elsalam Factory",
    "subtitle_ar": "أكثر من 25 عاماً من الريادة في صناعة الزيوت النباتية والسمن والشورتنج",
    "subtitle_en": "Over 25 years of leadership in the vegetable oils, margarine & shortening industry",
    "badge_ar": "من نحن",
    "badge_en": "About Us",
    "backgroundImage": "/uploads/upload_1776643103718_x1k9vw.jfif"
  },
  "story": {
    "title_ar": "قصتنا",
    "title_en": "Our Story",
    "paragraph1_ar": "تأسس مصنع السلام لعصر واستخلاص الزيوت النباتية عام 2000 في المنطقة الصناعية بمصر. بدأنا بخط إنتاج واحد ورؤية واضحة: تقديم زيوت نباتية بجودة عالمية وأسعار منافسة. واليوم، نفخر بامتلاك 8 خطوط إنتاج بطاقة 500 طن يومياً، ونصدّر إلى أكثر من 15 دولة.",
    "paragraph1_en": "Elsalam Factory for Extracting and Refining Vegetable Oils was established in 2000 in the Industrial Zone, Egypt. We started with a single production line and a clear vision: to provide world-class vegetable oils at competitive prices. Today, we proudly operate 8 production lines with a daily capacity of 500 MT, exporting to over 15 countries.",
    "paragraph2_ar": "نحن ملتزمون بالاستدامة والابتكار المستمر، مع استثمارات مستمرة في تطوير خطوط الإنتاج ومعامل الجودة لضمان مطابقة منتجاتنا لأعلى المواصفات القياسية المحلية والدولية.",
    "paragraph2_en": "We are committed to sustainability and continuous innovation, consistently investing in our production lines and quality laboratories to ensure our products meet the highest local and international standards."
  },
  "timeline": {
    "items": [
      {
        "year": "2000",
        "title_ar": "التأسيس والانطلاق",
        "title_en": "Foundation & Launch",
        "description_ar": "بدأنا رحلتنا بخط إنتاج واحد للزيوت النباتية مع التركيز على تلبية احتياجات السوق المحلي بأعلى معايير الجودة.",
        "description_en": "Began our journey with a single vegetable oil production line, focusing on meeting local market needs with the highest quality standards."
      },
      {
        "year": "2008",
        "title_ar": "توسعة خطوط التكرير",
        "title_en": "Refinery Expansion",
        "description_ar": "افتتاح خط التكرير المتطور لضمان النقاء التام والشفافية العالية لزيوتنا بمعايير أوروبية.",
        "description_en": "Inaugurated a state-of-the-art refining line to ensure absolute purity and high transparency of our oils under European standards."
      },
      {
        "year": "2015",
        "title_ar": "دخول أسواق التصدير",
        "title_en": "Entering Export Markets",
        "description_ar": "حصولنا على شهادات الجودة العالمية وبلوغ طاقة إنتاجية سمحت لنا ببدء التصدير الناجح لدول أفريقيا والشرق الأوسط.",
        "description_en": "Achieved international quality certifications and production capacity that enabled successful exports to Africa and the Middle East."
      },
      {
        "year": "2020",
        "title_ar": "إطلاق السمن والشورتنج",
        "title_en": "Ghee & Shortening Launch",
        "description_ar": "تنويع محفظة المنتجات لتشمل السمن النباتي الممتاز وشورتنج المخابز المتخصص لتلبية القطاع الصناعي.",
        "description_en": "Diversified the product portfolio to include premium vegetable ghee and specialized bakery shortening to supply the industrial sector."
      },
      {
        "year": "2025",
        "title_ar": "الريادة والاستدامة",
        "title_en": "Leadership & Sustainability",
        "description_ar": "الوصول لطاقة 500 طن يومياً مع تصدير مستمر لـ 15 دولة وتطبيق سياسات إنتاج خضراء ومستدامة.",
        "description_en": "Reached 500 MT daily capacity with continuous exports to 15+ countries, implementing green and sustainable production policies."
      }
    ]
  },
  "ceo": {
    "name_ar": "محمد إسماعيل إدريس",
    "name_en": "Mohamed Ismail Idris",
    "role_ar": "رئيس مجلس إدارة مصنع السلام لعصر واستخلاص الزيوت النباتية",
    "role_en": "Chairman of the Board, Elsalam Factory for Vegetable Oils and Refining",
    "quote_ar": "نؤمن أن الجودة ليست خياراً بل هي التزام. رؤيتنا أن نكون الشريك الأول لكل مصنع ومطعم وموزع يبحث عن زيوت نباتية بمعايير عالمية مصنوعة في مصر.",
    "quote_en": "We believe quality is an obligation, not an option. Our vision is to be the premier partner for every factory, restaurant, and distributor seeking world-class vegetable oils made in Egypt.",
    "educationDesc_ar": "تخرج السيد محمد إسماعيل إدريس من جامعة الإسكندرية عام 1990، وبدأ مسيرته المهنية في مجال المبيعات، حيث أظهر منذ بداياته شغفًا واضحًا بمجال التسويق وبناء العلامات التجارية وتعزيز الحصة السوقية للشركات.",
    "educationDesc_en": "Mr. Mohamed Ismail Idris graduated from Alexandria University in 1990 and began his professional career in sales, where he demonstrated a clear passion for marketing, brand building, and expanding market share from the very beginning.",
    "careerStations": [
      {
        "title_ar": "شركة كوكاكولا – الإسكندرية (1990–1992)",
        "title_en": "Coca-Cola Company – Alexandria (1990–1992)",
        "role_ar": "مشرف مبيعات",
        "role_en": "Sales Supervisor",
        "desc_ar": "توسيع الحصة السوقية، زيادة المبيعات، تطبيق تقنيات تسويق مبتكرة",
        "desc_en": "Expanded market share, increased sales, implemented innovative marketing techniques",
        "image": "/uploads/upload_1776634969823_pkokrf.jpg"
      },
      {
        "title_ar": "شركة العوجان – المملكة العربية السعودية (1993–1995)",
        "title_en": "Aujan Industries – Saudi Arabia (1993–1995)",
        "role_ar": "مشرف التموين",
        "role_en": "Catering Supervisor",
        "desc_ar": "أسّس قسم التموين بالشركة، وساهم في إدخال منتجات (راني، فيمتو، شوكولاتة كادبوري) إلى قطاعات الفنادق والمطاعم والمستشفيات والقطاع العسكري، والخطوط الجوية السعودية.",
        "desc_en": "Founded the company''s Catering Department, successfully introducing products (Rani, Vimto, Cadbury chocolate) to hotels, restaurants, hospitals, the military sector, and Saudi Arabian Airlines.",
        "image": "/uploads/upload_1776634996004_uviykm.webp"
      },
      {
        "title_ar": "شركة باعشن – السعودية (1995–1997)",
        "title_en": "Baeshen Company – Saudi Arabia (1995–1997)",
        "role_ar": "مدير المنطقة الشمالية",
        "role_en": "Northern Region Manager",
        "desc_ar": "قاد جهود تسويق علامة شاي ربيع، وأسهم في إطلاق وتوسيع انتشار المنتج في السوق السعودي.",
        "desc_en": "Led the marketing efforts for Rabea Tea brand, contributing to the launch and extensive expansion of the product in the Saudi market.",
        "image": "/uploads/upload_1776635060394_u8uwk5.jfif"
      },
      {
        "title_ar": "شركة نستله مصر (1998)",
        "title_en": "Nestle Egypt (1998)",
        "role_ar": "مدير المبيعات - الإسكندرية",
        "role_en": "Sales Manager - Alexandria",
        "desc_ar": "أشرف على توزيع المنتجات الجافة (نسكافيه، نيدو، سيريلاك، شوكولاتة نستله) وعزز انتشار العلامة محليًا.",
        "desc_en": "Supervised the distribution of dry products (Nescafe, Nido, Cerelac, Nestle chocolate) and enhanced the brand''s local presence.",
        "image": "/uploads/upload_1776635088623_5j5aj6.png"
      },
      {
        "title_ar": "شركة صافولا سايم داربي (1999–2001)",
        "title_en": "Savola Sime Darby (1999–2001)",
        "role_ar": "مدير مبيعات القطاع الصناعي",
        "role_en": "Industrial Sector Sales Manager",
        "desc_ar": "ركز على توزيع زيت النخيل للصناعات الغذائية وقدم حلولًا صناعية مبتكرة من خلال إعادة تدوير مشتقات الزيت.",
        "desc_en": "Focused on distributing palm oil to the food industry and introduced innovative industrial solutions by recycling oil derivatives.",
        "image": "/uploads/upload_1776635112855_q157ia.webp"
      }
    ],
    "entrepreneurshipDesc_ar": "في عام 2002، اتخذ السيد محمد إدريس خطوة جريئة بتأسيس شركة السلام كشركة متخصصة في تجارة وتكرير الزيوت النباتية وتوريد المواد الخام للمصانع الكبرى والمطاعم.",
    "entrepreneurshipDesc_en": "In 2002, Mr. Mohamed Idris took a bold step by founding Elsalam Company as a specialized entity in trading and refining vegetable oils and supplying raw materials to major factories and restaurants.",
    "expansionDesc_ar": "توسعت الشركة في توزيع زيت النخيل والشورتنج والمارجرين، وخدمة أكثر من 135 مصنعًا في مصر. وفي عام 2020، تم افتتاح مصنع حديث بدمنهور مزود بأحدث خطوط الإنتاج.",
    "expansionDesc_en": "The company expanded into distributing palm oil, shortening, and margarine, serving over 135 factories in Egypt. In 2020, a modern factory was inaugurated in Damanhour, equipped with the latest production lines.",
    "innovationPoints": [
      {
        "text_ar": "إدخال الشورتنج في إنتاج الأجبان",
        "text_en": "Introducing shortening in cheese production"
      },
      {
        "text_ar": "تطوير حلول صناعية لصناعة الأغذية",
        "text_en": "Developing industrial solutions for the food industry"
      },
      {
        "text_ar": "استثمار مخلفات زيت النخيل في صناعة الصابون",
        "text_en": "Investing palm oil derivatives in soap manufacturing"
      },
      {
        "text_ar": "تطبيق نظام رقابة جودة صارم في كل مراحل الإنتاج",
        "text_en": "Implementing strictly monitored quality control across all production stages"
      }
    ],
    "visionDesc_ar": "يهدف إلى الريادة في صناعة الزيوت والدهون الطبيعية في مصر والشرق الأوسط، معتمداً على بناء شراكات استراتيجية طويلة الأمد، دعم الصناعات الصغيرة، والالتزام بالمسؤولية المجتمعية.",
    "visionDesc_en": "His vision is to lead the vegetable oils and natural fats industry in Egypt and the Middle East, relying on building long-term strategic partnerships, supporting small industries, and committing to social responsibility.",
    "leadershipPoints": [
      {
        "text_ar": "خبرة تتجاوز 30 عامًا في قطاع الأغذية",
        "text_en": "Over 30 years of experience in the food sector"
      },
      {
        "text_ar": "خلفية قوية في المبيعات الصناعية",
        "text_en": "Strong background in industrial sales"
      },
      {
        "text_ar": "قدرة على بناء شراكات استراتيجية",
        "text_en": "Ability to build strategic partnerships"
      },
      {
        "text_ar": "توجه ابتكاري في تطوير المنتجات",
        "text_en": "Innovative approach to product development"
      },
      {
        "text_ar": "دعم حقيقي للصناعات الصغيرة والمتوسطة",
        "text_en": "Genuine support for small and medium-sized industries"
      }
    ],
    "image": "/uploads/upload_1777799701729_l6sh8u.png"
  },
  "gallery": {
    "title_ar": "جولة في المصنع",
    "title_en": "Factory Tour",
    "subtitle_ar": "نظرة على خطوط الإنتاج ومرافق الجودة",
    "subtitle_en": "A look at our production lines and quality facilities",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت الآلي",
        "title_en": "Automated Oil Production Line",
        "url": "/uploads/upload_1776643156622_joaqhw.jfif"
      },
      {
        "title_ar": "معامل رقابة الجودة",
        "title_en": "Quality Control Labs",
        "url": "/uploads/upload_1776643556377_mlqu6e.jfif"
      },
      {
        "title_ar": "خزانات التخزين",
        "title_en": "Storage Tanks",
        "url": "/uploads/upload_1776643692457_kvhcm0.jfif"
      },
      {
        "title_ar": "خط تعبئة العبوات",
        "title_en": "Bottle Filling Line",
        "url": "/uploads/upload_1776643846245_gg2zai.jfif"
      },
      {
        "title_ar": "مستودعات الشحن",
        "title_en": "Shipping Warehouses",
        "url": "/uploads/upload_1776643951492_u4bpcp.jfif"
      },
      {
        "title_ar": "منطقة استقبال المواد الخام",
        "title_en": "Raw Material Reception Area",
        "url": "/uploads/upload_1776644148629_oi3c0v.jfif"
      },
      {
        "title_ar": "غرفة التحكم المركزية",
        "title_en": "Central Control Room",
        "url": "/uploads/upload_1776644200524_obw0ri.jfif"
      },
      {
        "title_ar": "خط إنتاج السمن",
        "title_en": "Ghee Production Line",
        "url": "/uploads/upload_1776644483092_5m2czr.jfif"
      }
    ]
  },
  "team": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Partners in Success",
    "title_ar": "فريق الإدارة العليا",
    "title_en": "Executive Leadership",
    "subtitle_ar": "نخبة من الكفاءات المتميزة التي تقود رؤيتنا نحو العالمية، وتضمن أعلى معايير الجودة والتميز في كافة قطاعات الشركة.",
    "subtitle_en": "Our distinguished leadership driving our global vision and ensuring the highest standards of quality.",
    "members": [
      {
        "name_ar": "ذكى السيد ذكي",
        "name_en": "Zaki El-Sayed Zaki",
        "role_ar": "مشرف المبيعات ",
        "role_en": "Sales Supervisor",
        "image": "/uploads/upload_1776621029870_2h0jss.jfif"
      },
      {
        "name_ar": "وليد بيومي",
        "name_en": "Walid Bayoumi ",
        "role_ar": "مدير المبيعات ",
        "role_en": "Sales Manager",
        "image": "/uploads/upload_1776621270095_axlqdh.jfif"
      },
      {
        "name_ar": "منة الله زكريا ",
        "name_en": "Menat Allah Zakaria",
        "role_ar": "مديرة الحسابات",
        "role_en": "Accounts Manager",
        "image": "/uploads/upload_1776629197489_t4qeu8.jfif"
      },
      {
        "name_ar": "محمد عاطف",
        "name_en": "Mohamed Atef",
        "role_ar": "مدير الإنتاج",
        "role_en": "Production Manager",
        "image": "/uploads/upload_1776629419135_hu8pen.jfif"
      },
      {
        "name_ar": "محمد الريفي",
        "name_en": "Mohamed Elrifi",
        "role_ar": "مدير الجودة",
        "role_en": "Quality Manager",
        "image": "/uploads/upload_1776630914066_sad8o6.jfif"
      }
    ]
  }
}', '2026-05-03 09:15:04.77', '٣‏/٥‏/٢٠٢٦ ١٢:١٥:٠٤ م');
INSERT INTO public."PageContentHistory" VALUES ('cmopk7c2f0011rtosw6q04ue6', 'about', '{
  "hero": {
    "title_ar": "عن مصنع السلام",
    "title_en": "About Elsalam Factory",
    "subtitle_ar": "أكثر من 25 عاماً من الريادة في صناعة الزيوت النباتية والسمن والشورتنج",
    "subtitle_en": "Over 25 years of leadership in the vegetable oils, margarine & shortening industry",
    "badge_ar": "من نحن",
    "badge_en": "About Us",
    "backgroundImage": "/uploads/upload_1776643103718_x1k9vw.jfif"
  },
  "story": {
    "title_ar": "قصتنا",
    "title_en": "Our Story",
    "paragraph1_ar": "تأسس مصنع السلام لعصر واستخلاص الزيوت النباتية عام 2000 في المنطقة الصناعية بمصر. بدأنا بخط إنتاج واحد ورؤية واضحة: تقديم زيوت نباتية بجودة عالمية وأسعار منافسة. واليوم، نفخر بامتلاك 8 خطوط إنتاج بطاقة 500 طن يومياً، ونصدّر إلى أكثر من 15 دولة.",
    "paragraph1_en": "Elsalam Factory for Extracting and Refining Vegetable Oils was established in 2000 in the Industrial Zone, Egypt. We started with a single production line and a clear vision: to provide world-class vegetable oils at competitive prices. Today, we proudly operate 8 production lines with a daily capacity of 500 MT, exporting to over 15 countries.",
    "paragraph2_ar": "نحن ملتزمون بالاستدامة والابتكار المستمر، مع استثمارات مستمرة في تطوير خطوط الإنتاج ومعامل الجودة لضمان مطابقة منتجاتنا لأعلى المواصفات القياسية المحلية والدولية.",
    "paragraph2_en": "We are committed to sustainability and continuous innovation, consistently investing in our production lines and quality laboratories to ensure our products meet the highest local and international standards."
  },
  "timeline": {
    "items": [
      {
        "year": "2000",
        "title_ar": "التأسيس والانطلاق",
        "title_en": "Foundation & Launch",
        "description_ar": "بدأنا رحلتنا بخط إنتاج واحد للزيوت النباتية مع التركيز على تلبية احتياجات السوق المحلي بأعلى معايير الجودة.",
        "description_en": "Began our journey with a single vegetable oil production line, focusing on meeting local market needs with the highest quality standards."
      },
      {
        "year": "2008",
        "title_ar": "توسعة خطوط التكرير",
        "title_en": "Refinery Expansion",
        "description_ar": "افتتاح خط التكرير المتطور لضمان النقاء التام والشفافية العالية لزيوتنا بمعايير أوروبية.",
        "description_en": "Inaugurated a state-of-the-art refining line to ensure absolute purity and high transparency of our oils under European standards."
      },
      {
        "year": "2015",
        "title_ar": "دخول أسواق التصدير",
        "title_en": "Entering Export Markets",
        "description_ar": "حصولنا على شهادات الجودة العالمية وبلوغ طاقة إنتاجية سمحت لنا ببدء التصدير الناجح لدول أفريقيا والشرق الأوسط.",
        "description_en": "Achieved international quality certifications and production capacity that enabled successful exports to Africa and the Middle East."
      },
      {
        "year": "2020",
        "title_ar": "إطلاق السمن والشورتنج",
        "title_en": "Ghee & Shortening Launch",
        "description_ar": "تنويع محفظة المنتجات لتشمل السمن النباتي الممتاز وشورتنج المخابز المتخصص لتلبية القطاع الصناعي.",
        "description_en": "Diversified the product portfolio to include premium vegetable ghee and specialized bakery shortening to supply the industrial sector."
      },
      {
        "year": "2025",
        "title_ar": "الريادة والاستدامة",
        "title_en": "Leadership & Sustainability",
        "description_ar": "الوصول لطاقة 500 طن يومياً مع تصدير مستمر لـ 15 دولة وتطبيق سياسات إنتاج خضراء ومستدامة.",
        "description_en": "Reached 500 MT daily capacity with continuous exports to 15+ countries, implementing green and sustainable production policies."
      }
    ]
  },
  "ceo": {
    "name_ar": "محمد إسماعيل إدريس",
    "name_en": "Mohamed Ismail Idris",
    "role_ar": "رئيس مجلس إدارة مصنع السلام لعصر واستخلاص الزيوت النباتية",
    "role_en": "Chairman of the Board, Elsalam Factory for Vegetable Oils and Refining",
    "quote_ar": "نؤمن أن الجودة ليست خياراً بل هي التزام. رؤيتنا أن نكون الشريك الأول لكل مصنع ومطعم وموزع يبحث عن زيوت نباتية بمعايير عالمية مصنوعة في مصر.",
    "quote_en": "We believe quality is an obligation, not an option. Our vision is to be the premier partner for every factory, restaurant, and distributor seeking world-class vegetable oils made in Egypt.",
    "educationDesc_ar": "تخرج السيد محمد إسماعيل إدريس من جامعة الإسكندرية عام 1990، وبدأ مسيرته المهنية في مجال المبيعات، حيث أظهر منذ بداياته شغفًا واضحًا بمجال التسويق وبناء العلامات التجارية وتعزيز الحصة السوقية للشركات.",
    "educationDesc_en": "Mr. Mohamed Ismail Idris graduated from Alexandria University in 1990 and began his professional career in sales, where he demonstrated a clear passion for marketing, brand building, and expanding market share from the very beginning.",
    "careerStations": [
      {
        "title_ar": "شركة كوكاكولا – الإسكندرية (1990–1992)",
        "title_en": "Coca-Cola Company – Alexandria (1990–1992)",
        "role_ar": "مشرف مبيعات",
        "role_en": "Sales Supervisor",
        "desc_ar": "توسيع الحصة السوقية، زيادة المبيعات، تطبيق تقنيات تسويق مبتكرة",
        "desc_en": "Expanded market share, increased sales, implemented innovative marketing techniques",
        "image": "/uploads/upload_1776634969823_pkokrf.jpg"
      },
      {
        "title_ar": "شركة العوجان – المملكة العربية السعودية (1993–1995)",
        "title_en": "Aujan Industries – Saudi Arabia (1993–1995)",
        "role_ar": "مشرف التموين",
        "role_en": "Catering Supervisor",
        "desc_ar": "أسّس قسم التموين بالشركة، وساهم في إدخال منتجات (راني، فيمتو، شوكولاتة كادبوري) إلى قطاعات الفنادق والمطاعم والمستشفيات والقطاع العسكري، والخطوط الجوية السعودية.",
        "desc_en": "Founded the company''s Catering Department, successfully introducing products (Rani, Vimto, Cadbury chocolate) to hotels, restaurants, hospitals, the military sector, and Saudi Arabian Airlines.",
        "image": "/uploads/upload_1776634996004_uviykm.webp"
      },
      {
        "title_ar": "شركة باعشن – السعودية (1995–1997)",
        "title_en": "Baeshen Company – Saudi Arabia (1995–1997)",
        "role_ar": "مدير المنطقة الشمالية",
        "role_en": "Northern Region Manager",
        "desc_ar": "قاد جهود تسويق علامة شاي ربيع، وأسهم في إطلاق وتوسيع انتشار المنتج في السوق السعودي.",
        "desc_en": "Led the marketing efforts for Rabea Tea brand, contributing to the launch and extensive expansion of the product in the Saudi market.",
        "image": "/uploads/upload_1776635060394_u8uwk5.jfif"
      },
      {
        "title_ar": "شركة نستله مصر (1998)",
        "title_en": "Nestle Egypt (1998)",
        "role_ar": "مدير المبيعات - الإسكندرية",
        "role_en": "Sales Manager - Alexandria",
        "desc_ar": "أشرف على توزيع المنتجات الجافة (نسكافيه، نيدو، سيريلاك، شوكولاتة نستله) وعزز انتشار العلامة محليًا.",
        "desc_en": "Supervised the distribution of dry products (Nescafe, Nido, Cerelac, Nestle chocolate) and enhanced the brand''s local presence.",
        "image": "/uploads/upload_1776635088623_5j5aj6.png"
      },
      {
        "title_ar": "شركة صافولا سايم داربي (1999–2001)",
        "title_en": "Savola Sime Darby (1999–2001)",
        "role_ar": "مدير مبيعات القطاع الصناعي",
        "role_en": "Industrial Sector Sales Manager",
        "desc_ar": "ركز على توزيع زيت النخيل للصناعات الغذائية وقدم حلولًا صناعية مبتكرة من خلال إعادة تدوير مشتقات الزيت.",
        "desc_en": "Focused on distributing palm oil to the food industry and introduced innovative industrial solutions by recycling oil derivatives.",
        "image": "/uploads/upload_1776635112855_q157ia.webp"
      }
    ],
    "entrepreneurshipDesc_ar": "في عام 2002، اتخذ السيد محمد إدريس خطوة جريئة بتأسيس شركة السلام كشركة متخصصة في تجارة وتكرير الزيوت النباتية وتوريد المواد الخام للمصانع الكبرى والمطاعم.",
    "entrepreneurshipDesc_en": "In 2002, Mr. Mohamed Idris took a bold step by founding Elsalam Company as a specialized entity in trading and refining vegetable oils and supplying raw materials to major factories and restaurants.",
    "expansionDesc_ar": "توسعت الشركة في توزيع زيت النخيل والشورتنج والمارجرين، وخدمة أكثر من 135 مصنعًا في مصر. وفي عام 2020، تم افتتاح مصنع حديث بدمنهور مزود بأحدث خطوط الإنتاج.",
    "expansionDesc_en": "The company expanded into distributing palm oil, shortening, and margarine, serving over 135 factories in Egypt. In 2020, a modern factory was inaugurated in Damanhour, equipped with the latest production lines.",
    "innovationPoints": [
      {
        "text_ar": "إدخال الشورتنج في إنتاج الأجبان",
        "text_en": "Introducing shortening in cheese production"
      },
      {
        "text_ar": "تطوير حلول صناعية لصناعة الأغذية",
        "text_en": "Developing industrial solutions for the food industry"
      },
      {
        "text_ar": "استثمار مخلفات زيت النخيل في صناعة الصابون",
        "text_en": "Investing palm oil derivatives in soap manufacturing"
      },
      {
        "text_ar": "تطبيق نظام رقابة جودة صارم في كل مراحل الإنتاج",
        "text_en": "Implementing strictly monitored quality control across all production stages"
      }
    ],
    "visionDesc_ar": "يهدف إلى الريادة في صناعة الزيوت والدهون الطبيعية في مصر والشرق الأوسط، معتمداً على بناء شراكات استراتيجية طويلة الأمد، دعم الصناعات الصغيرة، والالتزام بالمسؤولية المجتمعية.",
    "visionDesc_en": "His vision is to lead the vegetable oils and natural fats industry in Egypt and the Middle East, relying on building long-term strategic partnerships, supporting small industries, and committing to social responsibility.",
    "leadershipPoints": [
      {
        "text_ar": "خبرة تتجاوز 30 عامًا في قطاع الأغذية",
        "text_en": "Over 30 years of experience in the food sector"
      },
      {
        "text_ar": "خلفية قوية في المبيعات الصناعية",
        "text_en": "Strong background in industrial sales"
      },
      {
        "text_ar": "قدرة على بناء شراكات استراتيجية",
        "text_en": "Ability to build strategic partnerships"
      },
      {
        "text_ar": "توجه ابتكاري في تطوير المنتجات",
        "text_en": "Innovative approach to product development"
      },
      {
        "text_ar": "دعم حقيقي للصناعات الصغيرة والمتوسطة",
        "text_en": "Genuine support for small and medium-sized industries"
      }
    ],
    "image": "/uploads/upload_1777799973239_8vhq9o.png"
  },
  "gallery": {
    "title_ar": "جولة في المصنع",
    "title_en": "Factory Tour",
    "subtitle_ar": "نظرة على خطوط الإنتاج ومرافق الجودة",
    "subtitle_en": "A look at our production lines and quality facilities",
    "items": [
      {
        "title_ar": "خط إنتاج الزيوت الآلي",
        "title_en": "Automated Oil Production Line",
        "url": "/uploads/upload_1776643156622_joaqhw.jfif"
      },
      {
        "title_ar": "معامل رقابة الجودة",
        "title_en": "Quality Control Labs",
        "url": "/uploads/upload_1776643556377_mlqu6e.jfif"
      },
      {
        "title_ar": "خزانات التخزين",
        "title_en": "Storage Tanks",
        "url": "/uploads/upload_1776643692457_kvhcm0.jfif"
      },
      {
        "title_ar": "خط تعبئة العبوات",
        "title_en": "Bottle Filling Line",
        "url": "/uploads/upload_1776643846245_gg2zai.jfif"
      },
      {
        "title_ar": "مستودعات الشحن",
        "title_en": "Shipping Warehouses",
        "url": "/uploads/upload_1776643951492_u4bpcp.jfif"
      },
      {
        "title_ar": "منطقة استقبال المواد الخام",
        "title_en": "Raw Material Reception Area",
        "url": "/uploads/upload_1776644148629_oi3c0v.jfif"
      },
      {
        "title_ar": "غرفة التحكم المركزية",
        "title_en": "Central Control Room",
        "url": "/uploads/upload_1776644200524_obw0ri.jfif"
      },
      {
        "title_ar": "خط إنتاج السمن",
        "title_en": "Ghee Production Line",
        "url": "/uploads/upload_1776644483092_5m2czr.jfif"
      }
    ]
  },
  "team": {
    "badge_ar": "شركاء النجاح",
    "badge_en": "Partners in Success",
    "title_ar": "فريق الإدارة العليا",
    "title_en": "Executive Leadership",
    "subtitle_ar": "نخبة من الكفاءات المتميزة التي تقود رؤيتنا نحو العالمية، وتضمن أعلى معايير الجودة والتميز في كافة قطاعات الشركة.",
    "subtitle_en": "Our distinguished leadership driving our global vision and ensuring the highest standards of quality.",
    "members": [
      {
        "name_ar": "ذكى السيد ذكي",
        "name_en": "Zaki El-Sayed Zaki",
        "role_ar": "مشرف المبيعات ",
        "role_en": "Sales Supervisor",
        "image": "/uploads/upload_1776621029870_2h0jss.jfif"
      },
      {
        "name_ar": "وليد بيومي",
        "name_en": "Walid Bayoumi ",
        "role_ar": "مدير المبيعات ",
        "role_en": "Sales Manager",
        "image": "/uploads/upload_1776621270095_axlqdh.jfif"
      },
      {
        "name_ar": "منة الله زكريا ",
        "name_en": "Menat Allah Zakaria",
        "role_ar": "مديرة الحسابات",
        "role_en": "Accounts Manager",
        "image": "/uploads/upload_1776629197489_t4qeu8.jfif"
      },
      {
        "name_ar": "محمد عاطف",
        "name_en": "Mohamed Atef",
        "role_ar": "مدير الإنتاج",
        "role_en": "Production Manager",
        "image": "/uploads/upload_1776629419135_hu8pen.jfif"
      },
      {
        "name_ar": "محمد الريفي",
        "name_en": "Mohamed Elrifi",
        "role_ar": "مدير الجودة",
        "role_en": "Quality Manager",
        "image": "/uploads/upload_1776630914066_sad8o6.jfif"
      }
    ]
  }
}', '2026-05-03 09:19:35.128', '٣‏/٥‏/٢٠٢٦ ١٢:١٩:٣٥ م');
INSERT INTO public."PageContentHistory" VALUES ('cmoqoh5ue0001rtns7rk2ekk1', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+20 1xx xxx xxxx",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM"
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "",
    "lat": "30.5965",
    "lng": "30.9876"
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:06:58.262', '٤‏/٥‏/٢٠٢٦ ٧:٠٦:٥٨ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqoy8kr0003rtnsqcwqyj8o', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+20 1xx xxx xxxx",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "أبعادية دمنهور، دمنهور،، 2CRH+4GC، أبعادية دمنهور، دمنهور،، محافظة البحيرة 5854960،"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "",
    "lat": "30.5965",
    "lng": "30.9876"
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:20:14.955', '٤‏/٥‏/٢٠٢٦ ٧:٢٠:١٤ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqoyp0b0005rtnsav36bofj', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+20 1xx xxx xxxx",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "",
    "lat": "30.5965",
    "lng": "30.9876"
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:20:36.251', '٤‏/٥‏/٢٠٢٦ ٧:٢٠:٣٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqp5cl80007rtns1ws98han', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "",
    "lat": "30.5965",
    "lng": "30.9876"
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:25:46.749', '٤‏/٥‏/٢٠٢٦ ٧:٢٥:٤٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqp63o70009rtnsipc2p016', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "30.5965",
    "lng": "30.9876"
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:26:21.847', '٤‏/٥‏/٢٠٢٦ ٧:٢٦:٢١ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqp6k47000brtnshfvlwpju', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "المنطقة الصناعية، المنوفية، مصر",
    "address_en": "Industrial Zone, Monofia, Egypt",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:26:43.16', '٤‏/٥‏/٢٠٢٦ ٧:٢٦:٤٣ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqpj4wp000drtnsz4gom8v3', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:36:29.978', '٤‏/٥‏/٢٠٢٦ ٧:٣٦:٢٩ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqpkkv7000frtnsuw2c5g02', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:37:37.316', '٤‏/٥‏/٢٠٢٦ ٧:٣٧:٣٧ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqpl99q000hrtnsmqvhuf5a', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:38:08.943', '٤‏/٥‏/٢٠٢٦ ٧:٣٨:٠٨ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqq0i61000jrtnsoayy9hhc', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "المنطقة الصناعية، المنوفية، مصر",
        "address_en": "Industrial Zone, Monofia, Egypt",
        "phone": "+20 1xx xxx xxxx"
      },
      {
        "name_ar": "مكتب المبيعات — القاهرة",
        "name_en": "Sales Office — Cairo",
        "address_ar": "القاهرة، مصر",
        "address_en": "Cairo, Egypt",
        "phone": "+20 1xx xxx xxxx"
      }
    ]
  }
}', '2026-05-04 04:50:00.314', '٤‏/٥‏/٢٠٢٦ ٧:٥٠:٠٠ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqq4jda000lrtnsyoondr3j', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "phone": "+201050051851"
      },
      {
        "name_ar": "فرع كفر الدوار ",
        "name_en": "Kafr El-Dawar branch",
        "address_ar": "البحيرة - كفر الدوار - منشأة الأوقاف - أرض العمدة - 1 شارع والي",
        "address_en": "Beheira – Kafr El-Dawar – Mansha’at Al-Awqaf – Ard El-Omda – 1 Wali Street",
        "phone": "+201222455205",
        "mapLink": "https://maps.app.goo.gl/MKoK2BWMNLXMDeWq8"
      }
    ]
  }
}', '2026-05-04 04:53:08.494', '٤‏/٥‏/٢٠٢٦ ٧:٥٣:٠٨ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqq7pnr000nrtnsd0g3rvxt', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "phone": "+201050051851"
      },
      {
        "name_ar": "فرع كفر الدوار ",
        "name_en": "Kafr El-Dawar branch",
        "address_ar": "البحيرة - كفر الدوار - منشأة الأوقاف - أرض العمدة - 1 شارع والي",
        "address_en": "Beheira – Kafr El-Dawar – Mansha’at Al-Awqaf – Ard El-Omda – 1 Wali Street ",
        "phone": "+201222455205",
        "mapLink": "https://maps.app.goo.gl/MKoK2BWMNLXMDeWq8"
      }
    ]
  }
}', '2026-05-04 04:55:36.615', '٤‏/٥‏/٢٠٢٦ ٧:٥٥:٣٦ ص');
INSERT INTO public."PageContentHistory" VALUES ('cmoqqx83m000prtnsi7hz2y04', 'contact', '{
  "hero": {
    "title_ar": "تواصل معنا",
    "title_en": "Contact Us",
    "subtitle_ar": "نسعد بالرد على استفساراتكم خلال 24 ساعة عمل",
    "subtitle_en": "We''re happy to respond to your inquiries within 24 business hours",
    "backgroundImage": "/uploads/upload_1777867615355_1tuqpy.png"
  },
  "contactInfo": {
    "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
    "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
    "phone": "+201050051851",
    "email": "info@elsalamoils.com",
    "workingHours_ar": "السبت – الخميس: 8:00 ص – 5:00 م",
    "workingHours_en": "Saturday – Thursday: 8:00 AM – 5:00 PM",
    "branches": [
      {
        "name_ar": "الفرع الرئيسي المصنع ",
        "name_en": "The main factory branch",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "mapLink": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9"
      },
      {
        "name_ar": "",
        "name_en": "",
        "address_ar": "",
        "address_en": "",
        "mapLink": ""
      }
    ]
  },
  "formSettings": {
    "title_ar": "أرسل رسالتك",
    "title_en": "Send Your Message",
    "submitButton_ar": "إرسال الرسالة",
    "submitButton_en": "Send Message",
    "successMessage_ar": "تم إرسال رسالتك بنجاح! سنرد عليك خلال 24 ساعة عمل.",
    "successMessage_en": "Your message has been sent successfully! We''ll respond within 24 business hours.",
    "errorMessage_ar": "حدث خطأ أثناء الإرسال. يرجى المحاولة مرة أخرى.",
    "errorMessage_en": "An error occurred while sending. Please try again."
  },
  "social": {
    "whatsappLocal": "https://wa.me/201234567890",
    "whatsappLocalLabel_ar": "واتساب — مبيعات محلية",
    "whatsappLocalLabel_en": "WhatsApp — Local Sales",
    "whatsappExport": "https://wa.me/201234567890",
    "whatsappExportLabel_ar": "واتساب — التصدير",
    "whatsappExportLabel_en": "WhatsApp — Export",
    "facebook": "https://www.facebook.com/profile.php?id=61573886707769 ",
    "instagram": "",
    "linkedin": ""
  },
  "map": {
    "mapEmbedUrl": "https://maps.app.goo.gl/fsWtecuR3ARnj5aV9",
    "lat": "",
    "lng": ""
  },
  "branches": {
    "title_ar": "فروعنا ومكاتبنا",
    "title_en": "Our Branches & Offices",
    "items": [
      {
        "name_ar": "المصنع الرئيسي",
        "name_en": "Main Factory",
        "address_ar": "البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ",
        "address_en": "Beheira – Damanhur – Al-Abadiya – near the Colleges Complex",
        "phone": "+201050051851"
      },
      {
        "name_ar": "فرع كفر الدوار ",
        "name_en": "Kafr El-Dawar branch",
        "address_ar": "البحيرة - كفر الدوار - منشأة الأوقاف - أرض العمدة - 1 شارع والي",
        "address_en": "Beheira – Kafr El-Dawar – Mansha’at Al-Awqaf – Ard El-Omda – 1 Wali Street ",
        "phone": "+201222455205",
        "mapLink": "https://maps.app.goo.gl/MKoK2BWMNLXMDeWq8"
      }
    ]
  }
}', '2026-05-04 05:15:26.914', '٤‏/٥‏/٢٠٢٦ ٨:١٥:٢٦ ص');


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (8, 'olein-oil-jerry-can-18-kg', 'جركن زيت أولين مكرر 18 كيلو ', 'Olein Oil Jerry Can – 18 KG', 'زيت أولين نقي عالي الأداء للقلي العميق، بثبات ممتاز وطعم خفيف.', 'Premium olein oil with high frying performance, excellent stability, and neutral taste.', 'يُعد زيت الأولين من الزيوت النباتية المكررة بعناية باستخدام أحدث تقنيات العصر والتكرير، مما يمنحه نقاءً عالياً وخالياً من الشوائب. يتميز هذا الزيت بنسبة عالية من الأحماض الدهنية غير المشبعة، ما يساعد على تحسين جودة الطعام المقلي والحفاظ على الطعم الأصلي دون امتصاص زائد للزيت.

يتميز بثباته عند درجات الحرارة المرتفعة، مما يقلل من تكوّن الرغوة والدخان أثناء القلي، ويطيل عمر الاستخدام، وبالتالي يقلل من تكلفة التشغيل للمطاعم والمطابخ الصناعية.', 'Olein oil is a carefully refined vegetable oil processed advanced extraction and refining technologies to ensure maximum purity and clarity. It contains a high level of unsaturated fatty acids, which helps maintain food quality and reduces excessive oil absorption during frying.

Its high heat stability minimizes foam formation and smoke during cooking, extending oil life and reducing operational costs for restaurants and food industries.', NULL, NULL, '/uploads/upload_1776662638338_dlng4d.jfif', 1180, 'للجركن 18 كيلو', '1180', true, true, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, '2026-04-20 05:29:06.256', '2026-05-03 04:01:44.895', 79);
INSERT INTO public."Product" VALUES (10, 'refined-soybean-oil-18kg-jerrycan', 'جركن زيت صويا 18 كيلو', 'Refined Soybean Oil - 18kg Jerrycan', 'زيت صويا نقي وعالي الجودة، الخيار المثالي للمطاعم والمصانع لضمان أداء فائق في الطهي والقلي.', 'Premium refined soybean oil, the ideal choice for restaurants and food industries seeking superior cooking and frying performance.', 'يتميز زيت الصويا لدينا بنقائه العالي وقدرته الفائقة على تحمل درجات الحرارة المرتفعة، مما يجعله الخيار الأول للقلي العميق والخبز وتحضير مختلف الأطباق دون التأثير على النكهة الأصلية للمكونات. بفضل تركيبته المتوازنة، يضمن لك نتائج مثالية في كل استخدام مع الحفاظ على القيمة الغذائية.

يأتي المنتج في جركن سعة 18 كيلو مصمم خصيصاً للاستخدام الكثيف في المطابخ التجارية ومصانع الأغذية، مما يوفر كفاءة عالية في التخزين والاستهلاك. إنه الحل الاقتصادي والاحترافي الذي يجمع بين الجودة العالمية والسعر التنافسي لتعزيز كفاءة أعمالك.', 'Our soybean oil is characterized by its high purity and exceptional smoke point, making it the top choice for deep frying, baking, and versatile culinary applications without altering the original food flavors. Its balanced composition ensures perfect results in every use while maintaining nutritional integrity.

Packaged in a robust 18kg jerrycan designed for heavy-duty use in commercial kitchens and food manufacturing plants, this product offers high efficiency in storage and consumption. It is the professional, economical solution that combines international quality standards with competitive pricing to boost your business productivity.', NULL, NULL, '/uploads/upload_1777325411213_oft6t8.jfif', NULL, NULL, NULL, true, true, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, '2026-04-27 22:32:21.486', '2026-04-27 22:33:06.811', 100);
INSERT INTO public."Product" VALUES (12, 'carton-of-12-jouri-soybean-oil-bottles-850ml', 'كرتونة 12 زجاجة زيت صويا جوري 850 ملي', 'Carton of 12 Jouri Soybean Oil Bottles - 850ml', 'زيت صويا جوري النقي، الخيار الأمثل لصحة عائلتك ومذاق أطباقك الفريد. عبوة اقتصادية توفر لك الجودة والوفرة في آن واحد لمطبخك.', 'Jouri pure soybean oil is the perfect choice for your family''s health and unique dish flavors. An economical pack providing both quality and value for your kitchen.', 'يعد زيت صويا جوري من أجود أنواع الزيوت النباتية، حيث يتم استخلاصه بعناية لضمان نقاء فائق ولون ذهبي صافٍ. يتميز بخفته على المعدة واحتوائه على نسبة عالية من الأحماض الدهنية غير المشبعة، مما يجعله الخيار الصحي المفضل للقلي، الطبخ، وتحضير أشهى المخبوزات والحلويات دون التأثير على الطعم الأصلي للمكونات.
تأتي هذه الكرتونة المكونة من 12 زجاجة لتلبي احتياجات المطابخ العصرية والمطاعم بكفاءة عالية، حيث تضمن لك مخزوناً مستمراً من الزيت النقي المقاوم لدرجات الحرارة العالية. بفضل تقنيات التكرير المتقدمة، يوفر زيت جوري توازناً مثالياً بين القيمة الغذائية والأداء المتميز في المطبخ، مع الحفاظ على نضارة وجودة الأطعمة.', 'Jouri Soybean Oil is one of the finest vegetable oils, carefully extracted to ensure superior purity and a clear golden color. It is characterized by being light on the stomach and containing a high percentage of unsaturated fatty acids, making it the preferred healthy choice for frying, cooking, and preparing delicious baked goods and desserts without affecting the original flavor of the ingredients.
This carton of 12 bottles is designed to efficiently meet the needs of modern kitchens and restaurants, ensuring a steady supply of pure oil that withstands high temperatures. Thanks to advanced refining techniques, Jouri oil provides a perfect balance between nutritional value and outstanding kitchen performance, while maintaining the freshness and quality of your food.', NULL, NULL, '/uploads/upload_1777333133941_i29fbr.png', 670, 'للكرتونة 12 زجاجة', NULL, true, true, NULL, NULL, NULL, 6, NULL, NULL, NULL, NULL, '2026-04-27 23:16:40.835', '2026-04-27 23:38:56.112', 100);
INSERT INTO public."Product" VALUES (13, 'jory-palm-olein-oil-carton-12-x-700ml', 'كرتونة 12 زجاجة زيت أولين جوري 700 ملي', 'Jory Palm Olein Oil - Carton (12 x 700ml)', 'الخيار الاحترافي للقلي العميق بفضل ثباته الحراري الفائق ونتائجه الصحية المقرمشة. زيت جوري يمنحك جودة استثنائية مع امتصاص أقل للزيت في كل وجبة.', 'The professional choice for deep frying with superior thermal stability and healthy, crispy results. Jory oil ensures exceptional quality with less oil absorption in every meal.', 'يعد زيت أولين جوري الحل المتكامل للمطابخ التي تبحث عن الكفاءة والصحة في آن واحد؛ فهو مصمم خصيصاً ليتحمل درجات الحرارة العالية جداً في القلي العميق دون أن يتأثر هيكله الكيميائي، مما يضمن نكهة نقية ولوناً ذهبياً مثالياً للأطعمة. بفضل تقنية الامتصاص المنخفض، ستحصل على وجبات خفيفة وأقل دسامة، مما يجعله المفضل لدى الشيفات والمستهلكين المهتمين بنمط حياة صحي.

إلى جانب أدائه المذهل، يتميز زيت جوري بكونه معززاً طبيعياً بمضادات الأكسدة وفيتامين E، وهو خالٍ تماماً من الكوليسترول والدهون المتحولة الضارة. تأتي هذه الكرتونة المكونة من 12 زجاجة لتلبي احتياجات الاستهلاك العالي مع ضمان استقرار الجودة لفترة طويلة، مما يجعله استثماراً ذكياً للمطاعم والمنازل التي لا تقبل المساومة على الجودة.', 'Jory Palm Olein Oil is the comprehensive solution for kitchens seeking both efficiency and health. Specifically formulated to withstand extreme temperatures in deep frying without chemical breakdown, it guarantees pure flavor and a perfect golden color for all foods. Thanks to its low-absorption technology, you will serve lighter, less greasy meals, making it the preferred choice for chefs and health-conscious consumers alike.

Beyond its stunning performance, Jory oil is naturally enriched with antioxidants and Vitamin E, while being completely free from cholesterol and harmful trans fats. This 12-bottle carton is designed to meet high-volume demands while ensuring consistent quality over a long shelf life, making it a smart investment for restaurants and households that refuse to compromise on excellence.', NULL, NULL, '/uploads/upload_1777332807226_t5pmtl.png', 775, 'كرتونة 12 زجاجة ', 'Carton of 12 bottles', true, true, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, '2026-04-27 23:33:49.47', '2026-04-27 23:33:49.47', 100);
INSERT INTO public."Product" VALUES (11, 'soma-olein-oil-1l-case-of-12-bottles', 'كرتونة 12 زجاجة زيت أولين سومة 1 لتر ', 'Soma Olein Oil 1L - Case of 12 Bottles', 'الخيار الاحترافي للقلي العميق بثبات حراري فائق وأعلى معايير الصحة. زيت سومة يمنحك قرمشة مثالية مع امتصاص أقل للزيت لنتائج أخف وأشهى.', 'The professional choice for deep frying with superior thermal stability and the highest health standards. Soma oil delivers perfect crunch with less oil absorption for lighter results.', 'يعد زيت أولين سومة الحل الأمثل للمطابخ التي تبحث عن الكفاءة والجودة الصحية في آن واحد، حيث يتميز بقدرة استثنائية على تحمل درجات الحرارة العالية دون تحلل، مما يجعله مثالياً للقلي العميق المتكرر. بفضل تركيبته المتطورة، يضمن الزيت امتصاصاً أقل للأطعمة، مما يوفر وجبات خفيفة ومقرمشة تحافظ على طعمها الأصلي، وهو ما يجعله الاختيار الأول للطهاة المحترفين وربات البيوت اللواتي يهتممن بالجودة.', 'Soma Olein Oil is the ultimate solution for kitchens seeking both efficiency and health quality. It features an exceptional ability to withstand high temperatures without breaking down, making it ideal for frequent deep frying. Thanks to its advanced formula, the oil ensures lower absorption into food, providing light and crispy meals that retain their original flavor, making it the first choice for professional chefs and quality-conscious home cooks.', NULL, NULL, '/uploads/upload_1777333656481_d9j7br.png', 775, 'كرتونة 12 زجاجة ', 'Carton of 12 bottles', true, true, NULL, NULL, NULL, 5, NULL, NULL, NULL, NULL, '2026-04-27 22:59:31.526', '2026-04-27 23:47:41.31', 100);
INSERT INTO public."Product" VALUES (14, 'blended-vegetable-oil-3-liters', 'زيت خليط 3 لتر ', 'Blended Vegetable Oil - 3 Liters', 'الخيار الأمثل لمطبخك، زيت خليط نقي يجمع بين الجودة العالية والقيمة الاقتصادية. صُمم خصيصاً ليمنحك نتائج مثالية في القلي والطهي مع الحفاظ على نكهة طعامك الأصلية.', 'The perfect choice for your kitchen, a pure blended oil that combines high quality with exceptional value. Specially formulated for ideal frying and cooking results while preserving original flavors.', 'يتميز زيت الخليط سعة 3 لتر بتركيبة متوازنة تم تطويرها بعناية لتناسب كافة احتياجات الطهي اليومي، سواء في القلي العميق أو التحمير أو إعداد الوجبات الخفيفة. بفضل درجة نقائه العالية وتحمله لدرجات الحرارة المرتفعة، يضمن لك الحصول على أطباق مقرمشة وصحية دون أي روائح غير مرغوب فيها، مما يجعله المساعد الأول لكل شيف يسعى للتميز في مطبخه.

تأتي هذه العبوة الاقتصادية لتلبي متطلبات العائلات والمطاعم التي تبحث عن التوازن المثالي بين الأداء المتفوق والسعر المنافس. تم إنتاج وتعبئة الزيت وفقاً لأحدث المعايير الصحية العالمية لضمان الحفاظ على جودته وخصائصه الغذائية لفترات طويلة، مما يجعله منتجاً أساسياً لا غنى عنه في مخازن المواد الغذائية والمنازل.', 'Our 3L Blended Vegetable Oil features a carefully balanced formula developed to suit all daily cooking needs, from deep frying to sautéing and preparing light meals. Thanks to its high purity and high smoke point, it ensures crispy and healthy dishes without any unwanted odors, making it the primary choice for every chef striving for excellence in their kitchen.

This economical packaging is designed to meet the demands of families and restaurants seeking the perfect balance between superior performance and competitive pricing. The oil is produced and bottled according to the latest international health standards to ensure its quality and nutritional properties are preserved for long periods, making it an essential product for food warehouses and households alike.', NULL, NULL, '/uploads/upload_1777334319195_9ls213.png', 745, 'كرتونة 4 زجاجات ', 'Carton of 4 bottles', true, true, NULL, NULL, NULL, 7, NULL, NULL, NULL, NULL, '2026-04-27 23:59:39.491', '2026-04-27 23:59:39.491', 100);
INSERT INTO public."Product" VALUES (16, 'somaty-vegetable-ghee-11kg-tin', 'سمنة نباتي سوماتي 11 كيلو  بستلة', 'somaty Vegetable Ghee - 11kg Tin', 'سمنة نباتي سوماتي بجودة استثنائية ونكهة غنية، الخيار الأمثل للمطابخ الاحترافية لضمان قوام مثالي ومذاق لا يقاوم.', 'somaty vegetable ghee offers exceptional quality and rich flavor, making it the perfect choice for professional kitchens to ensure ideal texture and irresistible taste.', 'تعد سمنة سوماتيالنباتية شريكك المثالي في الطهي والخبز، حيث تتميز بقوامها المتجانس وقدرتها العالية على تحمل درجات الحرارة المرتفعة، مما يجعلها مثالية للقلي والتحمير وإعداد الحلويات الشرقية الفاخرة. بفضل تركيبتها المتطورة، تمنح أطباقك نكهة غنية ورائحة زكية تعزز من جودة منتجاتك النهائية وتضمن رضا عملائك الدائم.
تأتي في عبوة صفيح اقتصادية بوزن 11 كيلو، مصممة خصيصاً لتلبية احتياجات المطاعم والفنادق وصناع الحلويات الكبار. تتميز بفترة صلاحية طويلة وسهولة في التخزين، كما أنها خالية من الكوليسترول، مما يوفر توازناً مثالياً بين الأداء المهني العالي والقيمة الغذائية المطلوبة في صناعة الأغذية الاحترافية.', 'somaty vegetable ghee is your ideal partner in cooking and baking, characterized by its consistent texture and high smoke point, which makes it perfect for frying, sautéing, and preparing premium oriental sweets. Thanks to its advanced formulation, it gives your dishes a rich flavor and aromatic scent that enhances the quality of your final products and ensures lasting customer satisfaction.
It comes in an economical 11kg tin, specifically designed to meet the needs of restaurants, hotels, and large-scale confectioners. It features a long shelf life and ease of storage, and is cholesterol-free, providing a perfect balance between high professional performance and the nutritional value required in the professional food industry.', NULL, NULL, '/uploads/upload_1777337251803_753lhw.jfif', 780, 'بستلة 11 كيلو', '11 kg weight plate ', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 00:52:27.252', '2026-04-28 00:54:03.16', 100);
INSERT INTO public."Product" VALUES (17, 'joory-vegetable-ghee-1kg-tin', 'كرتونة سمنة نباتي جوري 1كيلو صفيح', ' Carton Of Joory Vegetable Ghee - 1kg Tin', 'سمنة نباتي جوري بجودة استثنائية ونكهة غنية، الخيار الأمثل للمطابخ الاحترافية لضمان قوام مثالي ومذاق لا يقاوم.', 'Joory vegetable ghee offers exceptional quality and rich flavor, making it the perfect choice for professional kitchens to ensure ideal texture and irresistible taste.', 'تعد سمنة جوري النباتية شريكك المثالي في الطهي والخبز، حيث تتميز بقوامها المتجانس وقدرتها العالية على تحمل درجات الحرارة المرتفعة، مما يجعلها مثالية للقلي والتحمير وإعداد الحلويات الشرقية الفاخرة. بفضل تركيبتها المتطورة، تمنح أطباقك نكهة غنية ورائحة زكية تعزز من جودة منتجاتك النهائية وتضمن رضا عملائك الدائم.
تأتي في عبوة صفيح اقتصادية بوزن 11 كيلو، مصممة خصيصاً لتلبية احتياجات المطاعم والفنادق وصناع الحلويات الكبار. تتميز بفترة صلاحية طويلة وسهولة في التخزين، كما أنها خالية من الكوليسترول، مما يوفر توازناً مثالياً بين الأداء المهني العالي والقيمة الغذائية المطلوبة في صناعة الأغذية الاحترافية.', 'Joory vegetable ghee is your ideal partner in cooking and baking, characterized by its consistent texture and high smoke point, which makes it perfect for frying, sautéing, and preparing premium oriental sweets. Thanks to its advanced formulation, it gives your dishes a rich flavor and aromatic scent that enhances the quality of your final products and ensures lasting customer satisfaction.
It comes in an economical 11kg tin, specifically designed to meet the needs of restaurants, hotels, and large-scale confectioners. It features a long shelf life and ease of storage, and is cholesterol-free, providing a perfect balance between high professional performance and the nutritional value required in the professional food industry.', NULL, NULL, '/uploads/upload_1777338490917_d74vrs.png', 710, 'كرتونة 12 علبة صفيح 700 جرام ', 'A carton of 12 tins, 700 grams each', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 01:12:25.219', '2026-04-28 01:12:25.219', 100);
INSERT INTO public."Product" VALUES (18, 'jouri-600g-plant-based-margarine-tub', 'كرتونة سمنة نباتي جوري 650 جرام برطمان', 'Jouri 650g Plant Butter Jar', 'سمنة نباتية جوري 650 جرام، مثالية لصناعة الحلويات والمخبوزات الهشة.', 'Jouri 650g Plant Butter, ideal for baking and making crispy pastries.', 'سمنة نباتية جوري 650 جرام هي الخيار الأمثل للمخابز والمطاعم الكبيرة. تتميز بثباتها العالي عند درجات الحرارة المرتفعة، مما يجعلها مثالية للاستخدام في الطهي والخبز. كما أنها خالية تمامًا من الكوليسترول والدهون الحيوانية، مما يجعلها الخيار الصحي للعائلة. النكهة الغنية والرائحة الأصيلة تعطي منتجاتك نكهة فريدة ومميزة، بينما توفر اقتصادًا كبيرًا للمنشآت الغذائية الكبيرة.', 'Jouri 650g Plant Butter is the perfect choice for large bakeries and restaurants. It boasts high stability at high temperatures, making it ideal for cooking and baking. Additionally, it is completely free from cholesterol and animal fats, making it a healthy choice for your family. The rich flavor and authentic aroma give your products a unique and distinctive taste, while providing significant economic savings for large food establishments.', NULL, NULL, '/uploads/upload_1777340663443_yhchyr.png', 280, 'برطمان 600 جرام', '600g Jar', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 01:43:13.721', '2026-04-28 01:44:27.884', 100);
INSERT INTO public."Product" VALUES (19, 'jouri-600g-plant-based-margarine-jar', 'كرتونة سمنة نباتي جوري 600 جرام برطمان ', 'Jouri 600g Plant-Based Margarine Jar', 'سمنة نباتية جوري 600 جرام، الخيار الأمثل للمخبوزات والحلويات.', 'Jouri 600g Plant-Based Margarine, the perfect choice for baking and pastries.', 'كرتونة سمنة نباتية جوري 600 جرام هي الخيار المثالي لكل من يبحث عن جودة عالية وخالية من الكوليسترول. تتميز هذه السمنة بثباتها العالي عند درجات الحرارة المرتفعة، مما يجعلها مثالية للاستخدام في صناعة الحلويات والمخبوزات الهشة. كما أنها تأتي بنكهة غنية ورائحة أصيلة، مما يضفي طابعًا فريدًا على الأطباق. بالإضافة إلى ذلك، توفر هذه السمنة اقتصادًا كبيرًا للمنشآت الغذائية الكبيرة، مما يجعلها الخيار الأمثل للمطاعم والمخابز.', 'The Jouri 600g Plant-Based Margarine Jar is the ideal choice for those seeking high-quality, cholesterol-free options. This margarine boasts excellent heat stability, making it perfect for baking and creating crispy pastries. It offers a rich flavor and authentic aroma, enhancing the taste of your dishes. Moreover, it provides exceptional cost savings for large food establishments, making it the go-to choice for restaurants and bakeries.', NULL, NULL, '/uploads/upload_1777341364543_coo5oj.png', 260, 'برطمان 600 جرام', '600g Jar', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 01:56:26.807', '2026-04-28 01:56:26.807', 100);
INSERT INTO public."Product" VALUES (20, 'ghouri-700g-jar-of-vegetable-shortening', 'كرتونة سمنة نباتي جوري 700 جرام برطمان', 'Ghouri 700g Jar of Vegetable Shortening', 'سمنة نباتية جوري 700 جرام برطمان: الخيار الأمثل للحلويات والمخبوزات الهشة.', 'Ghouri 700g Jar of Vegetable Shortening: The perfect choice for pastries and crispy baked goods.', 'سمنة نباتية جوري 700 جرام برطمان هي الخيار المثالي لكل من يبحث عن جودة عالية وأداء متميز في صناعة الحلويات والمخبوزات. تتميز بثباتها العالي عند درجات الحرارة المرتفعة، مما يجعلها مثالية للاستخدام في المطاعم والمخبزات الكبيرة. كما أنها خالية تمامًا من الكوليسترول والدهون الحيوانية، مما يجعلها الخيار الصحي لعائلتك. بالإضافة إلى ذلك، توفر سمنة جوري اقتصادًا كبيرًا للمؤسسات الغذائية، حيث تضمن جودة ثابتة وكفاءة عالية في الاستخدام.', 'Ghouri 700g Jar of Vegetable Shortening is the ideal choice for those seeking high quality and superior performance in pastry and baking. It boasts excellent heat stability, making it perfect for use in large restaurants and bakeries. Additionally, it is completely free from cholesterol and animal fats, making it a healthy option for your family. Furthermore, Ghouri Shortening offers significant cost savings to food establishments, ensuring consistent quality and efficient use.', NULL, NULL, '/uploads/upload_1777341691465_ksshmf.png', 300, 'برطمان 700 جرام', '700 grams of butter', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 02:03:13.17', '2026-04-28 02:03:13.17', 100);
INSERT INTO public."Product" VALUES (21, 'jouri-1150g-plant-butter-jar', 'سمنة نباتي جوري 1150 جرام برطمان ', 'Jouri 1150g Plant Butter Jar', 'سمنة نباتية غنية بنكهة أصيلة وخالية من الكوليسترول، مثالية للمخابز والحلويات.', 'Rich plant butter with authentic flavor and cholesterol-free, perfect for bakeries and confectioneries.', 'سمنة نباتي جوري 1150 جرام برطمان هي الخيار الأمثل للمخابز والحلويات. تتميز بثباتها العالي عند درجات الحرارة المرتفعة، مما يجعلها مثالية للطهي والخبز دون فقدان جودتها. كما أنها خالية تمامًا من الكوليسترول والدهون الحيوانية، مما يجعلها خيارًا صحيًا ومفضلاً للمستهلكين الذين يهتمون بصحتهم. بالإضافة إلى ذلك، توفر هذه السمنة النباتية اقتصادًا كبيرًا للمنشآت الغذائية الكبيرة، حيث تأتي في حزمة عملية توفر تكلفة أقل لكل استخدام.', 'The Jouri 1150g Plant Butter Jar is the ideal choice for bakeries and confectioneries. It boasts high stability at high temperatures, making it perfect for cooking and baking without compromising on quality. Additionally, it is entirely free from cholesterol and animal fats, making it a healthy and preferred option for health-conscious consumers. Moreover, this plant butter offers significant economic savings for large food establishments, as it comes in a practical package that reduces cost per use.', NULL, NULL, '/uploads/upload_1777342104436_qbelq1.png', 480, 'برطمان 1150 جرام', '1150 grams of butter', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 02:10:27.103', '2026-04-28 02:17:59.825', 100);
INSERT INTO public."Product" VALUES (22, 'joory-plant-butter-1250g-jar', 'سمنة نباتي جوري 1250 جرام برطمان', 'Joory Plant Butter 1250g Jar', 'سمنة نباتية عالية الجودة، مثالية للمخبوزات والحلويات.', 'High-quality plant butter, perfect for baking and confections.', 'سمنة نباتي جوري هي الخيار الأمثل لكل من يبحث عن جودة عالية وخالية من الكوليسترول. تتميز بثباتها العالي عند درجات الحرارة المرتفعة، مما يجعلها مثالية لاستخدامها في صناعة الحلويات والمخبوزات الهشة. كما أنها توفر حلًّا اقتصاديًّا فائقًا للمنشآت الغذائية الكبيرة، حيث تضمن النكهة الغنية والرائحة الأصيلة في كل استخدام.', 'Ghori Plant Butter is the perfect choice for those seeking high quality and cholesterol-free options. It boasts exceptional stability at high temperatures, making it ideal for baking and creating crispy pastries. Additionally, it offers exceptional economic value for large food establishments, ensuring a rich flavor and authentic aroma with every use.', NULL, NULL, '/uploads/upload_1777343394246_s8xibc.png', 515, 'برطمان 1250 جرام', 'jar1250 grams', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 02:30:39.256', '2026-04-28 02:30:39.256', 100);
INSERT INTO public."Product" VALUES (23, 'salam-shortening-carton-25kg', 'كرتونة شورتنج السلام 25 كيلو ', 'Salam Shortening Carton 25kg', 'كرتونة الشورتنج السلام 25 كيلو: الخيار الأمثل للمخابز والمطاعم!', 'Salam Shortening Carton 25kg: The perfect choice for bakeries and restaurants!', 'كرتونة الشورتنج السلام 25 كيلو هي منتج عالي الجودة مصمم خصيصًا لتلبية احتياجات المخابز والمطاعم. يتميز هذا الشورتنج بقدرته على توفير نتائج متسقة وعالية الجودة في جميع أنواع الحلويات والمعجنات، مما يجعله الخيار المثالي للطهاة والمخبزين المحترفين. كما أنه سهل الاستخدام ويضمن حفظًا طويل الأمد، مما يوفر الراحة والكفاءة في المطبخ.', 'The Salam Shortening Carton 25kg is a high-quality product designed to meet the needs of bakeries and restaurants. This shortening is known for its ability to provide consistent and high-quality results in all types of pastries and baked goods, making it the ideal choice for professional chefs and bakers. It is easy to use and ensures long-term storage, providing convenience and efficiency in the kitchen.', NULL, NULL, '/uploads/upload_1777343973663_t0gmia.png', 1585, 'كرتونة 25 كيلو', '25 kg carton', true, true, NULL, NULL, NULL, 9, NULL, NULL, NULL, NULL, '2026-04-28 02:40:25.861', '2026-04-28 02:40:25.861', 100);
INSERT INTO public."Product" VALUES (15, 'joory-vegetable-ghee-11kg-tin', 'سمنة نباتي جوري 11 كيلو صفيح', 'Joory Vegetable Ghee - 11kg Tin', 'سمنة نباتي جوري بجودة استثنائية ونكهة غنية، الخيار الأمثل للمطابخ الاحترافية لضمان قوام مثالي ومذاق لا يقاوم.', 'Joory vegetable ghee offers exceptional quality and rich flavor, making it the perfect choice for professional kitchens to ensure ideal texture and irresistible taste.', 'تعد سمنة جوري النباتية شريكك المثالي في الطهي والخبز، حيث تتميز بقوامها المتجانس وقدرتها العالية على تحمل درجات الحرارة المرتفعة، مما يجعلها مثالية للقلي والتحمير وإعداد الحلويات الشرقية الفاخرة. بفضل تركيبتها المتطورة، تمنح أطباقك نكهة غنية ورائحة زكية تعزز من جودة منتجاتك النهائية وتضمن رضا عملائك الدائم.
تأتي في عبوة صفيح اقتصادية بوزن 11 كيلو، مصممة خصيصاً لتلبية احتياجات المطاعم والفنادق وصناع الحلويات الكبار. تتميز بفترة صلاحية طويلة وسهولة في التخزين، كما أنها خالية من الكوليسترول، مما يوفر توازناً مثالياً بين الأداء المهني العالي والقيمة الغذائية المطلوبة في صناعة الأغذية الاحترافية.', 'Joory vegetable ghee is your ideal partner in cooking and baking, characterized by its consistent texture and high smoke point, which makes it perfect for frying, sautéing, and preparing premium oriental sweets. Thanks to its advanced formulation, it gives your dishes a rich flavor and aromatic scent that enhances the quality of your final products and ensures lasting customer satisfaction.
It comes in an economical 11kg tin, specifically designed to meet the needs of restaurants, hotels, and large-scale confectioners. It features a long shelf life and ease of storage, and is cholesterol-free, providing a perfect balance between high professional performance and the nutritional value required in the professional food industry.', NULL, NULL, '/uploads/upload_1777335835582_tcht5w.png', 780, 'صفيحة 11 كيلو', '11 kg weight plate ', true, true, NULL, NULL, NULL, 8, NULL, NULL, NULL, NULL, '2026-04-28 00:31:41.966', '2026-05-16 13:30:11.458', 99);


--
-- Data for Name: ProductCertification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductCertification" VALUES (83, 13, 'ISO 22000 (Food Safety Management)');
INSERT INTO public."ProductCertification" VALUES (84, 13, 'Halal Certified');
INSERT INTO public."ProductCertification" VALUES (85, 13, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (86, 13, 'SASO Quality Mark');
INSERT INTO public."ProductCertification" VALUES (91, 12, 'ISO 22000');
INSERT INTO public."ProductCertification" VALUES (92, 12, 'Halal Certified');
INSERT INTO public."ProductCertification" VALUES (93, 12, 'HACCP');
INSERT INTO public."ProductCertification" VALUES (94, 12, 'Quality Mark Certificate');
INSERT INTO public."ProductCertification" VALUES (95, 11, 'ISO 22000 (Food Safety Management)');
INSERT INTO public."ProductCertification" VALUES (96, 11, 'Halal Certification');
INSERT INTO public."ProductCertification" VALUES (97, 11, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (98, 11, 'Egyptian Food Safety Authority (NFSA)');
INSERT INTO public."ProductCertification" VALUES (99, 14, 'ISO 22000 (Food Safety Management)');
INSERT INTO public."ProductCertification" VALUES (100, 14, 'Halal Certified');
INSERT INTO public."ProductCertification" VALUES (101, 14, 'FDA Approved Facilities');
INSERT INTO public."ProductCertification" VALUES (102, 14, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (103, 15, 'ISO 22000 (Food Safety Management System)');
INSERT INTO public."ProductCertification" VALUES (104, 15, 'Halal Certification');
INSERT INTO public."ProductCertification" VALUES (105, 15, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (106, 15, 'Quality Assurance Certificate (ES)');
INSERT INTO public."ProductCertification" VALUES (111, 16, 'ISO 22000 (Food Safety Management System)');
INSERT INTO public."ProductCertification" VALUES (112, 16, 'Halal Certification');
INSERT INTO public."ProductCertification" VALUES (113, 16, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (114, 16, 'Quality Assurance Certificate (ES)');
INSERT INTO public."ProductCertification" VALUES (115, 17, 'ISO 22000 (Food Safety Management System)');
INSERT INTO public."ProductCertification" VALUES (116, 17, 'Halal Certification');
INSERT INTO public."ProductCertification" VALUES (117, 17, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (118, 17, 'Quality Assurance Certificate (ES)');
INSERT INTO public."ProductCertification" VALUES (123, 18, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (124, 18, 'FDA Approved');
INSERT INTO public."ProductCertification" VALUES (125, 18, 'Halal Certified');
INSERT INTO public."ProductCertification" VALUES (126, 18, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (127, 19, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (128, 19, 'FDA');
INSERT INTO public."ProductCertification" VALUES (129, 19, 'Halal');
INSERT INTO public."ProductCertification" VALUES (130, 19, 'HACCP');
INSERT INTO public."ProductCertification" VALUES (131, 20, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (132, 20, 'Halal');
INSERT INTO public."ProductCertification" VALUES (133, 20, 'FDA');
INSERT INTO public."ProductCertification" VALUES (54, 8, 'ISO 22000');
INSERT INTO public."ProductCertification" VALUES (55, 8, 'HACCP');
INSERT INTO public."ProductCertification" VALUES (56, 8, 'GMP');
INSERT INTO public."ProductCertification" VALUES (57, 8, 'شهادة حلال');
INSERT INTO public."ProductCertification" VALUES (58, 8, 'SASO');
INSERT INTO public."ProductCertification" VALUES (138, 21, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (139, 21, 'FDA Approved');
INSERT INTO public."ProductCertification" VALUES (140, 21, 'Halal Certified');
INSERT INTO public."ProductCertification" VALUES (141, 21, 'HACCP Certified');
INSERT INTO public."ProductCertification" VALUES (142, 22, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (143, 22, 'FDA');
INSERT INTO public."ProductCertification" VALUES (67, 10, 'Halal Certificate (شهادة حلال)');
INSERT INTO public."ProductCertification" VALUES (68, 10, 'ISO 22000 (Food Safety) (أيزو 22000 (سلامة الغذاء))');
INSERT INTO public."ProductCertification" VALUES (69, 10, 'SFDA/FDA Compliant (هيئة الغذاء والدواء)');
INSERT INTO public."ProductCertification" VALUES (70, 10, 'HACCP Certified (شهادة هاسب (HACCP))');
INSERT INTO public."ProductCertification" VALUES (144, 22, 'Halal');
INSERT INTO public."ProductCertification" VALUES (145, 23, 'ISO 9001');
INSERT INTO public."ProductCertification" VALUES (146, 23, 'FDA Approved');
INSERT INTO public."ProductCertification" VALUES (147, 23, 'Halal Certified');


--
-- Data for Name: ProductFeature; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductFeature" VALUES (96, 13, 'ثبات حراري فائق للقلي المستمر', 'Superior thermal stability for continuous frying');
INSERT INTO public."ProductFeature" VALUES (97, 13, 'امتصاص أقل للزيت لنتائج أخف', 'Lower oil absorption for lighter results');
INSERT INTO public."ProductFeature" VALUES (98, 13, 'خالٍ تماماً من الكوليسترول والدهون المتحولة', 'Zero cholesterol and trans fats');
INSERT INTO public."ProductFeature" VALUES (99, 13, 'غني بفيتامين E ومضادات الأكسدة الطبيعية', 'Rich in Vitamin E and natural antioxidants');
INSERT INTO public."ProductFeature" VALUES (100, 13, 'عمر افتراضي طويل وجودة مستقرة', 'Long shelf life with stable quality');
INSERT INTO public."ProductFeature" VALUES (106, 12, 'نقي وطبيعي 100% وخالٍ من الكوليسترول', '100% Pure, natural, and cholesterol-free');
INSERT INTO public."ProductFeature" VALUES (107, 12, 'غني بالأوميجا 3 وفيتامين هـ لتعزيز صحة القلب', 'Rich in Omega-3 and Vitamin E for heart health');
INSERT INTO public."ProductFeature" VALUES (108, 12, 'نقطة تدخين عالية تجعله مثاليًا للقلي والتحمير', 'High smoke point ideal for deep frying and searing');
INSERT INTO public."ProductFeature" VALUES (109, 12, 'خفيف على المعدة ولا يغير طعم المأكولات الأصلي', 'Light on the stomach and preserves the original food flavor');
INSERT INTO public."ProductFeature" VALUES (110, 12, 'تعبئة اقتصادية في كرتونة توفر قيمة ممتازة مقابل السعر', 'Economical carton packaging offering excellent value for money');
INSERT INTO public."ProductFeature" VALUES (111, 11, 'ثبات حراري فائق للقلي العميق', 'Superior thermal stability for deep frying');
INSERT INTO public."ProductFeature" VALUES (112, 11, 'خالٍ تماماً من الكوليسترول والدهون المتحولة', 'Completely free of cholesterol and trans fats');
INSERT INTO public."ProductFeature" VALUES (113, 11, 'امتصاص أقل للزيت لنتائج أخف وأكثر صحة', 'Lower oil absorption for lighter and healthier results');
INSERT INTO public."ProductFeature" VALUES (114, 11, 'غني بمضادات الأكسدة الطبيعية وفيتامين E', 'Rich in natural antioxidants and Vitamin E');
INSERT INTO public."ProductFeature" VALUES (115, 11, 'عمر افتراضي طويل مع جودة مستقرة', 'Long shelf life with stable quality performance');
INSERT INTO public."ProductFeature" VALUES (116, 14, 'نقطة دخان عالية مناسبة للقلي العميق', 'High smoke point ideal for deep frying');
INSERT INTO public."ProductFeature" VALUES (117, 14, 'خالي من الكوليسترول والدهون المتحولة', 'Cholesterol and trans-fat free');
INSERT INTO public."ProductFeature" VALUES (118, 14, 'عبوة اقتصادية موفرة سعة 3 لتر', 'Economical 3-liter value pack');
INSERT INTO public."ProductFeature" VALUES (119, 14, 'طعم محايد يحافظ على نكهة المكونات', 'Neutral taste that preserves ingredient flavors');
INSERT INTO public."ProductFeature" VALUES (120, 14, 'معزز بفيتامينات A و D', 'Fortified with Vitamins A and D');
INSERT INTO public."ProductFeature" VALUES (121, 15, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High thermal stability for frying and baking');
INSERT INTO public."ProductFeature" VALUES (122, 15, 'نكهة غنية ورائحة أصيلة تعزز المذاق', 'Rich flavor and authentic aroma to enhance taste');
INSERT INTO public."ProductFeature" VALUES (123, 15, 'خالية تماماً من الكوليسترول والدهون الحيوانية', '100% free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (124, 15, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for confectionery and flaky pastry production');
INSERT INTO public."ProductFeature" VALUES (125, 15, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Superior economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (131, 16, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High thermal stability for frying and baking');
INSERT INTO public."ProductFeature" VALUES (132, 16, 'نكهة غنية ورائحة أصيلة تعزز المذاق', 'Rich flavor and authentic aroma to enhance taste');
INSERT INTO public."ProductFeature" VALUES (133, 16, 'خالية تماماً من الكوليسترول والدهون الحيوانية', '100% free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (134, 16, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for confectionery and flaky pastry production');
INSERT INTO public."ProductFeature" VALUES (55, 8, 'ثبات حراري عالي مناسب للقلي العميق', 'High thermal stability for deep frying');
INSERT INTO public."ProductFeature" VALUES (56, 8, 'عمر استخدام طويل مقارنة بالزيوت التقليدية', 'Extended frying life');
INSERT INTO public."ProductFeature" VALUES (57, 8, 'طعم محايد لا يؤثر على نكهة الطعام', 'Neutral taste that preserves food flavor');
INSERT INTO public."ProductFeature" VALUES (58, 8, 'نسبة امتصاص منخفضة للطعام', 'Low oil absorption');
INSERT INTO public."ProductFeature" VALUES (59, 8, 'مقاومة للأكسدة وتكوّن الرغوة', 'Oxidation resistant & low foaming');
INSERT INTO public."ProductFeature" VALUES (60, 8, 'لون ذهبي نقي', 'Clear golden color');
INSERT INTO public."ProductFeature" VALUES (135, 16, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Superior economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (136, 17, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High thermal stability for frying and baking');
INSERT INTO public."ProductFeature" VALUES (137, 17, 'نكهة غنية ورائحة أصيلة تعزز المذاق', 'Rich flavor and authentic aroma to enhance taste');
INSERT INTO public."ProductFeature" VALUES (138, 17, 'خالية تماماً من الكوليسترول والدهون الحيوانية', '100% free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (139, 17, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for confectionery and flaky pastry production');
INSERT INTO public."ProductFeature" VALUES (140, 17, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Superior economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (71, 10, 'درجة احتراق عالية مثالية للقلي', 'High smoke point ideal for deep frying');
INSERT INTO public."ProductFeature" VALUES (72, 10, 'نكهة محايدة تحافظ على طعم المأكولات', 'Neutral flavor that preserves food taste');
INSERT INTO public."ProductFeature" VALUES (73, 10, 'غني بأحماض أوميجا 3 و 6 الصحية', 'Rich in healthy Omega-3 and Omega-6 fatty acids');
INSERT INTO public."ProductFeature" VALUES (74, 10, 'عبوة اقتصادية مخصصة للاستخدام التجاري', 'Economical packaging designed for commercial use');
INSERT INTO public."ProductFeature" VALUES (75, 10, 'خالٍ من الكوليسترول والدهون المتحولة', 'Free from cholesterol and trans fats');
INSERT INTO public."ProductFeature" VALUES (146, 18, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High stability at high temperatures');
INSERT INTO public."ProductFeature" VALUES (147, 18, 'نكهة غنية ورائحة أصيلة', 'Rich flavor and authentic aroma');
INSERT INTO public."ProductFeature" VALUES (148, 18, 'خالية تمامًا من الكوليسترول والدهون الحيوانية', 'Completely free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (149, 18, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for baking and making crispy pastries');
INSERT INTO public."ProductFeature" VALUES (150, 18, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Significant economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (151, 19, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High heat stability');
INSERT INTO public."ProductFeature" VALUES (152, 19, 'نكهة غنية ورائحة أصيلة', 'Rich flavor and authentic aroma');
INSERT INTO public."ProductFeature" VALUES (153, 19, 'خالية تمامًا من الكوليسترول والدهون الحيوانية', 'Cholesterol-free and animal fat-free');
INSERT INTO public."ProductFeature" VALUES (154, 19, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for baking and pastries');
INSERT INTO public."ProductFeature" VALUES (155, 19, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Exceptional cost savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (156, 20, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High stability at high temperatures');
INSERT INTO public."ProductFeature" VALUES (157, 20, 'نكهة غنية ورائحة أصيلة', 'Rich flavor and authentic aroma');
INSERT INTO public."ProductFeature" VALUES (158, 20, 'خالية تمامًا من الكوليسترول والدهون الحيوانية', 'Completely free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (159, 20, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for pastries and crispy baked goods');
INSERT INTO public."ProductFeature" VALUES (160, 20, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Superior economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (166, 21, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High stability at high temperatures');
INSERT INTO public."ProductFeature" VALUES (167, 21, 'نكهة غنية ورائحة أصيلة', 'Rich flavor and authentic aroma');
INSERT INTO public."ProductFeature" VALUES (168, 21, 'خالية تمامًا من الكوليسترول والدهون الحيوانية', 'Cholesterol-free and animal fat-free');
INSERT INTO public."ProductFeature" VALUES (169, 21, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for confectionery and crispy baked goods');
INSERT INTO public."ProductFeature" VALUES (170, 21, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Superior economic savings for large food establishments');
INSERT INTO public."ProductFeature" VALUES (171, 22, 'ثبات عالي عند درجات الحرارة المرتفعة', 'High stability at high temperatures');
INSERT INTO public."ProductFeature" VALUES (172, 22, 'نكهة غنية ورائحة أصيلة', 'Rich flavor and authentic aroma');
INSERT INTO public."ProductFeature" VALUES (173, 22, 'خالية تمامًا من الكوليسترول والدهون الحيوانية', 'Completely free from cholesterol and animal fats');
INSERT INTO public."ProductFeature" VALUES (174, 22, 'مثالية لصناعة الحلويات والمخبوزات الهشة', 'Ideal for confections and crispy pastries');
INSERT INTO public."ProductFeature" VALUES (175, 22, 'توفير اقتصادي فائق للمنشآت الغذائية الكبيرة', 'Exceptional economic value for large food establishments');
INSERT INTO public."ProductFeature" VALUES (176, 23, 'نتائج متسقة وعالية الجودة', 'Consistent and High-Quality Results');
INSERT INTO public."ProductFeature" VALUES (177, 23, 'سهل الاستخدام', 'Easy to Use');
INSERT INTO public."ProductFeature" VALUES (178, 23, 'حفظ طويل الأمد', 'Long Shelf Life');
INSERT INTO public."ProductFeature" VALUES (179, 23, 'مناسب للحلويات والمعجنات', 'Ideal for Pastries and Baked Goods');
INSERT INTO public."ProductFeature" VALUES (180, 23, 'خيار مثالي للمطاعم والمخابز', 'Perfect for Restaurants and Bakeries');


--
-- Data for Name: ProductImage; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductImage" VALUES (6, 8, '/uploads/upload_1777319006646_8o8zi2.jfif', NULL);
INSERT INTO public."ProductImage" VALUES (7, 8, '/uploads/upload_1777319189214_89ekip.jfif', NULL);
INSERT INTO public."ProductImage" VALUES (14, 10, '/uploads/upload_1777328880284_534xcd.jfif', NULL);
INSERT INTO public."ProductImage" VALUES (15, 10, '/uploads/upload_1777329137568_qt4uov.jfif', NULL);
INSERT INTO public."ProductImage" VALUES (26, 13, '/uploads/upload_1777332710908_ci5dyz.png', NULL);
INSERT INTO public."ProductImage" VALUES (27, 13, '/uploads/upload_1777332810066_jg07ub.png', NULL);
INSERT INTO public."ProductImage" VALUES (31, 12, '/uploads/upload_1777331696065_k68p6e.png', NULL);
INSERT INTO public."ProductImage" VALUES (32, 12, '/uploads/upload_1777331786857_di7kkf.png', NULL);
INSERT INTO public."ProductImage" VALUES (33, 12, '/uploads/upload_1777333086225_ll3ha1.png', NULL);
INSERT INTO public."ProductImage" VALUES (34, 11, '/uploads/upload_1777330224287_ds1jtz.jfif', NULL);
INSERT INTO public."ProductImage" VALUES (35, 11, '/uploads/upload_1777330626064_71lwm1.png', NULL);
INSERT INTO public."ProductImage" VALUES (36, 11, '/uploads/upload_1777330702313_704b0a.png', NULL);
INSERT INTO public."ProductImage" VALUES (37, 14, '/uploads/upload_1777334321121_zmzav8.png', NULL);
INSERT INTO public."ProductImage" VALUES (38, 14, '/uploads/upload_1777334322968_qh2rjk.png', NULL);
INSERT INTO public."ProductImage" VALUES (39, 15, '/uploads/upload_1777336055397_sofqj8.png', NULL);
INSERT INTO public."ProductImage" VALUES (40, 15, '/uploads/upload_1777336143124_7et9iz.png', NULL);
INSERT INTO public."ProductImage" VALUES (44, 16, '/uploads/upload_1777337363540_xwhhf4.png', NULL);
INSERT INTO public."ProductImage" VALUES (45, 16, '/uploads/upload_1777337444698_27sjhg.png', NULL);
INSERT INTO public."ProductImage" VALUES (46, 16, '/uploads/upload_1777337534690_tpgl3h.png', NULL);
INSERT INTO public."ProductImage" VALUES (47, 17, '/uploads/upload_1777338466164_9afeo9.png', NULL);
INSERT INTO public."ProductImage" VALUES (48, 17, '/uploads/upload_1777338644308_60434t.png', NULL);
INSERT INTO public."ProductImage" VALUES (49, 17, '/uploads/upload_1777338730503_exk2zi.png', NULL);
INSERT INTO public."ProductImage" VALUES (52, 18, '/uploads/upload_1777340489576_acsw9w.png', NULL);
INSERT INTO public."ProductImage" VALUES (53, 18, '/uploads/upload_1777340659248_d1u210.png', NULL);
INSERT INTO public."ProductImage" VALUES (54, 19, '/uploads/upload_1777340489576_acsw9w.png', NULL);
INSERT INTO public."ProductImage" VALUES (55, 19, '/uploads/upload_1777341364536_uq55cn.png', NULL);
INSERT INTO public."ProductImage" VALUES (56, 20, '/uploads/upload_1777341692025_7i222s.png', NULL);
INSERT INTO public."ProductImage" VALUES (57, 20, '/uploads/upload_1777341693744_sq43vl.png', NULL);
INSERT INTO public."ProductImage" VALUES (60, 21, '/uploads/upload_1777342105650_cvzrqe.png', NULL);
INSERT INTO public."ProductImage" VALUES (61, 21, '/uploads/upload_1777342107090_2rfvcf.png', NULL);
INSERT INTO public."ProductImage" VALUES (62, 22, '/uploads/upload_1777343394249_udgcy4.png', NULL);
INSERT INTO public."ProductImage" VALUES (63, 22, '/uploads/upload_1777343433000_4qit3u.png', NULL);
INSERT INTO public."ProductImage" VALUES (64, 23, '/uploads/upload_1777343976481_cxziao.png', NULL);
INSERT INTO public."ProductImage" VALUES (65, 23, '/uploads/upload_1777344009834_6xv5yo.png', NULL);


--
-- Data for Name: ProductPackaging; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductPackaging" VALUES (25, 8, 'جركن 18 كيلو', 'Gallon 18 Kg', 1180);
INSERT INTO public."ProductPackaging" VALUES (28, 10, '18 كيلو', '18 kilo', 1265);
INSERT INTO public."ProductPackaging" VALUES (33, 13, 'كرتونة 12 زجاجة * 935 جرام', 'Carton 12 bottles * 935 grams', 775);
INSERT INTO public."ProductPackaging" VALUES (35, 12, 'كرتونة 12 زجاجة ', 'Carton of 12 bottles', 670);
INSERT INTO public."ProductPackaging" VALUES (36, 11, 'كرتونة 12 زجاجة * 935 جرام', 'Carton 12 bottles * 935 grams', 775);
INSERT INTO public."ProductPackaging" VALUES (37, 14, '4 زجاجات * 2610 جرام', '4 bottles * 2610 grams', 745);
INSERT INTO public."ProductPackaging" VALUES (38, 15, 'صفحة 11 كيلو ', '11 kg weight plate ', 780);
INSERT INTO public."ProductPackaging" VALUES (40, 16, 'بستلة 11 كيلو ', '11 kg weight plate ', 740);
INSERT INTO public."ProductPackaging" VALUES (41, 17, 'صفيحة 1 كيلو ', '1 kg weight plate ', 780);
INSERT INTO public."ProductPackaging" VALUES (43, 18, 'برطمان 650', 'Jar 650', 280);
INSERT INTO public."ProductPackaging" VALUES (44, 19, 'برطمان 600 جرام ', '600 grams of butter', 260);
INSERT INTO public."ProductPackaging" VALUES (45, 20, 'برطمان 700 جرام ', '700 grams of butter', 300);
INSERT INTO public."ProductPackaging" VALUES (48, 21, 'كرتونة 6 برطمان ', '6 jar carton', 2880);
INSERT INTO public."ProductPackaging" VALUES (49, 22, 'كرتونة 6 برطمان ', '6 jar carton', 3090);


--
-- Data for Name: ProductSpec; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: PromoCode; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PromoCode" VALUES (1, 'TEST50', 'PERCENTAGE', 50, NULL, NULL, 0, true, NULL, '2026-04-21 19:10:08.555', '2026-04-21 19:10:08.555');
INSERT INTO public."PromoCode" VALUES (2, 'FIXED50', 'FIXED', 50, NULL, NULL, 2, true, NULL, '2026-04-21 19:11:12.641', '2026-04-21 19:24:02.075');


--
-- Data for Name: Promotion; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Quotation; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: QuotationItem; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ShippingZone; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ShippingZone" VALUES (1, 'القاهرة', 'Cairo', 50, true, '2026-04-21 18:36:06.298', '2026-04-21 18:36:06.298');
INSERT INTO public."ShippingZone" VALUES (2, 'الجيزة', 'Giza', 50, true, '2026-04-21 18:36:06.306', '2026-04-21 18:36:06.306');
INSERT INTO public."ShippingZone" VALUES (3, 'الإسكندرية', 'Alexandria', 70, true, '2026-04-21 18:36:06.308', '2026-04-21 18:36:06.308');
INSERT INTO public."ShippingZone" VALUES (4, 'القليوبية', 'Qalyubia', 60, true, '2026-04-21 18:36:06.309', '2026-04-21 18:36:06.309');
INSERT INTO public."ShippingZone" VALUES (5, 'الدقهلية', 'Dakahlia', 70, true, '2026-04-21 18:36:06.369', '2026-04-21 18:36:06.369');
INSERT INTO public."ShippingZone" VALUES (6, 'الشرقية', 'Sharqia', 70, true, '2026-04-21 18:36:06.37', '2026-04-21 18:36:06.37');
INSERT INTO public."ShippingZone" VALUES (7, 'الغربية', 'Gharbia', 70, true, '2026-04-21 18:36:06.371', '2026-04-21 18:36:06.371');
INSERT INTO public."ShippingZone" VALUES (8, 'المنوفية', 'Monufia', 70, true, '2026-04-21 18:36:06.373', '2026-04-21 18:36:06.373');
INSERT INTO public."ShippingZone" VALUES (9, 'البحيرة', 'Beheira', 75, true, '2026-04-21 18:36:06.374', '2026-04-21 18:36:06.374');
INSERT INTO public."ShippingZone" VALUES (10, 'كفر الشيخ', 'Kafr El Sheikh', 75, true, '2026-04-21 18:36:06.375', '2026-04-21 18:36:06.375');
INSERT INTO public."ShippingZone" VALUES (11, 'بورسعيد', 'Port Said', 80, true, '2026-04-21 18:36:06.376', '2026-04-21 18:36:06.376');
INSERT INTO public."ShippingZone" VALUES (12, 'دمياط', 'Damietta', 80, true, '2026-04-21 18:36:06.377', '2026-04-21 18:36:06.377');
INSERT INTO public."ShippingZone" VALUES (13, 'الإسماعيلية', 'Ismailia', 80, true, '2026-04-21 18:36:06.378', '2026-04-21 18:36:06.378');
INSERT INTO public."ShippingZone" VALUES (14, 'السويس', 'Suez', 80, true, '2026-04-21 18:36:06.379', '2026-04-21 18:36:06.379');
INSERT INTO public."ShippingZone" VALUES (15, 'الفيوم', 'Faiyum', 90, true, '2026-04-21 18:36:06.38', '2026-04-21 18:36:06.38');
INSERT INTO public."ShippingZone" VALUES (17, 'المنيا', 'Minya', 100, true, '2026-04-21 18:36:06.382', '2026-04-21 18:36:06.382');
INSERT INTO public."ShippingZone" VALUES (18, 'أسيوط', 'Assiut', 100, true, '2026-04-21 18:36:06.384', '2026-04-21 18:36:06.384');
INSERT INTO public."ShippingZone" VALUES (19, 'سوهاج', 'Sohag', 120, true, '2026-04-21 18:36:06.386', '2026-04-21 18:36:06.386');
INSERT INTO public."ShippingZone" VALUES (20, 'قنا', 'Qena', 120, true, '2026-04-21 18:36:06.388', '2026-04-21 18:36:06.388');
INSERT INTO public."ShippingZone" VALUES (21, 'الأقصر', 'Luxor', 150, true, '2026-04-21 18:36:06.389', '2026-04-21 18:36:06.389');
INSERT INTO public."ShippingZone" VALUES (22, 'أسوان', 'Aswan', 150, true, '2026-04-21 18:36:06.39', '2026-04-21 18:36:06.39');
INSERT INTO public."ShippingZone" VALUES (23, 'البحر الأحمر', 'Red Sea', 150, true, '2026-04-21 18:36:06.391', '2026-04-21 18:36:06.391');
INSERT INTO public."ShippingZone" VALUES (24, 'جنوب سيناء', 'South Sinai', 150, true, '2026-04-21 18:36:06.392', '2026-04-21 18:36:06.392');
INSERT INTO public."ShippingZone" VALUES (25, 'شمال سيناء', 'North Sinai', 150, true, '2026-04-21 18:36:06.393', '2026-04-21 18:36:06.393');
INSERT INTO public."ShippingZone" VALUES (26, 'الوادي الجديد', 'New Valley', 180, true, '2026-04-21 18:36:06.394', '2026-04-21 18:36:06.394');
INSERT INTO public."ShippingZone" VALUES (27, 'مطروح', 'Matrouh', 150, true, '2026-04-21 18:36:06.395', '2026-04-21 18:36:06.395');
INSERT INTO public."ShippingZone" VALUES (16, 'بني سويف', 'Beni Suef', 90, true, '2026-04-21 18:36:06.381', '2026-04-22 00:01:04.41');


--
-- Data for Name: SiteSettings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."SiteSettings" VALUES ('cmmokssh30002rtf0oyvuymjp', 'مصنع السلام للزيوت النباتية', 'Elsalam Vegetable Oils Factory', 'الريادة في إنتاج الزيوت النباتية والسمن النباتي منذ عام 2000', 'Leader in vegetable oil and ghee production since 2000', 'info@elsalamoil.com', '+201050051851', 'البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ', 'Beheira – Damanhur – Al-Abadiya – near the Colleges Complex', 'https://www.facebook.com/profile.php?id=61576731414550', NULL, 'https://instagram.com/elsalamoils', 'https://linkedin.com/company/elsalamoils', 'mail.elsalamoil.com', 465, 'it@elsalamoil.com', 'Asd@1029', 'it@elsalamoil.com', 'Elsalam Factory System it', 'ssl', '/uploads/upload_1773461572429_o147s8.png', '2026-03-13 07:29:05.32', '2026-05-04 05:16:53.98', NULL, 'mail.elsalamoil.com', 'Asd@1029', 993, 'tls', 'it@elsalamoil.com', 'مصنع السلام لعصر وإستخلاص الزيوت النباتية 00', '', true, '', '#15803d', '', 64, 'مصنع السلام لعصر وإستخلاص الزيوت النباتية', 'www.elsalamoil.com', NULL, NULL, NULL, 'pollinations', 'gemini', NULL);
INSERT INTO public."SiteSettings" VALUES ('default', 'مصنع السلام للزيوت النباتية', 'Elsalam Vegetable Oils Factory', 'الريادة في إنتاج الزيوت النباتية والسمن النباتي منذ عام 2000', 'Leader in vegetable oil and ghee production since 2000', 'info@elsalamoil.com', '+201050051851', 'البحيرة - دمنهور - الأبعادية - عند مجمع الكليات ', 'Beheira – Damanhur – Al-Abadiya – near the Colleges Complex', 'https://www.facebook.com/profile.php?id=61576731414550', NULL, NULL, NULL, 'mail.elsalamoil.com', 465, 'it@elsalamoil.com', 'Asd@1029', 'it@elsalamoil.com', 'Elsalam Factory System it', 'ssl', '/uploads/upload_1773461572429_o147s8.png', '2026-04-17 21:35:21.761', '2026-05-16 14:06:17.481', NULL, 'mail.elsalamoil.com', 'Asd@1029', 993, 'tls', 'it@elsalamoil.com', NULL, NULL, true, NULL, '#15803d', NULL, 64, 'Industrial High-Quality Oils & Fats', 'www.elsalamoils.com', 'AIzaSyBiJd3bnjp-DnennDlawc9LID9HTkyPIF8', '', '', 'pollinations', 'gemini', NULL);


--
-- Data for Name: TechnicalSpec; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."TechnicalSpec" VALUES (92, 13, 'نوع المنتج', 'Product Type', 'زيت أولين نخيل نقي', 'Pure Palm Olein Oil', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (93, 13, 'حجم العبوة', 'Package Size', '12 زجاجة × 700 مل', '12 Bottles x 700ml', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (94, 13, 'مدة الصلاحية', 'Shelf Life', '12 - 18 شهر من تاريخ الإنتاج', '12 - 18 Months from production', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (95, 13, 'ظروف التخزين', 'Storage Conditions', 'يحفظ في مكان بارد وجاف بعيداً عن الشمس', 'Store in a cool, dry place away from sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (101, 12, 'الحجم لكل زجاجة', 'Volume per bottle', '850 مل', '850 ml', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (102, 12, 'عدد الزجاجات', 'Number of bottles', '12 زجاجة في الكرتونة', '12 bottles per carton', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (103, 12, 'المكونات', 'Ingredients', 'زيت صويا نقي 100%', '100% Pure Soybean Oil', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (104, 12, 'مدة الصلاحية', 'Shelf Life', '12-18 شهرًا', '12-18 Months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (105, 12, 'التخزين', 'Storage', 'يحفظ في مكان بارد وجاف بعيداً عن الشمس', 'Store in a cool, dry place away from sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (106, 11, 'حجم الزجاجة', 'Bottle Size', '1 لتر', '1 Liter', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (107, 11, 'الكمية في الكرتونة', 'Case Quantity', '12 زجاجة', '12 Bottles', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (108, 11, 'مدة الصلاحية', 'Shelf Life', '12 - 18 شهر', '12 - 18 Months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (109, 11, 'المكونات', 'Ingredients', 'زيت أولين نخيل مكرر نقي', 'Pure Refined Palm Olein Oil', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (110, 11, 'بلد المنشأ', 'Country of Origin', 'مصر / ماليزيا (حسب الدفعة)', 'Egypt / Malaysia (Subject to batch)', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (111, 14, 'الحجم', 'Volume', '3 لتر', '3 Liters', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (112, 14, 'المكونات', 'Ingredients', 'مزيج من زيوت نباتية نقية (دوار الشمس، صويا، أولين النخيل)', 'Blend of pure vegetable oils (Sunflower, Soy, Palm Olein)', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (113, 14, 'مدة الصلاحية', 'Shelf Life', '12-18 شهر من تاريخ الإنتاج', '12-18 months from production date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (114, 14, 'ظروف التخزين', 'Storage Conditions', 'يُحفظ في مكان بارد وجاف بعيداً عن أشعة الشمس المباشرة', 'Store in a cool, dry place away from direct sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (115, 15, 'الوزن الصافي', 'Net Weight', '11 كيلوجرام', '11 kg', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (116, 15, 'نوع التغليف', 'Packaging Type', 'عبوة صفيح محكمة الإغلاق', 'Hermetically sealed metal tin', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (117, 15, 'المكونات الأساسية', 'Main Ingredients', 'زيوت نباتية نقية، نكهة السمن الطبيعي', 'Pure vegetable oils, natural ghee flavor', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (118, 15, 'مدة الصلاحية', 'Shelf Life', '18 شهراً من تاريخ الإنتاج', '18 months from production date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (119, 15, 'ظروف التخزين', 'Storage Conditions', 'يُحفظ في مكان بارد وجاف بعيداً عن أشعة الشمس', 'Store in a cool, dry place away from direct sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (49, 8, 'النوع', 'Refined Vegetable Olein Oil', 'زيت أولين نباتي مكرر', 'Type', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (50, 8, 'الوزن الصافي', '18 KG', '18 كجم', 'Net Weight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (51, 8, 'اللون', 'Light golden', 'ذهبي فاتح', 'Color', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (52, 8, 'الرائحة', 'Nearly odorless', 'عديم الرائحة تقريباً', 'Odor', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (53, 8, 'نقطة التدخين', 'High (Approx. 220–230°C)', 'مرتفعة (تقريباً 220–230°C)', 'Smoke Point', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (54, 8, 'نسبة الأحماض الدهنية الحرة', '≤ 0.1%', '≤ 0.1%', 'Free Fatty Acids', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (55, 8, 'التعبئة', 'Packaging', 'جركن بلاستيك غذائي عالي الجودة', 'Food-grade plastic jerry can', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (56, 8, 'مدة الصلاحية', 'Shelf Life', '12–18 شهر', '12–18 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (125, 16, 'الوزن الصافي', 'Net Weight', '11 كيلوجرام', '11 kg', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (126, 16, 'نوع التغليف', 'Packaging Type', 'عبوة صفيح محكمة الإغلاق', 'Hermetically sealed metal tin', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (127, 16, 'المكونات الأساسية', 'Main Ingredients', 'زيوت نباتية نقية، نكهة السمن الطبيعي', 'Pure vegetable oils, natural ghee flavor', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (128, 16, 'مدة الصلاحية', 'Shelf Life', '18 شهراً من تاريخ الإنتاج', '18 months from production date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (129, 16, 'ظروف التخزين', 'Storage Conditions', 'يُحفظ في مكان بارد وجاف بعيداً عن أشعة الشمس', 'Store in a cool, dry place away from direct sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (67, 10, 'الوزن الصافي', 'Net Weight', '18 كيلوجرام', '18 kg', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (68, 10, 'المكونات', 'Ingredients', 'زيت صويا نقي 100%', '100% Pure Soybean Oil', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (69, 10, 'مدة الصلاحية', 'Shelf Life', '12 شهر من تاريخ الإنتاج', '12 months from production date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (70, 10, 'نوع العبوة', 'Packaging Type', 'جركن بلاستيكي عالي الجودة', 'High-quality plastic jerrycan', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (71, 10, 'ظروف التخزين', 'Storage Conditions', 'يُحفظ في مكان بارد وجاف بعيداً عن الشمس', 'Store in a cool, dry place away from sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (130, 17, 'الوزن الصافي', 'Net Weight', '700 جرام', '700 Gram', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (131, 17, 'نوع التغليف', 'Packaging Type', 'عبوة صفيح محكمة الإغلاق', 'Hermetically sealed metal tin', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (132, 17, 'المكونات الأساسية', 'Main Ingredients', 'زيوت نباتية نقية، نكهة السمن الطبيعي', 'Pure vegetable oils, natural ghee flavor', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (133, 17, 'مدة الصلاحية', 'Shelf Life', '18 شهراً من تاريخ الإنتاج', '18 months from production date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (134, 17, 'ظروف التخزين', 'Storage Conditions', 'يُحفظ في مكان بارد وجاف بعيداً عن أشعة الشمس', 'Store in a cool, dry place away from direct sunlight', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (139, 18, 'الوزن', 'Weight', '650 جرام', '650 grams', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (140, 18, 'مدة الصلاحية', 'Shelf Life', '18 شهرًا', '18 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (141, 18, 'المكونات', 'Ingredients', 'زيوت نباتية، ماء، ملح، حمض الليمون، مثبتات طبيعية', 'Vegetable oils, water, salt, lemon juice, natural stabilizers', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (142, 18, 'الحزمة', 'Packaging', 'كرتونة تحتوي على برطمان', 'Carton containing one jar', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (143, 19, 'الوزن', 'Weight', '600 جرام', '600 grams', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (144, 19, 'مدة الصلاحية', 'Shelf Life', '18 شهرًا', '18 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (145, 19, 'المكونات', 'Ingredients', 'زيوت نباتية، ماء، ملح، حمض الليمون، فيتامين E', 'Vegetable oils, water, salt, lemon juice, Vitamin E', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (146, 19, 'التعبئة', 'Packaging', 'كرتونة برطمان', 'Carton with jar', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (147, 20, 'الوزن', 'Weight', '700 جرام', '700 grams', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (148, 20, 'مدة الصلاحية', 'Shelf Life', '24 شهرًا', '24 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (149, 20, 'المكونات', 'Ingredients', 'زيوت نباتية مهدرجة', 'Hydrogenated vegetable oils', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (150, 20, 'الحالة', 'Form', 'صلبة', 'Solid', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (155, 21, 'الوزن', 'Weight', '1150 جرام', '1150 grams', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (156, 21, 'مدة الصلاحية', 'Shelf Life', '18 شهرًا من تاريخ التصنيع', '18 months from manufacturing date', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (157, 21, 'المكونات', 'Ingredients', 'زيوت نباتية، ماء، ملح، مستحلبات، نكهات طبيعية', 'Vegetable oils, water, salt, emulsifiers, natural flavors', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (158, 21, 'التعبئة', 'Packaging', 'كرتونة تحتوي على برطمان واحد', 'Carton containing one jar', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (159, 22, 'الوزن', 'Weight', '1250 جرام', '1250 grams', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (160, 22, 'مدة الصلاحية', 'Shelf Life', '18 شهرًا', '18 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (161, 22, 'المكونات', 'Ingredients', 'زيوت نباتية مكررة، ماء، ملح، حليب مجفف', 'Refined vegetable oils, water, salt, dried milk', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (162, 22, 'الحجم', 'Packaging', 'برطمان', 'Jar', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (163, 23, 'الوزن', 'Weight', '25 كيلوغرام', '25 kg', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (164, 23, 'مدة الصلاحية', 'Shelf Life', '18 شهر', '18 months', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (165, 23, 'المكونات', 'Ingredients', 'زيوت نباتية مهدرجة', 'Hydrogenated Vegetable Oils', NULL, NULL);
INSERT INTO public."TechnicalSpec" VALUES (166, 23, 'الحجم', 'Packaging', 'كرتونة', 'Carton', NULL, NULL);


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."User" VALUES ('cmmokssfm0001rtf0sdndqttp', 'Admin User', 'admin@elsalam.com', NULL, NULL, '$2b$12$yjiH03zxD.8aTy8Ih8JkmuFqQaFkvhw8/ewj9mWyT1GwqycWdJogy', 'ADMIN', '2026-03-13 07:29:05.266', '2026-03-13 07:29:05.266');


--
-- Data for Name: WebOrder; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."WebOrder" VALUES (25, 'زكي السيد زكي', NULL, '01501750002', 'Beheira', 'Damanhour', 'الشارع المعهد الديني', 855, 'PROCESSING', '2026-05-16 13:30:11.585', '2026-05-16 13:32:51.596', 'COD', 75, NULL, 0, NULL, NULL, false);
INSERT INTO public."WebOrder" VALUES (7, 'محمد الشباسي', 'admin@elsalam.com', '01013713596', 'Cairo', NULL, 'البحيرة دمنهور شارع المعهد الديني', 3630, 'SHIPPED', '2026-04-21 22:45:25.387', '2026-05-17 14:24:28.439', 'COD', 100, NULL, 10, NULL, 'مصاريف شحن زيادة', false);


--
-- Data for Name: WebOrderItem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."WebOrderItem" VALUES (33, 7, 8, 1, 1180, 1180);
INSERT INTO public."WebOrderItem" VALUES (34, 7, 8, 2, 1180, 2360);
INSERT INTO public."WebOrderItem" VALUES (36, 25, 15, 1, 780, 780);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public._prisma_migrations VALUES ('c906140a-d5f1-40fb-a7e8-752dff06d4cd', '12275ddf59009a6b171c63b56ee0d2be36f5a7f1569374e2ff2bea9f976e0e84', '2026-04-17 17:05:42.045004+02', '20260417150541_init_postgres', NULL, NULL, '2026-04-17 17:05:41.963749+02', 1);
INSERT INTO public._prisma_migrations VALUES ('b6a93da0-b589-4e7b-9dcb-7ed4fe51b2c6', 'a371b0e6b5fcaecbd3e16667f15c037f5e1dc11b91e07a26478c9dbd757b0523', '2026-04-18 14:40:51.512307+02', '20260418124051_add_google_analytics_id', NULL, NULL, '2026-04-18 14:40:51.510133+02', 1);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 10, true);


--
-- Name: ClientContact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ClientContact_id_seq"', 5, true);


--
-- Name: ClientInteraction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ClientInteraction_id_seq"', 1, true);


--
-- Name: ClientOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ClientOrder_id_seq"', 3, true);


--
-- Name: ClientPayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ClientPayment_id_seq"', 1, false);


--
-- Name: Client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Client_id_seq"', 4, true);


--
-- Name: Message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Message_id_seq"', 9, true);


--
-- Name: News_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."News_id_seq"', 14, true);


--
-- Name: OrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderItem_id_seq"', 8, true);


--
-- Name: ProductCertification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCertification_id_seq"', 147, true);


--
-- Name: ProductFeature_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductFeature_id_seq"', 180, true);


--
-- Name: ProductImage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductImage_id_seq"', 65, true);


--
-- Name: ProductPackaging_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductPackaging_id_seq"', 49, true);


--
-- Name: ProductSpec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductSpec_id_seq"', 14, true);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 23, true);


--
-- Name: PromoCode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PromoCode_id_seq"', 2, true);


--
-- Name: Promotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Promotion_id_seq"', 3, true);


--
-- Name: ShippingZone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ShippingZone_id_seq"', 27, true);


--
-- Name: TechnicalSpec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."TechnicalSpec_id_seq"', 166, true);


--
-- Name: WebOrderItem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."WebOrderItem_id_seq"', 36, true);


--
-- Name: WebOrder_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."WebOrder_id_seq"', 25, true);


--
-- Name: CartItem CartItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_pkey" PRIMARY KEY (id);


--
-- Name: Cart Cart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: ClientContact ClientContact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientContact"
    ADD CONSTRAINT "ClientContact_pkey" PRIMARY KEY (id);


--
-- Name: ClientInteraction ClientInteraction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientInteraction"
    ADD CONSTRAINT "ClientInteraction_pkey" PRIMARY KEY (id);


--
-- Name: ClientOrder ClientOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientOrder"
    ADD CONSTRAINT "ClientOrder_pkey" PRIMARY KEY (id);


--
-- Name: ClientPayment ClientPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientPayment"
    ADD CONSTRAINT "ClientPayment_pkey" PRIMARY KEY (id);


--
-- Name: Client Client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY (id);


--
-- Name: Message Message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Message"
    ADD CONSTRAINT "Message_pkey" PRIMARY KEY (id);


--
-- Name: News News_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."News"
    ADD CONSTRAINT "News_pkey" PRIMARY KEY (id);


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- Name: OutboxEvent OutboxEvent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OutboxEvent"
    ADD CONSTRAINT "OutboxEvent_pkey" PRIMARY KEY (id);


--
-- Name: PageContentHistory PageContentHistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PageContentHistory"
    ADD CONSTRAINT "PageContentHistory_pkey" PRIMARY KEY (id);


--
-- Name: PageContent PageContent_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PageContent"
    ADD CONSTRAINT "PageContent_pkey" PRIMARY KEY (id);


--
-- Name: ProductCertification ProductCertification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCertification"
    ADD CONSTRAINT "ProductCertification_pkey" PRIMARY KEY (id);


--
-- Name: ProductFeature ProductFeature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductFeature"
    ADD CONSTRAINT "ProductFeature_pkey" PRIMARY KEY (id);


--
-- Name: ProductImage ProductImage_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_pkey" PRIMARY KEY (id);


--
-- Name: ProductPackaging ProductPackaging_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductPackaging"
    ADD CONSTRAINT "ProductPackaging_pkey" PRIMARY KEY (id);


--
-- Name: ProductSpec ProductSpec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductSpec"
    ADD CONSTRAINT "ProductSpec_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: PromoCode PromoCode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PromoCode"
    ADD CONSTRAINT "PromoCode_pkey" PRIMARY KEY (id);


--
-- Name: Promotion Promotion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Promotion"
    ADD CONSTRAINT "Promotion_pkey" PRIMARY KEY (id);


--
-- Name: QuotationItem QuotationItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuotationItem"
    ADD CONSTRAINT "QuotationItem_pkey" PRIMARY KEY (id);


--
-- Name: Quotation Quotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Quotation"
    ADD CONSTRAINT "Quotation_pkey" PRIMARY KEY (id);


--
-- Name: ShippingZone ShippingZone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ShippingZone"
    ADD CONSTRAINT "ShippingZone_pkey" PRIMARY KEY (id);


--
-- Name: SiteSettings SiteSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SiteSettings"
    ADD CONSTRAINT "SiteSettings_pkey" PRIMARY KEY (id);


--
-- Name: TechnicalSpec TechnicalSpec_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TechnicalSpec"
    ADD CONSTRAINT "TechnicalSpec_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: WebOrderItem WebOrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrderItem"
    ADD CONSTRAINT "WebOrderItem_pkey" PRIMARY KEY (id);


--
-- Name: WebOrder WebOrder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrder"
    ADD CONSTRAINT "WebOrder_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: CartItem_cartId_productId_weightVariant_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "CartItem_cartId_productId_weightVariant_key" ON public."CartItem" USING btree ("cartId", "productId", "weightVariant");


--
-- Name: Cart_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Cart_userId_key" ON public."Cart" USING btree ("userId");


--
-- Name: Category_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Category_slug_key" ON public."Category" USING btree (slug);


--
-- Name: ClientInteraction_clientId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ClientInteraction_clientId_idx" ON public."ClientInteraction" USING btree ("clientId");


--
-- Name: ClientInteraction_repId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ClientInteraction_repId_idx" ON public."ClientInteraction" USING btree ("repId");


--
-- Name: ClientPayment_clientId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ClientPayment_clientId_idx" ON public."ClientPayment" USING btree ("clientId");


--
-- Name: ClientPayment_repId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "ClientPayment_repId_idx" ON public."ClientPayment" USING btree ("repId");


--
-- Name: Client_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Client_createdAt_idx" ON public."Client" USING btree ("createdAt");


--
-- Name: Client_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Client_name_idx" ON public."Client" USING btree (name);


--
-- Name: Client_repId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Client_repId_idx" ON public."Client" USING btree ("repId");


--
-- Name: Client_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Client_status_idx" ON public."Client" USING btree (status);


--
-- Name: News_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "News_slug_key" ON public."News" USING btree (slug);


--
-- Name: PageContentHistory_pageSlug_savedAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PageContentHistory_pageSlug_savedAt_idx" ON public."PageContentHistory" USING btree ("pageSlug", "savedAt");


--
-- Name: PageContent_pageSlug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PageContent_pageSlug_key" ON public."PageContent" USING btree ("pageSlug");


--
-- Name: Product_activePromotionId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Product_activePromotionId_key" ON public."Product" USING btree ("activePromotionId");


--
-- Name: Product_categoryId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Product_categoryId_idx" ON public."Product" USING btree ("categoryId");


--
-- Name: Product_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Product_createdAt_idx" ON public."Product" USING btree ("createdAt");


--
-- Name: Product_is_featured_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Product_is_featured_idx" ON public."Product" USING btree (is_featured);


--
-- Name: Product_name_ar_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Product_name_ar_idx" ON public."Product" USING btree (name_ar);


--
-- Name: Product_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Product_slug_key" ON public."Product" USING btree (slug);


--
-- Name: Product_stock_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Product_stock_idx" ON public."Product" USING btree (stock);


--
-- Name: PromoCode_code_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "PromoCode_code_key" ON public."PromoCode" USING btree (code);


--
-- Name: PromoCode_isActive_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "PromoCode_isActive_idx" ON public."PromoCode" USING btree ("isActive");


--
-- Name: QuotationItem_quotationId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "QuotationItem_quotationId_idx" ON public."QuotationItem" USING btree ("quotationId");


--
-- Name: Quotation_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Quotation_status_idx" ON public."Quotation" USING btree (status);


--
-- Name: Quotation_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Quotation_userId_idx" ON public."Quotation" USING btree ("userId");


--
-- Name: ShippingZone_name_ar_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ShippingZone_name_ar_key" ON public."ShippingZone" USING btree (name_ar);


--
-- Name: ShippingZone_name_en_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "ShippingZone_name_en_key" ON public."ShippingZone" USING btree (name_en);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: WebOrder_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "WebOrder_createdAt_idx" ON public."WebOrder" USING btree ("createdAt");


--
-- Name: WebOrder_isQuotation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "WebOrder_isQuotation_idx" ON public."WebOrder" USING btree ("isQuotation");


--
-- Name: WebOrder_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "WebOrder_status_idx" ON public."WebOrder" USING btree (status);


--
-- Name: WebOrder_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "WebOrder_userId_idx" ON public."WebOrder" USING btree ("userId");


--
-- Name: CartItem CartItem_cartId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_cartId_fkey" FOREIGN KEY ("cartId") REFERENCES public."Cart"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CartItem CartItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Cart Cart_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClientContact ClientContact_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientContact"
    ADD CONSTRAINT "ClientContact_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClientInteraction ClientInteraction_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientInteraction"
    ADD CONSTRAINT "ClientInteraction_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClientInteraction ClientInteraction_repId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientInteraction"
    ADD CONSTRAINT "ClientInteraction_repId_fkey" FOREIGN KEY ("repId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ClientOrder ClientOrder_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientOrder"
    ADD CONSTRAINT "ClientOrder_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClientOrder ClientOrder_repId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientOrder"
    ADD CONSTRAINT "ClientOrder_repId_fkey" FOREIGN KEY ("repId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ClientPayment ClientPayment_clientId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientPayment"
    ADD CONSTRAINT "ClientPayment_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES public."Client"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ClientPayment ClientPayment_repId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ClientPayment"
    ADD CONSTRAINT "ClientPayment_repId_fkey" FOREIGN KEY ("repId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Client Client_repId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Client"
    ADD CONSTRAINT "Client_repId_fkey" FOREIGN KEY ("repId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."ClientOrder"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: ProductCertification ProductCertification_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCertification"
    ADD CONSTRAINT "ProductCertification_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductFeature ProductFeature_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductFeature"
    ADD CONSTRAINT "ProductFeature_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductImage ProductImage_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductImage"
    ADD CONSTRAINT "ProductImage_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductPackaging ProductPackaging_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductPackaging"
    ADD CONSTRAINT "ProductPackaging_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductSpec ProductSpec_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductSpec"
    ADD CONSTRAINT "ProductSpec_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Promotion Promotion_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Promotion"
    ADD CONSTRAINT "Promotion_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuotationItem QuotationItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuotationItem"
    ADD CONSTRAINT "QuotationItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: QuotationItem QuotationItem_quotationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."QuotationItem"
    ADD CONSTRAINT "QuotationItem_quotationId_fkey" FOREIGN KEY ("quotationId") REFERENCES public."Quotation"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Quotation Quotation_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Quotation"
    ADD CONSTRAINT "Quotation_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TechnicalSpec TechnicalSpec_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TechnicalSpec"
    ADD CONSTRAINT "TechnicalSpec_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WebOrderItem WebOrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrderItem"
    ADD CONSTRAINT "WebOrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."WebOrder"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WebOrderItem WebOrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrderItem"
    ADD CONSTRAINT "WebOrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: WebOrder WebOrder_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."WebOrder"
    ADD CONSTRAINT "WebOrder_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict eja69asnIjFi0kwkAYfx89dM1HId8kUK0bc8M9QmeJmuthJrOrwYvMxJHmefaED

