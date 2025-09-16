<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import LiveMatchMain from '$lib/ui/live-score/LiveMatchMain.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-col gap-x-24 overflow-x-clip text-nowrap 2xl:h-[calc(100vh-4rem)] 2xl:flex-row *:[main]:py-24 *:[main]:pr-28"
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
