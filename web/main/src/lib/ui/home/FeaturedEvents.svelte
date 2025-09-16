<script lang="ts">
	import img1 from '$lib/assets/featured-event-1.webp';
	import img2 from '$lib/assets/featured-event-2.webp';
	import img3 from '$lib/assets/featured-event-3.webp';
</script>

{#snippet EventDiv(
	num: number,
	titleText: string,
	subText: string,
	imgSrc: string,
	className?: string,
	bgColor?: string
)}
	<div
		class="flex flex-col items-center py-12 text-center text-white lg:py-20 xl:py-24 {className} relative h-fit overflow-clip"
	>
		<img
			src={imgSrc}
			alt="bg img"
			class="absolute top-0 -z-30 h-full w-full skew-y-8 object-cover max-lg:scale-125 lg:max-w-full lg:skew-y-0"
		/>
		<div class="{bgColor} absolute top-0 left-0 -z-10 h-full w-full opacity-90"></div>
		<div
			class="relative -skew-x-12 skew-y-8 text-[7.5rem] leading-none lg:skew-y-0 lg:text-[8rem] xl:text-[8.5rem] 2xl:text-[10rem]"
		>
			{num}
			<span class="button-text absolute top-0 -right-4 skew-x-12 skew-y-8 lg:skew-y-0">TH</span>
		</div>
		<h2 class="skew-y-8 lg:skew-y-0">{@html titleText}</h2>
		<div
			class="button-text mt-4 -skew-x-12 skew-y-8 rounded-sm border border-white px-12 py-2 leading-none lg:skew-y-0"
		>
			<div class="skew-x-12">{@html subText}</div>
		</div>
	</div>
{/snippet}

<section class="mt-32 flex flex-col items-center">
	<h2>FEATURED EVENTS</h2>

	<p class="mt-8 mb-16 w-4/5 text-center lg:w-3/4 2xl:mb-4 2xl:w-1/2">
		These are some of the key events happening as part of Inter IIT this year. Each one brings
		athletes from across IITs together for an exciting showcase of talent and spirit.
	</p>

	<div class="relative w-full">
		<div
			class="bg-custom-dark-yellow absolute -z-10 h-full w-full lg:bottom-[12%] lg:h-[76%]"
		></div>
		<div
			class="bg-custom-yellow absolute bottom-[7%] -z-20 hidden h-[86%] w-full lg:block"
			style="clip-path: polygon(0% 0%, 100% 10%, 100% 100%, 0% 90%);"
		></div>
		<div class="bg-custom-yellow absolute -z-20 h-full w-full skew-y-6 lg:hidden"></div>
		<div id="event-div" class="grid w-full -skew-y-8 lg:skew-y-0 lg:grid-cols-3">
			{@render EventDiv(
				39,
				'INTER IIT<br/>AQUATICS MEET',
				'30<sup>th</sup> Sep to 5<sup>th</sup> Oct 2025',
				img1,
				'lg:translate-y-4 xl:translate-y-8',
				'bg-custom-blue'
			)}
			{@render EventDiv(
				58,
				'INTER IIT<br/>SPORTS MEET',
				'14<sup>th</sup> Dec to 21<sup>st</sup> Dec 2025',
				img2,
				'',
				'bg-custom-teal'
			)}
			{@render EventDiv(
				30,
				'INTER IIT STAFF<br/>SPORTS MEET',
				'24<sup>th</sup> Dec to 29<sup>th</sup> Dec 2025',
				img3,
				'lg:-translate-y-4 xl:-translate-y-8',
				'bg-custom-dark-blue'
			)}
		</div>
	</div>
</section>

<style>
	@media (width >= 64rem) {
		#event-div {
			clip-path: polygon(0% 20%, 100% 0%, 100% 80%, 0% 100%);
		}
	}
</style>
