import { PUBLIC_API_URL } from '$env/static/public';

export async function updatePoolTeam(
	poolTeamId: number,
	upcoming: boolean,
	instituteId?: number
): Promise<boolean> {
	const data = await fetch(`${PUBLIC_API_URL}/update-pool-team`, {
		method: 'POST',
		body: JSON.stringify({
			id: poolTeamId,
			instituteId: instituteId ?? -1,
			upcoming: upcoming
		})
	});
	return data.status == 200;
}
