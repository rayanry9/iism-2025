<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { Sports } from '$lib/types/sports';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import Button from '../components/Button.svelte';

	let {
		activeIIT,
		sports,
		activeSport = $bindable()
	}: { activeIIT: IITNames; sports: Sports[]; activeSport: Sports | undefined } = $props();
</script>

<div class="flex w-full flex-col items-center justify-between gap-8 xl:flex-row">
	<div class="flex min-w-fit items-center gap-[2rem]">
		<img src={getIITImgSrc(activeIIT)} class="h-16 xl:h-12 2xl:h-24" alt="iit logo" />
		<div class="flex flex-col">
			<span class="xl:text-2xl 2xl:text-4xl">IIT {activeIIT}</span>
			<!-- <span class="text-2xl xl:text-xl">Ranked 1st in Leaderboard</span> -->
		</div>
	</div>
	<div class={`grid grid-cols-5 gap-4`}>
		{#each sports as sport}
			<Button
				onclick={() => {
					activeSport = sport;
				}}
				class={`border-custom-light-blue flex size-16 flex-col items-center justify-center rounded-sm border-1 p-1.5 ${activeSport == sport ? 'bg-custom-blue' : 'bg-custom-white'}`}
			>
				<img src={getSportImageSrc(sport)} class="mx-auto my-auto h-8" alt="sport" />
			</Button>
		{/each}
	</div>
</div>
<div class="border-t-custom-gray mt-12 ml-4 h-0 w-[95%] border-t"></div>
