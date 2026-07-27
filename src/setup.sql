-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- =============================================
-- Service Project Table
-- =============================================
 
CREATE TABLE service_projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    project_date DATE NOT NULL,
    FOREIGN KEY (organization_id)
        REFERENCES organization(organization_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO service_projects
(organization_id, title, description, location, project_date)
VALUES
-- Organization 1
(1, 'Community Food Drive',
 'Collect and distribute donated food to local families in need.',
 'Downtown Community Center',
 '2026-03-15'),

(1, 'Neighborhood Cleanup',
 'Volunteers clean parks, streets, and public spaces.',
 'Riverside Park',
 '2026-04-12'),

(1, 'School Supply Donation',
 'Provide backpacks and school supplies for students.',
 'Lincoln Elementary School',
 '2026-08-08'),

(1, 'Senior Assistance Day',
 'Help senior citizens with yard work and household chores.',
 'Sunrise Senior Center',
 '2026-06-20'),

(1, 'Holiday Toy Drive',
 'Collect and distribute toys for children during the holidays.',
 'Community Recreation Hall',
 '2026-12-05'),

-- Organization 2
(2, 'Tree Planting Campaign',
 'Plant native trees to improve the local environment.',
 'Greenwood Park',
 '2026-04-22'),

(2, 'Blood Donation Drive',
 'Partner with local hospitals to collect blood donations.',
 'City General Hospital',
 '2026-05-18'),

(2, 'Community Health Fair',
 'Offer free health screenings and wellness education.',
 'Civic Center',
 '2026-07-09'),

(2, 'Community Garden Project',
 'Create and maintain a shared vegetable garden.',
 'Maple Street Garden',
 '2026-08-14'),

(2, 'Beach Cleanup',
 'Remove litter and recyclable waste from the shoreline.',
 'East Beach',
 '2026-09-11'),

-- Organization 3
(3, 'Youth Mentorship Program',
 'Connect volunteers with high school students for mentoring.',
 'Youth Resource Center',
 '2026-02-28'),

(3, 'Adult Literacy Workshop',
 'Teach reading and writing skills to adult learners.',
 'Central Public Library',
 '2026-03-25'),

(3, 'Animal Shelter Volunteer Day',
 'Assist with caring for rescued animals and cleaning facilities.',
 'County Animal Shelter',
 '2026-05-22'),

(3, 'Charity Walk for Wellness',
 'Community fundraising walk supporting local charities.',
 'Central City Park',
 '2026-09-20'),

(3, 'Winter Clothing Drive',
 'Collect coats, blankets, and warm clothing for families in need.',
 'Hope Community Center',
 '2026-11-15');

-- =============================================
-- Category Table
-- =============================================

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

SELECT * FROM category;

-- =============================================
-- Project-Category Junction Table
-- Many-to-many relationship
-- =============================================

CREATE TABLE service_project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    CONSTRAINT fk_service_project_category_project
        FOREIGN KEY (project_id)
        REFERENCES service_projects(project_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_service_project_category_category
        FOREIGN KEY (category_id)
        REFERENCES category(category_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =============================================
-- Insert Categories
-- =============================================

INSERT INTO category (name)
VALUES
    ('Community Support'),
    ('Environment'),
    ('Health and Wellness'),
    ('Education and Mentorship'),
    ('Donation Drives'),
    ('Animal Welfare');
 
SELECT * FROM category;

-- =============================================
-- Associate Projects with Categories
-- =============================================

-- Community Food Drive
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Community Food Drive'
  AND c.name IN ('Community Support', 'Donation Drives');

-- Neighborhood Cleanup
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Neighborhood Cleanup'
  AND c.name IN ('Community Support', 'Environment');

-- School Supply Donation
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'School Supply Donation'
  AND c.name IN ('Education and Mentorship', 'Donation Drives');

-- Senior Assistance Day
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Senior Assistance Day'
  AND c.name = 'Community Support';

-- Holiday Toy Drive
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Holiday Toy Drive'
  AND c.name IN ('Community Support', 'Donation Drives');

-- Tree Planting Campaign
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Tree Planting Campaign'
  AND c.name = 'Environment';

-- Blood Donation Drive
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Blood Donation Drive'
  AND c.name IN ('Health and Wellness', 'Donation Drives');

-- Community Health Fair
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Community Health Fair'
  AND c.name IN ('Community Support', 'Health and Wellness');

-- Community Garden Project
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Community Garden Project'
  AND c.name IN ('Community Support', 'Environment');

-- Beach Cleanup
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Beach Cleanup'
  AND c.name = 'Environment';

-- Youth Mentorship Program
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Youth Mentorship Program'
  AND c.name = 'Education and Mentorship';

-- Adult Literacy Workshop
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Adult Literacy Workshop'
  AND c.name = 'Education and Mentorship';

-- Animal Shelter Volunteer Day
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Animal Shelter Volunteer Day'
  AND c.name IN ('Community Support', 'Animal Welfare');

-- Charity Walk for Wellness
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Charity Walk for Wellness'
  AND c.name IN ('Community Support', 'Health and Wellness');

-- Winter Clothing Drive
INSERT INTO service_project_category (project_id, category_id)
SELECT sp.project_id, c.category_id
FROM service_projects sp
CROSS JOIN category c
WHERE sp.title = 'Winter Clothing Drive'
  AND c.name IN ('Community Support', 'Donation Drives');

--This is to check for projects without any category
SELECT
    sp.project_id,
    sp.title
FROM service_projects sp
LEFT JOIN service_project_category spc
    ON sp.project_id = spc.project_id
WHERE spc.project_id IS NULL;

SELECT * FROM category;

SELECT * FROM service_project_category;
