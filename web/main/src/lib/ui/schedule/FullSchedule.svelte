<script lang="ts">
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { Sports } from '$lib/types/sports';
	import { getSportFromSportId } from '$lib/utility/sport';
	import DaySelector from '../common/DaySelector.svelte';
	import SportSelector from '../common/SportSelector.svelte';
	import PoolMatchRow from './PoolMatchRow.svelte';

	let {
		matchData,
		institutes
	}: { institutes: GetAllInstitutesResponse[]; matchData: Array<GetAllPoolMatchesResponse> } =
		$props();
	let currentDate: Date = $state<Date>(new Date(2025, 11, 13));
	let currentSport: 'All Matches' | Sports = $state('All Matches');
	let timeSets = $derived.by(() => {
		return matchData
			.filter((val) => val.startTime.getDate() == currentDate.getDate())
			.map((val) => {
				return {
					hour: val.startTime.getHours(),
					min: val.startTime.getMinutes(),
					val: val.startTime
						.toLocaleString()
						.split(',')[1]
						.trim()
						.split(':')
						.map((val, idx) => {
							if (idx == 2) {
								return val.split(' ')[1];
							} else {
								return val;
							}
						})
						.join(':')
						.replace(/:(?!.*:)/, ' ')
						.toLocaleUpperCase()
				};
			})
			.filter((val, idx, arr) => {
				return idx == arr.findLastIndex((v) => v.val == val.val);
			});
	});
</script>

<main class="2xl:h-full">
	<h2 class="hidden xl:block">FULL SCHEDULE</h2>

	<section class="flex flex-col xl:pt-12">
		<div class="mb-12 flex flex-col gap-y-4 xl:hidden">
			<div class="button-text ml-8">Select a Sport</div>
			<SportSelector bind:currentSport />
		</div>
		<div class="flex flex-col gap-y-4 {currentSport != 'All Matches' ? 'hidden' : ''}">
			<div class="button-text ml-8 xl:hidden">Select a day</div>
			<DaySelector bind:currentDate />
		</div>
		<hr class="text-custom-gray mx-12 mt-8" />
		{#each timeSets as time}
			<div class="my-12 flex flex-col gap-y-3">
				<div class="bg-custom-light-blue title-text w-fit px-5 py-3 text-white">
					{time.val}
				</div>
				{#each matchData.filter((val) => val.startTime.getDate() == currentDate.getDate() && val.startTime.getHours() == time.hour && val.startTime.getMinutes() == time.min) as match}
					<PoolMatchRow
						sport={getSportFromSportId(match.sportId) ?? 'Athletics'}
						instituteData={institutes}
						matchData={match}
					/>
				{/each}
			</div>
		{/each}
	</section>
</main>
