<script lang="ts">
	import { getContext } from 'svelte';
	import type { HTMLButtonAttributes } from 'svelte/elements';

	let { children, class: className, onclick, ...rest }: HTMLButtonAttributes = $props();
	let updateIndex: (index: number) => void = getContext('updateIndex');
	let buttonElem: HTMLButtonElement;
</script>

<button
	class={'button-text 3xl:px-10 3xl:py-6 z-[1] px-5 py-3 transition-colors hover:cursor-pointer xl:px-8 xl:py-4 ' +
		className}
	bind:this={buttonElem}
	onclick={(ev) => {
		updateIndex(parseInt(buttonElem.dataset.index ?? '0'));
		onclick?.(ev);
	}}
	{...rest}
>
	{@render children?.()}
</button>
