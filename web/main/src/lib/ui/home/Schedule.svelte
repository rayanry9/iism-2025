<script lang="ts">
	import Button from '../components/Button.svelte';
	import { ToggleTabs } from '../components/toggleTabs';
	import ScheduleMatch from './ScheduleMatch.svelte';
	import ScheduleMatchMobile from './ScheduleMatchMobile.svelte';

	let sport = $state('all');
</script>

<div>
	<article
		class="border-custom-gray drop-shadow-custom-gray 3xl:mx-64 3xl:rounded-3xl 3xl:flex-row 3xl:*:px-12 3xl:*:py-24 relative mx-2 mt-5 flex flex-col rounded-lg border drop-shadow-xs *:px-6"
	>
		<div class="3xl:hidden absolute -top-6 right-0 left-0 *:mx-auto">
			<ToggleTabs.Root>
				<ToggleTabs.Item>ONGOING</ToggleTabs.Item>
				<ToggleTabs.Item>UPCOMING</ToggleTabs.Item>
			</ToggleTabs.Root>
		</div>

		<aside
			class="border-r-custom-gray border-b-custom-gray 3xl:border-r 3xl:flex-col 3xl:w-fit max-3xl:overflow-x-auto max-3xl:pb-8 max-3xl:pt-14 3xl:*:px-8 3xl:*:py-3 relative flex gap-3 border-b text-nowrap *:px-6 *:py-2 *:transition-colors *:duration-200 *:ease-out"
			style="scrollbar-width: none;"
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

		<main class="max-3xl:py-8 relative flex w-full flex-col gap-y-6">
			<div class="absolute -top-10 right-0 left-0 hidden *:mx-auto sm:block">
				<ToggleTabs.Root>
					<ToggleTabs.Item class="button-text px-10 py-5">ONGOING MATCHES</ToggleTabs.Item>
					<ToggleTabs.Item class="button-text px-10 py-5">UPCOMING MATCHES</ToggleTabs.Item>
				</ToggleTabs.Root>
			</div>

			<ScheduleMatch />
			<ScheduleMatchMobile />
			<ScheduleMatch />
			<ScheduleMatchMobile />
			<ScheduleMatch />
			<ScheduleMatchMobile />
		</main>
	</article>
</div>
