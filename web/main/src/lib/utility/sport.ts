import type { GetAllSportsResponse, Sports } from '$lib/types/sports';

export function getSportsAll(staff: boolean) {
	if (!staff) {
		return ['Athletics', 'Cricket', 'Football', 'Hockey', 'Volleyball'] satisfies Array<Sports>;
	} else {
		return [
			'Athletics',
			'Badminton',
			'Basketball',
			'Chess',
			'Cricket',
			'Football',
			'Table Tennis',
			'Tennis',
			'Volleyball',
			'Squash'
		] satisfies Array<Sports>;
	}
}

export function isSportIdStaff(id: number): boolean {
	if ((id >= 16 && id <= 25) || (id >= -6 && id <= -3) || id == -11 || (id >= 59 && id <= 83)) {
		return true;
	} else {
		return false;
	}
}

export function getRegisterableSports(
	staff: boolean,
	allSports: GetAllSportsResponse[]
): GetAllSportsResponse[] {
	if (staff) {
		const newArr = allSports.filter(
			(sport) => sport.staff && (sport.type == 1 || sport.type == 2 || sport.type == 3)
		);
		newArr.push({ id: -3, name: 'Athletics', staff: true, type: 1 });
		newArr.push({ id: -4, name: 'Athletics', staff: true, type: 2 });
		newArr.push({ id: -11, name: 'Sports Officer/Coach/PTI/Ground Staff', staff: true, type: -1 });
		return newArr.sort((a, b) => a.name.localeCompare(b.name));
	} else {
		return [
			{ id: -10, name: 'Sports Officer/Coach/PTI/Ground Staff', staff: false, type: -1 },
			{ name: 'Athletics', staff: false, type: 1, id: 0 },
			{ name: 'Athletics', staff: false, type: 2, id: -1 },
			{ name: 'Athletics', staff: false, type: 3, id: -2 },
			{ name: 'Cricket', staff: false, type: 1, id: getSportIdOfSport('Cricket', 1, false) },
			{ name: 'Football', staff: false, type: 1, id: getSportIdOfSport('Football', 1, false) },
			{ name: 'Hockey', staff: false, type: 1, id: getSportIdOfSport('Hockey', 1, false) },
			{ name: 'Volleyball', staff: false, type: 1, id: getSportIdOfSport('Volleyball', 1, false) },
			{ name: 'Volleyball', staff: false, type: 2, id: getSportIdOfSport('Volleyball', 2, false) }
		].sort((a, b) => a.name.localeCompare(b.name));
	}
}

export function getSportFromSportId(id: number): Sports | null {
	switch (id) {
		case -5:
		case -4:
		case -3:
		case -2:
		case -1:
		case 0:
			return 'Athletics';
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
		case 59:
			return 'Chess';
		default:
			return null;
	}
}

export function getSportIdOfSport(sport: Sports, type: number, staff: boolean) {
	if (staff) {
		switch (sport) {
			case 'Athletics':
				if (type == 1) return -3;
				else if (type == 2) return -4;
				else if (type == 3) return -5;
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
			case 'Chess':
				return 59;
			default:
				return 0;
		}
	} else {
		switch (sport) {
			case 'Athletics':
				if (type == 1) return 0;
				else if (type == 2) return -1;
				else if (type == 3) return -2;
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

export function isSportMixed(id: number) {
	return id == 58;
}

export function isSportFemale(id: number) {
	switch (id) {
		case 2:
		case 4:
		case 9:
		case 11:
		case 13:
		case 15:
		case 17:
		case 24:
		case 45:
		case 46:
		case 47:
		case 48:
		case 49:
		case 50:
		case 51:
		case 52:
		case 53:
		case 54:
		case 55:
		case 56:
		case 57:
		case 62:
		case 76:
		case 77:
		case 78:
		case 79:
		case 80:
		case 81:
		case 82:
		case 83:
		case -1:
		case -4:
			return true;
		default:
			return false;
	}
}

export function getSportMaxRegistrants(sportId: number): number {
	switch (sportId) {
		case -11:
			return 2;
		case -10:
			return 20;
		case -4:
			return 7 * 3 + 1 * 6;
		case -3:
			return 12 * 3 + 1 * 6;
		case -2:
			return 6;
		case -1:
			return 13 * 3 + 2 * 6;
		case 0:
			return 16 * 3 + 2 * 6;
		case 1:
			return 5;
		case 2:
		case 11:
			return 3;
		case 3:
		case 4:
		case 14:
		case 15:
			return 12;
		case 5:
		case 6:
		case 7:
			return 16;
		case 8:
		case 9:
		case 10:
		case 12:
		case 13:
		case 16:
		case 17:
		case 21:
		case 22:
		case 23:
		case 24:
		case 59:
			return 4;
		case 18:
			return 11;
		case 19:
		case 20:
			return 17;
		case 25:
			return 11;
		default:
			return -1;
	}
}
