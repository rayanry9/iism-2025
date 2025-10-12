import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPlayerCount } from '$lib/types/user';
import { getSportIdOfSport } from '$lib/utility/sport';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch, parent }) => {
	const data = await parent();

	return {
		athletics: (await (
			await fetch(PUBLIC_API_URL + `/get-player-count?sport_id=0&institute=${data.me?.institute}`)
		).json()) as GetPlayerCount,
		cricket: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${getSportIdOfSport('Cricket', 1, false)}&institute=${data.me?.institute}`
			)
		).json()) as GetPlayerCount,
		football: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${getSportIdOfSport('Football', 1, false)}&institute=${data.me?.institute}`
			)
		).json()) as GetPlayerCount,
		hockey: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${getSportIdOfSport('Hockey', 1, false)}&institute=${data.me?.institute}`
			)
		).json()) as GetPlayerCount,
		volleyball: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${getSportIdOfSport('Volleyball', 1, false)}&institute=${data.me?.institute}`
			)
		).json()) as GetPlayerCount,
		volleyballWomen: (await (
			await fetch(
				PUBLIC_API_URL +
					`/get-player-count?sport_id=${getSportIdOfSport('Volleyball', 2, false)}&institute=${data.me?.institute}`
			)
		).json()) as GetPlayerCount
	};
};
