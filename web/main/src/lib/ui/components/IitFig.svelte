<script lang="ts">
	import type { ClassValue } from 'svelte/elements';
	import type { IITNames } from '$lib/types/iitNames';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	let {
		iit,
		class: className,
		showCaption = true
	}: { iit: IITNames; class?: ClassValue; showCaption?: boolean } = $props();
</script>

<figure class={`3xl:gap-y-4 flex h-fit w-fit flex-col items-center gap-y-2 ${className}`}>
	<img src={getIITImgSrc(iit)} class="3xl:size-24 size-14" alt={'IIT ' + iit + ' logo'} />
	<figcaption hidden={!showCaption} class="button-text">IIT {iit.toUpperCase()}</figcaption>
</figure>
