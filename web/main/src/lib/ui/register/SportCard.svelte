<script lang="ts">
	import type { Sports } from '$lib/types/sports';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';

	let {
		sport,
		extraText,
		currentCount,
		totalCount,
		maxCount
	}: {
		sport: Sports;
		extraText?: string;
		currentCount: number;
		totalCount: number;
		maxCount: number;
	} = $props();
</script>

<div
	class="border-custom-gray flex min-w-[28rem] flex-col gap-y-6 border bg-white px-12 py-8 transition-all hover:scale-[102%] hover:brightness-[99%]"
>
	<div class="flex gap-x-4">
		<img
			src={getSportImageSrc(sport)}
			hidden={(sport as string) == 'Sports Officer/Coach/PTI/Ground Staff'}
			class="h-10"
			alt={sport}
		/>
		<h2>{sport.toUpperCase()} {extraText?.toUpperCase()}</h2>
	</div>
	<div class="flex flex-col gap-y-4">
		<div
			class="bg-custom-gray h-2 -skew-x-12"
			style="width: calc({Math.floor((totalCount * 100) / maxCount)}%);"
		>
			<div
				class="bg-custom-teal h-full"
				style="width: calc({Math.floor((currentCount * 100) / totalCount)}%);"
			></div>
		</div>

		<div class="button-text">{currentCount}/{totalCount} spots registered</div>
	</div>
</div>
