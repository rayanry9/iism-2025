<script lang="ts">
	import type { Snippet } from 'svelte';
	import type { ClassValue } from 'svelte/elements';

	let { children, class: className }: { children: Snippet; class?: ClassValue } = $props();
</script>

<div class="relative w-full 2xl:hidden {className}">
	<div
		class="bg-custom-dark-blue z-20 px-6 py-10 text-white"
		style="clip-path: polygon(0% 0%, 100% 0%, 100% 85%, 0% 100%); "
	>
		{@render children()}
	</div>
	<div
		style="clip-path: polygon(0% 0%, 100% 0%, 100% 92%, 0% 80%); "
		class="bg-custom-dark-yellow absolute top-0 left-0 -z-10 h-full w-full"
	></div>
	<div
		style="clip-path: polygon(0% 0%, 100% 0%, 100% 100%, 0% 60%); "
		class="bg-custom-yellow absolute top-0 left-0 -z-20 h-full w-full"
	></div>
</div>
