<script lang="ts">
	import { getContext } from 'svelte';
	import type { HTMLButtonAttributes } from 'svelte/elements';

	let { children, class: className, ...rest }: HTMLButtonAttributes = $props();
	let updateIndex: (index: number) => void = getContext('updateIndex');
	let buttonElem: HTMLButtonElement;
</script>

<button
	class={'transition-colors hover:cursor-pointer ' + className}
	bind:this={buttonElem}
	onclick={() => {
		updateIndex(parseInt(buttonElem.dataset.index ?? '0'));
	}}
	{...rest}
>
	{@render children?.()}
</button>
