<script lang="ts">
	import { getContext } from 'svelte';
	import type { HTMLButtonAttributes } from 'svelte/elements';

	let { children, class: className, onclick, ...rest }: HTMLButtonAttributes = $props();
	let updateIndex: (index: number) => void = getContext('updateIndex');
	let buttonElem: HTMLButtonElement;
</script>

<button
	class={'z-[1] transition-colors hover:cursor-pointer ' + className}
	bind:this={buttonElem}
	onclick={(ev) => {
		updateIndex(parseInt(buttonElem.dataset.index ?? '0'));
		onclick?.(ev);
	}}
	{...rest}
>
	{@render children?.()}
</button>
