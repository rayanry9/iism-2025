import type { PageLoad } from './$types';
import type { GetAllAthleticSubSportsDataResponse } from '$lib/types/sports';
import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPlayerData } from '$lib/types/user';
import { getSportMaxRegistrants, isSportFemale, isSportIdStaff } from '$lib/utility/sport';
import { redirect } from '@sveltejs/kit';

export const ssr = false;

export const load: PageLoad = async ({ parent, fetch, url }) => {
	const par = await parent();
	const sportId = parseInt(url.searchParams.get('sport')!);

	if (
		par.playerCount.count + par.playerCount.reserveCount + par.playerCount.secondaryCount >=
			getSportMaxRegistrants(sportId) &&
		!url.searchParams.has('edit')
	) {
		throw redirect(307, '/register/team?sport=' + sportId);
	}

	if (sportId >= -8 && sportId <= 0) {
		return {
			athleticSubSport: (await (
				await fetch(
					PUBLIC_API_URL +
						`/get-all-athletic-sub-sports-data?institute=${par.me?.institute}&sportId=${sportId}`,
					{ method: 'GET', credentials: 'include' }
				)
			).json()) as GetAllAthleticSubSportsDataResponse[],
			playerData: url.searchParams.has('edit')
				? ((await (
						await fetch(PUBLIC_API_URL + '/get-player-data?id=' + url.searchParams.get('edit'))
					).json()) as GetPlayerData)
				: null
		};
	} else {
		let athleticId = 0;
		if (isSportFemale(sportId)) {
			if (isSportIdStaff(sportId)) {
				athleticId = -4;
			} else {
				athleticId = -1;
			}
		} else {
			if (isSportIdStaff(sportId)) {
				athleticId = -3;
			}
		}
		return {
			athleticSubSport: (await (
				await fetch(
					PUBLIC_API_URL +
						`/get-all-athletic-sub-sports-data?institute=${par.me?.institute}&sportId=${athleticId}`,
					{ method: 'GET', credentials: 'include' }
				)
			).json()) as GetAllAthleticSubSportsDataResponse[],
			playerData: url.searchParams.has('edit')
				? ((await (
						await fetch(PUBLIC_API_URL + '/get-player-data?id=' + url.searchParams.get('edit'))
					).json()) as GetPlayerData)
				: null
		};
	}
};
