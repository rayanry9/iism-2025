import { getAllAthleticMatches } from '$lib/api/athleticMatches';
import { getAllInstitutes } from '$lib/api/institutes';
import { getAllPoolMatches } from '$lib/api/poolMatches';
import { getAllSports } from '$lib/api/sports';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch }) => {
	return {
		athleticMatches: await getAllAthleticMatches(fetch),
		institutes: await getAllInstitutes(fetch),
		allSports: await getAllSports(fetch)
	};
};
