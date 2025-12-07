export const MatchStatus = {
	MatchPending: 1,
	MatchOngoing: 2,
	MatchConcluded: 3
};
export const PoolMatchType = {
	PoolMatchLeague: 1,
	PoolMatchPreQuarter: 2,
	PoolMatchQuarterFinal: 3,
	PoolMatchSemiFinal: 4,
	PoolMatchFinal: 5
};
export const PoolMatchResult = {
	PoolMatchTeam1Win: 1,
	PoolMatchTeam2Win: 2,
	PoolMatchDraw: 3
};

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
