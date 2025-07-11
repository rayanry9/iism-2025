<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';

	let { iit }: { iit: IITNames } = $props();
</script>

<div
	class="border-custom-gray 3xl:px-20 3xl:py-16 min-w-max -skew-x-12 border px-8 py-6 xl:px-16 xl:py-12"
>
	<div class="w-fit skew-x-12">
		<img
			src={getIITImgSrc(iit)}
			class="3xl:size-32 size-16 w-fit xl:size-28"
			alt={'IIT ' + iit + ' logo'}
		/>
	</div>
</div>
