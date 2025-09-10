<script lang="ts">
	import Button from '../components/Button.svelte';
	import FlairedTitle from '../components/FlairedTitle.svelte';
	import IitCarouselItem from './IitCarouselItem.svelte';
	import upperRightArrow from '$lib/assets/icons/diag-up-right-arrow.svg';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';
	import { onMount } from 'svelte';

	let scrollingDiv: HTMLDivElement | undefined = $state<HTMLDivElement>();
	onMount(() => {
		scrollingDiv?.scrollBy({
			left: (scrollingDiv.scrollWidth - scrollingDiv.clientWidth) / 2,
			behavior: 'smooth'
		});
	});
</script>

<section class="my-24 flex flex-col items-center gap-y-12 sm:my-48">
	<FlairedTitle>PARTICIPATING IITS</FlairedTitle>

	<div class="flex flex-col items-center gap-y-8 px-12 text-center xl:*:w-[60rem]">
		<p class="">
			From North to South, East to West, students from 23 IITs across India will come together to
			compete in the 58th Inter IIT Sports Meet at IIT Hyderabad.
		</p>
		<!-- TODO -->
		<!-- <div class="tags-text text-custom-orange flex items-center justify-center gap-x-4"> -->
		<!-- 	<div class="bg-custom-orange size-4 animate-bounce rounded-full"></div> -->
		<!-- 	<div class="hidden xl:block"> -->
		<!-- 		(Hover over the logos to Identify their team jersey color and pattern) -->
		<!-- 	</div> -->
		<!-- 	<div class="block xl:hidden"> -->
		<!-- 		(Click on the logos to Identify their team jersey color and pattern) -->
		<!-- 	</div> -->
		<!-- </div> -->
	</div>

	<div class="relative w-full">
		<div
			class="*:border-custom-gray absolute -top-20 right-16 hidden gap-x-4 *:border *:p-4 xl:flex"
		>
			<Button
				onclick={() => {
					scrollingDiv?.scrollBy({ behavior: 'smooth', left: -scrollingDiv.clientWidth / 2 });
				}}
			>
				<img src={arrowLeft} alt="Arrow Left" />
			</Button>
			<Button
				onclick={() => {
					scrollingDiv?.scrollBy({ behavior: 'smooth', left: scrollingDiv.clientWidth / 2 });
				}}
			>
				<img class="rotate-180" src={arrowLeft} alt="Arrow Left" />
			</Button>
		</div>
		<div
			style="scrollbar-width: none;"
			bind:this={scrollingDiv}
			class="3xl:gap-x-16 3xl:px-32 grid auto-cols-auto grid-flow-col grid-rows-2 gap-x-6 gap-y-6 overflow-x-auto px-8 xl:grid-rows-1 xl:gap-x-12 xl:px-24"
		>
			<IitCarouselItem iit={'Bombay'} />
			<IitCarouselItem iit={'Bhubaneswar'} />
			<IitCarouselItem iit={'Bhilai'} />
			<IitCarouselItem iit={'(BHU) Varanasi'} />
			<IitCarouselItem iit={'Delhi'} />
			<IitCarouselItem iit={'Dharwad'} />
			<IitCarouselItem iit={'(ISM) Dhanbad'} />
			<IitCarouselItem iit={'Guwahati'} />
			<IitCarouselItem iit={'Gandhinagar'} />
			<IitCarouselItem iit={'Goa'} />
			<IitCarouselItem iit={'Hyderabad'} />
			<IitCarouselItem iit={'Indore'} />
			<IitCarouselItem iit={'Jodhpur'} />
			<IitCarouselItem iit={'Jammu'} />
			<IitCarouselItem iit={'Kanpur'} />
			<IitCarouselItem iit={'Kharagpur'} />
			<IitCarouselItem iit={'Madras'} />
			<IitCarouselItem iit={'Mandi'} />
			<IitCarouselItem iit={'Patna'} />
			<IitCarouselItem iit={'Palakkad'} />
			<IitCarouselItem iit={'Roorkee'} />
			<IitCarouselItem iit={'Ropar'} />
			<IitCarouselItem iit={'Tirupati'} />
		</div>
	</div>

	<a href="/teams" class="">
		<Button
			class="bg-custom-orange 3xl:px-12 flex-nowrap px-6 py-3 text-white *:flex *:flex-row *:gap-x-4"
			>SHOW FULL LIST<img src={upperRightArrow} alt="upper right arrow" /></Button
		>
	</a>
</section>
