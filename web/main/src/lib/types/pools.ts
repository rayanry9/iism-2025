export interface GetPoolsBySportIdResponseTeamData {
	id: number;
	tempName: string;
	name: string | null;
}
export interface GetPoolsBySportIdResponse {
	id: number;
	name: string;
	teams: Array<GetPoolsBySportIdResponseTeamData>;
}

export interface GetAllPoolTeamsResponse {
	id: number;
	tempName: string;
	instituteId: number | null;
	poolId: number;
}
