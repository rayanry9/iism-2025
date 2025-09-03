import type { Sports } from '$lib/types/sports';
import footballImg from '$lib/assets/sport/football.webp';
import volleyballImg from '$lib/assets/sport/volleyball.webp';
import hockeyImg from '$lib/assets/sport/hockey.webp';
import athleticsImg from '$lib/assets/sport/athletics.webp';
import cricketImg from '$lib/assets/sport/cricket.webp';

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
		default:
			return '';
	}
}
