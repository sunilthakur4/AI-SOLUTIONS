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

async function checkContent() {
  const pages = ['home', 'solutions', 'events', 'blog', 'casestudies', 'testimonials', 'gallery'];
  const postCounts = await pool.query(
    `SELECT page, COUNT(*)::int AS count
     FROM posts
     WHERE published = TRUE AND page = ANY($1)
     GROUP BY page
     ORDER BY page`,
    [pages]
  );
  const inquiryCount = await pool.query('SELECT COUNT(*)::int AS count FROM inquiries');
  const pastEvents = await pool.query(
    `SELECT COUNT(*)::int AS count
     FROM posts
     WHERE page = 'events' AND title ILIKE 'Completed:%' AND published = TRUE`
  );

  console.table(postCounts.rows);
  console.log(`inquiries: ${inquiryCount.rows[0].count}`);
  console.log(`past events: ${pastEvents.rows[0].count}`);
}

checkContent()
  .catch((err) => {
    console.error('Content check failed:', err.message);
    process.exitCode = 1;
  })
  .finally(() => pool.end());
