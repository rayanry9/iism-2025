import { getAllAthleticMatches } from '$lib/api/athleticMatches';
import { getAllInstitutes } from '$lib/api/institutes';
import { getAllPoolMatches } from '$lib/api/poolMatches';
import { getAllPoolTeams } from '$lib/api/pools';
import { getAllSports } from '$lib/api/sports';
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async ({ fetch }) => {
	return {
		athleticMatches: await getAllAthleticMatches(fetch),
		poolMatches: await getAllPoolMatches(fetch),
		institutes: await getAllInstitutes(fetch),
		allSports: await getAllSports(fetch)
	};
};
