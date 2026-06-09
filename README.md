# AI-Solutions Inquiry Management System

AI-Solutions is a start-up company based in Sunderland that provides AI-driven software solutions to enhance the digital employee experience across different industries.

This project is a dynamic website and admin system for presenting company information, services, case studies, testimonials, events, gallery content, and customer inquiries. It includes a public Contact Us workflow, AI chatbot, admin dashboard, content publishing tools, email notifications, and PostgreSQL-backed data storage.

## Features

### Public Website
- Home page with About Us section and company overview.
- Solutions, Events, Blog and Case Studies, Testimonials, Gallery, and Contact Us pages.
- Mobile responsive navigation with hamburger menu.
- Day and night theme mode.
- AI chatbot button labelled "Chat with AI".
- Google reCAPTCHA v3 protection on Contact Us.
- Contact form stores inquiries in PostgreSQL.
- Automatic inquiry received email sent to the user.

### Admin Area
- Admin setup page.
- Admin login with Google reCAPTCHA v3.
- Protected admin dashboard using JWT authentication.
- Inquiry dashboard with search, sorting, status counts, CSV export, reply support, and delete support.
- Expandable inquiry records so admins can view full inquiry details clearly.
- Content manager for Home, Solutions, Events, Blog, Case Studies, Testimonials, and Gallery.
- Gallery content can use online image links or local uploaded image files.

### Backend
- Node.js and Express API.
- PostgreSQL database.
- JWT authentication.
- Nodemailer email support.
- AI response support through the configured AI API key.
- Seed scripts for demo content and sample inquiry records.

## Project Structure

```text
AI_Solutions_Inquiry_Management_System/
|-- admin/
|   |-- dashboard.html
|   |-- login.html
|   |-- setup.html
|   `-- admin.css
|-- backend/
|   |-- server.js
|   |-- seed-content.js
|   |-- check-content.js
|   |-- package.json
|   `-- .env
|-- database/
|   |-- schema.sql
|   `-- seed_content.sql
|-- frontend/
|   |-- index.html
|   |-- solutions.html
|   |-- events.html
|   |-- blog-casestudies.html
|   |-- testimonials.html
|   |-- gallery.html
|   |-- contact.html
|   |-- style.css
|   |-- theme.js
|   |-- chatbot.js
|   `-- logo.svg
|-- PROJECT_LOG.md
`-- README.md
```

## Requirements

- Node.js
- PostgreSQL
- A Gmail app password for sending email
- Google reCAPTCHA v3 site key and secret key
- Optional AI API key for generated AI responses

## Database Setup

Create the PostgreSQL database:

```powershell
psql -U postgres -c "CREATE DATABASE ai_solutions;"
```

Run the schema:

```powershell
psql -U postgres -d ai_solutions -f database/schema.sql
```

Optional demo data:

```powershell
node backend\seed-content.js
```

The seed file adds sample website content and sample inquiries for testing the admin dashboard.

## Backend Setup

Install dependencies:

```powershell
cd backend
npm install
```

Create or update `backend/.env` with your local values:

```env
DB_HOST=localhost
DB_USER=postgres
DB_PASSWORD=your_postgres_password
DB_NAME=ai_solutions
DB_PORT=5432
JWT_SECRET=your_random_secret
ADMIN_EMAIL=your_gmail_address
ADMIN_EMAIL_PASSWORD=your_gmail_app_password
RECAPTCHA_SECRET=your_recaptcha_v3_secret
RECAPTCHA_MIN_SCORE=0.3
```

Start the backend:

```powershell
npm start
```

The API runs at:

```text
http://localhost:5000
```

## Frontend Setup

Open the public website with VS Code Live Server or open:

```text
frontend/index.html
```

For the admin area, open:

```text
admin/setup.html
admin/login.html
admin/dashboard.html
```

The backend must be running for contact forms, chatbot, admin login, dashboard data, and content loading.

## Useful Commands

Run seed content:

```powershell
node backend\seed-content.js
```

Check database content counts:

```powershell
node backend\check-content.js
```

Check backend syntax:

```powershell
node --check backend\server.js
```

## GitHub Safety

Do not push private secrets to GitHub. Keep these out of source control:

```gitignore
backend/.env
backend/node_modules/
node_modules/
*.log
```

## Developer

Sunil Kumar Thakur

BSc (Hons) Computer Systems Engineering
