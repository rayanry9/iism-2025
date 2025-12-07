import { PUBLIC_API_URL } from '$env/static/public';
import type { GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';

export async function getAllAthleticMatches(
	fetch: typeof globalThis.fetch
): Promise<Array<GetAllAthleticMatchesResponse>> {
	const data = await fetch(PUBLIC_API_URL + `/get-all-athletic-matches`);
	return ((await data.json()) as GetAllAthleticMatchesResponse[]).map((val) => {
		val.startTime = new Date(val.startTime);
		if (val.endTime) {
			val.endTime = new Date(val.endTime);
		}
		return val;
	});
}
