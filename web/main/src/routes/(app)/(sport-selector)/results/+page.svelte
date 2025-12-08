<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import OverallLeaderboard from '$lib/ui/results/OverallLeaderboard.svelte';
	import PastMatches from '$lib/ui/results/PastMatches.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

{#if selectedSport == undefined}
	<OverallLeaderboard />
{:else}
	<PastMatches />
{/if}
