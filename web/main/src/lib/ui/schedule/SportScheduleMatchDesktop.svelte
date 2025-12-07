<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import { getIITImgSrc, getIITShortCode } from '$lib/utility/iitLogoImgSrc';
	let {
		institutes,
		matchData
	}: {
		institutes: GetAllInstitutesResponse[];
		matchData: Array<GetAllPoolMatchesResponse>;
	} = $props();
</script>

<table class="button-text hidden table-auto border-separate border-spacing-y-1 xl:table">
	<thead class="bg-custom-light-blue text-white">
		<tr class="*:py-2.5 *:not-first:border-l *:not-first:border-l-white">
			<th>NO.</th>
			<th>NAME</th>
			<th>MATCHES</th>
			<th>TIME</th>
			<th>PLACE</th>
		</tr>
	</thead>

	<tbody>
		{#each matchData.sort((a, b) => a.id - b.id) as match (match.id)}
			<tr class="*:border-custom-gray text-center *:border">
				<td class="bg-custom-light-gray px-4">{match.id}</td>
				<td class="px-4">{match.matchName?.toUpperCase()}</td>
				<td class="grid grid-cols-[1fr_auto_1fr] px-4 *:py-2.5">
					{#if institutes.find((val) => val.id == match.team1Id)}
						<div class="flex items-center xl:mr-auto">
							<img
								class="mr-4 size-8"
								src={getIITImgSrc(
									(institutes.find((val) => val.id == match.team1Id)?.name ??
										'Hyderabad') as IITNames
								)}
								alt="IIT Logo"
							/>
							<span
								>IIT {getIITShortCode(
									institutes.find((val) => val.id == match.team1Id)!.name as IITNames
								).toUpperCase()}</span
							>
						</div>
					{:else}
						<div>{match.team1TempName}</div>
					{/if}
					<div
						class="border-l-custom-gray border-r-custom-gray mx-2 hidden h-full -skew-x-12 items-center border-r border-l px-3 xl:flex"
					>
						<span class="mt-1 skew-x-12">VS</span>
					</div>
					{#if institutes.find((val) => val.id == match.team2Id)}
						<div class="flex items-center xl:ml-auto">
							<img
								class="mr-4 size-8"
								src={getIITImgSrc(
									(institutes.find((val) => val.id == match.team2Id)?.name ??
										'Hyderabad') as IITNames
								)}
								alt="IIT Logo"
							/>
							<span
								>IIT {getIITShortCode(
									institutes.find((val) => val.id == match.team2Id)!.name as IITNames
								).toUpperCase()}</span
							>
						</div>
					{:else}
						<div>{match.team2TempName.toUpperCase()}</div>
					{/if}
				</td>
				<td>{match.startTime.toLocaleTimeString().split(':00 ').join(' ').toUpperCase()}</td>
				<td>{match.venue?.toUpperCase()}</td>
			</tr>
		{/each}
	</tbody>
</table>
