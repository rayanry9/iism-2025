import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPlayerCount, GetPlayers } from '$lib/types/user';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ fetch, url, parent }) => {
	const { me } = await parent();
	return {
		playerData: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-players?sport_id=${url.searchParams.get('sport')}&institute=${me!.institute}`,
				{ method: 'get' }
			)
		).json()) as GetPlayers[]
	};
};
