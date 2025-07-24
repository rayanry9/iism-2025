import { PUBLIC_API_URL_NO_HTTP, PUBLIC_WEBSOCKET_MODE } from '$env/static/public';
import type { WebsocketUpdateData } from '$lib/types/update';

export function registerWebsocketConnection(onUpdate: (data: WebsocketUpdateData) => void) {
	const conn = new WebSocket(
		`${PUBLIC_WEBSOCKET_MODE}://${PUBLIC_API_URL_NO_HTTP}/notify-pool-team-update`
	);

	conn.onmessage = (ev) => {
		const data: WebsocketUpdateData = JSON.parse(ev.data) satisfies WebsocketUpdateData;
		onUpdate(data);
	};

	return () => {
		conn.close();
	};
}
