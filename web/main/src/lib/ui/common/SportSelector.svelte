<script lang="ts">
	import { page } from '$app/state';
	import { globals } from '$lib/state.svelte';
	import type { Sports } from '$lib/types/sports';
	import { getSportsAll } from '$lib/utility/sport';
	import Button from '../components/Button.svelte';

	let sports = $derived.by(() => {
		let arr = getSportsAll(globals.staff) as (undefined | Sports)[];
		arr.unshift(undefined);
		return arr;
	});
	let { currentSport = $bindable() }: { currentSport: undefined | Sports } = $props();
	let activeSport = $derived(sports.findIndex((val) => val == currentSport));
</script>

<section
	class="flex flex-row gap-y-4 px-8 *:mx-2 max-xl:overflow-scroll xl:flex-wrap"
	style="scrollbar-width: none;"
>
	{#each sports as sport, i}
		<Button
			class="{activeSport == i
				? 'bg-custom-orange text-white'
				: 'outline-custom-gray outline'} my-0.5 rounded-sm px-6 py-2.5"
			onclick={() => {
				activeSport = i;
				currentSport = sport;
			}}
			data-umami-event="Day selector used"
			data-umami-event-day={sport}
		>
			{#if sports[i]}
				{sports[i]}
			{:else if page.url.pathname != '/live-score'}
				Overall
			{:else}
				ALL MATCHES
			{/if}
		</Button>
	{/each}
</section>
