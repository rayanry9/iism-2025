<script lang="ts">
	import type { HTMLButtonAttributes } from 'svelte/elements';

	let { children, class: className, ...rest }: HTMLButtonAttributes = $props();
</script>

<button
	class={className +
		' button-text -skew-x-12 transition-colors duration-200 hover:scale-103 hover:cursor-pointer active:brightness-90'}
	{...rest}
>
	<div class="skew-x-12">
		{@render children?.()}
	</div>
</button>
