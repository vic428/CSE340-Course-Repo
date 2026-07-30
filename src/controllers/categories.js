// Import any needed model functions
import {
    getAllCategories,
    getCategoryDetails,
    getProjectsByCategoryId
} from '../models/categories.js';

// Define any controller functions
const showCategoriesPage = async (req, res) => {
    const categories = await getAllCategories();
    const title = 'Service Categories';

    res.render('categories', { title, categories });
};

const showCategoryDetailsPage = async (req, res) => {
    const categoryId = req.params.id;
    const [category, projects] = await Promise.all([
        getCategoryDetails(categoryId),
        getProjectsByCategoryId(categoryId)
    ]);

    if (!category) {
        const err = new Error('Service Category Not Found');
        err.status = 404;
        throw err;
    }

    const title = 'Service Category Details';
    res.render('category', { title, category, projects });
};

// Export any controller functions
export { showCategoriesPage, showCategoryDetailsPage };
