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

	import { getIITImgSrc } from '$lib/utility/iitLogoSrc';

	let { data }: { data: PoolCardData } = $props();
</script>

<div class="grid grid-cols-1 gap-y-1 *:flex *:h-[2.75rem] *:w-[13.5rem] *:items-center *:pl-4">
	<div class="bg-custom-teal-light">
		<h2 class="-mb-1 leading-none text-black">{data.PoolName}</h2>
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
			<div>{item.InstituteName ?? ''}</div>
		</div>
	{/each}
</div>
