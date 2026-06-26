# Elsalam Website - cPanel Deployment Instructions

Follow these strict instructions to deploy your Next.js application on a cPanel environment with 1GB RAM and PostgreSQL.

## Prerequisites
1. **Node.js App Manager**: Ensure your cPanel has the "Setup Node.js App" feature.
2. **PostgreSQL**: Ensure you have created a PostgreSQL database in cPanel.

## Step 1: Database Import
1. Open **phpPgAdmin** (or use command line if available).
2. Select your newly created empty database.
3. Import the `current-live-database.sql` file included in this zip. This will restore all your live data, sessions, and configurations perfectly.

## Step 2: Extract Files
1. Open the cPanel **File Manager**.
2. Upload `elsalam-cpanel-deploy.zip` to your application folder (e.g., `/home/username/elsalam-app`). Do NOT upload directly to `public_html`.
3. Extract the ZIP archive.

## Step 3: Setup Node.js App
1. Go to **Setup Node.js App** in cPanel.
2. Click **Create Application**.
3. Set the following:
   - **Node.js version:** `20.x.x`
   - **Application mode:** `Production`
   - **Application root:** The folder where you extracted the files (e.g., `elsalam-app`).
   - **Application URL:** Your live domain.
   - **Application startup file:** `server.js`
4. Click **Create**.

## Step 4: Environment Variables
Scroll down to the **Environment variables** section and add the following STRICTLY matching your live credentials:

- `DATABASE_URL`: `postgresql://db_user:db_password@localhost:5432/db_name` (Update to match your cPanel Postgres credentials).
- `NEXTAUTH_SECRET`: Copy your existing secret here.
- `NEXTAUTH_URL`: Your live domain (e.g., `https://www.elsalam.com`).
- `NEXT_PUBLIC_API_URL`: Your live domain API route (e.g., `https://www.elsalam.com/api/public`).

## Step 5: Start Application
1. Click the **Start** (or Restart) button in the Node.js App interface.
2. The site is now live! Background jobs will process via the DB queues safely.
3. **IMPORTANT CRON JOB:** Go to the cPanel "Cron Jobs" section and add the following command to run **Every Minute**:
   `curl -s https://yourdomain.com/api/public/ping > /dev/null`
   *(This ensures background jobs like emails are processed reliably).*
