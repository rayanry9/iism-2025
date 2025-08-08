<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import SportsAsideBar from '$lib/ui/common/SportsAsideBar.svelte';
	import LiveMatchMain from '$lib/ui/live-score/LiveMatchMain.svelte';

	let selectedSport = $state<Sports | undefined>();
</script>

<div
	class="relative flex flex-row gap-x-24 overflow-x-clip text-nowrap *:[main]:mt-24 *:[main]:mr-28"
>
	<SportsAsideBar
		{selectedSport}
		buttonText={'ALL MATCHES'}
		bottomText={'Select a Sport<br/>to view live<br/>matches'}
	/>

	<LiveMatchMain />
</div>
