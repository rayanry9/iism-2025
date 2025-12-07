<script lang="ts">
	import Button from '../components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';
	import type { TopStory } from '$lib/types/topStories';
	import { PUBLIC_API_URL } from '$env/static/public';

	let {
		topStories
	}: {
		topStories: TopStory[];
	} = $props();
	let scrollContainer;

	function scrollLeft() {
		if (!scrollContainer) return;

		scrollContainer.scrollBy({
			left: -(scrollContainer.offsetWidth * 0.9),
			behavior: 'smooth'
		});
	}

	function scrollRight() {
		if (!scrollContainer) return;

		scrollContainer.scrollBy({
			left: scrollContainer.offsetWidth * 0.9,
			behavior: 'smooth'
		});
	}
</script>

<section class="flex flex-col items-center pt-24">
	<h2 class="mb-2 text-center">TOP STORIES</h2>

	<p class="mb-6 text-center text-black">See What is Happening Through top stories and Updates</p>

	<!-- Horizontal Scroll -->
	<div
		class="flex h-fit max-w-full snap-x snap-mandatory items-center gap-10 overflow-x-auto scroll-smooth px-40"
		style="scrollbar-width: none;"
		bind:this={scrollContainer}
	>
		<style>
			div::-webkit-scrollbar {
				display: none;
			}
		</style>

		{#each topStories as story}
			<div class="relative flex min-w-80 flex-col overflow-hidden rounded-xl bg-white md:min-w-120">
				<img
					src={PUBLIC_API_URL + '/gallery/' + story.imgSrc}
					alt="post"
					class="h-60 w-80 rounded-t-xl object-cover object-center md:h-100 md:w-120 md:min-w-120"
				/>
				<div
					class="border-custom-gray title-text bottom-0 flex w-full items-center rounded-b-xl border bg-white px-4 py-4 text-black md:px-10 md:py-5"
				>
					{story.subText}
					<a href={story.href} class="ml-auto w-fit" rel="noopener" target="_blank">
						<button
							class="button-text bg-custom-pastel-blue text-custom-teal hover:bg-custom-blue border-custom-teal w-fit rounded-full border px-4 py-1 transition-colors duration-200 hover:cursor-pointer hover:text-white md:px-5 md:py-2"
							>VIEW</button
						>
					</a>
				</div>
			</div>
		{/each}
	</div>

	<!-- Navigation Buttons -->
	<div class="mt-12 flex items-center gap-6">
		<!-- VIEW ALL -->
		<a
			href="https://www.instagram.com/interiit_sportsmeet/"
			rel="noopener"
			target="_blank"
			class="inline-block"
		>
			<Button
				class="hover:bg-custom-blue hover:border-custom-blue
					   border border-[#0A4C62]
					   bg-[#D2EDF2] px-8
					   py-3 text-[#0A4C62] transition hover:text-white"
			>
				<span class="button-text flex skew-x-6 items-center gap-2">
					VIEW ALL <span class="inline-block text-lg">↗</span>
				</span>
			</Button>
		</a>

		<div class="*:border-custom-gray hidden gap-x-4 *:border *:p-4 xl:flex">
			<Button
				onclick={() => {
					scrollContainer?.scrollBy({ behavior: 'smooth', left: -scrollContainer.clientWidth / 2 });
				}}
			>
				<img src={arrowLeft} alt="Arrow Left" />
			</Button>
			<Button
				onclick={() => {
					scrollContainer?.scrollBy({ behavior: 'smooth', left: scrollContainer.clientWidth / 2 });
				}}
			>
				<img class="rotate-180" src={arrowLeft} alt="Arrow Left" />
			</Button>
		</div>
	</div>
</section>
