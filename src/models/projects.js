// Function to get all projects along with their organization names.
// The query will select project details and the organization name for each project.
import db from './db.js';

const getAllProjects = async() => {
    const query = `
        SELECT p.project_id, p.title, p.description, p.project_date,
               o.name AS organization_name
        FROM public.service_projects p
        JOIN public.organization o ON p.organization_id = o.organization_id;
    `;
    const { rows } = await db.query(query);
    return rows;
};

const getProjectsByOrganizationId = async (organizationId) => {
    const query = `
        SELECT project_id, title, description, project_date, organization_id
        FROM public.service_projects
        WHERE organization_id = $1;
    `;

    const { rows } = await db.query(query, [organizationId]);
    return rows;
};

async function getUpcomingProjects(number_of_projects) {
    const query = `
        SELECT p.project_id, p.title, p.description,
               p.project_date AS date, p.location, p.organization_id,
               o.name AS organization_name
        FROM public.service_projects p
        JOIN public.organization o ON p.organization_id = o.organization_id
        WHERE p.project_date >= CURRENT_DATE
        ORDER BY p.project_date ASC
        LIMIT $1;
    `;

    const { rows } = await db.query(query, [number_of_projects]);
    return rows;
}

async function getProjectDetails(id) {
    const query = `
        SELECT p.project_id, p.title, p.description,
               p.project_date AS date, p.location, p.organization_id,
               o.name AS organization_name
        FROM public.service_projects p
        JOIN public.organization o
          ON p.organization_id = o.organization_id
        WHERE p.project_id = $1;
    `;

    const { rows } = await db.query(query, [id]);
    return rows[0];
}

export { getAllProjects, getProjectsByOrganizationId, getUpcomingProjects, getProjectDetails };
