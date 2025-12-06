<script>
	import DownloadBanner from '$lib/ui/home/DownloadBanner.svelte';
	import FeaturedEvents from '$lib/ui/home/FeaturedEvents.svelte';
	import Header from '$lib/ui/home/Header.svelte';
	import InfoBanner from '$lib/ui/home/InfoBanner.svelte';
	import ParticipatingIiTs from '$lib/ui/home/ParticipatingIITs.svelte';
	import Schedule from '$lib/ui/home/Schedule.svelte';
	import SportsToPlay from '$lib/ui/home/SportsToPlay.svelte';
	import TopStories from '$lib/ui/home/TopStories.svelte';

	let { data } = $props();
</script>

<svelte:head>
	<title>Inter IIT Sports Meet, IIT Hyderabad, 2025</title>
	<meta
		name="description"
		content="Official page for 58th Inter IIT Sports Meet 2025 hosted by IIT Hyderabad in joint collaboration with IIT Madras and IIT Tirupati."
	/>
</svelte:head>

<Header />
{#if data.topStories.length}
	<TopStories topStories={data.topStories} />
{/if}
<!-- <Schedule /> -->
<InfoBanner />
<FeaturedEvents />
<ParticipatingIiTs />
<SportsToPlay />
<DownloadBanner />
