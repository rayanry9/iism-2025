import { PUBLIC_API_URL } from '$env/static/public';
import type { Sports } from '$lib/types/sports';
import { getSportIdOfSport } from '$lib/utility/sport';
import type { PageLoad } from './$types';

export const load: PageLoad = async ({ fetch, parent, url }) => {
	const data = await parent();
	let selectedSport = url.searchParams.get('sport') as Sports | undefined;

	return {
		matchData: (await Promise.all(
			(
				await Promise.all(
					data.poolMatches
						.filter(
							(val) =>
								val.status == 2 &&
								(selectedSport == undefined ||
									val.sportId == getSportIdOfSport(selectedSport!, 1, false) ||
									val.sportId == getSportIdOfSport(selectedSport!, 1, true) ||
									val.sportId == getSportIdOfSport(selectedSport!, 2, false) ||
									val.sportId == getSportIdOfSport(selectedSport!, 2, true))
						)
						.map((val) => {
							return fetch(PUBLIC_API_URL + '/get-pool-match-data-by-id?match_id=' + val.id);
						})
				)
			).map((res) => res.json())
		)) as GetPoolMatchDataById[]
	};
};
