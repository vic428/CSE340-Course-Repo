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

const createCategory = async (name) => {
    const query = `
        INSERT INTO public.category (name)
        VALUES ($1)
        RETURNING category_id;
    `;

    const result = await db.query(query, [name]);

    if (result.rows.length === 0) {
        throw new Error('Failed to create category');
    }

    return result.rows[0].category_id;
};

const updateCategory = async (categoryId, name) => {
    const query = `
        UPDATE public.category
        SET name = $1
        WHERE category_id = $2
        RETURNING category_id;
    `;

    const result = await db.query(query, [name, categoryId]);

    if (result.rows.length === 0) {
        throw new Error('Category not found');
    }

    return result.rows[0].category_id;
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

const assignCategoryToProject = async (projectId, categoryId) => {
    const query = `
        INSERT INTO public.service_project_category (project_id, category_id)
        VALUES ($1, $2);
    `;

    await db.query(query, [projectId, categoryId]);
};

const updateCategoryAssignments = async (projectId, categoryIds) => {
    // First, remove existing category assignments for the project
    const deleteQuery = `
        DELETE FROM public.service_project_category
        WHERE project_id = $1;
    `;
    await db.query(deleteQuery, [projectId]);

    // Next, add the new category assignments
    for (const categoryId of categoryIds) {
        await assignCategoryToProject(projectId, categoryId);
    }
};

export {
    getAllCategories,
    getCategoryDetails,
    createCategory,
    updateCategory,
    getProjectsByCategoryId,
    getCategoriesByProjectId,
    updateCategoryAssignments
};
