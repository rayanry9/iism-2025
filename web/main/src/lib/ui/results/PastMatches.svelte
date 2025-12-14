<script lang="ts">
	import { page } from '$app/state';
	import { PUBLIC_API_URL } from '$env/static/public';
	import type { Sports } from '$lib/types/sports';
	import MatchCard from '$lib/ui/common/MatchCard.svelte';
	import pinImg from '$lib/assets/icons/pin.svg';
	import { getSportIdOfSport } from '$lib/utility/sport.js';
	import { globals } from '$lib/state.svelte.js';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';

	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);
	let { poolMatches }: { poolMatches: Promise<GetAllPoolMatchesResponse[]> } = $props();
</script>

<main class="h-full w-full">
	<div class="flex w-full flex-col justify-center gap-y-8 max-xl:items-center max-xl:px-8">
		<h2>PAST MATCHES</h2>
		<div class="grid w-full grid-cols-1 items-center justify-center gap-12">
			{#await poolMatches then matches}
				{#if matches.filter((val) => val.status == 3 && (val.sportId == getSportIdOfSport(selectedSport!, 1, globals.staff) || val.sportId == getSportIdOfSport(selectedSport!, 2, globals.staff))).length}
					{#each matches.filter((val) => val.status == 3 && (val.sportId == getSportIdOfSport(selectedSport!, 1, globals.staff) || val.sportId == getSportIdOfSport(selectedSport!, 2, globals.staff))) as match (match.id)}
						{#await fetch(PUBLIC_API_URL + '/get-pool-match-data-by-id?match_id=' + match.id) then match_data}
							{#await match_data.json() then matchData: GetPoolMatchDataById}
								<MatchCard
									sportId={match.sportId}
									matchData={matchData ?? {
										id: 1,
										team1Balls: 0,
										team1Score: [0, 0, 0, 0, 0],
										team1Wickets: 0,
										team2Balls: 0,
										team2Score: [0, 0, 0, 0, 0],
										team2Wickets: 0
									}}
									pool={match.matchName ?? ''}
									startTime="AAA"
									team1="Bombay"
									team2="Bhubaneswar"
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
							{/await}
						{/await}
					{/each}
				{:else}
					<h2 class="mx-auto my-12">NO PAST MATCHES</h2>
				{/if}
			{/await}
		</div>
	</div>
</main>
