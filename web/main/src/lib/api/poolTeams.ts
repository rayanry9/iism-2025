import { PUBLIC_API_URL, PUBLIC_API_URL_NO_HTTP, PUBLIC_WEBSOCKET_MODE } from '$env/static/public';

export function registerPoolTeamUpdateWebsocket(sportId: number, onUpdate: () => void): () => void {
	let conn = new WebSocket(
		`${PUBLIC_WEBSOCKET_MODE}://${PUBLIC_API_URL_NO_HTTP}/notify-pool-team-update?sportId=${sportId}`
	);
	conn.onmessage = (ev) => {
		onUpdate();
	};
	return () => {
		conn.close();
	};
}
