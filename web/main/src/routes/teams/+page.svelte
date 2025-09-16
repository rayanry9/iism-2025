<script lang="ts">
	import { getAllIITNames, getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import asideBg from '$lib/assets/team-aside-bg.webp';
	import logoNoText from '$lib/assets/logo-no-text.svg';
	import type { IITNames } from '$lib/types/iitNames';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';

	let activeIIT = $state<IITNames | undefined>(undefined);
</script>

<div class="flex flex-col overflow-x-clip lg:flex-row">
	<MobileHeaderFrame>
		<h2>TEAMS</h2>
	</MobileHeaderFrame>
	<aside class="mr-32 -ml-64 hidden -skew-x-12 flex-row lg:flex">
		<div class="bg-custom-dark-blue relative mr-8 flex w-[20rem] flex-row overflow-x-clip">
			<img
				src={asideBg}
				alt="aside bg"
				class="absolute -top-12 left-48 w-[16rem] skew-x-12 opacity-30"
			/>
			<div class="border-l-custom-blue z-10 ml-auto h-full border-l-8"></div>
			<div class="border-l-custom-light-blue z-10 h-full border-l-8"></div>
		</div>
		<div
			class="my-12 flex h-[calc(100vh-10rem)] flex-col gap-y-6 overflow-y-scroll pr-8"
			style="scrollbar-color: #FDB424 #F0F0F0; scrollbar-width:auto ;"
		>
			{#each getAllIITNames() as iit}
				<button
					class="{activeIIT == iit
						? 'outline-custom-dark-yellow'
						: 'outline-custom-gray'} hover:bg-custom-light-blue/10 my-1 w-fit self-center px-10 py-6 outline-2 transition-colors hover:cursor-pointer xl:ml-4 2xl:mx-6"
					onclick={() => {
						activeIIT = iit;
					}}
					data-umami-event="Team selection"
					data-umami-event-team={activeIIT}
				>
					<img
						src={getIITImgSrc(iit)}
						class="skew-x-12 xl:w-16 2xl:w-24"
						alt={'IIT ' + iit + ' logo'}
					/>
				</button>
			{/each}
		</div>
	</aside>

	{#if activeIIT == undefined}
		<main class="flex h-fit grow items-center justify-center">
			<section
				class="mt-32 hidden flex-col items-center gap-y-6 text-center max-lg:mb-32 xl:mt-64 xl:flex"
			>
				<div class="relative">
					<div
						style="filter: invert(48%) sepia(79%) saturate(26%) hue-rotate(86deg) brightness(118%) contrast(119%) opacity(70%); clip-path: polygon(100% 0%, 100% 100%, 0% 50%);"
						class="absolute top-[calc(50%-1.5rem)] -left-24 h-12 w-4 bg-black"
					></div>
					<img
						src={logoNoText}
						alt="logo"
						class="h-fit"
						style="filter: invert(48%) sepia(79%) saturate(26%) hue-rotate(86deg) brightness(118%) contrast(119%) opacity(70%);"
					/>
				</div>
				<p>Select a College to see their<br />teams and players.</p>
			</section>
		</main>
	{:else}
		<main class="flex h-[calc(100vh-20rem)] grow items-center justify-center">
			<h2>Team has not been decided yet.</h2>
		</main>
	{/if}
</div>
