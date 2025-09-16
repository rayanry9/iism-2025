<script lang="ts">
	import { page } from '$app/state';
	import type { Sports } from '$lib/types/sports';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import { fade } from 'svelte/transition';
	let {
		sport,
		selected = false,
		onclick = () => {}
	}: {
		sport: Sports;
		selected?: boolean;
		onclick?: () => void;
	} = $props();
</script>

<div
	role="button"
	onkeydown={onclick}
	tabindex={1}
	{onclick}
	class="relative mt-8 flex h-[8rem] w-[12rem] flex-col border-2 border-white transition-all {selected
		? 'bg-custom-orange'
		: 'bg-black'} "
	data-umami-event="Sport selected"
	data-umami-event-page={page.url.pathname}
>
	<img
		class="absolute {selected
			? '-top-8'
			: '-top-6'} right-0 left-0 mx-auto h-[8.5rem] skew-x-12 transition-all"
		src={getSportImageSrc(sport)}
		alt={sport}
	/>
	<div
		class=" transition-all {selected
			? 'bg-custom-dark-yellow border-t-custom-yellow'
			: 'bg-custom-dark-gray border-t-custom-gray'}  button-text z-20 mt-auto h-fit border-t-4 px-6 py-3 leading-none text-white"
	>
		<div class="skew-x-12">{sport.toUpperCase()}</div>
	</div>

	{#if selected}
		<div
			transition:fade={{ duration: 200 }}
			class="bg-custom-dark-yellow absolute top-0 -right-6 bottom-0 my-auto h-12 w-4 transition-all"
			style="clip-path: polygon(0% 0%, 100% 50%, 0% 100%);"
		></div>
	{/if}
</div>
