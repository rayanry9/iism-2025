import { isValidUser } from '$lib/server/auth';
import { redirect } from '@sveltejs/kit';
import type { Actions } from './$types';

export const actions = {
	default: async ({ cookies, request }) => {
		const data = await request.formData();
		const username = data.get('username') ?? '';
		const password = data.get('password') ?? '';
		if (isValidUser(username.toString(), password.toString())) {
			cookies.set('admin', 'true', {
				path: '/',
				httpOnly: true,
				sameSite: 'lax',
				maxAge: 6 * 60 * 60
			});
			console.log('LOGGED IN');
			redirect(303, '/admin');
		} else {
			console.log('Invalid credentials');
		}
	}
} satisfies Actions;
