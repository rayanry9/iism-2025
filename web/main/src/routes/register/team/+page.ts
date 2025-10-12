import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPlayers } from '$lib/types/user';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch, url, parent }) => {
	const { me } = await parent();
	console.log(
		await (
			await fetch(
				PUBLIC_API_URL +
					`/get-players?sport_id=${url.searchParams.get('sport')}&institute=${me!.institute}`,
				{ method: 'get' }
			)
		).json()
	);
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
