import { PUBLIC_API_URL } from '$env/static/public';
import type { Actions } from './$types';

export const actions = {
	default: async ({ request, fetch }) => {
		let data = await request.formData();
		data.append(
			'sports',
			JSON.stringify([
				{
					sportId: parseInt(data.get('sport_id_1')!.toString()),
					secondary: false,
					reserve: false,
					extra: data.get('extra')
				}
			])
		);
		data.delete('extra');
		data.delete('sport_id_1');
		const res = await fetch(PUBLIC_API_URL + '/register', {
			method: 'POST',
			credentials: 'include',
			body: data
		});
		if (res.status == 200) {
			return {
				success: true
			};
		} else {
			return {
				success: false
			};
		}
	}
} satisfies Actions;
