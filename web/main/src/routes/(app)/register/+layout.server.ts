import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { PUBLIC_API_URL, PUBLIC_URL } from '$env/static/public';
import type { UserDetails } from '$lib/types/user';
import type { GetAllSportsResponse } from '$lib/types/sports';

export const load: LayoutServerLoad = async ({ cookies, url, fetch }) => {
	if (!cookies.get('jwt') && url.pathname != '/register/login') {
		throw redirect(307, '/register/login');
	}
	const res = await fetch(`${PUBLIC_API_URL}/me`, { credentials: 'include' });
	let me = null;
	if (res.status == 200) {
		me = (await res.json()) as UserDetails | null;
	}

	if (me && me.role != 3) {
		cookies.set('jwt', '', {
			path: '/',
			maxAge: -1,
			httpOnly: true,
			sameSite: 'lax',
			domain: import.meta.env.PROD
				? PUBLIC_URL.split('://')[1]
				: PUBLIC_URL.split('://')[1].split(':')[0]
		});
		throw redirect(307, '/register/login');
	}
	return {
		me: me,
		sports: (await (
			await fetch(PUBLIC_API_URL + '/get-all-sports')
		).json()) as GetAllSportsResponse[]
	};
};
