// Import any needed model functions
import { getAllOrganizations, getOrganizationDetails } from '../models/organizations.js';
import { getProjectsByOrganizationId } from '../models/projects.js';

// Define any controller functions
const showOrganizationsPage = async (req, res) => {
    const organizations = await getAllOrganizations();
    const title = 'Our Partner Organizations';

    res.render('organizations', { title, organizations });
};

const showOrganizationDetailsPage = async (req, res) => {
    const organizationId = req.params.id;
    const [organizationDetails, projects] = await Promise.all([
        getOrganizationDetails(organizationId),
        getProjectsByOrganizationId(organizationId)
    ]);

    if (!organizationDetails) {
        const err = new Error('Organization Not Found');
        err.status = 404;
        throw err;
    }

    const title = 'Organization Details';

    res.render('organization', { title, organizationDetails, projects });
};

// Export any controller functions
export { showOrganizationsPage, showOrganizationDetailsPage };
