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

<button
	{onclick}
	class="relative flex h-26 w-42 shrink-0 flex-col overflow-visible border-2 border-white transition-all 2xl:h-32 2xl:w-52 {selected
		? 'bg-custom-orange'
		: 'bg-black'} "
	data-umami-event="Sport selected"
	data-umami-event-page={page.url.pathname}
>
	<img
		class="{selected
			? 'bottom-5'
			: 'bottom-2 '} absolute right-0 left-0 mx-auto h-28 skew-x-12 transition-all 2xl:h-36"
		src={getSportImageSrc(sport)}
		alt={sport}
	/>
	<div
		class=" transition-all {selected
			? 'bg-custom-dark-yellow border-t-custom-yellow'
			: 'bg-custom-dark-gray border-t-custom-gray'} button-text z-20 mt-auto flex h-fit flex-col border-t-4 py-2.5 leading-none text-white 2xl:py-3"
	>
		<div class="mr-auto ml-3 skew-x-12 2xl:ml-6">{sport.toUpperCase()}</div>
	</div>

	{#if selected}
		<div
			transition:fade={{ duration: 200 }}
			class="bg-custom-dark-yellow absolute top-0 -right-6 bottom-0 my-auto h-8 w-4 transition-all 2xl:h-12"
			style="clip-path: polygon(0% 0%, 100% 50%, 0% 100%);"
		></div>
	{/if}
</button>
