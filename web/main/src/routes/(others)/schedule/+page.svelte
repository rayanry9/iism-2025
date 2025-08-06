<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import AthleticsSchedule from '$lib/ui/schedule/AthleticsSchedule.svelte';
	import FullSchedule from '$lib/ui/schedule/FullSchedule.svelte';
	import ScheduleSidebarSportCard from '$lib/ui/schedule/ScheduleSidebarSportCard.svelte';
	import SportSchedule from '$lib/ui/schedule/SportSchedule.svelte';
	import { fade } from 'svelte/transition';
	import downloadIcon from '$lib/assets/icons/download.svg';

	let sports = $state<Array<Sports>>(['Football', 'Athletics', 'Volleyball', 'Hockey', 'Cricket']);
	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-row gap-x-24 overflow-x-clip text-nowrap *:[main]:mt-24 *:[main]:mr-28"
>
	<aside class="flex h-[250vh] -translate-x-[22rem] -skew-x-12 flex-row">
		<div
			class="flex flex-col items-end gap-y-6 bg-black pt-20 pr-8 pl-32 text-white *:[button]:w-fit *:[button]:rounded-sm *:[button]:px-4 *:[button]:py-2.5 *:[button]:transition *:[button]:hover:cursor-pointer *:[button]:hover:brightness-95"
		>
			<button
				class="button-text {selectedSport == undefined
					? 'bg-custom-orange'
					: 'bg-custom-blue outline outline-white'} "
				onclick={() => {
					selectedSport = undefined;
				}}><div class="skew-x-12">FULL SCHEDULE</div></button
			>
			<button class="border-custom-light-blue button-text border-2">
				<div class="flex skew-x-12 items-center gap-x-1.5 leading-none">
					PDF <img src={downloadIcon} alt="download" />
				</div></button
			>
			{#if selectedSport == undefined}
				<div transition:fade={{ duration: 100 }} class="flex items-center gap-x-4">
					<p class="leading-tight">Select a Sport<br />to see Pools</p>
					<div
						class="bg-custom-dark-gray h-[calc(100%-0.5rem)] w-4"
						style="clip-path: polygon(0% 0%, 100% 50%, 0% 100%);"
					></div>
				</div>
			{/if}
		</div>
		<div class="bg-custom-blue flex flex-col gap-y-4 pt-14 *:translate-x-8">
			{#each sports as s}
				<ScheduleSidebarSportCard
					sport={s}
					onclick={() => {
						selectedSport = s;
					}}
					selected={selectedSport == s}
				/>
			{/each}
		</div>
	</aside>

	{#if selectedSport == undefined}
		<FullSchedule />
	{:else if selectedSport == 'Athletics'}
		<AthleticsSchedule />
	{:else}
		<SportSchedule sport={selectedSport} />
	{/if}
</div>
