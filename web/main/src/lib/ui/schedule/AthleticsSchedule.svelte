<script lang="ts">
	import type { GetAllAthleticMatchesResponse } from '$lib/types/athleticMatch';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';

	let { athleticMatchData }: { athleticMatchData: Array<GetAllAthleticMatchesResponse> } = $props();
</script>

<main class="w-full max-xl:px-8">
	<h2 class="flex items-center">
		ATHLETICS
		<img class="mb-1.5 ml-3 h-10" src={getSportImageSrc('Athletics')} alt="Athletics icon" />
	</h2>

	<section class="flex h-full w-full items-center justify-center">
		<h2>Currently Unavailable</h2>
	</section>
</main>
