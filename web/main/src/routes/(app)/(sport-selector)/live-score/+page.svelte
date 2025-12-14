<script lang="ts">
	import { page } from '$app/state';
	import { PUBLIC_API_URL } from '$env/static/public';
	import type { Sports } from '$lib/types/sports';
	import MatchCard from '$lib/ui/common/MatchCard.svelte';
	import pinImg from '$lib/assets/icons/pin.svg';
	import { getSportIdOfSport } from '$lib/utility/sport.js';
	import { globals } from '$lib/state.svelte.js';
	import type { IITNames } from '$lib/types/iitNames.js';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches.js';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);
	let { data } = $props();

	let filteredPoolMatches = $derived(
		data.poolMatches.filter(
			(val) =>
				val.status == 2 &&
				(selectedSport == undefined ||
					val.sportId == getSportIdOfSport(selectedSport!, 1, globals.staff) ||
					val.sportId == getSportIdOfSport(selectedSport!, 2, globals.staff))
		)
	);
</script>

<main class="h-full w-full">
	<div class="flex w-full flex-col justify-center gap-y-8 max-xl:items-center max-xl:px-8">
		<h2>LIVE MATCHES</h2>
		<div class="grid w-full grid-cols-1 items-center justify-center gap-12">
			{#if filteredPoolMatches.length}
				{#each filteredPoolMatches as match (match.id)}
					<MatchCard
						sportId={match.sportId}
						matchData={data.matchData.find((m) => m.matchId == match.id) ?? {
							id: 1,
							matchId: 1,
							team1Balls: 0,
							team1Score: [0, 0, 0, 0, 0],
							team1Wickets: 0,
							team2Balls: 0,
							team2Score: [0, 0, 0, 0, 0],
							team2Wickets: 0
						}}
						pool={match.matchName ?? ''}
						startTime={match.startTime}
						team1={data.institutes.find((i) => i.id == match.team1Id)!.name as IITNames}
						team2={data.institutes.find((i) => i.id == match.team2Id)!.name as IITNames}
						liveStreamLink={match.liveStreamLink}
					>
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
