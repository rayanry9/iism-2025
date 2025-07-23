import { getAllInstitutes, getAllPools, getAllPoolTeams, getAllSports } from '$lib/api/data';
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
	return {
		institutes: await getAllInstitutes(),
		sports: await getAllSports(),
		pools: await getAllPools(),
		poolTeams: await getAllPoolTeams()
	};
};
