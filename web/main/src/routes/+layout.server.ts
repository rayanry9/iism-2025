import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = ({ cookies }) => {
	if (cookies.get('jwt')) {
		return {
			isLoggedIn: true
		};
	} else {
		return {
			isLoggedIn: false
		};
	}
};
