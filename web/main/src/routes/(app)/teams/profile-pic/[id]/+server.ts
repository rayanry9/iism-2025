import { PUBLIC_API_URL } from '$env/static/public';
import removeBackground from '@imgly/background-removal-node';
import type { RequestHandler } from './$types';
import fs from 'node:fs/promises';

export const GET: RequestHandler = async ({ url, params, fetch }) => {
	try {
		await fs.mkdir('images/users', { recursive: true });
	} catch (e) {
		console.error(e);
		console.error('Failed to create images directory');
	}
	console.log(params.id);
	try {
		const data = await fs.readFile('images/users/' + params.id);
		return new Response(data);
	} catch (e) {
		console.info(e);
		const data = await (await fetch(PUBLIC_API_URL + '/profile-pic/' + params.id)).blob();
		const output = await removeBackground(data);
		await fs.writeFile('images/users/' + params.id, await output.bytes());

		const res = await fs.readFile('images/users/' + params.id);

		return new Response(res);
	}
};
