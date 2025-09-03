export interface GetAllPoolMatchesResponse {
	id: number;
	sportId: number;
	team1TempName: string;
	team1Id: number | null;
	team2TempName: string;
	team2Id: number | null;
	status: number;
	result: number | null;
	startTime: Date;
	endTime: Date;
	venue: string | null;
	type: number;
	matchName: string | null;
	liveStreamLink: string | null;
}
