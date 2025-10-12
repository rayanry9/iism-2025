import { PUBLIC_API_URL } from '$env/static/public';
import type { GetAllInstitutesResponse } from '$lib/types/insitutes';

export async function getAllInstitutes(
	fetch: typeof globalThis.fetch
): Promise<Array<GetAllInstitutesResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-institutes`);
	return (await data.json()) as Array<GetAllInstitutesResponse>;
}
