<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import type { GetPoolsBySportIdResponseTeamData } from '$lib/types/pools';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import type { ClassValue } from 'svelte/elements';
	import chevronUpSvg from '$lib/assets/icons/chevron-up.svg';
	import { slide } from 'svelte/transition';

	let {
		poolName,
		teamData,
		class: className
	}: {
		poolName: string;
		teamData: Array<GetPoolsBySportIdResponseTeamData>;
		class?: ClassValue;
	} = $props();
	teamData.sort((a, b) => {
		return a.tempName.localeCompare(b.tempName);
	});

	let poolOpen = $state(false);
</script>

<div
	class="button-text *:not-first:border-custom-gray grid h-fit w-[14rem] grid-cols-1 flex-col gap-y-1 *:px-4 *:py-2.5 *:not-first:border 2xl:w-[15rem] {className}"
>
	<div class="bg-custom-pastel-yellow flex">
		POOL - <span class="font-extrabold">{poolName}</span>
		<button
			class="ml-auto hover:cursor-pointer md:hidden"
			onclick={() => {
				poolOpen = !poolOpen;
			}}
			><img
				src={chevronUpSvg}
				class="{poolOpen ? '' : 'rotate-180'} transition-all"
				alt="open/close"
			/></button
		>
	</div>
	{#each teamData as team}
		{#if team.name != null && (poolOpen || innerWidth >= 768)}
			<div class="flex items-center leading-none" transition:slide>
				<img class="mr-2 h-fit w-6" src={getIITImgSrc(team.name as IITNames)} alt="iit logo" />
				<span class="pt-2">IIT {team.name}</span>
			</div>
		{:else if poolOpen || innerWidth >= 768}
			<div transition:slide>{team.tempName}</div>
		{/if}
	{/each}
</div>
