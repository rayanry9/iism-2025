<script lang="ts">
	import { getAllIITNames, getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import asideBg from '$lib/assets/team-aside-bg.webp';
	import logoNoText from '$lib/assets/logo-no-text.svg';
	import type { IITNames } from '$lib/types/iitNames';

	let activeIIT = $state<IITNames | undefined>(undefined);
</script>

<div class="flex flex-row overflow-x-clip">
	<aside class="mr-32 -ml-64 flex -skew-x-12 flex-row">
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
			class="my-12 flex h-screen flex-col gap-y-6 overflow-y-scroll pr-8"
			style="scrollbar-color: #FDB424 #F0F0F0; scrollbar-width:auto ;"
		>
			{#each getAllIITNames() as iit}
				<button
					class="{activeIIT == iit
						? 'outline-custom-dark-yellow'
						: 'outline-custom-gray'} hover:bg-custom-light-blue/10 mx-6 my-1 w-fit self-center px-10 py-6 outline-2 transition-colors hover:cursor-pointer"
					onclick={() => {
						activeIIT = iit;
					}}
				>
					<img src={getIITImgSrc(iit)} class="3xl:w-24 skew-x-12" alt={'IIT ' + iit + ' logo'} />
				</button>
			{/each}
		</div>
	</aside>

	{#if activeIIT == undefined}
		<main class="flex h-fit grow items-center justify-center">
			<section class="mt-64 flex flex-col items-center gap-y-6 text-center">
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
	{/if}
</div>
