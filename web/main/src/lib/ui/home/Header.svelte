<script lang="ts">
	import logoWithText from '$lib/assets/logo-text.webp';
	import iithLogoFull from '$lib/assets/iith-logo-full-blue-text.webp';
	import pinImg from '$lib/assets/icons/pin.svg';
	import headerImg1 from '$lib/assets/header-1.webp';
	import headerImg2 from '$lib/assets/header-2.webp';
	import headerImg3 from '$lib/assets/header-3.webp';
	import headerImg4 from '$lib/assets/header-4.webp';
	import headerImg5 from '$lib/assets/header-5.webp';
	import headerMobImg1 from '$lib/assets/header-mob-1.webp';
	import headerMobImg2 from '$lib/assets/header-mob-2.webp';
	import headerMobImg3 from '$lib/assets/header-mob-3.webp';
	import headerMobImg4 from '$lib/assets/header-mob-4.webp';
	import SocialButtons from '$lib/ui/common/SocialButtons.svelte';
	import FlairedTitle from '../components/FlairedTitle.svelte';
	import { onMount } from 'svelte';
	import Button from '../components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left-white.svg';
	import arrowRight from '$lib/assets/icons/arrow-right-white.svg';
	import { globals } from '$lib/state.svelte';

	let remTime = $derived(
		new Date(2025, 11, globals.staff ? 24 : 14, 0, 0, 0).getTime() - Date.now()
	);
	let remDays = $derived(Math.floor(remTime / (24 * 60 * 60 * 1000)));
	let remHours = $derived(Math.floor((remTime / (1000 * 60 * 60)) % 24));
	let remMinutes = $derived(Math.floor((remTime / (1000 * 60)) % 60));
	let remSeconds = $derived(Math.floor((remTime / 1000) % 60));

	const headerImages = [headerImg1, headerImg2, headerImg3, headerImg4, headerImg5];
	const mobHeaderImages = [headerMobImg1, headerMobImg2, headerMobImg3, headerMobImg4];

	let currentHeaderImageIdx = $state(0);

	onMount(() => {
		const imgInterval = setInterval(() => {
			if (window.innerWidth > 1280) {
				currentHeaderImageIdx = (currentHeaderImageIdx + 1) % headerImages.length;
			} else {
				currentHeaderImageIdx = (currentHeaderImageIdx + 1) % mobHeaderImages.length;
			}
		}, 3000);

		const interval = setInterval(() => {
			if (remSeconds <= 0) {
				if (remMinutes <= 0) {
					remMinutes = 59;
					if (remHours <= 0) {
						remHours = 59;
						if (remHours <= 0) {
							remDays -= 1;
						}
					} else {
						remHours -= 1;
					}
				} else {
					remMinutes -= 1;
				}
				remSeconds = 59;
			} else {
				remSeconds -= 1;
			}
		}, 1000);
		return () => {
			clearInterval(interval);
			clearInterval(imgInterval);
		};
	});
</script>

{#snippet MascotButtons()}
	<div class="flex flex-col items-start xl:-skew-x-12">
		<div class="button-text xl:skew-x-12">
			<span class="hidden xl:inline">Official</span> Event Mascot
		</div>
		<h1 class="hero-text mb-2 xl:-mb-4 xl:skew-x-12">SIMHI</h1>
	</div>

	<div class="relative flex flex-col xl:self-end">
		<div
			class="flex gap-x-2 *:rounded-sm *:border *:border-white *:px-2.5 *:py-2.5 2xl:gap-x-3 2xl:*:border-2 2xl:*:px-3 2xl:*:py-3"
		>
			<Button
				onclick={() => {
					if (window.innerWidth > 1280) {
						currentHeaderImageIdx = (currentHeaderImageIdx + 4) % headerImages.length;
					} else {
						currentHeaderImageIdx = (currentHeaderImageIdx + 3) % mobHeaderImages.length;
					}
				}}
			>
				<img src={arrowLeft} alt="left arrow" />
			</Button>
			<Button
				onclick={() => {
					if (window.innerWidth > 1280) {
						currentHeaderImageIdx = (currentHeaderImageIdx + 1) % headerImages.length;
					} else {
						currentHeaderImageIdx = (currentHeaderImageIdx + 1) % mobHeaderImages.length;
					}
				}}
			>
				<img src={arrowRight} alt="right arrow" />
			</Button>
		</div>

		<div
			class="mt-6 flex -skew-x-12 flex-row gap-x-1 *:size-2 xl:absolute xl:right-2.5 xl:-bottom-6 xl:mt-0 xl:hidden"
		>
			{#each mobHeaderImages as _, idx}
				<div class={idx == currentHeaderImageIdx ? 'bg-white' : 'bg-white/25'}></div>
			{/each}
		</div>
		<div
			class="mt-4 hidden -skew-x-12 flex-row gap-x-1 *:size-2 xl:absolute xl:right-2.5 xl:-bottom-6 xl:mt-0 xl:flex"
		>
			{#each headerImages as _, idx}
				<div class={idx == currentHeaderImageIdx ? 'bg-white' : 'bg-white/25'}></div>
			{/each}
		</div>
	</div>
{/snippet}

<header class="relative flex w-full lg:h-[calc(100vh-4rem)]">
	<div class="absolute right-0 z-20 hidden lg:block">
		<img
			fetchpriority="high"
			class="h-[calc(100vh-4rem)]"
			src={headerImages[currentHeaderImageIdx % headerImages.length]}
			alt="hero img"
		/>
	</div>
	<section
		class="flex grow flex-col items-center gap-y-4 text-center lg:items-start lg:text-start xl:gap-y-8 2xl:gap-y-14"
	>
		<div
			class="3xl:mt-24 hidden w-full lg:mt-8 lg:flex lg:pl-[5rem] xl:mt-12 xl:pl-[8.5rem] 2xl:mt-16 2xl:pl-[15rem]"
		>
			<div class="flex lg:gap-x-6 xl:gap-x-8">
				<img class="h-10 2xl:h-12" src={logoWithText} alt="inter iit logo" />
				<img class="h-10 2xl:h-12" src={iithLogoFull} alt="iit hyderabad logo" />
			</div>
			<div
				class="3xl:gap-x-20 3xl:mr-0 z-40 ml-auto hidden text-white lg:-mr-8 lg:flex lg:gap-x-6 xl:-mr-10 xl:gap-x-8 2xl:-mr-6 2xl:gap-x-12"
			>
				{@render MascotButtons()}
			</div>
		</div>

		<div class="mt-20 lg:mt-0 lg:ml-[5rem] xl:ml-[8.5rem] 2xl:ml-[15rem]">
			<h1 class="hero-text flex flex-col items-center lg:block">
				{globals.staff ? '30TH' : '58TH'}<br />INTER IIT{globals.staff ? ' STAFF' : ''}<br />SPORTS
				MEET<br />2025<span
					class="button-text text-custom-orange border-custom-orange flex h-fit w-fit gap-x-2 rounded-3xl border px-4 pt-2.5 pb-2 align-top leading-none not-italic lg:mt-1 lg:ml-4 lg:inline-flex lg:pt-2 lg:pb-1.5 xl:mt-2 xl:pt-2.5 xl:pb-2"
					><img src={pinImg} class="text-custom-orange -mt-1 inline" alt="pin" />IIT Hyderabad</span
				>
			</h1>
		</div>

		<div class="mt-8 w-full xl:mt-0 2xl:mt-12">
			<div class="button-text lg:ml-[6rem] xl:ml-[10.5rem] 2xl:ml-[17.5rem]">
				{#if globals.staff}
					24th to 29th December 2025
				{:else}
					14th to 21st December 2025
				{/if}
			</div>

			<FlairedTitle
				class="3xl:!w-[110rem] 3xl:-translate-x-[30rem] !w-full lg:!w-[50rem] lg:-translate-x-[13rem] xl:!w-[70rem] xl:-translate-x-[17.5rem] 2xl:!w-[90rem] 2xl:-translate-x-[20rem]"
			>
				<div
					class="*:inline-flex *:max-w-12 *:min-w-12 *:flex-col *:items-center 2xl:*:max-w-16 2xl:*:min-w-16 **:[span]:inline-flex **:[span]:max-w-3 **:[span]:min-w-3 **:[span]:justify-center 2xl:**:[span]:max-w-4 2xl:**:[span]:min-w-4"
				>
					<div>
						<div>
							{#if remDays >= 10}
								<span>{remDays.toString().at(0)}</span>
								<span>{remDays.toString().at(1)}</span>
							{:else}
								<span>0</span>
								<span>{remDays.toString().at(0)}</span>
							{/if}
						</div>
						<p class="leading-none">Days</p>
					</div>
					:
					<div>
						<div>
							{#if remHours >= 10}
								<span>{remHours.toString().at(0)}</span>
								<span>{remHours.toString().at(1)}</span>
							{:else}
								<span>0</span>
								<span>{remHours.toString().at(0)}</span>
							{/if}
						</div>
						<p class="leading-none">Hrs</p>
					</div>
					:
					<div>
						<div>
							{#if remMinutes >= 10}
								<span>{remMinutes.toString().at(0)}</span>
								<span>{remMinutes.toString().at(1)}</span>
							{:else}
								<span>0</span>
								<span>{remMinutes.toString().at(0)}</span>
							{/if}
						</div>
						<p class="leading-none">Mins</p>
					</div>
					:
					<div>
						<div>
							{#if remSeconds >= 10}
								<span>{remSeconds.toString().at(0)}</span>
								<span>{remSeconds.toString().at(1)}</span>
							{:else}
								<span>0</span>
								<span>{remSeconds.toString().at(0)}</span>
							{/if}
						</div>
						<p class="leading-none">Sec</p>
					</div>
				</div>
			</FlairedTitle>
		</div>

		<div class="relative lg:hidden">
			<img
				fetchpriority="high"
				class="max-w-screen"
				src={mobHeaderImages[currentHeaderImageIdx % mobHeaderImages.length]}
				alt="hero img"
			/>
			<div class="absolute top-[36%] flex flex-col pl-8 text-white sm:top-[44%] sm:pl-16">
				{@render MascotButtons()}
			</div>
			<SocialButtons class="*:bg-custom-teal-light absolute right-4 bottom-2" />
		</div>
	</section>
	<div class="z-50 hidden self-end lg:block">
		<SocialButtons
			class="*:bg-custom-teal-light !flex-col gap-y-4  lg:mr-4 lg:mb-4 xl:mb-6 2xl:mr-8 2xl:mb-24"
		/>
	</div>
</header>
