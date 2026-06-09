-- AI Solutions Inquiry Management System
-- PostgreSQL Database Schema

CREATE TABLE IF NOT EXISTS admins (
  id SERIAL PRIMARY KEY,
  username VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS inquiries (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(30),
  company VARCHAR(150),
  country VARCHAR(100),
  job_title VARCHAR(150),
  job_details TEXT NOT NULL,
  ai_response TEXT,
  admin_reply TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Content management tables
CREATE TABLE IF NOT EXISTS posts (
  id SERIAL PRIMARY KEY,
  page VARCHAR(50) NOT NULL, -- 'home', 'solutions', 'events', 'blog', 'casestudies', 'testimonials', 'gallery'
  title VARCHAR(255) NOT NULL,
  content TEXT,
  image_url TEXT,
  author VARCHAR(150),
  rating INTEGER DEFAULT 5,
  extra VARCHAR(500), -- for extra info like date, category, client name etc.
  published BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- If upgrading from old schema run these:
-- ALTER TABLE inquiries ADD COLUMN IF NOT EXISTS admin_reply TEXT;
-- ALTER TABLE posts ALTER COLUMN image_url TYPE TEXT;
-- CREATE TABLE IF NOT EXISTS posts (...);
