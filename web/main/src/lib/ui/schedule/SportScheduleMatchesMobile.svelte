<script lang="ts">
	import chevronUpSvg from '$lib/assets/icons/chevron-up.svg';
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { slide } from 'svelte/transition';
	let {
		institutes,
		matchData
	}: {
		institutes: GetAllInstitutesResponse[];
		matchData: Array<GetAllPoolMatchesResponse>;
	} = $props();

	let open = $state(false);
</script>

<div class="flex flex-col gap-y-2 xl:hidden">
	<div class="bg-custom-light-blue button-text flex items-center px-6 py-2 text-white">
		<span>MATCHES</span>
		<button
			class="ml-auto p-2"
			onclick={() => {
				open = !open;
			}}
		>
			<img
				src={chevronUpSvg}
				alt="open/close"
				class="size-4 brightness-200 saturate-200 {open ? '' : 'rotate-180'}"
			/>
		</button>
	</div>

	{#each matchData.sort((a, b) => a.id - b.id) as match (match.id)}
		{#if open}
			<div class="button-text border-custom-gray flex flex-col border *:px-6" transition:slide>
				<div
					class="bg-custom-light-gray border-b-custom-gray grid grid-cols-2 gap-y-3 border-b py-3"
				>
					<div>
						<span class="text-custom-blue">MATCH</span> : {match.id}
					</div>
					<div>
						<span class="text-custom-blue">TIME</span> : {match.startTime.toLocaleTimeString()}
					</div>
					<div>
						{match.matchName}
					</div>
					<div>
						<span class="text-custom-blue">PLACE</span> : {match.venue}
					</div>
				</div>
				<div class="grid grid-cols-[1fr_auto_1fr] items-center px-4 py-4">
					<div class="mr-auto flex flex-col items-center gap-y-2">
						{#if match.team1Id != null}
							<img
								src={getIITImgSrc(institutes.find((i) => i.id == match.team1Id!)!.name as IITNames)}
								alt="iit"
								class="h-14"
							/>
							<div>IIT {institutes.find((i) => i.id == match.team1Id!)!.name as IITNames}</div>
						{:else}
							<div>{match.team1TempName}</div>
						{/if}
					</div>

					<div class="border-custom-gray -mt-4 flex h-fit -skew-x-12 items-center border px-2 py-1">
						<span class="skew-x-12">VS</span>
					</div>

					<div class="ml-auto flex flex-col items-center gap-y-2">
						{#if match.team2Id != null}
							<img
								src={getIITImgSrc(institutes.find((i) => i.id == match.team2Id!)!.name as IITNames)}
								alt="iit"
								class="h-14"
							/>
							<div>IIT {institutes.find((i) => i.id == match.team2Id!)!.name.toUpperCase()}</div>
						{:else}
							<div>{match.team2TempName}</div>
						{/if}
					</div>
				</div>
			</div>
		{/if}
	{/each}
</div>
