import { PUBLIC_API_URL } from '$env/static/public';
import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';

export async function getAllPoolMatches(): Promise<Array<GetAllPoolMatchesResponse>> {
	const data = await fetch(PUBLIC_API_URL + `/get-all-pool-matches`);
	return ((await data.json()) as GetAllPoolMatchesResponse[]).map((val) => {
		val.startTime = new Date(val.startTime);
		if (val.endTime) {
			val.endTime = new Date(val.endTime);
		}
		return val;
	});
}
