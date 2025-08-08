<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-row gap-x-24 overflow-x-clip text-nowrap *:[main]:mt-24 *:[main]:mr-28"
>
	<SportsAsideBar
		{selectedSport}
		bottomText={'Select a Sport<br/>to see Pools'}
		buttonText={'FULL SCHEDULE'}
	/>

	{#if selectedSport == undefined}
		<FullSchedule />
	{:else if selectedSport == 'Athletics'}
		<AthleticsSchedule />
	{:else}
		<SportSchedule sport={selectedSport} />
	{/if}
</div>
