<script lang="ts">
	import Button from '../components/Button.svelte';

	let {
		playerName,
		photoUrl,
		subText,
		onRemove
	}: { playerName: string; photoUrl: string; subText: string; onRemove: () => void } = $props();
</script>

<div class="border-custom-gray flex flex-col rounded-xl border p-5">
	<img
		src={photoUrl}
		class="mb-5 aspect-square w-[15rem] object-cover object-top"
		alt="player pic"
	/>
	<div class="title-text mb-2 w-[15rem] text-wrap wrap-break-word">{playerName}</div>
	<p class="text-custom-orange mb-4 w-[15rem] wrap-break-word">{subText}</p>
	<Button
		onclick={onRemove}
		class="text-custom-teal border-custom-teal mt-auto w-fit rounded-sm border bg-white p-6 leading-0 transition-all"
		>REMOVE</Button
	>
</div>
