import { getAllInstitutes } from '$lib/api/institutes';
import { getAllPoolMatches } from '$lib/api/poolMatches';
import type { LayoutLoad } from './$types';

export const load: LayoutLoad = async () => {
	return {
		poolMatches: await getAllPoolMatches(),
		institutes: await getAllInstitutes()
	};
};
