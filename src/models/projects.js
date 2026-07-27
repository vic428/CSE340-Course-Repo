//function to get all projects along with their organization names which would require the use of a JOIN query to combine data from the projects and organizartions tables. 
// The query will select project details and the organization name for each project.
import db from './db.js'

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

export { getAllProjects };
