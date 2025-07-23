export interface GetAllInstitutesResponse {
	id: number;
	name: string;
}
export interface GetAllPoolsResponse {
	id: number;
	name: string;
	sportId: number;
}

export interface GetAllPoolTeamsResponse {
	id: number;
	tempName: string;
	instituteId: number | null;
	poolId: number;
}

export type SportType = 1 | 2 | 3;

export interface GetAllSportsResponse {
	id: number;
	name: string;
	staff: boolean;
	type: SportType;
}
