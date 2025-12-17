import type { HandleFetch } from '@sveltejs/kit';

export const handleFetch: HandleFetch = async ({ request, fetch, event }) => {
	request.headers.set('cookie', event.request.headers.get('cookie') ?? '');
	return fetch(request);
};
