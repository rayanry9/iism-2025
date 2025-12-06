<script lang="ts">
	import { globals } from '$lib/state.svelte';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';

	import downloadIcon from '$lib/assets/icons/download.svg';
	import type { Sports } from '$lib/types/sports';
	import { page } from '$app/state';
	import { goto } from '$app/navigation';

	let { children } = $props();
	let selectedSport = $derived<Sports | undefined>(page.url.searchParams.get('sport') as Sports);
</script>

<div
	class="relative flex flex-col overflow-x-clip text-nowrap xl:h-[calc(100vh-4rem)] xl:flex-row *:[main]:overflow-y-scroll *:[main]:py-12 xl:*:[main]:px-24 2xl:*:[main]:py-24"
>
	<SportsAsideBar
		bind:selectedSport={
			() => selectedSport,
			(val) => {
				if (val != undefined) {
					goto(page.url.pathname + '?sport=' + val);
				} else {
					goto(page.url.pathname);
				}
				selectedSport = val;
			}
		}
		bottomText={page.url.pathname == '/schedule'
			? 'Select a Sport<br/>to see Pools'
			: page.url.pathname == '/results'
				? 'Select a Sport<br/>to see past<br/>Matches<br/>and Results'
				: page.url.pathname == '/live-score'
					? 'Select a Sport<br/>to view live<br/>matches'
					: ''}
		buttonText={page.url.pathname == '/schedule'
			? 'FULL SCHEDULE'
			: page.url.pathname == '/live-score'
				? 'ALL MATCHES'
				: page.url.pathname == '/results'
					? 'LEADERBOARD'
					: ''}
	/>
	<MobileHeaderFrame>
		{#if page.url.pathname == '/schedule'}
			<div class="flex flex-row items-center">
				<h2>FULL SCHEDULE</h2>

				<button
					class="border-custom-light-blue button-text ml-auto w-fit -skew-x-12 self-end rounded-sm border-2 px-4 py-2.5 hover:cursor-pointer hover:brightness-95"
				>
					<a
						href={globals.staff
							? '/30th%20IISSM%20Staff%20Schedule.pdf'
							: '/58th%20IISM%20Student%20Schedule.pdf'}
						target="_blank"
						download
					>
						<div class="flex skew-x-12 items-center gap-x-1.5 leading-none">
							PDF <img src={downloadIcon} alt="download" />
						</div>
					</a>
				</button>
			</div>
		{:else if page.url.pathname == '/results'}
			<div class="flex flex-col gap-y-1">
				<h2>LEADERBOARD</h2>
				<p>Select a Sport to see past Matches and Results</p>
			</div>
		{:else if page.url.pathname == '/live-score'}
			<h2>LIVE MATCHES</h2>
		{/if}
	</MobileHeaderFrame>

	{@render children?.()}
</div>
