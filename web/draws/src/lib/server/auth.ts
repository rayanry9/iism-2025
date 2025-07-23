import { ADMIN_PASSWORD, ADMIN_USERNAME } from '$env/static/private';

export function isValidUser(username: string, password: string): boolean {
	if (username == ADMIN_USERNAME && password == ADMIN_PASSWORD) {
		return true;
	} else {
		return false;
	}
}
