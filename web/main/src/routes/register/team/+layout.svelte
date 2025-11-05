<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/state';
	import chevronLeftImg from '$lib/assets/icons/chevron-left.svg';
	let { children } = $props();
</script>

<main class="flex flex-col px-32 py-24 2xl:px-40 2xl:py-32">
	<button
		onclick={() => {
			if (page.url.pathname == '/register/team') {
				goto('/register');
			} else if (page.url.pathname == '/register/team/add') {
				goto('/register/team' + page.url.search.split('edit')[0]);
			}
		}}
		class="button-text flex w-fit gap-x-4 hover:cursor-pointer"
	>
		<img src={chevronLeftImg} alt="back" />
		BACK</button
	>
	{@render children?.()}
</main>
