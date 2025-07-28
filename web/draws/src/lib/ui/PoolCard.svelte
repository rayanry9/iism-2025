<script module>
	export interface PoolCardData {
		PoolName: string;
		Items: Array<{
			PoolTeamId: number;
			PoolTeamTempName: string;
			InstituteName?: string;
			Upcoming: boolean;
		}>;
	}
</script>

<script lang="ts">
	import type { IITNames } from '$lib/types/other';
	import bgPattern from '$lib/assets/img-1.webp';

	import { getIITImgSrc } from '$lib/utility/iitLogoSrc';

	let { data }: { data: PoolCardData } = $props();
</script>

<div class="grid grid-cols-1 gap-y-1 *:flex *:h-[2.75rem] *:w-[14rem] *:items-center *:pl-4">
	<div class="flex bg-custom-teal-light">
		<h2 class="-mb-1 leading-none text-black">{data.PoolName}</h2>
		<img src={bgPattern} class="ml-auto h-full" alt="bg pattern" />
	</div>
	{#each data.Items as item}
		<div
			class={`${item.Upcoming ? 'bg-custom-yellow text-white' : 'bg-white text-black'} button-text gap-x-2.5 transition-all duration-300 *:-ml-0.5 *:opacity-100 *:transition-all *:duration-300 *:starting:opacity-0`}
		>
			{#if item.InstituteName != undefined}
				<img
					src={getIITImgSrc(item.InstituteName as IITNames)}
					class="w-6"
					alt="{item.InstituteName} logo"
				/>
			{/if}
			{#if item.InstituteName}
				<div class="-mb-1 leading-none">IIT {item.InstituteName}</div>
			{/if}
		</div>
	{/each}
</div>
