<script lang="ts">
	import type { GetPoolsBySportIdResponseTeamData } from '$lib/types/pools';
	import type { ClassValue } from 'svelte/elements';

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
</script>

<div
	class="button-text *:not-first:border-custom-gray grid h-fit w-[15rem] grid-cols-1 flex-col gap-y-1 *:px-4 *:py-2.5 *:not-first:border {className}"
>
	<div class="bg-custom-pastel-yellow">
		POOL - <span class="font-extrabold">{poolName}</span>
	</div>
	{#each teamData as team}
		{#if team.name != null}
			<div>{team.name}</div>
		{:else}
			<div>{team.tempName}</div>
		{/if}
	{/each}
</div>
