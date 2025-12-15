<script lang="ts">
	import { page } from '$app/state';
	import type { GetAllSportsResponse, Sports } from '$lib/types/sports';
	import MatchCard from '$lib/ui/common/MatchCard.svelte';
	import pinImg from '$lib/assets/icons/pin.svg';
	import { getSportIdOfSport } from '$lib/utility/sport.js';
	import { globals } from '$lib/state.svelte.js';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);

	let {
		poolMatches,
		athleticMatches,
		institutes,
		sports
	}: {
		poolMatches: GetAllPoolMatchesResponse[];
		athleticMatches: GetAllAthleticMatchesResponse[];
		institutes: GetAllInstitutesResponse[];
		sports: GetAllSportsResponse[];
	} = $props();

	let filteredPoolMatches = $derived(
		poolMatches.filter(
			(val) =>
				val.status == 3 &&
				(selectedSport == undefined ||
					val.sportId == getSportIdOfSport(selectedSport!, 1, globals.staff) ||
					val.sportId == getSportIdOfSport(selectedSport!, 2, globals.staff))
		)
	);

	let filteredAthleticMatches = $derived(
		athleticMatches.filter(
			(val) => val.status == 2 && (selectedSport == undefined || selectedSport == 'Athletics')
		)
	);
</script>

<main class="h-full w-full">
	<div class="flex w-full flex-col justify-center gap-y-8 max-xl:items-center max-xl:px-8">
		<h2>PAST MATCHES</h2>
		<div class="grid w-full grid-cols-1 items-center justify-center gap-12">
			{#if filteredPoolMatches.length || filteredAthleticMatches.length}
				{#each filteredPoolMatches as match (match.id)}
					<MatchCard matchData={match} {institutes} {sports}>
						{#snippet subCTA()}
							<span
								class="button-text border-custom-gray flex h-fit w-fit items-center gap-x-2 rounded-3xl border px-4 pt-2.5 pb-2 align-top leading-none not-italic lg:inline-flex lg:pt-2 lg:pb-1.5 xl:pt-2 xl:pb-1.5"
								><img
									src={pinImg}
									class="text-custom-orange -mt-1 inline xl:h-4"
									alt="pin"
								/>{match.venue}</span
							>
						{/snippet}
					</MatchCard>
				{/each}

				{#each filteredAthleticMatches as match (match.id)}
					<MatchCard athleticMatchData={match} {institutes} {sports}>
						{#snippet subCTA()}
							<span
								class="button-text border-custom-gray flex h-fit w-fit items-center gap-x-2 rounded-3xl border px-4 pt-2.5 pb-2 align-top leading-none not-italic lg:inline-flex lg:pt-2 lg:pb-1.5 xl:pt-2 xl:pb-1.5"
								><img
									src={pinImg}
									class="text-custom-orange -mt-1 inline xl:h-4"
									alt="pin"
								/>{match.venue}</span
							>
						{/snippet}
					</MatchCard>
				{/each}
			{:else}
				<h2 class="mx-auto my-12">NO PAST MATCHES</h2>
			{/if}
		</div>
	</div>
</main>
