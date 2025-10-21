import type { PageLoad } from './$types';
import type { GetAllAthleticSubSportsDataResponse } from '$lib/types/sports';
import { PUBLIC_API_URL } from '$env/static/public';

export const ssr = false;

export const load: PageLoad = async ({ parent, fetch, url }) => {
	const par = await parent();
	const sportId = parseInt(url.searchParams.get('sport')!);

	if (sportId <= 0) {
		return {
			athleticSubSport: (await (
				await fetch(
					PUBLIC_API_URL +
						`/get-all-athletic-sub-sports-data?institute=${par.me?.institute}&sportId=${sportId}`,
					{ method: 'GET', credentials: 'include' }
				)
			).json()) as GetAllAthleticSubSportsDataResponse[]
		};
	}
};
