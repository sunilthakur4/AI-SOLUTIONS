-- Seed content for AI-Solutions public website sections.
-- Safe to run more than once: each row is inserted only if the same page/title does not already exist.

UPDATE posts SET extra = 'JUL|12|10:00 AM - 12:00 PM|Sunderland Software Centre, UK|Registration Open'
WHERE page = 'events' AND title = 'Sunderland AI Adoption Workshop';

UPDATE posts SET extra = 'AUG|04|6:00 PM - 7:30 PM|Online|Registration Open'
WHERE page = 'events' AND title = 'Nepal-UK Digital Service Meetup';

UPDATE posts SET extra = 'SEP|18|To be announced|Newcastle, UK|Upcoming'
WHERE page = 'events' AND title = 'Customer Support Automation Demo';

UPDATE posts SET extra = 'FEB|16|9:30 AM - 11:00 AM|Sunderland, UK|Past Event'
WHERE page = 'events' AND title = 'Completed: AI for Small Business Breakfast';

UPDATE posts SET extra = 'MAR|07|2:00 PM - 4:00 PM|Kathmandu, Nepal|Past Event'
WHERE page = 'events' AND title = 'Completed: Kathmandu Digital Workflow Roundtable';

UPDATE posts SET extra = 'APR|24|To be announced|Online|Past Event'
WHERE page = 'events' AND title = 'Completed: Online Inquiry Dashboard Demo';

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'AI Inquiry Management', 'AI-Solutions helps teams capture, understand, and respond to customer inquiries faster using intelligent automation and clear admin workflows.', NULL, NULL, 5, 'Digital employee experience', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'AI Inquiry Management');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Smart Digital Workflows', 'From Sunderland to growing teams across the UK and Nepal, our tools reduce manual work and make everyday service tasks easier to manage.', NULL, NULL, 5, 'Automation for teams', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Smart Digital Workflows');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Data-Led Decisions', 'We turn inquiry and service data into practical insights so managers can spot trends, improve response quality, and plan with confidence.', NULL, NULL, 5, 'Reporting and analytics', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Data-Led Decisions');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'AI Customer Inquiry Assistant', 'A web-based assistant that supports customer inquiries, drafts useful responses, and stores each request for admin review.', NULL, NULL, 5, 'Service automation', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'AI Customer Inquiry Assistant');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Admin Dashboard and Reply Management', 'A secure dashboard for reviewing inquiries, sending replies, publishing content, and keeping service communication organized.', NULL, NULL, 5, 'Inquiry operations', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Admin Dashboard and Reply Management');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Digital Employee Experience Tools', 'Custom AI-driven software that helps employees work faster, reduce repetitive tasks, and deliver better customer support.', NULL, NULL, 5, 'Custom software', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Digital Employee Experience Tools');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Sunderland AI Adoption Workshop', 'A practical workshop for small businesses exploring how AI can improve customer service, reporting, and employee productivity.', NULL, NULL, 5, 'JUL|12|10:00 AM - 12:00 PM|Sunderland Software Centre, UK|Registration Open', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Sunderland AI Adoption Workshop');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Nepal-UK Digital Service Meetup', 'An online session connecting Nepali and UK professionals to discuss AI tools for service teams and inquiry management.', NULL, NULL, 5, 'AUG|04|6:00 PM - 7:30 PM|Online|Registration Open', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Nepal-UK Digital Service Meetup');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Customer Support Automation Demo', 'A live product demo showing how inquiries move from contact form submission to admin review and response management.', NULL, NULL, 5, 'SEP|18|To be announced|Newcastle, UK|Upcoming', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Customer Support Automation Demo');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Why AI Matters for Employee Experience', 'AI is most valuable when it removes repetitive work from employees and gives them more time for high-quality customer communication.', NULL, 'Aarav Sharma', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Why AI Matters for Employee Experience');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Designing Inquiry Systems for Growing Teams', 'A good inquiry system should be simple for customers, structured for admins, and clear enough for managers to track performance.', NULL, 'Emily Thompson', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Designing Inquiry Systems for Growing Teams');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Bringing Nepal and UK Service Ideas Together', 'Mixed teams can benefit from shared AI workflows that support different regions, communication styles, and operational needs.', NULL, 'Sushmita Gurung', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Bringing Nepal and UK Service Ideas Together');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Retail Support Response Time Reduced', 'A UK retail team used AI-Solutions inquiry management to organize requests and reduce average response time across busy service periods.', NULL, 'NorthBridge Retail', 5, 'Case Study - Retail', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Retail Support Response Time Reduced');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Education Helpdesk Workflow Improved', 'A training provider improved student support by tracking inquiries in one dashboard and preparing faster first responses.', NULL, 'Sunderland Learning Hub', 5, 'Case Study - Education', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Education Helpdesk Workflow Improved');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Nepali Service Team Modernized', 'A Kathmandu-based support team used structured inquiry records and AI response support to improve daily customer communication.', NULL, 'Himal Service Group', 5, 'Case Study - Service Operations', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Nepali Service Team Modernized');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'The dashboard made inquiry follow-up much easier for our team.', 'We can now see customer requests clearly, prepare replies faster, and avoid losing important messages during busy periods.', NULL, 'Prabin Karki, Operations Manager, Himal Service Group', 5, 'Kathmandu, Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'The dashboard made inquiry follow-up much easier for our team.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'AI-Solutions gave our support process a professional structure.', 'The system is easy for staff to use and gives managers better visibility into what customers are asking for.', NULL, 'Charlotte Wilson, Customer Experience Lead, NorthBridge Retail', 5, 'Sunderland, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'AI-Solutions gave our support process a professional structure.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'It helped our team respond with more confidence.', 'The inquiry records and AI response support save time while still keeping our communication personal.', NULL, 'Nisha Adhikari, Service Coordinator, EduCare Nepal', 5, 'Lalitpur, Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'It helped our team respond with more confidence.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Sunderland product demo session', 'AI-Solutions presenting inquiry management workflows to local business owners.', 'https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Sunderland, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Sunderland product demo session');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Online Nepal-UK collaboration meeting', 'A remote planning session for AI-driven digital employee experience ideas.', 'https://images.unsplash.com/photo-1559136555-9303baea8ebd?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Online event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Online Nepal-UK collaboration meeting');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Customer service automation planning', 'Team workshop focused on simplifying support tasks and inquiry response flows.', 'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Workshop', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Customer service automation planning');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Employee Support Automation', 'AI-Solutions creates tools that help employees find answers, manage tasks, and support customers without switching between messy systems.', NULL, NULL, 5, 'Employee productivity', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Employee Support Automation');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Secure Content Publishing', 'Admins can publish updates for services, events, case studies, testimonials, and gallery items directly from the dashboard.', NULL, NULL, 5, 'Admin-managed website', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Secure Content Publishing');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Practical AI for Service Teams', 'Our approach focuses on useful, simple AI features that make daily service work faster for small and growing organizations.', NULL, NULL, 5, 'Practical AI adoption', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Practical AI for Service Teams');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'AI Knowledge Base Support', 'A searchable support layer that helps employees find approved answers, policies, and service guidance from one place.', NULL, NULL, 5, 'Knowledge management', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'AI Knowledge Base Support');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Service Performance Reporting', 'Dashboards that summarize inquiry volume, response patterns, common requests, and operational trends for managers.', NULL, NULL, 5, 'Analytics dashboard', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Service Performance Reporting');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Website Content Management', 'A lightweight publishing workflow for keeping public service pages, events, articles, case studies, and gallery posts up to date.', NULL, NULL, 5, 'Content workflow', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Website Content Management');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Completed: AI for Small Business Breakfast', 'Past event: Local Sunderland founders discussed practical AI use cases for service teams, admin tasks, and customer inquiry handling.', NULL, NULL, 5, 'FEB|16|9:30 AM - 11:00 AM|Sunderland, UK|Past Event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Completed: AI for Small Business Breakfast');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Completed: Kathmandu Digital Workflow Roundtable', 'Past event: Nepali service managers shared how simple automation can reduce repeated admin work and improve response quality.', NULL, NULL, 5, 'MAR|07|2:00 PM - 4:00 PM|Kathmandu, Nepal|Past Event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Completed: Kathmandu Digital Workflow Roundtable');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Completed: Online Inquiry Dashboard Demo', 'Past event: A remote demo showed how inquiries can move from contact form submission to admin tracking and response management.', NULL, NULL, 5, 'APR|24|To be announced|Online|Past Event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Completed: Online Inquiry Dashboard Demo');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'How Start-ups Can Use AI Without Overcomplicating Work', 'Start-ups get the best value from AI when they solve one clear workflow first, such as inquiry handling or internal support.', NULL, 'Oliver Bennett', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'How Start-ups Can Use AI Without Overcomplicating Work');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'What Admin Dashboards Should Show First', 'A useful dashboard should highlight the newest inquiries, pending replies, content status, and simple actions before anything complex.', NULL, 'Rabin Thapa', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'What Admin Dashboards Should Show First');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Using AI to Support Human Customer Service', 'AI should support people by preparing information, suggesting responses, and reducing repeated effort while staff keep control.', NULL, 'Grace Walker', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Using AI to Support Human Customer Service');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Local Council Inquiry Sorting Prototype', 'A council-facing prototype grouped incoming resident questions by topic, urgency, and department to help staff triage requests faster.', NULL, 'Wearside Digital Services', 5, 'Case Study - Public Service', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Local Council Inquiry Sorting Prototype');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Hospitality Booking Support Assistant', 'A hotel support team tested AI-assisted inquiry summaries to handle booking questions and event requests more consistently.', NULL, 'TyneStay Hotels', 5, 'Case Study - Hospitality', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Hospitality Booking Support Assistant');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Training Centre Student Inquiry Hub', 'A Nepali training centre organized course questions, payment queries, and certificate requests in one searchable admin workspace.', NULL, 'Pokhara Skills Academy', 5, 'Case Study - Education', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Training Centre Student Inquiry Hub');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'The system gave us a much cleaner way to manage messages.', 'Before this, customer questions were spread across inboxes. Now our team can review, assign, and follow up from one dashboard.', NULL, 'Maya Shrestha, Director, Pokhara Skills Academy', 5, 'Pokhara, Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'The system gave us a much cleaner way to manage messages.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'It helped us explain AI in a practical way to staff.', 'The project focused on real daily tasks instead of buzzwords, which made adoption easier for our support team.', NULL, 'Daniel Hughes, Service Manager, TyneStay Hotels', 5, 'Newcastle, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'It helped us explain AI in a practical way to staff.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'Our team saves time during the first review of every inquiry.', 'The AI response support and organized records make customer follow-up faster without making the process feel robotic.', NULL, 'Anjana Rai, Customer Support Lead, Everest Connect', 5, 'Kathmandu, Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'Our team saves time during the first review of every inquiry.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Admin dashboard content review', 'A content manager reviewing published services, events, and testimonials from the admin dashboard.', 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Dashboard workflow', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Admin dashboard content review');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Sunderland start-up workspace', 'Planning AI-driven software features for small business service teams.', 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Sunderland, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Sunderland start-up workspace');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Remote customer support planning', 'A distributed team mapping inquiry categories and response workflows.', 'https://images.unsplash.com/photo-1600880292203-757bb62b4baf?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Remote team', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Remote customer support planning');

INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response, admin_reply)
SELECT 'Sanjay Gurung', 'sanjay.gurung@example.com', '+977-9841001111', 'Everest Connect', 'Nepal', 'Support Manager', 'We want to organize customer questions from email and website forms in one dashboard. Can AI-Solutions help us track and reply faster?', 'Thank you for your inquiry. AI-Solutions can help centralize customer questions and support faster response workflows through an admin dashboard.', NULL
WHERE NOT EXISTS (SELECT 1 FROM inquiries WHERE email = 'sanjay.gurung@example.com' AND job_title = 'Support Manager');

INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response, admin_reply)
SELECT 'Amelia Clarke', 'amelia.clarke@example.co.uk', '+44 191 555 0182', 'Wearside Digital Services', 'United Kingdom', 'Operations Lead', 'We are interested in a demo for inquiry sorting and reporting for a small public service team.', 'Thank you for contacting AI-Solutions. We can arrange a demo focused on inquiry sorting, reporting, and practical workflow improvements.', 'Demo details sent to customer.'
WHERE NOT EXISTS (SELECT 1 FROM inquiries WHERE email = 'amelia.clarke@example.co.uk' AND job_title = 'Operations Lead');

INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response, admin_reply)
SELECT 'Priya Adhikari', 'priya.adhikari@example.com', '+977-9803002222', 'Pokhara Skills Academy', 'Nepal', 'Training Coordinator', 'Our students send many course and certificate questions. We need a simple system to manage them and publish updates.', 'Thanks for reaching out. AI-Solutions can support student inquiry management and admin content publishing for course updates.', NULL
WHERE NOT EXISTS (SELECT 1 FROM inquiries WHERE email = 'priya.adhikari@example.com' AND job_title = 'Training Coordinator');

INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response, admin_reply)
SELECT 'Thomas Reed', 'thomas.reed@example.co.uk', '+44 7400 555 284', 'TyneStay Hotels', 'United Kingdom', 'Guest Services Director', 'Can your AI inquiry system help our hotel team respond to booking and event questions more consistently?', 'Thank you for your inquiry. AI-Solutions can help hotel teams organize booking questions, prepare consistent replies, and track follow-up.', NULL
WHERE NOT EXISTS (SELECT 1 FROM inquiries WHERE email = 'thomas.reed@example.co.uk' AND job_title = 'Guest Services Director');

INSERT INTO inquiries (name, email, phone, company, country, job_title, job_details, ai_response, admin_reply)
SELECT 'Bikash Rai', 'bikash.rai@example.com', '+977-9812004444', 'Lalitpur Retail Mart', 'Nepal', 'Business Owner', 'I need a website contact system and dashboard where my staff can review product inquiries every day.', 'Thank you for contacting AI-Solutions. We can build a contact system and admin dashboard to help your staff review product inquiries efficiently.', NULL
WHERE NOT EXISTS (SELECT 1 FROM inquiries WHERE email = 'bikash.rai@example.com' AND job_title = 'Business Owner');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Fast Customer Follow-Up', 'Reduce delays by giving admins one place to review new inquiries, read AI summaries, and prepare replies.', NULL, NULL, 5, 'Customer service speed', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Fast Customer Follow-Up');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'AI for Growing Teams', 'Designed for start-ups and small teams that need useful automation without heavy enterprise complexity.', NULL, NULL, 5, 'Scalable support', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'AI for Growing Teams');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Clear Service Records', 'Keep customer messages, AI responses, and admin replies together so teams always know what happened.', NULL, NULL, 5, 'Organized records', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Clear Service Records');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'home', 'Sunderland-Based Innovation', 'We build from Sunderland with a practical view of how UK and Nepali teams can use AI in everyday work.', NULL, NULL, 5, 'Local and international focus', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'home' AND title = 'Sunderland-Based Innovation');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Inquiry Categorisation', 'Automatically group incoming messages by topic such as pricing, support, booking, training, or technical help.', NULL, NULL, 5, 'AI classification', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Inquiry Categorisation');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Reply Draft Assistance', 'Generate professional first-draft replies that admins can edit before sending to customers.', NULL, NULL, 5, 'Response support', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Reply Draft Assistance');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Event and Gallery Publishing', 'Let administrators publish event updates and gallery items without editing the website code.', NULL, NULL, 5, 'Content publishing', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Event and Gallery Publishing');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'solutions', 'Customer Insight Reports', 'Identify repeated inquiry themes so managers can improve website information, service scripts, and internal training.', NULL, NULL, 5, 'Operational insight', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'solutions' AND title = 'Customer Insight Reports');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Completed: Sunderland Demo Evening', 'Past event: A hands-on evening where local teams tested inquiry reply workflows and dashboard search features.', NULL, NULL, 5, 'MAY|14|5:30 PM - 7:00 PM|Sunderland, UK|Past Event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Completed: Sunderland Demo Evening');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Completed: Nepal Support Team Clinic', 'Past event: A clinic for Nepali service teams on organizing customer questions and reducing repeated admin work.', NULL, NULL, 5, 'JUN|05|11:00 AM - 1:00 PM|Lalitpur, Nepal|Past Event', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Completed: Nepal Support Team Clinic');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'AI Website Content Publishing Session', 'A practical session showing admins how to publish services, testimonials, events, and gallery updates.', NULL, NULL, 5, 'OCT|03|To be announced|To be announced|Upcoming', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'AI Website Content Publishing Session');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'events', 'Digital Employee Experience Forum', 'A discussion on how small businesses can improve employee workflows with lightweight AI tools.', NULL, NULL, 5, 'NOV|21|1:00 PM - 3:00 PM|Online|Upcoming', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'events' AND title = 'Digital Employee Experience Forum');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'How to Prepare Your Contact Form for AI', 'Clear form fields, useful inquiry details, and consistent categories help AI produce better support suggestions.', NULL, 'Sita Koirala', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'How to Prepare Your Contact Form for AI');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Why Admin Experience Matters', 'A dashboard should make important customer information visible quickly so admins can act with confidence.', NULL, 'Harry Collins', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Why Admin Experience Matters');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'Balancing Automation and Human Replies', 'The best inquiry systems let AI prepare helpful context while humans make the final decision.', NULL, 'Anil Basnet', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'Balancing Automation and Human Replies');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'blog', 'What Small Teams Should Track First', 'New teams should start with inquiry volume, response status, repeated topics, and unanswered messages.', NULL, 'Sophie Turner', 5, 'Blog article', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'blog' AND title = 'What Small Teams Should Track First');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Clinic Front Desk Inquiry Support', 'A clinic team used structured inquiry tracking to separate appointment, billing, and report collection questions.', NULL, 'HealthBridge Sunderland', 5, 'Case Study - Healthcare', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Clinic Front Desk Inquiry Support');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Nepal Retail Customer Message Hub', 'A retail team in Nepal organized product questions and delivery messages through one inquiry dashboard.', NULL, 'Kathmandu Smart Retail', 5, 'Case Study - Retail', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Nepal Retail Customer Message Hub');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'University Applicant Support Flow', 'An admissions team improved visibility over applicant questions by tracking inquiry status and admin replies.', NULL, 'North East Study Centre', 5, 'Case Study - Education', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'University Applicant Support Flow');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'casestudies', 'Event Booking Inquiry Automation', 'An events company used AI response support to handle venue, date, and package questions more consistently.', NULL, 'RiverWear Events', 5, 'Case Study - Events', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'casestudies' AND title = 'Event Booking Inquiry Automation');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'Viewing full inquiries made replies much easier.', 'Our admins can read the full customer message before replying, which makes responses clearer and more useful.', NULL, 'Kiran Shrestha, Admin Lead, Kathmandu Smart Retail', 5, 'Kathmandu, Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'Viewing full inquiries made replies much easier.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'The event publishing workflow saves us time.', 'We can update past and upcoming events from the dashboard without asking a developer for every small change.', NULL, 'Rebecca Hill, Marketing Officer, RiverWear Events', 5, 'Durham, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'The event publishing workflow saves us time.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'It is simple enough for our daily support work.', 'The interface keeps the important inquiry details together so our team does not waste time searching.', NULL, 'Pema Lama, Support Supervisor, Everest Connect', 5, 'Nepal', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'It is simple enough for our daily support work.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'testimonials', 'The system feels practical, not complicated.', 'AI-Solutions focused on the workflow we actually needed, especially customer messages and follow-up.', NULL, 'Matthew Scott, Director, HealthBridge Sunderland', 5, 'Sunderland, UK', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'testimonials' AND title = 'The system feels practical, not complicated.');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Customer inquiry planning board', 'Team members mapping inquiry categories for a new AI support workflow.', 'https://images.unsplash.com/photo-1556761175-b413da4baf72?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Planning session', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Customer inquiry planning board');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Admin reply workflow review', 'Reviewing reply drafts and customer records before publishing a workflow update.', 'https://images.unsplash.com/photo-1551836022-d5d88e9218df?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Admin training', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Admin reply workflow review');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Nepal digital service workshop', 'Participants discussing customer support automation for small businesses.', 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Workshop', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Nepal digital service workshop');

INSERT INTO posts (page, title, content, image_url, author, rating, extra, published)
SELECT 'gallery', 'Sunderland team product review', 'A product review session focused on website content and admin dashboard improvements.', 'https://images.unsplash.com/photo-1556761175-4b46a572b786?auto=format&fit=crop&w=900&q=80', NULL, 5, 'Product review', TRUE
WHERE NOT EXISTS (SELECT 1 FROM posts WHERE page = 'gallery' AND title = 'Sunderland team product review');
