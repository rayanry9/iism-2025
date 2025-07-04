<script lang="ts">
	import Button from '../components/Button.svelte';
	import { ToggleTabs } from '../components/toggleTabs';

	let sport = $state('all');
</script>

<div>
	<article
		class="border-custom-gray drop-shadow-custom-gray relative mx-64 my-12 flex flex-row border drop-shadow-xs"
	>
		<aside
			class="border-r-custom-gray flex w-fit flex-col gap-y-3 border-r px-8 py-20 text-nowrap *:px-8 *:py-3 *:transition-colors *:duration-200 *:ease-out"
		>
			<Button
				onclick={() => {
					sport = 'all';
				}}
				class={sport == 'all' ? 'bg-custom-orange text-white' : 'outline-custom-gray outline'}
				>ALL MATCHES</Button
			>
			<Button
				onclick={() => {
					sport = 'football';
				}}
				class={sport == 'football' ? 'bg-custom-orange text-white' : 'outline-custom-gray outline'}
				>FOOTBALL</Button
			>
			<Button
				onclick={() => {
					sport = 'athletics';
				}}
				class={sport == 'athletics' ? 'bg-custom-orange text-white' : 'outline-custom-gray outline'}
				>ATHLETICS</Button
			>
			<Button
				onclick={() => {
					sport = 'hockey';
				}}
				class={sport == 'hockey' ? 'bg-custom-orange text-white' : 'outline-custom-gray outline'}
				>HOCKEY</Button
			>
			<Button
				onclick={() => {
					sport = 'volleyball';
				}}
				class={sport == 'volleyball'
					? 'bg-custom-orange text-white'
					: 'outline-custom-gray outline'}>VOLLEYBALL</Button
			>
			<Button
				onclick={() => {
					sport = 'cricket';
				}}
				class={sport == 'cricket' ? 'bg-custom-orange text-white' : 'outline-custom-gray outline'}
				>CRICKET</Button
			>
		</aside>

		<main class="relative w-full">
			<div class="absolute -top-10 right-0 left-0 *:mx-auto">
				<ToggleTabs.Root>
					<ToggleTabs.Item class="button-text px-10 py-5">ONGOING MATCHES</ToggleTabs.Item>
					<ToggleTabs.Item class="button-text px-10 py-5">UPCOMING MATCHES</ToggleTabs.Item>
				</ToggleTabs.Root>
			</div>
		</main>
	</article>
</div>
