<script lang="ts">
	import Button from '../components/Button.svelte';

	let days = [
		new Date(2025, 11, 13),
		new Date(2025, 11, 14),
		new Date(2025, 11, 15),
		new Date(2025, 11, 16),
		new Date(2025, 11, 16),
		new Date(2025, 11, 17),
		new Date(2025, 11, 18),
		new Date(2025, 11, 19),
		new Date(2025, 11, 20),
		new Date(2025, 11, 21)
	];

	let activeDate = $state(0);
	let { currentDate = $bindable() }: { currentDate: Date } = $props();
</script>

<section class="flex flex-row flex-wrap gap-y-4 *:mx-2">
	{#each days as day, i}
		<Button
			class="{activeDate == i
				? 'bg-custom-teal text-white'
				: 'outline-custom-gray outline'} rounded-sm px-6 py-2.5"
			onclick={() => {
				activeDate = i;
				currentDate = days[i];
			}}
		>
			DAY {i} - {day.getDate()}/{day.getMonth()}/{day.getFullYear()}
		</Button>
	{/each}
</section>
