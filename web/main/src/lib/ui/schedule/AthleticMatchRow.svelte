<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import { MatchStatus } from '$lib/types/poolMatches';
	import { getIITImgSrc, getIITShortCode } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import { isSportFemale, isSportMixed } from '$lib/utility/sport';
	import { AthleticMatchType, type GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import type { GetAllSportsResponse } from '$lib/types/sports';
	import chevronUpSvg from '$lib/assets/icons/chevron-up.svg';
	import { slide } from 'svelte/transition';

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

	let institutesOpen = $state(false);
</script>

<div class="border-custom-gray button-text flex flex-col border">
	<div class="flex flex-col leading-none xl:flex-row">
		<div
			class="border-b-custom-gray max-xl:bg-custom-light-gray flex shrink-0 items-center gap-x-3 px-4 py-2.5 max-xl:border-b xl:py-0 2xl:gap-x-5 2xl:px-8 2xl:leading-5"
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
			{#if isSportMixed(sportId)}
				<img src={womenSvg} alt="svg" class="h-4 w-fit" />
			{/if}
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

				({#if (matchData.participants?.length ?? 0) == 23}
					All
				{/if}

				{#if matchData.participants == null || matchData.participants.length == 0}
					{matchData.participantsTempText}
				{:else}
					{matchData.participants.length} IITs
				{/if}
				)
				<button
					class="p-2 hover:cursor-pointer hover:brightness-99"
					onclick={() => {
						institutesOpen = !institutesOpen;
					}}
				>
					<img
						src={chevronUpSvg}
						alt="open/close"
						class="-mr-5 ml-3 inline-block {institutesOpen ? '' : 'rotate-180'} w-3.5 min-w-3.5"
					/>
				</button>
			</div>
			<div
				class="border-l-custom-gray flex min-h-full flex-col items-center justify-center border-l px-4 py-4 text-wrap xl:ml-auto xl:w-min"
			>
				<span class="mx-auto w-min leading-6 md:w-max"
					>STATUS-
					{#if matchData.status == MatchStatus.MatchPending}
						Pending
					{:else if matchData.status == MatchStatus.MatchConcluded}
						Done
					{:else if matchData.status == MatchStatus.MatchOngoing && matchData.liveStreamLink != null}
						<a
							href={matchData.liveStreamLink}
							class="text-custom-orange cursor-pointer font-bold underline underline-offset-4"
							>LIVE ↗</a
						>
					{:else}
						Ongoing
					{/if}
				</span>
			</div>
		</div>
	</div>
	{#if institutesOpen}
		<div
			transition:slide
			class="border-t-custom-gray grid grid-cols-3 gap-y-3 border-t px-4 py-4 md:grid-cols-5 xl:grid-cols-7 2xl:grid-cols-8"
		>
			{#each matchData.participants as iit}
				<div class="button-text mx-auto flex w-fit gap-x-2 px-4">
					<img
						src={getIITImgSrc(instituteData.find((i) => i.id == iit)!.name as IITNames)}
						class="size-5"
						alt="iit logo"
					/>
					IIT {getIITShortCode(instituteData.find((i) => i.id == iit)!.name as IITNames)}
				</div>
			{/each}
		</div>
	{/if}
</div>
