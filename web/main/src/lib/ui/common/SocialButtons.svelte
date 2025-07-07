<script lang="ts">
	import Button from '../components/Button.svelte';
	import igIcon from '$lib/assets/icons/instagram.svg';
	import type { ClassValue } from 'svelte/elements';

	let { class: className }: { class?: ClassValue } = $props();
</script>

<div
	class={`3xl:gap-x-5 flex flex-row gap-x-3 *:p-3 lg:*:p-3.5 xl:gap-x-4 2xl:*:p-4 **:[img]:size-5 xl:**:[img]:size-[1.5rem] 2xl:**:[img]:size-8 ${className}`}
>
	<Button class="bg-custom-orange">
		<img src={igIcon} class="" alt="Instagram Social" />
	</Button>

	<Button class="bg-custom-orange">
		<img src={igIcon} class="" alt="Instagram Social" />
	</Button>

	<Button class="bg-custom-orange">
		<img src={igIcon} class="" alt="Instagram Social" />
	</Button>

	<Button class="bg-custom-orange">
		<img src={igIcon} class="" alt="Instagram Social" />
	</Button>
</div>
