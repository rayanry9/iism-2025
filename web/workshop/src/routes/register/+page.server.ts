import { SendMail } from '$lib/server/db/email';
import { createRegistrant, type RegisterData } from '$lib/server/db/register';
import type { Actions } from './$types';
import { appendFile, writeFile } from 'node:fs/promises';
import { homedir } from 'node:os';
import { extname, join } from 'node:path';

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
			sport: formData.get('sport')?.toString() ?? '',
			utr: formData.get('utr')?.toString() ?? '',
			accountHolderName: formData.get('account_holder_name')?.toString() ?? '',
			screenshot: formData.get('screenshot') as File
		};
		try {
			let file = await data.screenshot.bytes();

			await writeFile(join(homedir(), 'payments', data.utr + extname(data.screenshot.name)), file, {
				flush: true
			});
		} catch (e) {
			console.error(e);
			return { success: false };
		}

		const success = await createRegistrant(data);
		if (success) {
			console.log(
				new Date().toISOString() +
					' | ' +
					data.name +
					' | ' +
					data.phone +
					' | ' +
					data.email +
					' |  ' +
					data.utr +
					' | Has Registerd'
			);
			try {
				SendMail(data)
					.then((val) => {
						if (!val) {
							console.error('failed sending email to ' + data.email + ' | Phone: ' + data.phone);
							try {
								appendFile(
									join(homedir(), 'logs', 'email-fails.txt'),
									'\nEmail: ' + data.email + ' | Phone: ' + data.phone
								);
							} catch (e) {
								console.error('Failed writing to email fails');
								console.error(e);
								console.error('----------------------------------------');
							}
						}
					})
					.catch((err) => {
						try {
							appendFile(
								join(homedir(), 'logs', 'email-fails.txt'),
								'\nEmail: ' + data.email + ' | Phone: ' + data.phone + '\n' + err
							);
						} catch (e) {
							console.error('failed sending email to ' + data.email + ' | Phone: ' + data.phone);
							console.error(err);
							console.error('----------------------------------------');
						}
					});
			} catch (e) {
				console.error('failed sending email to ' + data.email + ' | Phone: ' + data.phone);
				console.error(e);
				console.error('----------------------------------------');
				try {
					appendFile(
						join(homedir(), 'logs', 'email-fails.txt'),
						'\nEmail: ' + data.email + ' | Phone: ' + data.phone + '\n' + e
					);
				} catch (e) {
					console.error(e);
					console.error('Failed writing to email fails');
				}
			}
		} else {
			console.error(
				'failed registering user with email: ' + data.email + ' | Phone: ' + data.phone
			);
			console.error('-----------------------------------');
			console.error(data);
			console.error('-----------------------------------');
			try {
				appendFile(
					join(homedir(), 'logs', 'registration-fail.txt'),
					'\nFailed registering user with email: ' + data.email + ' | Phone: ' + data.phone + '\n'
				);
				appendFile(join(homedir(), 'logs', 'registration-fail.txt'), JSON.stringify(data));
				appendFile(
					join(homedir(), 'logs', 'registration-fail.txt'),
					'\n-------------------------------------------------------'
				);
			} catch (e) {
				console.error(e);
				console.error('Failed writing to failed registrations');
			}
		}
		return { success: success };
	}
};
