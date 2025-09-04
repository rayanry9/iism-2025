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
		class="flex flex-col items-center py-24 text-center text-white {className} relative h-fit overflow-y-clip"
	>
		<img src={imgSrc} alt="bg img" class="absolute top-0 -z-30 max-w-full" />
		<div class="{bgColor} absolute top-0 left-0 -z-10 h-full w-full opacity-90"></div>
		<div class="relative -skew-x-12 text-[10rem] leading-none">
			{num}
			<span class="button-text absolute top-0 -right-4 skew-x-12">TH</span>
		</div>
		<h2>{@html titleText}</h2>
		<div class="button-text mt-4 -skew-x-12 rounded-sm border border-white px-12 py-2 leading-none">
			<div class="skew-x-12">{@html subText}</div>
		</div>
	</div>
{/snippet}

<section class="mt-32 flex flex-col items-center">
	<h2>FEATURED EVENTS</h2>

	<p class="mt-8 mb-4 w-[50%] text-center">
		These are some of the key events happening as part of Inter IIT this year. Each one brings
		athletes from across IITs together for an exciting showcase of talent and spirit.
	</p>

	<div class="relative w-full">
		<div class="bg-custom-dark-yellow absolute bottom-[12%] -z-10 h-[76%] w-full"></div>
		<div
			class="bg-custom-yellow absolute bottom-[7%] -z-20 h-[86%] w-full"
			style="clip-path: polygon(0% 0%, 100% 10%, 100% 100%, 0% 90%);"
		></div>
		<div
			class="grid w-full grid-cols-3"
			style="clip-path: polygon(0% 20%, 100% 0%, 100% 80%, 0% 100%);"
		>
			{@render EventDiv(
				39,
				'INTER IIT<br/>AQUATICS MEET',
				'30<sup>th</sup> Sep to 5<sup>th</sup> Oct 2025',
				img1,
				'translate-y-8',
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
				'-translate-y-8',
				'bg-custom-dark-blue'
			)}
		</div>
	</div>
</section>
