<script lang="ts">
	import type { ClassValue, HTMLInputAttributes } from 'svelte/elements';

	let {
		id,
		label,
		class: className,
		...rest
	}: { id: string; label: string; class?: ClassValue } & HTMLInputAttributes = $props();
</script>

<div class="flex flex-col gap-y-3">
	<label class="button-text" for={id}>{label}</label>
	<input
		{id}
		{...rest}
		class="{className} bg-custom-light-gray border-custom-gray button-text border px-4 py-3 leading-0 !font-normal"
	/>
</div>
