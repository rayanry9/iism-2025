import { browser } from '$app/environment';

export const globals = $state({
	staff: browser ? localStorage.getItem('staff') == 'true' : false,
	loading: false
});
