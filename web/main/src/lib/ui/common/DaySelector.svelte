<script lang="ts">
	import { globals } from '$lib/state.svelte';
	import Button from '../components/Button.svelte';

	let days = $derived(
		globals.staff
			? [
					new Date(2025, 11, 23),
					new Date(2025, 11, 24),
					new Date(2025, 11, 25),
					new Date(2025, 11, 26),
					new Date(2025, 11, 27),
					new Date(2025, 11, 28),
					new Date(2025, 11, 29)
				]
			: [
					new Date(2025, 11, 13),
					new Date(2025, 11, 14),
					new Date(2025, 11, 15),
					new Date(2025, 11, 16),
					new Date(2025, 11, 17),
					new Date(2025, 11, 18),
					new Date(2025, 11, 19),
					new Date(2025, 11, 20),
					new Date(2025, 11, 21)
				]
	);
	let activeDate = $state(0);
	let { currentDate = $bindable() }: { currentDate: Date } = $props();
</script>

<section
	class="flex w-full flex-row gap-y-4 *:mx-2 max-xl:overflow-scroll xl:flex-wrap"
	style="scrollbar-width: none;"
>
	{#each days as day, i}
		<Button
			class="{activeDate == i
				? 'bg-custom-teal text-white'
				: 'outline-custom-gray outline'} rounded-sm px-6 py-2.5"
			onclick={() => {
				activeDate = i;
				currentDate = days[i];
			}}
			data-umami-event="Day selector used"
			data-umami-event-day={currentDate}
		>
			{day.getDate()}
			{day.toLocaleString('en-IN', { month: 'short' })}
		</Button>
	{/each}
</section>
