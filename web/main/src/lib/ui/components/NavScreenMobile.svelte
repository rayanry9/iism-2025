<script lang="ts">
	import type { ClassValue } from 'svelte/elements';
	import logoWithTextWhite from '$lib/assets/logo-text-white.webp';
	import SocialButtons from '$lib/ui/common/SocialButtons.svelte';
	import { page } from '$app/state';

	let showMenu = $state<boolean>(false);

	let { class: className }: { class?: ClassValue } = $props();
</script>

<!-- Menu button -->
<button
	onclick={() => {
		showMenu = !showMenu;
	}}
	class={` text-3xl italic focus:outline-none ${className}`}
	aria-label="Toggle menu"
>
	☰
</button>

<!-- Full-screen menu content -->
{#if showMenu}
	<div class="bg-custom-blue fixed top-0 left-0 z-[1000] h-screen w-screen">
		<!-- Close Button (X mark) -->
		<div class="flex flex-row justify-between p-4">
			<img src={logoWithTextWhite} class="h-10" alt="IISM Logo" />
			<button
				onclick={() => {
					showMenu = !showMenu;
				}}
				class="text-5xl font-bold text-white"
				aria-label="Close menu"
			>
				×
			</button>
		</div>

		<div class="button-text flex flex-col space-y-4 pt-10 text-white *:box-border *:py-2 *:pl-12">
			<!-- Regular Menu Items -->
			<a
				class={`${page.url.pathname == '/' ? 'text-custom-yellow border-l-custom-yellow border-l-4' : ''}`}
				href="/"
			>
				HOME
			</a>

			<a
				class={`${page.url.pathname == '/schedule' ? 'text-custom-yellow border-l-custom-yellow' : 'border-transparent'}  border-l-4`}
				href="/schedule">SCHEDULE</a
			>
			<a
				class={`${page.url.pathname == '/teams' ? 'text-custom-yellow border-l-custom-yellow ' : 'border-transparent'} border-l-4`}
				href="/teams">TEAMS AND PLAYERS</a
			>
			<a
				class={`${page.url.pathname == '/live-score' ? 'text-custom-yellow border-l-custom-yellow ' : 'border-transparent'} border-l-4`}
				href="/live-score">LIVE SCORE</a
			>
			<a
				class={`${page.url.pathname == '/results' ? 'text-custom-yellow border-l-custom-yellow ' : 'border-transparent'} border-l-4`}
				href="/results">RESULTS</a
			>
			<a
				class={`${page.url.pathname == '/gallery' ? 'text-custom-yellow border-l-custom-yellow ' : 'border-transparent'} border-l-4`}
				href="/gallery">GALLERY</a
			>
			<a
				class={`${page.url.pathname == '/contact' ? 'text-custom-yellow border-l-custom-yellow ' : 'border-transparent'} border-l-4`}
				href="/contact">CONTACT</a
			>
			<SocialButtons class={'mt-12'} />
		</div>
	</div>
{/if}
