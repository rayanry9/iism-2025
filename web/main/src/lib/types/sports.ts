export type Sports =
	| 'Athletics'
	| 'Football'
	| 'Cricket'
	| 'Volleyball'
	| 'Hockey'
	| 'Badminton'
	| 'Basketball'
	| 'Squash'
	| 'Aquatics Water Polo'
	| 'Table Tennis'
	| 'Chess'
	| 'Tennis';

export type SportType = 'Male' | 'Female' | 'Mixed';

export interface GetAllSportsResponse {
	id: number;
	name: string;
	staff: boolean;
	type: number;
}
export interface GetAllAthleticSubSportsDataResponse {
	sportId: number;
	name: string;
	type: number;
	count: number;
	reservedCount: number;
}
