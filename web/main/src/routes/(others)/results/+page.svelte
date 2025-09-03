<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import OverallLeaderboard from '$lib/ui/results/OverallLeaderboard.svelte';
	import PastMatches from '$lib/ui/results/PastMatches.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-col gap-x-24 overflow-x-clip text-nowrap 2xl:flex-row *:[main]:mt-24 *:[main]:mr-28"
>
	<SportsAsideBar
		bind:selectedSport
		bottomText={'Select a Sport<br/>to see past<br/>Matches<br/>and Results'}
		buttonText={'LEADERBOARD'}
	/>

	{#if selectedSport == undefined}
		<OverallLeaderboard />
	{:else}
		<PastMatches />
	{/if}
</div>
