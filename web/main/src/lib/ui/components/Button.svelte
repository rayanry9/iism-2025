<script lang="ts">
	import type { HTMLButtonAttributes } from 'svelte/elements';

	let { children, class: className, ...rest }: HTMLButtonAttributes = $props();
</script>

<button
	class={className + ' button-text -skew-x-12 hover:cursor-pointer active:brightness-90'}
	{...rest}
>
	<div class="skew-x-12">
		{@render children?.()}
	</div>
</button>
