<script lang="ts">
	import { globals } from '$lib/state.svelte';
	import type { GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { GetAllSportsResponse, Sports } from '$lib/types/sports';
	import { getSportFromSportId } from '$lib/utility/sport';
	import DaySelector from '../common/DaySelector.svelte';
	import AthleticMatchRow from './AthleticMatchRow.svelte';
	import PoolMatchRow from './PoolMatchRow.svelte';

	let {
		poolMatchData,
		athleticMatchData,
		institutes,
		sportData
	}: {
		institutes: GetAllInstitutesResponse[];
		poolMatchData: Array<GetAllPoolMatchesResponse>;
		athleticMatchData: Array<GetAllAthleticMatchesResponse>;
		sportData: Array<GetAllSportsResponse>;
	} = $props();
	let currentDate: Date = $state<Date>(new Date(2025, 11, globals.staff ? 23 : 13));
	let currentSport: 'All Matches' | Sports = $state('All Matches');
	let timeSets = $derived.by(() => {
		return poolMatchData
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
			.concat(
				athleticMatchData
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
			)
			.filter((val, idx, arr) => {
				return idx == arr.findLastIndex((v) => v.val == val.val);
			});
	});
</script>

<main class="w-full 2xl:h-full">
	<h2 class="hidden xl:block">FULL SCHEDULE</h2>

	<section class="flex flex-col xl:pt-12">
		<div
			class="flex flex-col gap-y-4 max-xl:*:px-8 {currentSport != 'All Matches' ? 'hidden' : ''}"
		>
			<div class="button-text xl:hidden">Select a day</div>
			<DaySelector bind:currentDate />
		</div>
		<hr class="text-custom-gray mx-12 mt-8" />
		{#each timeSets.sort((a, b) => {
			return a.hour * 60 + a.min - b.hour * 60 + b.min;
		}) as time}
			<div class="my-4 flex flex-col gap-y-3 *:max-xl:mx-8 xl:my-8">
				<div class="bg-custom-light-blue title-text px-5 py-3 text-white xl:w-fit">
					{time.val}
				</div>
				{#each poolMatchData.filter((val) => val.startTime.getDate() == currentDate.getDate() && val.startTime.getHours() == time.hour && val.startTime.getMinutes() == time.min) as match}
					<PoolMatchRow sportId={match.sportId} instituteData={institutes} matchData={match} />
				{/each}
				{#each athleticMatchData.filter((val) => val.startTime.getDate() == currentDate.getDate() && val.startTime.getHours() == time.hour && val.startTime.getMinutes() == time.min) as match}
					<AthleticMatchRow
						sportId={match.sportId}
						allSportData={sportData}
						instituteData={institutes}
						matchData={match}
					/>
				{/each}
			</div>
		{/each}
	</section>
</main>
