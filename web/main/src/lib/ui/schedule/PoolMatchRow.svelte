<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { Sports } from '$lib/types/sports';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';

	let {
		sport,
		instituteData,
		matchData
	}: {
		sport: Sports;
		instituteData: GetAllInstitutesResponse[];
		matchData: GetAllPoolMatchesResponse;
	} = $props();
</script>

<div class="border-custom-gray button-text flex border leading-none *:flex *:items-center">
	<div class="border-r-custom-gray gap-x-3 border-r px-8">
		<img class="h-8 w-fit" src={getSportImageSrc(sport)} alt="sport icon" />
		<div>{sport.toUpperCase()} - {matchData.matchName?.toUpperCase()}</div>
	</div>
	<div
		class="mx-8 !grid grow grid-cols-3 self-center *:flex *:items-center *:last:ml-auto *:even:mx-auto"
	>
		{#if instituteData.find((val) => val.id == matchData.team1Id)}
			<div>
				<img
					class="mr-3 h-8"
					src={getIITImgSrc(
						(instituteData.find((val) => val.id == matchData.team1Id)?.name ??
							'Hyderabad') as IITNames
					)}
					alt="IIT Logo"
				/>
				<span
					>IIT {instituteData.find((val) => val.id == matchData.team1Id)?.name.toUpperCase()}</span
				>
			</div>
		{:else}
			<div>{matchData.team1TempName}</div>
		{/if}
		<div
			class="border-l-custom-gray border-r-custom-gray mx-2 h-full -skew-x-12 border-r border-l px-3 py-4"
		>
			<span class="skew-x-12">VS</span>
		</div>
		{#if instituteData.find((val) => val.id == matchData.team2Id)}
			<div>
				<span>
					IIT {instituteData.find((val) => val.id == matchData.team2Id)?.name.toUpperCase()}
				</span>
				<img
					class="ml-3 h-8"
					src={getIITImgSrc(
						(instituteData.find((val) => val.id == matchData.team1Id)?.name ??
							'Hyderabad') as IITNames
					)}
					alt="IIT Logo"
				/>
			</div>
		{:else}
			<div>{matchData.team2TempName.toUpperCase()}</div>
		{/if}
	</div>
	<div class="border-l-custom-gray justify-center border-l px-8">
		STATUS - {matchData.status}
	</div>
</div>
