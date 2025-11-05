import { PUBLIC_API_URL } from '$env/static/public';
import type { Actions } from './$types';

export const actions = {
	default: async ({ request, fetch }) => {
		let data = await request.formData();
		console.log(data.entries().toArray());
		if (data.get('sport_1') != '-10') {
			let sportData = [
				{
					sportId: parseInt(data.get('sport_1')!.toString()),
					secondary: false,
					reserve: (data.get('reserve_1') ?? '') == 'on',
					extra: data.get('extra_1')
				}
			];
			data.delete('extra_1');
			data.delete('sport_1');
			data.delete('reserve_1');
			for (let i = 2; data.has('sport_' + i); i++) {
				sportData.push({
					sportId: parseInt(data.get('sport_' + i)!.toString()),
					secondary: !((data.get('reserve_' + i) ?? '') == 'on'),
					reserve: (data.get('reserve_' + i) ?? '') == 'on',
					extra: data.get('extra_' + i)
				});
				data.delete('extra_' + i);
				data.delete('sport_' + i);
				data.delete('reserve_' + i);
			}
			console.log(sportData);
			data.append('sports', JSON.stringify(sportData));
			try {
				let res: Response;
				if (data.has('user_id')) {
					res = await fetch(PUBLIC_API_URL + '/register-edit', {
						method: 'POST',
						credentials: 'include',
						body: data
					});
				} else {
					res = await fetch(PUBLIC_API_URL + '/register', {
						method: 'POST',
						credentials: 'include',
						body: data
					});
				}
				if (res!.status == 200) {
					return { success: true };
				} else {
					return { success: false };
				}
			} catch (e) {
				return {
					success: false
				};
			}
		} else {
			try {
				let res: Response;
				if (data.has('user_id')) {
					res = await fetch(PUBLIC_API_URL + '/register-coach-edit', {
						method: 'POST',
						credentials: 'include',
						body: data
					});
				} else {
					res = await fetch(PUBLIC_API_URL + '/register-coach', {
						method: 'POST',
						credentials: 'include',
						body: data
					});
				}
				if (res.status == 200) {
					return { success: true };
				} else {
					return { success: false };
				}
			} catch (e) {
				return {
					success: false
				};
			}
		}
	}
} satisfies Actions;
