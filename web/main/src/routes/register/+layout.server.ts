import { redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { PUBLIC_API_URL, PUBLIC_URL } from '$env/static/public';
import type { UserDetails } from '$lib/types/user';

export const load: LayoutServerLoad = async ({ cookies, url, fetch }) => {
	if (!cookies.get('jwt') && url.pathname != '/register/login') {
		redirect(307, '/register/login');
	}
	if (url.pathname == '/register/login') {
		return {
			me: null
		};
	}
	const me = (await (await fetch(`${PUBLIC_API_URL}/me`)).json()) as UserDetails;
	if (me.role != 3) {
		cookies.set('jwt', '', {
			path: '/',
			maxAge: -1,
			httpOnly: true,
			sameSite: 'lax',
			domain: import.meta.env.PROD
				? PUBLIC_URL.split('://')[1]
				: PUBLIC_URL.split('://')[1].split(':')[0]
		});
		redirect(307, '/register/login');
	}
	return {
		me: me
	};
};
