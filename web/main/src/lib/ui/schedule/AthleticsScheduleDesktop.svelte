<script lang="ts">
	import { AthleticMatchType, type GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import type { GetAllSportsResponse } from '$lib/types/sports';
	import { isSportFemale, isSportIdStaff, isSportMixed } from '$lib/utility/sport';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	let {
		allSports,
		matchData
	}: {
		allSports: GetAllSportsResponse[];
		matchData: Array<GetAllAthleticMatchesResponse>;
	} = $props();
</script>

<table class="button-text hidden table-auto border-separate border-spacing-y-1 xl:table">
	<thead class="bg-custom-light-blue text-white">
		<tr class="*:py-2.5 *:not-first:border-l *:not-first:border-l-white">
			<th>NO.</th>
			<th>TIME</th>
			<th>EVENT</th>
			<th>SECTION</th>
			<th>ROUND</th>
		</tr>
	</thead>

	<tbody>
		{#each matchData.sort((a, b) => a.id - b.id) as match (match.id)}
			<tr class="*:border-custom-gray text-center *:border *:py-2.5">
				<td class="bg-custom-light-gray px-4">{match.id}</td>
				<td>{match.startTime.toLocaleTimeString().split(':00 ').join(' ').toUpperCase()}</td>
				<td class="px-4">{allSports.find((s) => s.id == match.sportId)?.name.toUpperCase()}</td>
				<td class="flex items-center justify-center gap-x-3"
					>{isSportFemale(match.sportId) ? 'WOMEN' : isSportMixed(match.sportId) ? 'MIXED' : 'MEN'}
					<img src={isSportFemale(match.sportId) ? womenSvg : menSvg} alt="svg" class="mb-1" />
					{#if isSportMixed(match.sportId)}
						<img src={womenSvg} alt="svg" class="mb-1" />
					{/if}
				</td>
				<td>
					{#if match.type == AthleticMatchType.AthleticHeats}
						Heats
					{:else if match.type == AthleticMatchType.AthleticQuarterFinal}
						Quarter Final
					{:else if match.type == AthleticMatchType.AthleticSemiFinal}
						Semi Final
					{:else if match.type == AthleticMatchType.AthleticFinal}
						Final
					{/if}
				</td>
			</tr>
		{/each}
	</tbody>
</table>
