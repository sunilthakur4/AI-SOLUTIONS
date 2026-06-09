const express = require('express');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { Pool } = require('pg');
const nodemailer = require('nodemailer');
const axios = require('axios');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'yourpassword',
  database: process.env.DB_NAME || 'ai_solutions',
  port: process.env.DB_PORT || 5432,
});

const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key';
const NVIDIA_API_KEY = process.env.NVIDIA_API_KEY || '';
const RECAPTCHA_SECRET = process.env.RECAPTCHA_SECRET || '';

function createMailTransporter() {
  if (!process.env.ADMIN_EMAIL || !process.env.ADMIN_EMAIL_PASSWORD) return null;
  return nodemailer.createTransport({
    service: 'gmail',
    auth: { user: process.env.ADMIN_EMAIL, pass: process.env.ADMIN_EMAIL_PASSWORD }
  });
}

function escapeHtml(value) {
  return String(value)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}

async function sendInquiryReceivedEmail({ name, email, jobDetails }) {
  const transporter = createMailTransporter();
  if (!transporter) {
    console.warn('Inquiry receipt email skipped: ADMIN_EMAIL or ADMIN_EMAIL_PASSWORD is not configured.');
    return;
  }

  await transporter.sendMail({
    from: `"AI-Solutions" <${process.env.ADMIN_EMAIL}>`,
    to: email,
    subject: 'We received your inquiry - AI-Solutions',
    html: `<div style="font-family:Arial,sans-serif;max-width:620px;margin:0 auto;color:#1a1a2e;">
      <div style="background:#101828;padding:22px;text-align:center;">
        <h2 style="color:#22d3ee;margin:0;">AI-Solutions</h2>
      </div>
      <div style="padding:30px;background:#f8fafc;">
        <p>Dear <strong>${escapeHtml(name)}</strong>,</p>
        <p>Thank you for contacting AI-Solutions. We have received your inquiry and our team will review it shortly.</p>
        <div style="background:#ffffff;border-left:4px solid #22d3ee;padding:16px;margin:20px 0;border-radius:4px;">
          <p style="margin:0 0 8px;font-weight:bold;">Your inquiry:</p>
          <p style="margin:0;">${escapeHtml(jobDetails).replace(/\n/g, '<br/>')}</p>
        </div>
        <p>We will get back to you as soon as possible with the next steps.</p>
        <p>Best regards,<br/><strong>AI-Solutions Team</strong></p>
      </div>
      <div style="background:#101828;padding:15px;text-align:center;">
        <p style="color:#cbd5e1;margin:0;">&copy; 2026 AI-Solutions. All rights reserved.</p>
      </div>
    </div>`
  });
}

// =====================
// MIDDLEWARE
// =====================
function verifyToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Access denied' });
  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.status(403).json({ message: 'Invalid token' });
    req.user = user;
    next();
  });
}

// Verify Google reCAPTCHA v3
async function verifyRecaptcha(token, expectedAction) {
  try {
    if (!RECAPTCHA_SECRET) return { valid: true }; // Skip if not configured
    if (!token) return { valid: false, reason: 'missing-token' };
    const params = new URLSearchParams();
    params.append('secret', RECAPTCHA_SECRET);
    params.append('response', token);
    const res = await axios.post('https://www.google.com/recaptcha/api/siteverify', params);
    const scoreThreshold = Number(process.env.RECAPTCHA_MIN_SCORE || 0.3);
    const actionMatches = !expectedAction || res.data.action === expectedAction;
    const scorePasses = typeof res.data.score === 'number' && res.data.score >= scoreThreshold;
    const valid = Boolean(res.data.success && actionMatches && scorePasses);
    if (!valid) {
      console.warn('reCAPTCHA verification failed:', {
        success: res.data.success,
        action: res.data.action,
        expectedAction,
        score: res.data.score,
        scoreThreshold,
        errorCodes: res.data['error-codes'] || []
      });
    }
    return { valid, details: res.data };
  } catch (err) {
    console.error('reCAPTCHA error:', err.message);
    return { valid: false, reason: 'request-failed' };
  }
}

// API call with conversation context
async function callAI(prompt) {
  try {
    if (!NVIDIA_API_KEY || NVIDIA_API_KEY === 'your_nvidia_api_key_here') return null;
    const fetch = (await import('node-fetch')).default;
    const response = await fetch('https://integrate.api.nvidia.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${NVIDIA_API_KEY}`
      },
      body: JSON.stringify({
        model: 'google/gemma-2-2b-it',
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.7,
        top_p: 0.9,
        max_tokens: 300,
        stream: false
      })
    });
    const data = await response.json();
    if (data.error) { console.error('NVIDIA error:', data.error.message); return null; }
    return data.choices?.[0]?.message?.content || null;
  } catch (err) {
    console.error('NVIDIA call failed:', err.message);
    return null;
  }
}

// =====================
// ADMIN SETUP
// =====================
app.post('/api/admin/setup', async (req, res) => {
  const { setupKey, username, password } = req.body;
  if (setupKey !== 'SETUP_AI_SOLUTIONS_2026') return res.status(403).json({ message: 'Invalid setup key.' });
  try {
    const hashed = await bcrypt.hash(password, 10);
    await pool.query('DELETE FROM admins');
    await pool.query('INSERT INTO admins (username, password) VALUES ($1, $2)', [username, hashed]);
    res.json({ message: `Admin "${username}" created! You can now login.` });
  } catch (err) {
    res.status(500).json({ message: 'Setup failed: ' + err.message });
  }
});

// =====================
// PUBLIC ROUTES
// =====================

// Submit inquiry with reCAPTCHA v3
app.post('/api/inquiries', async (req, res) => {
  const { name, email, phone, company, country, jobTitle, jobDetails, recaptchaToken } = req.body;
  if (!name || !email || !jobDetails) return res.status(400).json({ message: 'Name, email and job details are required.' });

  const captcha = await verifyRecaptcha(recaptchaToken, 'contact_inquiry');
  if (!captcha.valid) return res.status(400).json({ message: 'reCAPTCHA verification failed. Please try again.' });

  try {
    const prompt = `You are a professional assistant for AI-Solutions, a company providing AI-driven software solutions. 
Customer named ${name} submitted this inquiry: "${jobDetails}". 
Write a warm, specific and professional response of 3-4 sentences on behalf of AI-Solutions addressing their exact inquiry.`;
    let aiResponse = await callAI(prompt) || 'Thank you for your inquiry. Our team will review it and get back to you shortly.';
    await pool.query(
      `INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response) VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`,
      [name, email, phone || null, company || null, country || null, jobTitle || null, jobDetails, aiResponse]
    );
    sendInquiryReceivedEmail({ name, email, jobDetails }).catch(err => {
      console.error('Inquiry receipt email failed:', err.message);
    });
    res.status(200).json({ message: 'Inquiry submitted successfully.' });
  } catch (err) {
    console.error('Inquiry error:', err.message);
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// AI Chatbot - fixed with varied responses and conversation history
app.post('/api/chat', async (req, res) => {
  const { message, history } = req.body;
  if (!message) return res.status(400).json({ reply: 'Please send a message.' });
  try {
    // Build conversation context from history
    let conversationContext = '';
    if (history && history.length > 0) {
      conversationContext = history.slice(-6).map(h => `${h.role === 'user' ? 'Visitor' : 'AI'}: ${h.text}`).join('\n');
    }

    const prompt = `You are a knowledgeable and friendly AI assistant for AI-Solutions, a start-up company based in Sunderland providing AI-driven software solutions across healthcare, retail, finance, and education industries.

About AI-Solutions:
- Services: AI Inquiry Management, Digital Transformation, Data Analytics, Custom AI Development
- Clients: RetailCo (reduced response time 70%), HealthFirst (5 clinics), FinTrack, EduSmart
- Tech stack: HTML, CSS, JavaScript, Node.js, PostgreSQL, Gemini AI
- Contact: visitors use the Contact Us page on the website
- Location: Sunderland, UK

${conversationContext ? `Previous conversation:\n${conversationContext}\n` : ''}

Current visitor message: "${message}"

IMPORTANT RULES:
- Give a DIFFERENT and SPECIFIC response each time based on what was asked
- Never repeat the same response
- Be conversational, helpful and specific to the question asked
- Keep response to 2-4 sentences
- If asked about contact, mention the Contact Us page
- If asked about services, mention specific services
- If asked about pricing, say to contact them for a custom quote`;

    const reply = await callAI(prompt);
    res.json({ reply: reply || 'Thanks for your message! For detailed information, please visit our Contact Us page and our team will be happy to help you.' });
  } catch (err) {
    res.json({ reply: 'Sorry, I am having trouble right now. Please try again shortly.' });
  }
});

// Get published posts for a page
app.get('/api/posts/:page', async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT * FROM posts WHERE page = $1 AND published = TRUE ORDER BY created_at DESC`,
      [req.params.page]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// =====================
// ADMIN ROUTES
// =====================

// Admin login with reCAPTCHA v3
app.post('/api/admin/login', async (req, res) => {
  const { username, password, recaptchaToken } = req.body;
  console.log('Login attempt:', username);

  const captcha = await verifyRecaptcha(recaptchaToken, 'admin_login');
  if (!captcha.valid) return res.status(400).json({ message: 'reCAPTCHA verification failed.' });

  try {
    const result = await pool.query('SELECT * FROM admins WHERE username = $1', [username]);
    if (result.rows.length === 0) return res.status(401).json({ message: 'Invalid credentials.' });
    const admin = result.rows[0];
    const match = await bcrypt.compare(password, admin.password);
    console.log('Password match:', match);
    if (!match) return res.status(401).json({ message: 'Invalid credentials.' });
    const token = jwt.sign({ id: admin.id, username: admin.username }, JWT_SECRET, { expiresIn: '8h' });
    res.json({ token });
  } catch (err) {
    console.error('Login error:', err.message);
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Verify admin session before showing dashboard
app.get('/api/admin/verify', verifyToken, (req, res) => {
  res.json({ valid: true, user: req.user });
});

// Get all inquiries
app.get('/api/admin/inquiries', verifyToken, async (req, res) => {
  const search = req.query.search || '';
  const sort = ['name', 'country', 'job_title', 'created_at'].includes(req.query.sort) ? req.query.sort : 'created_at';
  try {
    const result = await pool.query(
      `SELECT * FROM inquiries WHERE name ILIKE $1 OR country ILIKE $1 OR company ILIKE $1 ORDER BY ${sort} DESC`,
      [`%${search}%`]
    );
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Reply to inquiry
app.post('/api/admin/reply', verifyToken, async (req, res) => {
  const { inquiryId, toEmail, toName, replyMessage } = req.body;
  if (!inquiryId || !toEmail || !replyMessage) return res.status(400).json({ message: 'Missing fields.' });
  try {
    await pool.query('UPDATE inquiries SET admin_reply = $1 WHERE id = $2', [replyMessage, inquiryId]);
    const transporter = createMailTransporter();
    if (!transporter) return res.status(500).json({ message: 'Email settings are not configured.' });
    await transporter.sendMail({
      from: `"AI-Solutions" <${process.env.ADMIN_EMAIL}>`,
      to: toEmail,
      subject: 'Re: Your Inquiry to AI-Solutions',
      html: `<div style="font-family:Arial,sans-serif;max-width:600px;margin:0 auto;">
        <div style="background:#1a1a2e;padding:20px;text-align:center;"><h2 style="color:#00d4ff;margin:0;">AI-Solutions</h2></div>
        <div style="padding:30px;background:#f9f9f9;">
          <p>Dear <strong>${toName}</strong>,</p>
          <p>Thank you for contacting AI-Solutions. Here is our response:</p>
          <div style="background:white;border-left:4px solid #00d4ff;padding:15px;margin:20px 0;border-radius:4px;">${replyMessage.replace(/\n/g, '<br/>')}</div>
          <p>Best regards,<br/><strong>AI-Solutions Team</strong></p>
        </div>
        <div style="background:#1a1a2e;padding:15px;text-align:center;"><p style="color:#aaa;margin:0;">&copy; 2026 AI-Solutions.</p></div>
      </div>`
    });
    res.json({ message: 'Reply sent successfully!' });
  } catch (err) {
    res.status(500).json({ message: 'Failed to send: ' + err.message });
  }
});

// Delete inquiry
app.delete('/api/admin/inquiries/:id', verifyToken, async (req, res) => {
  try {
    await pool.query('DELETE FROM inquiries WHERE id = $1', [req.params.id]);
    res.json({ message: 'Inquiry deleted.' });
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Export CSV
app.get('/api/admin/export', async (req, res) => {
  try {
    jwt.verify(req.query.token, JWT_SECRET);
    const result = await pool.query('SELECT * FROM inquiries ORDER BY created_at DESC');
    const headers = ['id', 'name', 'email', 'phone', 'company', 'country', 'job_title', 'job_details', 'ai_response', 'admin_reply', 'created_at'];
    const csv = [headers.join(','), ...result.rows.map(r => headers.map(h => `"${(r[h] || '').toString().replace(/"/g, '""')}"`).join(','))].join('\n');
    res.header('Content-Type', 'text/csv');
    res.attachment('inquiries.csv');
    res.send(csv);
  } catch (err) {
    res.status(403).json({ message: 'Invalid token.' });
  }
});

// =====================
// CONTENT MANAGEMENT
// =====================

// Get all posts (admin)
app.get('/api/admin/posts', verifyToken, async (req, res) => {
  const page = req.query.page || '';
  try {
    const query = page
      ? `SELECT * FROM posts WHERE page = $1 ORDER BY created_at DESC`
      : `SELECT * FROM posts ORDER BY created_at DESC`;
    const result = page ? await pool.query(query, [page]) : await pool.query(query);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Create post
app.post('/api/admin/posts', verifyToken, async (req, res) => {
  const { page, title, content, image_url, author, rating, extra } = req.body;
  if (!page || !title) return res.status(400).json({ message: 'Page and title are required.' });
  try {
    const result = await pool.query(
      `INSERT INTO posts (page, title, content, image_url, author, rating, extra) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *`,
      [page, title, content || '', image_url || '', author || '', rating || 5, extra || '']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Update post
app.put('/api/admin/posts/:id', verifyToken, async (req, res) => {
  const { title, content, image_url, author, rating, extra, published } = req.body;
  try {
    const result = await pool.query(
      `UPDATE posts SET title=$1, content=$2, image_url=$3, author=$4, rating=$5, extra=$6, published=$7 WHERE id=$8 RETURNING *`,
      [title, content, image_url, author, rating, extra, published, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

// Delete post
app.delete('/api/admin/posts/:id', verifyToken, async (req, res) => {
  try {
    await pool.query('DELETE FROM posts WHERE id = $1', [req.params.id]);
    res.json({ message: 'Post deleted.' });
  } catch (err) {
    res.status(500).json({ message: 'Server error: ' + err.message });
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
