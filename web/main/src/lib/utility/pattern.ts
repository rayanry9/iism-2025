import iitmPattern from '$lib/assets/patterns/madras.webp';
import iithPattern from '$lib/assets/patterns/blank.webp';
import iitrPattern from '$lib/assets/patterns/roorkee.webp';
import iitgPattern from '$lib/assets/patterns/guwahati.webp';
import iitbPattern from '$lib/assets/patterns/bombay.webp';
import iitbbsPattern from '$lib/assets/patterns/bhuvneshwar.webp';
import iitbhPattern from '$lib/assets/patterns/bhilai.webp';
import iitbhuPattern from '$lib/assets/patterns/blank.webp';
import iitdPattern from '$lib/assets/patterns/delhi.webp';
import iitdhPattern from '$lib/assets/patterns/dharwad.webp';
import iitgnPattern from '$lib/assets/patterns/gandhinagar.webp';
import iitgoaPattern from '$lib/assets/patterns/goa.webp';
import iitiPattern from '$lib/assets/patterns/blank.webp';
import iitismPattern from '$lib/assets/patterns/dhanbad.webp';
import iitjPattern from '$lib/assets/patterns/jodhpur.webp';
import iitjmuPattern from '$lib/assets/patterns/jammu.webp';
import iitkPattern from '$lib/assets/patterns/kanpur.webp';
import iitkgpPattern from '$lib/assets/patterns/blank.webp';
import iitmdPattern from '$lib/assets/patterns/mandi.webp';
import iitpPattern from '$lib/assets/patterns/patna.webp';
import iitpkdPattern from '$lib/assets/patterns/palakad.webp';
import iitrprPattern from '$lib/assets/patterns/ropar.webp';
import iittpPattern from '$lib/assets/patterns/tirupati.webp';
import type { IITNames } from '$lib/types/iitNames';

export function getIITImgSrc(name: IITNames): string {
    switch (name) {
        case 'Madras':
            return iitmPattern;
        case 'Hyderabad':
            return iithPattern;
        case 'Guwahati':
            return iitgPattern;
        case 'Roorkee':
            return iitrPattern;
        case 'Bombay':
            return iitbPattern;
        case 'Bhubaneswar':
            return iitbbsPattern;
        case 'Bhilai':
            return iitbhPattern;
        case '(BHU) Varanasi':
            return iitbhuPattern;
        case 'Delhi':
            return iitdPattern;
        case 'Dharwad':
            return iitdhPattern;
        case 'Gandhinagar':
            return iitgnPattern;
        case 'Goa':
            return iitgoaPattern;
        case 'Indore':
            return iitiPattern;
        case '(ISM) Dhanbad':
            return iitismPattern;
        case 'Jodhpur':
            return iitjPattern;
        case 'Jammu':
            return iitjmuPattern;
        case 'Kanpur':
            return iitkPattern;
        case 'Kharagpur':
            return iitkgpPattern;
        case 'Mandi':
            return iitmdPattern;
        case 'Patna':
            return iitpPattern;
        case 'Palakkad':
            return iitpkdPattern;
        case 'Ropar':
            return iitrprPattern;
        case 'Tirupati':
            return iittpPattern;
    }
}

export function getAllIITNames(): IITNames[] {
    return [
        'Bombay',
        'Bhubaneswar',
        'Bhilai',
        '(BHU) Varanasi',
        'Delhi',
        'Dharwad',
        'Guwahati',
        'Gandhinagar',
        'Goa',
        'Hyderabad',
        'Indore',
        '(ISM) Dhanbad',
        'Jodhpur',
        'Jammu',
        'Kanpur',
        'Kharagpur',
        'Madras',
        'Mandi',
        'Patna',
        'Palakkad',
        'Roorkee',
        'Ropar',
        'Tirupati'
    ];
}
