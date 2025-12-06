<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';
	import type { PageProps } from './$types';

	let selectedSport = $state<Sports | undefined>(undefined);
	let { data }: PageProps = $props();
</script>

{#if selectedSport == undefined}
	{#await Promise.all([data.institutes, data.poolMatches])}
		<FullSchedule institutes={[]} matchData={[]} />
	{:then value}
		<FullSchedule institutes={value[0]} matchData={value[1]} />
		<!-- <FullSchedule institutes={[]} matchData={[]} /> -->
	{/await}
{:else if selectedSport == 'Athletics'}
	<AthleticsSchedule />
{:else}
	{#await Promise.all([data.institutes, data.poolMatches])}
		<SportSchedule institutes={[]} matchData={[]} sport={selectedSport} />
	{:then value}
		<SportSchedule institutes={value[0]} matchData={value[1]} sport={selectedSport} />
	{/await}
{/if}
