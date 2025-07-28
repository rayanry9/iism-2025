<script lang="ts">
	import type { IITNames } from '$lib/types/other';
	import { getIITImgSrc } from '$lib/utility/iitLogoSrc';
	import { fade } from 'svelte/transition';

	let {
		poolName,
		poolTeamTempName,
		iit
	}: { poolName: string; poolTeamTempName: string; iit?: IITNames } = $props();
</script>

<div class="flex w-full flex-col items-center gap-y-4">
	<div class="title-text">Coin Deciding</div>
	<div
		class="flex h-[7.5rem] w-full rounded-xl border-2 border-custom-yellow bg-custom-dark-blue *:h-full **:leading-none"
	>
		<div
			class="flex w-1/2 shrink items-center justify-between pr-24 pl-12 *:flex *:items-center *:gap-x-2"
		>
			<div class="">
				<div class="title-text opacity-40">Pool</div>
				<h2 class="text-custom-yellow">{poolName}</h2>
			</div>
			<div class="">
				<div class="title-text opacity-40">Position</div>
				<h2 class="text-custom-yellow">{poolTeamTempName}</h2>
			</div>
		</div>
		<div class="w-0.5 -skew-x-12 bg-custom-yellow"></div>
		<div class="flex w-1/2 flex-col items-center justify-center">
			{#if iit == undefined}
				<div in:fade class="title-text">Loading</div>
				<span in:fade class="loading loading-lg -skew-x-12 loading-bars text-custom-yellow"></span>
			{:else}
				<div in:fade class="flex items-center gap-x-6">
					<img class="h-16" src={getIITImgSrc(iit)} alt="{iit} logo" />
					<h2>IIT {iit}</h2>
				</div>
			{/if}
		</div>
	</div>
</div>
