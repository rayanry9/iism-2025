<script lang="ts">
	import chevronUpSvg from '$lib/assets/icons/chevron-up.svg';
	import { AthleticMatchType, type GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import { isSportFemale } from '$lib/utility/sport';
	import { slide } from 'svelte/transition';

	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import type { GetAllSportsResponse } from '$lib/types/sports';

	let {
		allSports,
		matchData
	}: {
		allSports: GetAllSportsResponse[];
		matchData: Array<GetAllAthleticMatchesResponse>;
	} = $props();

	let open = $state(false);
</script>

<div class="flex flex-col gap-y-2 xl:hidden">
	<div class="bg-custom-light-blue button-text flex items-center px-6 py-2 text-white">
		<span>EVENTS</span>
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
						<span class="text-custom-blue">EVENT NO.</span> : {match.id}
					</div>
					<div>
						<span class="text-custom-blue">TIME</span> : {match.startTime
							.toLocaleTimeString()
							.split(':00 ')
							.join(' ')
							.toUpperCase()}
					</div>
					<div class="flex gap-x-3">
						{isSportFemale(match.sportId) ? 'WOMEN' : 'MEN'}
						<img src={isSportFemale(match.sportId) ? womenSvg : menSvg} alt="svg" class="mb-1" />
					</div>
				</div>
				<div class="grid grid-cols-[1fr_1fr] items-center px-4 py-4">
					<div>
						<span class="text-custom-blue">EVENT:</span>
						{allSports.find((s) => s.id == match.sportId)?.name.toUpperCase()}
					</div>
					<div>
						{#if match.type == AthleticMatchType.AthleticHeats}
							Heats
						{:else if match.type == AthleticMatchType.AthleticQuarterFinal}
							Quarter Final
						{:else if match.type == AthleticMatchType.AthleticSemiFinal}
							Semi Final
						{:else if match.type == AthleticMatchType.AthleticFinal}
							Final
						{/if}
					</div>
				</div>
			</div>
		{/if}
	{/each}
</div>
