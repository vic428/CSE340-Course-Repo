// Function to get all categories from the database.
import db from './db.js';

const getAllCategories = async() => {
    const query = `
        SELECT category_id, name
        FROM public.category;
    `;
    const { rows } = await db.query(query);
    return rows;
};

const getCategoryDetails = async (id) => {
    const query = `
        SELECT category_id, name
        FROM public.category
        WHERE category_id = $1;
    `;

    const { rows } = await db.query(query, [id]);
    return rows[0];
};

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
        SELECT p.project_id, p.title
        FROM public.service_projects p
        JOIN public.service_project_category spc
          ON p.project_id = spc.project_id
        WHERE spc.category_id = $1
        ORDER BY p.project_date ASC;
    `;

    const { rows } = await db.query(query, [categoryId]);
    return rows;
};

const getCategoriesByProjectId = async (projectId) => {
    const query = `
        SELECT c.category_id, c.name
        FROM public.category c
        JOIN public.service_project_category spc
          ON c.category_id = spc.category_id
        WHERE spc.project_id = $1
        ORDER BY c.name ASC;
    `;

    const { rows } = await db.query(query, [projectId]);
    return rows;
};

export {
    getAllCategories,
    getCategoryDetails,
    getProjectsByCategoryId,
    getCategoriesByProjectId
};
