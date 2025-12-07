import { PUBLIC_API_URL } from '$env/static/public';
import type { GetAllSportsResponse } from '$lib/types/sports';

export async function getAllSports(
	fetch: typeof globalThis.fetch
): Promise<Array<GetAllSportsResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-sports`);
	return (await data.json()) as Array<GetAllSportsResponse>;
}
