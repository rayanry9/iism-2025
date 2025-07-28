import type { Sports } from '$lib/types/other';
import footballImg from '$lib/assets/sports/football.webp';
import volleyballImg from '$lib/assets/sports/volleyball.webp';
import hockeyImg from '$lib/assets/sports/hockey.webp';
import badmintonImg from '$lib/assets/sports/badminton.webp';
import cricketImg from '$lib/assets/sports/cricket.webp';
import basketballImg from '$lib/assets/sports/basketball.webp';
import squashImg from '$lib/assets/sports/squash.webp';
import tableTennisImg from '$lib/assets/sports/table-tennis.webp';
import tennisImg from '$lib/assets/sports/tennis.webp';

export function getSportImageSrc(sport: Sports): string {
	switch (sport) {
		case 'Football':
			return footballImg;
		case 'Cricket':
			return cricketImg;
		case 'Volleyball':
			return volleyballImg;
		case 'Hockey':
			return hockeyImg;
		case 'Badminton':
			return badmintonImg;
		case 'Basketball':
			return basketballImg;
		case 'Squash':
			return squashImg;
		case 'Table Tennis':
			return tableTennisImg;
		case 'Tennis':
			return tennisImg;
	}
}

export function getSportId(sport: Sports, type: number, staff: boolean): number {
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
		}
	}
}
