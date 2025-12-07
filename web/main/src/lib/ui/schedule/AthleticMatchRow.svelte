<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import { MatchStatus, type GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import { getSportFromSportId, getSportIdOfSport, isSportFemale } from '$lib/utility/sport';
	import { AthleticMatchType, type GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import type { GetAllSportsResponse } from '$lib/types/sports';

	let {
		sportId,
		instituteData,
		allSportData,
		matchData
	}: {
		sportId: number;
		instituteData: GetAllInstitutesResponse[];
		allSportData: GetAllSportsResponse[];
		matchData: GetAllAthleticMatchesResponse;
	} = $props();
</script>

<div class="border-custom-gray button-text flex flex-col border leading-none xl:flex-row">
	<div
		class="border-r-custom-gray max-xl:bg-custom-light-gray flex shrink-0 items-center gap-x-3 border-r px-4 py-2.5 xl:py-0 2xl:gap-x-5 2xl:px-8 2xl:leading-5"
	>
		<img class="h-8 w-fit" src={getSportImageSrc('Athletics')} alt="sport icon" />
		<div>
			<span class="button-text font-bold">ATHLETICS</span> - {allSportData.find(
				(s) => s.id == sportId
			)?.name ?? ''}
		</div>
		<img
			class="ml-auto h-4 w-fit"
			src={isSportFemale(sportId ?? 1) ? womenSvg : menSvg}
			alt="sport icon"
		/>
	</div>
	<div class="flex grow">
		<div
			class="mxau flex grow items-center justify-center px-4 text-center leading-6 md:justify-start lg:justify-center"
		>
			{#if matchData.type == AthleticMatchType.AthleticHeats}
				Heats
			{:else if matchData.type == AthleticMatchType.AthleticQuarterFinal}
				Quarter Final
			{:else if matchData.type == AthleticMatchType.AthleticSemiFinal}
				Semi Final
			{:else if matchData.type == AthleticMatchType.AthleticFinal}
				Final
			{/if}
			<br class="md:hidden" />
			({#if matchData.participants.length == 23}
				All
			{/if}
			{matchData.participants.length} IITs )
		</div>
		<div
			class="border-l-custom-gray flex min-h-full flex-col items-center justify-center border-l px-4 py-4 text-wrap xl:ml-auto xl:w-min"
		>
			<span class="mx-auto w-min leading-6 md:w-max"
				>STATUS-
				{#if matchData.status == MatchStatus.MatchPending}
					Pending
				{:else if matchData.status == MatchStatus.MatchConcluded}
					Concluded
				{:else if matchData.status == MatchStatus.MatchOngoing}
					<a
						href={matchData.liveStreamLink}
						class="text-custom-orange cursor-pointer font-bold underline underline-offset-4"
						>LIVE ↗</a
					>
				{/if}
			</span>
		</div>
	</div>
</div>
