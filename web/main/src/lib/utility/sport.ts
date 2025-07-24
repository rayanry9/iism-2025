import type { Sports, SportType } from '$lib/types/sports';

export function getSportIdOfSport(sport: Sports, type: SportType, staff: boolean): number {
	if (staff) {
		//TODO
		return 0;
	} else {
		switch (sport) {
			case 'Volleyball':
				if (type == 'Male') return 14;
				else if (type == 'Female') return 15;
			case 'Football':
				return 7;
			case 'Cricket':
				return 5;
			case 'Hockey':
				return 6;
			case 'Athletics':
			default:
				return 0;
		}
	}
}
