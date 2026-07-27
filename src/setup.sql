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

 
