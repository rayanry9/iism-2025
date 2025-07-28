import iitmLogo from '$lib/assets/logos/iitm.webp';
import iithLogo from '$lib/assets/logos/iith.webp';
import iitrLogo from '$lib/assets/logos/iitr.webp';
import iitgLogo from '$lib/assets/logos/iitg.webp';
import iitbLogo from '$lib/assets/logos/iitb.webp';
import iitbbsLogo from '$lib/assets/logos/iitbbs.webp';
import iitbhLogo from '$lib/assets/logos/iitbh.webp';
import iitbhuLogo from '$lib/assets/logos/iitbhu.webp';
import iitdLogo from '$lib/assets/logos/iitd.webp';
import iitdhLogo from '$lib/assets/logos/iitdh.webp';
import iitgnLogo from '$lib/assets/logos/iitgn.webp';
import iitgoaLogo from '$lib/assets/logos/iitgoa.webp';
import iitiLogo from '$lib/assets/logos/iiti.webp';
import iitismLogo from '$lib/assets/logos/iitism.webp';
import iitjLogo from '$lib/assets/logos/iitj.webp';
import iitjmuLogo from '$lib/assets/logos/iitjmu.webp';
import iitkLogo from '$lib/assets/logos/iitk.webp';
import iitkgpLogo from '$lib/assets/logos/iitkgp.webp';
import iitmdLogo from '$lib/assets/logos/iitmd.webp';
import iitpLogo from '$lib/assets/logos/iitp.webp';
import iitpkdLogo from '$lib/assets/logos/iitpkd.webp';
import iitrprLogo from '$lib/assets/logos/iitrpr.webp';
import iittpLogo from '$lib/assets/logos/iittp.webp';
import type { IITNames } from '$lib/types/other';

export function getIITImgSrc(name: IITNames): string {
	switch (name) {
		case 'Madras':
			return iitmLogo;
		case 'Hyderabad':
			return iithLogo;
		case 'Guwahati':
			return iitgLogo;
		case 'Roorkee':
			return iitrLogo;
		case 'Bombay':
			return iitbLogo;
		case 'Bhubaneswar':
			return iitbbsLogo;
		case 'Bhilai':
			return iitbhLogo;
		case '(BHU) Varanasi':
			return iitbhuLogo;
		case 'Delhi':
			return iitdLogo;
		case 'Dharwad':
			return iitdhLogo;
		case 'Gandhinagar':
			return iitgnLogo;
		case 'Goa':
			return iitgoaLogo;
		case 'Indore':
			return iitiLogo;
		case '(ISM) Dhanbad':
			return iitismLogo;
		case 'Jodhpur':
			return iitjLogo;
		case 'Jammu':
			return iitjmuLogo;
		case 'Kanpur':
			return iitkLogo;
		case 'Kharagpur':
			return iitkgpLogo;
		case 'Mandi':
			return iitmdLogo;
		case 'Patna':
			return iitpLogo;
		case 'Palakkad':
			return iitpkdLogo;
		case 'Ropar':
			return iitrprLogo;
		case 'Tirupati':
			return iittpLogo;
	}
}
