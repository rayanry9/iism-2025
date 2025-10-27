<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import type { PageProps } from './$types';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import downloadIcon from '$lib/assets/icons/download.svg';

	let selectedSport = $state<Sports | undefined>(undefined);
	let { data }: PageProps = $props();
</script>

<div
	class="relative flex flex-col overflow-x-clip text-nowrap xl:h-[calc(100vh-4rem)] xl:flex-row *:[main]:overflow-y-scroll *:[main]:px-12 *:[main]:py-16 xl:*:[main]:px-24 2xl:*:[main]:py-24"
>
	<SportsAsideBar
		bind:selectedSport
		bottomText={'Select a Sport<br/>to see Pools'}
		buttonText={'FULL SCHEDULE'}
	/>
	<MobileHeaderFrame>
		<div class="flex flex-row items-center">
			<h2>FULL SCHEDULE</h2>

			<button
				class="border-custom-light-blue button-text ml-auto w-fit -skew-x-12 self-end rounded-sm border-2 px-4 py-2.5 hover:cursor-pointer hover:brightness-95"
			>
				<div class="flex skew-x-12 items-center gap-x-1.5 leading-none">
					PDF <img src={downloadIcon} alt="download" />
				</div></button
			>
		</div>
	</MobileHeaderFrame>

	{#if selectedSport == undefined}
		{#await Promise.all([data.institutes, data.poolMatches])}
			<FullSchedule institutes={[]} matchData={[]} />
		{:then value}
			<FullSchedule institutes={value[0]} matchData={value[1]} />
		{/await}
	{:else if selectedSport == 'Athletics'}
		<AthleticsSchedule />
	{:else}
		{#await Promise.all([data.institutes, data.poolMatches])}
			<SportSchedule institutes={[]} matchData={[]} sport={selectedSport} />
		{:then value}
			<SportSchedule institutes={value[0]} matchData={value[1]} sport={selectedSport} />
		{/await}
	{/if}
</div>
