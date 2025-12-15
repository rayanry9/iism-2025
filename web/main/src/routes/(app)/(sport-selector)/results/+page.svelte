<script lang="ts">
	import { page } from '$app/state';
	import { PUBLIC_API_URL } from '$env/static/public';
	import { globals } from '$lib/state.svelte.js';
	import type { GetLeaderBoardDataResponse } from '$lib/types/leaderboard.js';
	import type { Sports } from '$lib/types/sports';
	import OverallLeaderboard from '$lib/ui/results/OverallLeaderboard.svelte';
	import PastMatches from '$lib/ui/results/PastMatches.svelte';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);

	let { data } = $props();
	let leaderboardData = $derived(async () => {
		return (await (
			await fetch(PUBLIC_API_URL + '/get-leaderboard?staff=' + globals.staff.toString())
		).json()) as GetLeaderBoardDataResponse[];
	});
</script>

{#if selectedSport == undefined}
	{#await Promise.all([leaderboardData, data.institutes])}
		<OverallLeaderboard institutes={[]} leaderboardData={[]} />
	{:then val}
		{#await val[0]()}
			<OverallLeaderboard institutes={val[1]} leaderboardData={[]} />
		{:then l}
			<OverallLeaderboard institutes={val[1]} leaderboardData={l} />
		{/await}
	{/await}
{:else}
	<PastMatches
		sports={data.allSports}
		poolMatches={data.poolMatches}
		institutes={data.institutes}
	/>
{/if}
