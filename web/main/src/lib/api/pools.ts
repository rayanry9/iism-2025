import { PUBLIC_API_URL } from '$env/static/public';
import type { GetPoolsBySportIdResponse } from '$lib/types/pools';

export async function getPoolsBySportId(id: number): Promise<Array<GetPoolsBySportIdResponse>> {
	let data = await fetch(PUBLIC_API_URL + `/get-pools-by-sport-id?sportId=${id}`);
	return (await data.json()) satisfies Array<GetPoolsBySportIdResponse>;
}
