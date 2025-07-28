import { isValidUser } from '$lib/server/auth';
import { redirect } from '@sveltejs/kit';
import type { Actions } from './$types';
import { resolve } from '$app/paths';

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
				maxAge: 6 * 60 * 60,
				secure: false
			});
			console.log('LOGGED IN');
			redirect(303, resolve('/admin'));
		} else {
			console.log('Invalid credentials');
		}
	}
} satisfies Actions;
