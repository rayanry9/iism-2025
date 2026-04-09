<script lang="ts">
	import { page } from '$app/state';
	import { athleticMatchesData } from '$lib/data/athleticMatch';
	import { institutesData } from '$lib/data/institutes';
	import { poolMatchesData } from '$lib/data/poolMatch';
	import { allSportsData } from '$lib/data/sport';
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);
</script>

{#if selectedSport == undefined}
	<FullSchedule
		institutes={institutesData}
		poolMatchData={poolMatchesData}
		athleticMatchData={athleticMatchesData}
		sportData={allSportsData}
	/>
	<!-- <FullSchedule institutes={[]} matchData={[]} /> -->
{:else if selectedSport == 'Athletics'}
	<AthleticsSchedule athleticMatchData={athleticMatchesData} allSports={allSportsData} />
{:else}
	<SportSchedule institutes={institutesData} matchData={poolMatchesData} sport={selectedSport} />
{/if}
