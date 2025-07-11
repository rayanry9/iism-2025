import iitmLogo from '$lib/assets/logos/iitm.webp';
import iithLogo from '$lib/assets/logos/iith.webp';
import iitrLogo from '$lib/assets/logos/iitr.webp';
import iitgLogo from '$lib/assets/logos/iitg.webp';
import type { IITNames } from '$lib/types/iitNames';

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
	}
}
