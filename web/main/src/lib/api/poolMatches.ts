import { PUBLIC_API_URL } from '$env/static/public';
import type {
	GetAllAthleticMatchesResponse,
	GetAllPoolMatchesResponse
} from '$lib/types/poolMatches';

export async function getAllPoolMatches(
	fetch: typeof globalThis.fetch
): Promise<Array<GetAllPoolMatchesResponse>> {
	const data = await fetch(PUBLIC_API_URL + `/get-all-pool-matches`);
	return ((await data.json()) as GetAllPoolMatchesResponse[]).map((val) => {
		val.startTime = new Date(val.startTime);
		if (val.endTime) {
			val.endTime = new Date(val.endTime);
		}
		return val;
	});
}

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
