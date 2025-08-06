<script lang="ts">
	import landingHeader from '$lib/assets/landing-header.webp';
	import logoWithText from '$lib/assets/logo-text.webp';
	import iithLogoFull from '$lib/assets/iith-logo-full.png';
	import pin from '$lib/assets/icons/pin.svg';
	import SocialButtons from '$lib/ui/common/SocialButtons.svelte';
	import NavScreenMobile from '../components/NavScreenMobile.svelte';
</script>

<header
	class="3xl:p-5 3xl:rounded-2xl relative h-full overflow-x-clip rounded-lg p-2 sm:p-3 2xl:p-4"
>
	<div class="relative z-10 h-full">
		<!-- Gradients -->
		<div
			class="absolute z-0 h-1/3 w-full rounded-2xl bg-gradient-to-b from-black/60 to-transparent"
		></div>
		<div
			class="absolute z-0 h-full w-1/2 rounded-2xl bg-gradient-to-r from-black/60 to-transparent"
		></div>

		<!-- Main image -->
		<img
			src={landingHeader}
			alt="Landing"
			class="3xl:rounded-2xl h-full w-full rounded-lg object-cover object-[65%_10%]"
		/>

		<!-- Logo + Text container positioned on top left of the image -->
		<section
			class="3xl:-left-4 3xl:gap-x-5 3xl:pl-9 3xl:pr-7 3xl:rounded-br-2xl 3xl:py-5 absolute -top-[0.3px] -left-2 flex -skew-x-12 items-center gap-x-2 rounded-br-lg bg-white py-3 pr-3 pl-4 sm:pr-4"
		>
			<!-- Rounded Corner top right -->
			<div
				class="top-left-corner 3xl:size-4 3xl:-right-4 absolute top-0 -right-2 size-2 bg-white"
			></div>
			<!-- Rounded Corner bottom left-->
			<div
				class="top-left-corner 3xl:size-4 3xl:left-[27px] 3xl:-bottom-[15px] absolute -bottom-[7.5px] left-[16px] size-2 skew-x-12 bg-white"
			></div>

			<img src={logoWithText} alt="IISM Logo" class="3xl:h-14 h-9 skew-x-12 sm:h-12" />
		</section>

		<!--Nav bar for the layouts other than mobile-->
		<nav
			class="3xl:p-12 3xl:gap-x-12 absolute top-0 right-0 hidden justify-end gap-x-6 text-white lg:flex lg:p-8"
		>
			<a href="/" class="button-text hover:underline">HOME</a>
			<a href="/schedule" class="button-text hover:underline">SCHEDULE</a>
			<a href="/teams" class="button-text hover:underline">TEAMS & PLAYERS</a>
			<a href="/live-score" class="button-text hover:underline">LIVE SCORE</a>
			<a href="/results" class="button-text hover:underline">RESULTS</a>
			<a href="/gallery" class="button-text hover:underline">GALLERY</a>
			<a href="/contact" class="button-text hover:underline">CONTACT</a>
		</nav>

		<!--Nav bar for mobile-->
		<nav class="absolute top-0 left-0 z-50 w-full lg:hidden">
			<NavScreenMobile class={'absolute top-4 right-6 text-white'} />
		</nav>

		<!-- Header Text -->
		<section
			class="3xl:pl-28 3xl:gap-8 absolute top-32 flex flex-col justify-center gap-4 pl-14 text-white sm:top-40 sm:gap-6 sm:pl-16 lg:top-0 lg:bottom-0"
		>
			<!-- IITH logo -->
			<div class="flex justify-start">
				<img src={iithLogoFull} alt="IITH Logo" class="3xl:h-10 mb-4 h-7 sm:h-8" />
			</div>

			<!-- Event Title -->
			<h1 class="hero-text text-nowrap">
				58TH<br />
				INTER IIT<br />
				SPORTS MEET<br />
				2025<br />
			</h1>

			<!-- IIT HYDERABAD location -->
			<div
				class="-mt-2 flex w-fit items-center gap-2 rounded-full border border-white bg-[#020202] px-3.5 py-2.5"
			>
				<img src={pin} alt="pin" class="3xl:size-fit -mt-0.5 size-4 sm:size-5" />
				<span class="tags-text">IIT HYDERABAD</span>
			</div>

			<!-- Dates -->
			<div
				class="bg-custom-blue/60 tags-text inline-flex w-fit items-center gap-2 rounded-sm border border-white/80 px-4 py-2"
			>
				14th to 21st December 2025
			</div>
		</section>

		<!-- Bottom Right Announcement -->
		<section
			class="3xl:rounded-tl-2xl 3xl:pt-5 3xl:pl-5 absolute -right-2 -bottom-[0.3px] flex w-fit -skew-x-12 flex-col rounded-tl-lg bg-white pt-3 pr-4 pb-1.5 pl-3 text-white"
		>
			<!-- Rounded Corner top right -->
			<div
				class="bottom-right-corner 3xl:size-4 3xl:-top-[0.9rem] absolute -top-[7.7px] right-[15.7px] size-2 skew-x-12 bg-white"
			></div>

			<!-- Rounded Corner bottom left -->
			<div
				class="bottom-right-corner 3xl:size-4 3xl:-left-[0.98rem] absolute -bottom-[0.2px] -left-2 size-2 bg-white"
			></div>

			<div class="skew-x-12">
				<SocialButtons />
			</div>
		</section>
	</div>
</header>

<style>
	@media (width>=120rem) {
		.top-left-corner {
			mask-image: radial-gradient(
				circle 1rem at bottom right,
				transparent 0%,
				transparent 100%,
				black 100%
			) !important;
		}
		.bottom-right-corner {
			mask-image: radial-gradient(
				circle 1rem at top left,
				transparent 0%,
				transparent 100%,
				black 100%
			) !important;
		}
	}

	.top-left-corner {
		mask-composite: exclude;
		mask-image: radial-gradient(
			circle 0.5rem at bottom right,
			transparent 0%,
			transparent 100%,
			black 100%
		);
	}
	.bottom-right-corner {
		mask-composite: exclude;
		mask-image: radial-gradient(
			circle 0.5rem at top left,
			transparent 0%,
			transparent 100%,
			black 100%
		);
	}
</style>
