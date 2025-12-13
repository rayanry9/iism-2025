import { getAllInstitutes } from '$lib/api/institutes';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch }) => {
	return {
		institutes: getAllInstitutes(fetch)
	};
};
