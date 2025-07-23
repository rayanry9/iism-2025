import { PUBLIC_API_URL } from '$env/static/public';
import type {
	GetAllInstitutesResponse,
	GetAllPoolsResponse,
	GetAllPoolTeamsResponse,
	GetAllSportsResponse
} from '$lib/types/data';

export async function getAllInstitutes(): Promise<Array<GetAllInstitutesResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-institutes`);
	return (await data.json()) satisfies Array<GetAllInstitutesResponse>;
}

export async function getAllSports(): Promise<Array<GetAllSportsResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-sports`);
	return (await data.json()) satisfies Array<GetAllSportsResponse>;
}

export async function getAllPools(): Promise<Array<GetAllPoolsResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-pools`);
	return (await data.json()) satisfies Array<GetAllPoolsResponse>;
}

export async function getAllPoolTeams(): Promise<Array<GetAllPoolTeamsResponse>> {
	const data = await fetch(`${PUBLIC_API_URL}/get-all-pool-teams`);
	return (await data.json()) satisfies Array<GetAllPoolTeamsResponse>;
}
