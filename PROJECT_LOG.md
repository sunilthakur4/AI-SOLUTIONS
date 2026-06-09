# Project Log

This file records the main development changes made to the AI-Solutions Inquiry Management System.

## 2026-06-07

### Public Website
- Redesigned the frontend with a more modern and responsive layout.
- Added a custom AI-Solutions logo and applied it across public and admin pages.
- Added day and night theme support.
- Added a mobile-only hamburger menu for public navigation.
- Added About Us content based on the Sunderland AI-Solutions project overview.
- Updated footer text across public pages.
- Added Events page.
- Added Blog and Case Studies combined page.
- Added Testimonials and Gallery database-backed sections.
- Updated Contact page layout into a two-column responsive design.
- Added Google reCAPTCHA v3 to Contact Us.
- Removed old reCAPTCHA v2 behavior.
- Moved About Us to the bottom of the home page.
- Improved chatbot button placement and label.

### Admin Area
- Added separate admin styling in `admin/admin.css`.
- Redesigned the admin dashboard.
- Added authentication verification before showing the dashboard.
- Added admin content publishing for Home, Solutions, Events, Blog, Case Studies, Testimonials, and Gallery.
- Added gallery support for online image URLs and local image upload as data URL.
- Added expandable inquiry rows so admins can view full inquiry information clearly.
- Added admin reply workflow.
- Added inquiry delete support.
- Added CSV export for inquiries.

### Backend
- Added PostgreSQL-backed content routes.
- Added admin JWT authentication.
- Added admin session verification endpoint.
- Added Google reCAPTCHA v3 verification.
- Added inquiry receipt email using Gmail app password settings.
- Added admin reply email support.
- Added inquiry delete API route.
- Added seed script: `backend/seed-content.js`.
- Added content check script: `backend/check-content.js`.

### Database
- Added `posts` table for website content management.
- Added `admin_reply` support for inquiries.
- Updated `image_url` to `TEXT` for larger uploaded gallery images.
- Added `database/seed_content.sql` for sample website content and sample inquiry records.
- Seed data includes mixed Nepali and UK names, organizations, testimonials, case studies, and events.
- Events include past and upcoming records, with some time/location fields intentionally marked as "To be announced".

## Notes

- Keep `database/seed_content.sql` in the project. It is useful for testing, demonstration, and quickly rebuilding sample data after resetting the database.
- Do not treat seed data as production customer data.
- Do not push `backend/.env` to GitHub because it contains private credentials and API secrets.
