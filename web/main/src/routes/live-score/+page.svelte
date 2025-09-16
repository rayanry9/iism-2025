<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import LiveMatchMain from '$lib/ui/live-score/LiveMatchMain.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-col gap-x-24 overflow-x-clip text-nowrap xl:h-[calc(100vh-4rem)] xl:flex-row *:[main]:px-12 *:[main]:py-16 xl:*:[main]:py-24 xl:*:[main]:pr-28 xl:*:[main]:pl-0"
>
	<MobileHeaderFrame>
		<h2>LIVE MATCHES</h2>
	</MobileHeaderFrame>
	<SportsAsideBar
		bind:selectedSport
		buttonText={'ALL MATCHES'}
		bottomText={'Select a Sport<br/>to view live<br/>matches'}
	/>

	<LiveMatchMain />
</div>
