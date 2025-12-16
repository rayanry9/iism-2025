<script lang="ts">
	import { getPoolsBySportId } from '$lib/api/pools';
	import { globals } from '$lib/state.svelte';
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { Sports, SportType } from '$lib/types/sports';
	import { getSportIdOfSport } from '$lib/utility/sport';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import { ToggleTabs } from '../components/toggleTabs';
	import SchedulePoolCard from './SchedulePoolCard.svelte';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import { untrack } from 'svelte';
	import SportScheduleMatchesMobile from './SportScheduleMatchesMobile.svelte';
	import SportScheduleMatchDesktop from './SportScheduleMatchDesktop.svelte';

	let {
		sport,
		institutes,
		matchData
	}: {
		sport: Sports;
		institutes: GetAllInstitutesResponse[];
		matchData: Array<GetAllPoolMatchesResponse>;
	} = $props();
	let sportType = $state<SportType>('Male');
	let poolData = $derived.by(() => {
		return getPoolsBySportId(getSportIdOfSport(sport, sportType == 'Male' ? 1 : 2, globals.staff));
	});
	$effect(() => {
		sport;
		untrack(() => {
			sportType = 'Male';
		});
	});

	let sportMatches = $derived(
		matchData.filter(
			(val) => val.sportId == getSportIdOfSport(sport, sportType == 'Male' ? 1 : 2, globals.staff)
		)
	);
</script>

<main class="flex w-full flex-col px-6 xl:px-0">
	<div class="mb-12 flex w-full">
		<div class="flex flex-col">
			<h2 class="flex items-center">
				{sport.toUpperCase()}
				<img class="mb-1.5 ml-3 h-10" src={getSportImageSrc(sport)} alt="{sport} icon" />
			</h2>

			<p>
				{sportType == 'Male' ? 'Men' : sportType == 'Female' ? 'Women' : ''} - {#await poolData then dat}
					{dat.flatMap((val) => val.teams).length}
				{/await} Teams
			</p>
		</div>
		{#key sport}
			{#if getSportIdOfSport(sport, 1, globals.staff) != getSportIdOfSport(sport, 2, globals.staff)}
				<ToggleTabs.Root class="ml-auto h-fit">
					<ToggleTabs.Item
						onclick={() => {
							sportType = 'Male';
						}}
						class="flex gap-x-2 px-3! py-2! xl:px-5!"
					>
						<span class="hidden xl:block">MEN</span><img
							src={menSvg}
							alt="men"
							class="size-4 xl:size-6"
						/></ToggleTabs.Item
					>
					<ToggleTabs.Item
						onclick={() => {
							sportType = 'Female';
						}}
						class="flex gap-x-1 px-3! py-2! xl:px-5!"
					>
						<span class="hidden xl:block">WOMEN</span>
						<img src={womenSvg} alt="women" class="size-4 xl:size-6" /></ToggleTabs.Item
					>
				</ToggleTabs.Root>
			{/if}
		{/key}
	</div>

	<!-- <section class="grid w-full grid-flow-col grid-rows-2 gap-12"> -->
	<section class="flex w-full flex-wrap justify-center gap-8 md:justify-start 2xl:gap-12">
		{#await poolData}
			{#each [1, 2, 3, 4, 5, 6, 7, 8] as key}
				<SchedulePoolCard
					poolName="A"
					teamData={[
						{ id: 1, tempName: 'A', name: null },
						{ id: 1, tempName: 'A', name: null },
						{ id: 1, tempName: 'A', name: null }
					]}
				/>
			{/each}
		{:then awaitedData}
			{#each awaitedData.sort((a, b) => a.name.localeCompare(b.name)) as pool}
				<SchedulePoolCard poolName={pool.name} teamData={pool.teams} />
			{/each}
		{/await}
	</section>

	<section class="mt-12 flex flex-col gap-y-6">
		{#each sportMatches
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
			<div class="flex flex-col">
				<div class="button-text">
					DAY {idx + 1} - <span class="text-custom-teal">{day.date}/{day.month + 1}/2025</span>
				</div>
				<SportScheduleMatchesMobile
					{institutes}
					matchData={sportMatches.filter((m) => {
						if (m.startTime.getDate() == day.date && m.startTime.getMonth() == day.month) {
							return m;
						}
					})}
				/>
				<SportScheduleMatchDesktop
					{institutes}
					matchData={sportMatches.filter((m) => {
						if (m.startTime.getDate() == day.date && m.startTime.getMonth() == day.month) {
							return m;
						}
					})}
				/>
			</div>
		{/each}
	</section>
</main>
