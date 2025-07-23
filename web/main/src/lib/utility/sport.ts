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
			default:
				return 0;
		}
	}
}
