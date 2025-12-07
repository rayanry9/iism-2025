import { getAllAthleticMatches } from '$lib/api/athleticMatches';
import { getAllInstitutes } from '$lib/api/institutes';
import { getAllPoolMatches } from '$lib/api/poolMatches';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch }) => {
	return {
		athleticMatches: getAllAthleticMatches(fetch),
		poolMatches: getAllPoolMatches(fetch),
		institutes: getAllInstitutes(fetch)
	};
};
