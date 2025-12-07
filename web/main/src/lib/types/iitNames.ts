export type IITNames =
	| 'Bombay'
	| 'Bhubaneswar'
	| 'Bhilai'
	| '(BHU) Varanasi'
	| 'Delhi'
	| 'Dharwad'
	| 'Guwahati'
	| 'Gandhinagar'
	| 'Goa'
	| 'Hyderabad'
	| 'Indore'
	| '(ISM) Dhanbad'
	| 'Jodhpur'
	| 'Jammu'
	| 'Kanpur'
	| 'Kharagpur'
	| 'Madras'
	| 'Mandi'
	| 'Patna'
	| 'Palakkad'
	| 'Roorkee'
	| 'Ropar'
	| 'Tirupati';

export function getIITShortCode(iit: IITNames): string {
	switch (iit) {
		case 'Bombay':
			return 'B';
		case 'Bhubaneswar':
			return 'BBS';
		case 'Bhilai':
			return 'BH';
		case '(BHU) Varanasi':
			return 'BHU';
		case 'Delhi':
			return 'D';
		case 'Dharwad':
			return 'DH';
		case 'Guwahati':
			return 'G';
		case 'Gandhinagar':
			return 'GN';
		case 'Goa':
			return 'GOA';
		case 'Hyderabad':
			return 'H';
		case 'Indore':
			return 'I';
		case '(ISM) Dhanbad':
			return 'ISM';
		case 'Jodhpur':
			return 'J';
		case 'Jammu':
			return 'JMU';
		case 'Kanpur':
			return 'K';
		case 'Kharagpur':
			return 'KGP';
		case 'Madras':
			return 'M';
		case 'Mandi':
			return 'MD';
		case 'Patna':
			return 'P';
		case 'Palakkad':
			return 'PKD';
		case 'Roorkee':
			return 'R';
		case 'Ropar':
			return 'RPR';
		case 'Tirupati':
			return 'TP';
	}
}
