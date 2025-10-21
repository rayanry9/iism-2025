import type { Sports } from '$lib/types/sports';
import footballImg from '$lib/assets/sport/football.webp';
import volleyballImg from '$lib/assets/sport/volleyball.webp';
import hockeyImg from '$lib/assets/sport/hockey.webp';
import athleticsImg from '$lib/assets/sport/athletics.webp';
import cricketImg from '$lib/assets/sport/cricket.webp';
import badmintonImg from '$lib/assets/sport/badminton.webp';
import basketballImg from '$lib/assets/sport/basketball.webp';
import squashImg from '$lib/assets/sport/squash.webp';
import chessImg from '$lib/assets/sport/tennis.webp';
import tennisImg from '$lib/assets/sport/tennis.webp';
import ttImg from '$lib/assets/sport/table-tennis.webp';

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
		case 'Athletics':
			return athleticsImg;
		case 'Badminton':
			return badmintonImg;
		case 'Basketball':
			return basketballImg;
		case 'Squash':
			return squashImg;
		case 'Tennis':
			return tennisImg;
		case 'Table Tennis':
			return ttImg;
		case 'Chess':
			return chessImg;
		default:
			return '';
	}
}
