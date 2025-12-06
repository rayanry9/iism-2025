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
	endTime: Date | null;
	venue: string | null;
	type: number;
	matchName: string | null;
	liveStreamLink: string | null;
}

export interface GetAllAthleticMatchesResponse {
	id: number;
	sportId: number;
	participantsTempText: string;
	participants: number[];
	startTime: Date;
	endTime: Date | null;
	venue: string | null;
	status: number;
	type: number;
	matchName: string | null;
	liveStreamLink: string | null;
}
