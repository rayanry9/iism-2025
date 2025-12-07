export const AthleticMatchType = {
	AthleticHeats: 1,
	AthleticQuarterFinal: 2,
	AthleticSemiFinal: 3,
	AthleticFinal: 4
};
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
	liveStreamLink: string | null;
}
