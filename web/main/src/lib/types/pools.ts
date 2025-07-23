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
