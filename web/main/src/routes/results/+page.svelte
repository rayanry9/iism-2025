<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import OverallLeaderboard from '$lib/ui/results/OverallLeaderboard.svelte';
	import PastMatches from '$lib/ui/results/PastMatches.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-col gap-x-24 overflow-x-clip text-nowrap 2xl:h-[calc(100vh-4rem)] 2xl:flex-row *:[main]:py-24 *:[main]:pr-28"
>
	<MobileHeaderFrame>
		<div class="flex flex-col gap-y-1">
			<h2>LEADERBOARD</h2>
			<p>Select a Sport to see past Matches and Results</p>
		</div>
	</MobileHeaderFrame>
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
