<script lang="ts">
	import type { GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import type { GetAllSportsResponse } from '$lib/types/sports';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import AthleticScheduleMobile from './AthleticScheduleMobile.svelte';
	import AthleticsScheduleDesktop from './AthleticsScheduleDesktop.svelte';

	let {
		athleticMatchData,
		allSports
	}: {
		athleticMatchData: Array<GetAllAthleticMatchesResponse>;
		allSports: GetAllSportsResponse[];
	} = $props();
</script>

<main class="w-full max-xl:px-8">
	<h2 class="flex items-center">
		ATHLETICS
		<img class="mb-1.5 ml-3 h-10" src={getSportImageSrc('Athletics')} alt="Athletics icon" />
	</h2>

	<section class="flex h-full flex-col gap-y-4">
		{#each athleticMatchData
			.map((val) => {
				return { date: val.startTime.getDate(), month: val.startTime.getMonth() };
			})
			.filter((val, idx, arr) => {
				if (arr.findLastIndex((v) => v.date == val.date && v.month == val.month) == idx) {
					return val;
				}
			})
			.sort((a, b) => {
				if (a.month == b.month) {
					return a.date - b.date;
				} else if (a.month < b.month) {
					return -40;
				} else {
					return 40;
				}
			}) as day, idx}
			<div class="flex flex-col gap-y-1">
				<div class="button-text">
					<span class="text-custom-teal">{day.date}/{day.month}/2025</span> - DAY {idx + 1}
				</div>
				<AthleticsScheduleDesktop
					{allSports}
					matchData={athleticMatchData.filter((m) => {
						if (m.startTime.getDate() == day.date && m.startTime.getMonth() == day.month) {
							return m;
						}
					})}
				/>
				<AthleticScheduleMobile
					{allSports}
					matchData={athleticMatchData.filter((m) => {
						if (m.startTime.getDate() == day.date && m.startTime.getMonth() == day.month) {
							return m;
						}
					})}
				/>
			</div>
		{/each}
	</section>
</main>
