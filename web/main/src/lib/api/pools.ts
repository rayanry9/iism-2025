import { PUBLIC_API_URL } from '$env/static/public';
import type { GetAllPoolTeamsResponse, GetPoolsBySportIdResponse } from '$lib/types/pools';

export async function getPoolsBySportId(id: number): Promise<Array<GetPoolsBySportIdResponse>> {
	let data = await fetch(PUBLIC_API_URL + `/get-pools-by-sport-id?sportId=${id}`);
	return (await data.json()) satisfies Array<GetPoolsBySportIdResponse>;
}
export async function getAllPoolTeams(): Promise<Array<GetAllPoolTeamsResponse>> {
	let data = await fetch(PUBLIC_API_URL + `/get-all-pool-teams`);
	return (await data.json()) satisfies Array<GetAllPoolTeamsResponse>;
}
