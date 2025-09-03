import type { Sports } from '$lib/types/sports';

export function isSportIdStaff(id: number): boolean {
	if (id >= 16 && id <= 25) {
		return true;
	} else {
		return false;
	}
}

export function getSportFromSportId(id: number): Sports | null {
	switch (id) {
		case 1:
			return 'Badminton';
		case 2:
			return 'Badminton';
		case 3:
			return 'Basketball';
		case 4:
			return 'Basketball';
		case 5:
			return 'Cricket';
		case 6:
			return 'Hockey';
		case 7:
			return 'Football';
		case 8:
			return 'Squash';
		case 9:
			return 'Squash';
		case 10:
			return 'Table Tennis';
		case 11:
			return 'Table Tennis';
		case 12:
			return 'Tennis';
		case 13:
			return 'Tennis';
		case 14:
			return 'Volleyball';
		case 15:
			return 'Volleyball';
		case 16:
			return 'Badminton';
		case 17:
			return 'Badminton';
		case 18:
			return 'Basketball';
		case 19:
			return 'Cricket';
		case 20:
			return 'Football';
		case 21:
			return 'Squash';
		case 22:
			return 'Tennis';
		case 23:
			return 'Table Tennis';
		case 24:
			return 'Table Tennis';
		case 25:
			return 'Volleyball';
		default:
			return null;
	}
}

export function getSportIdOfSport(sport: Sports, type: number, staff: boolean) {
	if (staff) {
		switch (sport) {
			case 'Volleyball':
				return 25;
			case 'Football':
				return 20;
			case 'Cricket':
				return 19;
			case 'Badminton':
				if (type == 1) return 16;
				else return 17;
			case 'Basketball':
				return 18;
			case 'Tennis':
				return 22;
			case 'Squash':
				return 21;
			case 'Table Tennis':
				if (type == 1) return 23;
				else return 24;
			default:
				return 0;
		}
	} else {
		switch (sport) {
			case 'Volleyball':
				if (type == 1) return 14;
				else return 15;
			case 'Football':
				return 7;
			case 'Cricket':
				return 5;
			case 'Hockey':
				return 6;
			case 'Badminton':
				if (type == 1) return 1;
				else return 2;
			case 'Basketball':
				if (type == 1) return 3;
				else return 4;
			case 'Squash':
				if (type == 1) return 8;
				else return 9;
			case 'Table Tennis':
				if (type == 1) return 10;
				else return 11;
			case 'Tennis':
				if (type == 1) return 12;
				else return 13;
			case 'Aquatics Water Polo':
				return 26;
		}
	}
	return 1;
}
