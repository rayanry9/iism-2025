import { redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { updatePoolTeam } from '$lib/api/update';

export const load: PageServerLoad = ({ cookies }) => {
	const admin = cookies.get('admin');
	if (admin == undefined) {
		redirect(307, '/admin/login');
	}
	if (admin != 'true') {
		redirect(307, '/admin/login');
	}
};

export const actions = {
	update: async ({ request }) => {
		const formData = await request.formData();
		const instituteId = formData.get('instituteId') ?? '';
		const poolTeamId = formData.get('poolTeamId') ?? '';
		const upcoming = formData.get('upcoming') ?? false;

		return await updatePoolTeam(
			parseInt(poolTeamId.toString()),
			upcoming == 'true',
			parseInt(instituteId.toString())
		);
	},
	logout: ({ cookies }) => {
		cookies.delete('admin', { path: '/' });
	}
} satisfies Actions;
