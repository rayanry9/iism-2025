<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import patternImg from '$lib/assets/pattern.webp';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';

	let { sport }: { sport: Sports } = $props();
</script>

<div
	class="bg-custom-blue relative flex h-[10rem] w-fit -skew-x-12 flex-col overflow-x-clip 2xl:h-[11rem]"
>
	<div
		class="absolute h-full w-full skew-x-12 opacity-40"
		style="background-image: url({patternImg}); background-size: 150px; background-position-y: -2rem;"
	></div>
	<img
		src={getSportImageSrc(sport)}
		alt="{sport} img"
		style="clip-path: inset(0 0 5% 0);"
		class="absolute -top-5 right-8 h-[10rem] skew-x-12 2xl:-top-10 2xl:h-[12rem]"
	/>
	<div
		class="bg-custom-teal button-text border-t-custom-teal-light z-10 mt-auto flex w-[18rem] items-center border-t-4 p-4 pr-6 leading-none text-white 2xl:w-[21rem]"
	>
		<div class="skew-x-12">{sport.toUpperCase()}</div>
		<div class="item ml-auto flex skew-x-12 items-center gap-x-3">
			{#if sport == 'Athletics' || sport == 'Volleyball'}
				M&W
			{:else}
				M
			{/if}
			<div class=" flex gap-x-2">
				{#if sport == 'Athletics' || sport == 'Volleyball'}
					<img class="h-[1.2rem]" src={menSvg} alt="men" />
					<img src={womenSvg} class="h-[1.2rem]" alt="women" />
				{:else}
					<img class="h-[1.2rem]" src={menSvg} alt="men" />
				{/if}
			</div>
		</div>
	</div>
</div>
