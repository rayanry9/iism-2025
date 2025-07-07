<script lang="ts">
	import flairHead from '$lib/assets/title-flair-head.webp';
	import flairTail from '$lib/assets/title-flair-tail.webp';
	let { children } = $props();
</script>

<div class="flex w-full flex-row items-center">
	<div class="flex w-full">
		<div class="grow bg-contain" style="background-image: url({flairTail})"></div>
		<img src={flairHead} class="3xl:h-24 h-14 w-fit" alt="Flair head design" />
	</div>
	<div class="3xl:px-8 px-4"><h2>{@render children?.()}</h2></div>
	<div class="flex w-full">
		<img src={flairHead} class="3xl:h-24 h-14 w-fit rotate-180" alt="Flair head design" />
		<div class="grow bg-contain" style="background-image: url({flairTail})"></div>
	</div>
</div>
