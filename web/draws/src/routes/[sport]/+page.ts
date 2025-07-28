import { getAllInstitutes, getAllPools, getAllPoolTeams, getAllSports } from '$lib/api/data';
import { error } from '@sveltejs/kit';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ params }) => {
	const sportData = await getAllSports();
	try {
		let sportId = parseInt(params.sport);
		if (sportData.find((val) => val.id == sportId) == undefined) {
			error(404);
		}
	} catch (_) {
		error(404);
	}
	return {
		institutes: await getAllInstitutes(),
		sports: sportData,
		pools: await getAllPools(),
		poolTeams: await getAllPoolTeams()
	};
};
