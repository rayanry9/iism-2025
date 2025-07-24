<script lang="ts">
	import { getPoolsBySportId } from '$lib/api/pools';
	import type { Sports, SportType } from '$lib/types/sports';
	import { getSportIdOfSport } from '$lib/utility/sport';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import { ToggleTabs } from '../components/toggleTabs';
	import SchedulePoolCard from './SchedulePoolCard.svelte';

	let { sport }: { sport: Sports } = $props();
	let data = $derived.by(() => getPoolsBySportId(getSportIdOfSport(sport, sportType, false)));
	$effect(() => {
		sport;
		sportType = 'Male';
	});
	let sportType = $state<SportType>('Male');
</script>

<main class="flex w-full flex-col">
	<div class="mb-12 flex w-full">
		<div class="flex flex-col">
			<h2 class="flex items-center">
				{sport.toUpperCase()}
				<img class="mb-1.5 ml-3 h-10" src={getSportImageSrc(sport)} alt="{sport} icon" />
			</h2>

			<p>
				{sportType == 'Male' ? 'Men' : sportType == 'Female' ? 'Women' : ''} - {#await data then dat}
					{dat.flatMap((val) => val.teams).length}
				{/await} Teams
			</p>
		</div>
		{#if sport == 'Volleyball'}
			<ToggleTabs.Root class="ml-auto h-fit">
				<ToggleTabs.Item
					onclick={() => {
						sportType = 'Male';
					}}
					class="!px-5 !py-2">MEN</ToggleTabs.Item
				>
				<ToggleTabs.Item
					onclick={() => {
						sportType = 'Female';
					}}
					class="!px-5 !py-2">WOMEN</ToggleTabs.Item
				>
			</ToggleTabs.Root>
		{/if}
	</div>

	<!-- <section class="grid w-full grid-flow-col grid-rows-2 gap-12"> -->
	<section class="flex w-full flex-wrap place-content-between gap-12">
		{#await data}
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
</main>
