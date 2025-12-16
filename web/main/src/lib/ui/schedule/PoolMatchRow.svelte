<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import { MatchStatus, type GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import { getSportFromSportId, isSportFemale } from '$lib/utility/sport';

	let {
		sportId,
		instituteData,
		matchData
	}: {
		sportId: number;
		instituteData: GetAllInstitutesResponse[];
		matchData: GetAllPoolMatchesResponse;
	} = $props();

	let sport = $derived(getSportFromSportId(sportId) ?? 'Athletics');
</script>

<div class="border-custom-gray button-text flex flex-col border leading-none xl:flex-row">
	<div
		class="border-r-custom-gray max-xl:bg-custom-light-gray flex shrink-0 items-center gap-x-3 border-r px-4 py-2.5 xl:py-0 2xl:gap-x-5 2xl:px-8 2xl:leading-5"
	>
		<img class="h-8 w-fit" src={getSportImageSrc(sport)} alt="sport icon" />
		<div>
			{sport.toUpperCase()} -<br class="hidden xl:block" />
			{matchData.matchName?.toUpperCase()}
		</div>
		<img
			class="ml-auto h-4 w-fit"
			src={isSportFemale(sportId ?? 1) ? womenSvg : menSvg}
			alt="sport icon"
		/>
	</div>
	<div class="flex h-full grow">
		<div
			class="flex grow grid-cols-[1fr_auto_1fr] flex-col gap-y-3 px-4 py-3 xl:flex-row xl:py-0 xl:*:py-3 2xl:grid 2xl:*:py-4"
		>
			<div class="flex items-center xl:mr-auto">
				{#if instituteData.find((val) => val.id == matchData.team1Id)}
					<img
						class="mr-2 size-8 xl:mr-4"
						src={getIITImgSrc(
							(instituteData.find((val) => val.id == matchData.team1Id)?.name ??
								'Hyderabad') as IITNames
						)}
						alt="IIT Logo"
					/>
					<span
						>IIT {instituteData
							.find((val) => val.id == matchData.team1Id)
							?.name.toUpperCase()}</span
					>
				{:else}
					{matchData.team1TempName.toUpperCase()}
				{/if}
			</div>
			<div
				class="border-l-custom-gray border-r-custom-gray mx-2 hidden h-full -skew-x-12 items-center border-r border-l px-3 xl:flex"
			>
				<span class="skew-x-12">VS</span>
			</div>
			<div class="flex items-center xl:ml-auto">
				{#if instituteData.find((val) => val.id == matchData.team2Id)}
					<img
						class="mr-2 size-8 xl:mr-4"
						src={getIITImgSrc(
							(instituteData.find((val) => val.id == matchData.team2Id)?.name ??
								'Hyderabad') as IITNames
						)}
						alt="IIT Logo"
					/>
					<span class="">
						IIT {instituteData.find((val) => val.id == matchData.team2Id)?.name.toUpperCase()}
					</span>
				{:else}
					{matchData.team2TempName.toUpperCase()}
				{/if}
			</div>
		</div>
		<div
			class="border-l-custom-gray flex min-h-full flex-col items-center justify-center border-l px-2 text-wrap md:px-4 xl:ml-auto xl:w-min"
		>
			<span class="mx-auto w-min leading-6 md:w-fit 2xl:w-max"
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
