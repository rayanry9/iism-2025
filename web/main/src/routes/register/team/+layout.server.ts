import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPlayerCount, GetPlayers } from '$lib/types/user';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ fetch, url, parent }) => {
	const { me } = await parent();
	return {
		playerCount: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${url.searchParams.get('sport')}&institute=${me!.institute}`
			)
		).json()) as GetPlayerCount
	};
};
