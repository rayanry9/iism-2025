<script lang="ts">
	import Button from '../components/Button.svelte';
	import HomeSportCard from './HomeSportCard.svelte';
	import diagArrow from '$lib/assets/icons/diag-up-right-arrow.svg';
</script>

<section class="3xl:mb-48 relative mb-24 sm:mb-32 lg:mb-36 xl:mb-28 2xl:mb-32">
	<div class="bg-custom-teal-light absolute h-full w-full -skew-y-6 xl:-skew-y-3"></div>
	<div class="bg-custom-teal absolute h-full w-full"></div>
	<div
		class="bg-custom-dark-blue 3xl:px-28 flex skew-y-6 flex-col px-6 pt-14 pb-20 text-white sm:px-14 sm:pt-20 lg:px-16 xl:skew-y-3 xl:px-20 xl:pt-16 2xl:px-24 2xl:pt-20 2xl:pb-24"
	>
		<h1 class="hero-text -skew-y-6 xl:-skew-y-3">
			SPORTS <br class="hidden xl:block" />TO <br class="xl:hidden" />PLAY
		</h1>
		<div
			class="3xl:gap-x-80 mt-8 flex -skew-y-6 flex-col gap-y-16 xl:-skew-y-3 xl:flex-row xl:gap-x-24 2xl:gap-x-32"
		>
			<p class="xl:self-end">
				Welcome to the highly anticipated Inter-IIT Sports Meet, 2025! This year's competition
				promises to be an exhilarating showcase of athletic talent, teamwork, and sportsmanship.
				Here's a glimpse into the exciting games that will be featured:
			</p>
			<div
				class="3xl:mr-36 3xl:gap-x-12 flex flex-col items-center gap-y-16 max-xl:flex-wrap max-xl:justify-center sm:flex-row sm:gap-x-8 xl:mr-24 2xl:mr-32 2xl:gap-x-10"
			>
				<HomeSportCard sport="Athletics" />
				<HomeSportCard sport="Cricket" />
			</div>
		</div>

		<div
			class="3xl:mt-20 3xl:mr-12 3xl:gap-x-12 mt-16 flex -skew-y-6 flex-col items-center gap-y-16 max-xl:flex-wrap max-xl:justify-center sm:flex-row sm:gap-x-8 lg:mt-12 xl:mt-8 xl:-skew-y-3 xl:self-end 2xl:mt-12 2xl:mr-8 2xl:gap-x-10"
		>
			<HomeSportCard sport="Football" />
			<HomeSportCard sport="Hockey" />
			<HomeSportCard sport="Volleyball" />
		</div>

		<a
			href="/results"
			class="3xl:mt-28 3xl:mr-24 mt-16 w-fit -skew-y-6 self-center xl:mt-12 xl:-skew-y-3 xl:self-end 2xl:mt-20 2xl:mr-20"
			data-umami-event="Leaderboard from home"
		>
			<Button class="bg-custom-orange px-6 py-2 *:flex *:gap-x-2">
				View Leaderboard
				<img src={diagArrow} alt="arrow" />
			</Button>
		</a>
	</div>
</section>
