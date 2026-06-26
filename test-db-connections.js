const { Client } = require('pg');

async function testConnection(url) {
    const client = new Client({ connectionString: url });
    try {
        await client.connect();
        const res = await client.query("SELECT tablename FROM pg_tables WHERE schemaname='public' LIMIT 5");
        console.log(`\nSUCCESS: Connected to ${url}`);
        console.log(`Tables: ${res.rows.map(r => r.tablename).join(', ')}`);
        await client.end();
        return true;
    } catch (err) {
        console.log(`\nFAILED: ${url}`);
        console.log(`Error: ${err.message}`);
        return false;
    }
}

async function main() {
    const urls = [
        "postgresql://postgres:postgres@localhost:5433/elsalam_db",
        "postgresql://postgres@localhost:5432/elsalam_db",
        "postgresql://postgres:postgres@localhost:5432/elsalam_db",
        "postgresql://postgres:root@localhost:5432/elsalam_db"
    ];
    for (const url of urls) {
        await testConnection(url);
    }
}
main();
