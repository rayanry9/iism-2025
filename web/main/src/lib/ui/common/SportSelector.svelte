<script lang="ts">
	import { globals } from '$lib/state.svelte';
	import type { Sports } from '$lib/types/sports';
	import { getSportsAll } from '$lib/utility/sport';
	import Button from '../components/Button.svelte';

	let sports = $derived.by(() => {
		let arr = getSportsAll(globals.staff) as ('All Matches' | Sports)[];
		arr.unshift('All Matches');
		return arr;
	});
	let activeSport = $state(0);
	let { currentSport = $bindable() }: { currentSport: 'All Matches' | Sports } = $props();
</script>

<section
	class="flex flex-row gap-y-4 px-8 *:mx-2 max-xl:overflow-scroll xl:flex-wrap"
	style="scrollbar-width: none;"
>
	{#each sports as sport, i}
		<Button
			class="{activeSport == i
				? 'bg-custom-orange text-white'
				: 'outline-custom-gray outline'} rounded-sm px-6 py-2.5"
			onclick={() => {
				activeSport = i;
				currentSport = sport;
			}}
			data-umami-event="Day selector used"
			data-umami-event-day={sport}
		>
			{sports[i]}
		</Button>
	{/each}
</section>
