<script lang="ts">
	import { page } from '$app/state';
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';
	import type { PageProps } from './$types';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);
	let { data }: PageProps = $props();
</script>

{#if selectedSport == undefined}
	{#await Promise.all([data.institutes, data.poolMatches, data.athleticMatches, data.allSports])}
		<FullSchedule institutes={[]} poolMatchData={[]} athleticMatchData={[]} sportData={[]} />
	{:then value}
		<FullSchedule
			institutes={value[0]}
			poolMatchData={value[1]}
			athleticMatchData={value[2]}
			sportData={value[3]}
		/>
		<!-- <FullSchedule institutes={[]} matchData={[]} /> -->
	{/await}
{:else if selectedSport == 'Athletics'}
	{#await Promise.all([data.athleticMatches, data.institutes, data.allSports])}
		<AthleticsSchedule athleticMatchData={[]} institutes={[]} allSports={[]} />
	{:then value}
		<AthleticsSchedule athleticMatchData={value[0]} institutes={value[1]} allSports={value[2]} />
	{/await}
{:else}
	{#await Promise.all([data.institutes, data.poolMatches])}
		<SportSchedule institutes={[]} matchData={[]} sport={selectedSport} />
	{:then value}
		<SportSchedule institutes={value[0]} matchData={value[1]} sport={selectedSport} />
	{/await}
{/if}
