<script lang="ts">
	import ScheduleSidebarSportCard from '../schedule/ScheduleSidebarSportCard.svelte';
	import downloadIcon from '$lib/assets/icons/download.svg';
	import type { Sports } from '$lib/types/sports';
	import { page } from '$app/state';
	import { fade } from 'svelte/transition';
	import { globals } from '$lib/state.svelte';
	let sports = $derived.by(() => {
		if (!globals.staff) {
			return ['Athletics', 'Cricket', 'Football', 'Hockey', 'Volleyball'] satisfies Array<Sports>;
		} else {
			return [
				'Athletics',
				'Badminton',
				'Basketball',
				'Chess',
				'Cricket',
				'Football',
				'Table Tennis',
				'Tennis',
				'Volleyball',
				'Squash'
			] satisfies Array<Sports>;
		}
	});

	let {
		buttonText,
		bottomText,
		selectedSport = $bindable()
	}: {
		buttonText: string;
		bottomText: string;
		selectedSport: Sports | undefined;
	} = $props();
</script>

<aside
	class="hidden flex-col xl:ml-[1.5rem] xl:flex xl:h-full xl:-translate-x-[11rem] xl:-skew-x-12 xl:flex-row 2xl:ml-[0.5rem]"
>
	<div
		class="hidden flex-col items-end gap-y-6 bg-black pt-20 pl-32 text-white xl:flex xl:pr-4 2xl:pr-8 *:[button]:w-fit *:[button]:rounded-sm *:[button]:px-4 *:[button]:py-2.5 *:[button]:transition *:[button]:hover:cursor-pointer *:[button]:hover:brightness-95"
	>
		<button
			class="button-text {selectedSport == undefined
				? 'bg-custom-orange'
				: 'bg-custom-blue outline outline-white'} "
			onclick={() => {
				selectedSport = undefined;
			}}><div class="skew-x-12">{buttonText}</div></button
		>
		<button
			hidden={page.url.pathname != '/schedule'}
			class="border-custom-light-blue button-text border-2"
			data-umami-event="Full schedule pdf download"
		>
			<div class="flex skew-x-12 items-center gap-x-1.5 leading-none">
				PDF <img src={downloadIcon} alt="download" />
			</div></button
		>
		{#if selectedSport == undefined}
			<div transition:fade={{ duration: 100 }} class="flex items-center gap-x-4">
				<p class="leading-tight">{@html bottomText}</p>
				<div
					class="bg-custom-dark-gray h-[calc(100%-0.5rem)] w-4"
					style="clip-path: polygon(0% 0%, 100% 50%, 0% 100%);"
				></div>
			</div>
		{/if}
	</div>
	<div
		style="scrollbar-color: var(--custom-light-blue) #F0F0F0; scrollbar-width:auto ;"
		class="bg-custom-blue hidden flex-col overflow-x-visible overflow-y-scroll pt-14 *:translate-x-8 xl:flex xl:w-[8rem] xl:gap-y-[3vh] 2xl:w-[11rem] 2xl:gap-y-4"
	>
		{#each sports as s}
			<ScheduleSidebarSportCard
				sport={s}
				selected={selectedSport == s}
				onclick={() => {
					selectedSport = s;
				}}
			/>
		{/each}
	</div>
</aside>
