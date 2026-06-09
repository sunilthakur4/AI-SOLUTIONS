const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
require('dotenv').config({ path: path.join(__dirname, '.env') });

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'yourpassword',
  database: process.env.DB_NAME || 'ai_solutions',
  port: process.env.DB_PORT || 5432,
});

async function seedContent() {
  const sqlPath = path.join(__dirname, '..', 'database', 'seed_content.sql');
  const sql = fs.readFileSync(sqlPath, 'utf8');
  await pool.query(sql);
  const result = await pool.query('SELECT page, COUNT(*)::int AS count FROM posts GROUP BY page ORDER BY page');
  console.table(result.rows);
}

seedContent()
  .then(() => {
    console.log('Website content seed complete.');
  })
  .catch((err) => {
    console.error('Website content seed failed:', err.message);
    process.exitCode = 1;
  })
  .finally(() => pool.end());
