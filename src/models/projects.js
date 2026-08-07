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

const createProject = async (title, description, location, date, organizationId) => {
    const query = `
      INSERT INTO service_projects (title, description, location, project_date, organization_id)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING project_id;
    `;

    const queryParams = [title, description, location, date, organizationId];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Failed to create project');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Created new project with ID:', result.rows[0].project_id);
    }

    return result.rows[0].project_id;
};

const updateProject = async (projectId, title, description, location, date, organizationId) => {
    const query = `
      UPDATE service_projects
      SET title = $1,
          description = $2,
          location = $3,
          project_date = $4,
          organization_id = $5
      WHERE project_id = $6
      RETURNING project_id;
    `;

    const queryParams = [title, description, location, date, organizationId, projectId];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Service project not found');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Updated service project with ID:', projectId);
    }

    return result.rows[0].project_id;
};

export {
    getAllProjects,
    getProjectsByOrganizationId,
    getUpcomingProjects,
    getProjectDetails,
    createProject,
    updateProject
};
