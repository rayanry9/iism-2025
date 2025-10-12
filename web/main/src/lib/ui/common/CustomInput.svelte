<script lang="ts">
	import type { Snippet } from 'svelte';
	import type { ClassValue, HTMLInputAttributes } from 'svelte/elements';

	let {
		children,
		class: className,
		...rest
	}: { children: Snippet; class?: ClassValue } & HTMLInputAttributes = $props();
</script>

<label class="button-text flex flex-col gap-y-1 {className}">
	{@render children()}
	<input
		{...rest}
		class="bg-custom-light-gray border-custom-gray focus:ring-custom-orange border px-5 py-2 font-normal focus:ring-2 focus:outline-none"
	/>
</label>
