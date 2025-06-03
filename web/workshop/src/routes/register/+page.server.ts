import { createRegistrant, type RegisterData } from '$lib/server/db/register';
import type { Actions } from './$types';

export const actions: Actions = {
	default: async (event) => {
		const formData = await event.request.formData();
		const data: RegisterData = {
			name: formData.get('name')?.toString() ?? '',
			class: formData.get('class')?.toString() ?? '',
			address: formData.get('address')?.toString() ?? '',
			dob: formData.get('dob')?.toString() ?? '',
			age: formData.get('age')?.toString() ?? '',
			blood: formData.get('blood')?.toString() ?? '',
			email: formData.get('email')?.toString() ?? '',
			experience: formData.get('experience')?.toString() ?? '',
			gaurdianName: formData.get('gaurdian_name')?.toString() ?? '',
			gaurdianPhone: formData.get('gaurdian_phone')?.toString() ?? '',
			gender: formData.get('gender')?.toString() ?? '',
			hostel: formData.get('hostel')?.toString() ?? '',
			institute: formData.get('institute')?.toString() ?? '',
			medical: formData.get('medical')?.toString() ?? '',
			phone: formData.get('phone')?.toString() ?? '',
			pincode: formData.get('pincode')?.toString() ?? '',
			sport: formData.get('sport')?.toString() ?? ''
		};

		const success = await createRegistrant(data);
		return { success: success };
	}
};
