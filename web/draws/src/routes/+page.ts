import { getAllSports } from '$lib/api/data';
import type { PageLoad } from './$types';

export const load: PageLoad = async () => {
	return {
		sports: await getAllSports()
	};
};
