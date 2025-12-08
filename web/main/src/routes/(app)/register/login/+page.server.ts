import { redirect } from '@sveltejs/kit';
import type { Actions } from './$types';
import { PUBLIC_API_URL, PUBLIC_URL } from '$env/static/public';

export const actions = {
	default: async ({ request, fetch, cookies }) => {
		const res = await fetch(PUBLIC_API_URL + '/login', {
			method: 'post',
			credentials: 'include',
			body: await request.formData()
		});
		if (res.status == 401) {
			return {
				success: false,
				text: (await res.json())['message']
			};
		} else if (res.status == 200) {
			cookies.set('jwt', res.headers.getSetCookie()[0].split(';')[0].split('=')[1], {
				path: '/',
				maxAge: 60 * 60 * 6,
				httpOnly: true,
				sameSite: 'lax',
				domain: import.meta.env.PROD
					? PUBLIC_URL.split('://')[1]
					: PUBLIC_URL.split('://')[1].split(':')[0]
			});
			redirect(307, '/register');
		} else {
			console.log(await res.json());
		}
	}
} satisfies Actions;
