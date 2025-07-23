import { PUBLIC_API_URL } from '$env/static/public';

export async function updatePoolTeam(poolTeamId: number, instituteId: number): Promise<boolean> {
	console.log(poolTeamId, instituteId);
	const data = await fetch(`${PUBLIC_API_URL}/update-pool-team`, {
		method: 'POST',
		body: JSON.stringify({
			id: poolTeamId,
			instituteId: instituteId
		})
	});
	return data.status == 200;
}
