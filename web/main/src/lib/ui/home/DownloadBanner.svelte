<script lang="ts">
	import phonesImg from '$lib/assets/phones.webp';
	import downloadIcon from '$lib/assets/icons/download.svg';
	import appleDownload from '$lib/assets/apple-download.svg';
	import googleDownload from '$lib/assets/google-download.png';
	import Button from '../components/Button.svelte';
</script>

<section class="relative grid grid-cols-1 gap-y-20 pb-24 md:grid-cols-2">
	<img
		src={phonesImg}
		alt="phones"
		class="3xl:px-56 z-10 order-last w-full px-12 md:order-first md:px-16 lg:px-24 2xl:px-40"
	/>
	<div class="flex flex-col gap-y-10 px-8 leading-snug lg:w-[26rem] xl:w-[30rem] xl:px-0 xl:pl-24">
		<h2>STAY UPDATED !</h2>
		<div class="flex flex-col gap-y-5">
			<p>Download the brochure to know everything about the event in one place.</p>
			<Button
				data-umami-event="Brochure Download"
				class="bg-custom-teal w-fit rounded-sm py-3.5 pr-4 pl-6 leading-none text-white *:flex *:items-baseline *:gap-x-2"
				>DOWNLOAD <img src={downloadIcon} alt="download" class="size-4" /></Button
			>
		</div>
		<div class="flex flex-col gap-y-6">
			<p>
				Check schedules, live scores and daily updates on phone. Download the Inter IIT Sports Meet
				2025 app now.
			</p>
			<div class="flex gap-x-4 self-center md:self-start xl:gap-x-2">
				<a href="#" data-umami-event="IOS app download"
					><img
						src={appleDownload}
						class="w-[10rem] xl:w-[14rem]"
						alt="Download from Apple Store"
					/></a
				>
				<a href="#" data-umami-event="Android app download"
					><img
						src={googleDownload}
						class="w-[10rem] xl:w-[14rem]"
						alt="Download from Google Play Store"
					/></a
				>
			</div>
		</div>
	</div>

	<div
		class="bg-custom-yellow absolute z-[-2] h-full w-full"
		style="clip-path: polygon(0% 45%, 100% 100%, 0% 100%);"
	></div>
	<div
		class="bg-custom-dark-blue absolute -bottom-0.5 z-[-1] h-full w-full"
		style="clip-path: polygon(0% 50%, 100% 100%, 0% 100%);"
	></div>
</section>
