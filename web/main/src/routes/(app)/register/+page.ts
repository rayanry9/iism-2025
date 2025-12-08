import { PUBLIC_API_URL } from '$env/static/public';
import { globals } from '$lib/state.svelte';
import type { GetPlayerCount } from '$lib/types/user';
import { getRegisterableSports, getSportIdOfSport } from '$lib/utility/sport';
import { redirect } from '@sveltejs/kit';
import type { PageLoad } from './$types';
import { browser } from '$app/environment';

export const load: PageLoad = async ({ fetch, parent }) => {
	const data = await parent();
	if (browser) {
		if (data.me != undefined) {
			if (data.me.staff != globals.staff) {
				throw redirect(307, '/register/login');
			}
		}
	}
	const promiseData = Promise.all(
		getRegisterableSports(globals.staff, data.sports!).map((sport) => {
			return fetch(
				PUBLIC_API_URL + `/get-player-count?sport_id=${sport.id}&institute=${data.me?.institute}`
			);
		})
	);
	return {
		playerCountData: await Promise.all(
			(await promiseData).map(async (val) => (await val.json()) as GetPlayerCount)
		)
	};

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
