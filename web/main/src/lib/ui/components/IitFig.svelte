<script module>
	export type IITType = 'Madras' | 'Hyderabad' | 'Guwahati' | 'Roorkee';
</script>

<script lang="ts">
	import iitmLogo from '$lib/assets/logos/iitm.webp';
	import iithLogo from '$lib/assets/logos/iith.webp';
	import iitrLogo from '$lib/assets/logos/iitr.webp';
	import iitgLogo from '$lib/assets/logos/iitg.webp';
	import type { ClassValue } from 'svelte/elements';
	let { iit, class: className }: { iit: IITType; class?: ClassValue } = $props();
</script>

<figure class={`3xl:gap-y-4 flex h-fit w-fit flex-col items-center gap-y-2 ${className}`}>
	<img
		src={(() => {
			switch (iit) {
				case 'Hyderabad':
					return iithLogo;
				case 'Madras':
					return iitmLogo;
				case 'Guwahati':
					return iitgLogo;
				case 'Roorkee':
					return iitrLogo;
				default:
					return iithLogo;
			}
		})()}
		class="3xl:size-24 size-14"
		alt={'IIT ' + iit + ' logo'}
	/>
	<figcaption class="button-text">IIT {iit.toUpperCase()}</figcaption>
</figure>
