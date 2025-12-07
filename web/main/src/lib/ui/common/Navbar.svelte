<script lang="ts">
	import { goto, invalidateAll } from '$app/navigation';
	import { page } from '$app/state';
	import { PUBLIC_API_URL } from '$env/static/public';
	import logoWithText from '$lib/assets/logo-text.webp';
	import { globals } from '$lib/state.svelte';
	import StartToastifyInstance from 'toastify-js';
	import NavScreenMobile from '../components/NavScreenMobile.svelte';
	import { fade } from 'svelte/transition';
	let { isLoggedIn }: { isLoggedIn: boolean } = $props();
</script>

<nav class="border-b-custom-gray flex flex-row items-center border-b bg-white px-3 py-3 md:px-8">
	<img src={logoWithText} alt="Logo IISM" class="h-10" />
	{#if globals.staff}
		<button
			class="border-b-custom-gray text-custom-dark-gray button-text ml-2 rounded-full border px-3 py-1 font-bold xl:ml-3 2xl:ml-4 2xl:py-1.5"
			in:fade
			onclick={() => {
				globals.staff = false;
			}}>Switch to Student Meet</button
		>
	{:else}
		<button
			in:fade
			class="border-b-custom-gray text-custom-dark-gray button-text ml-2 rounded-full border px-4 py-1 font-bold xl:ml-3 2xl:ml-4 2xl:py-1.5"
			onclick={() => {
				globals.staff = true;
			}}>Switch to Staff Meet</button
		>
	{/if}
	<div
		class="button-text ml-auto hidden flex-row items-center gap-x-5 *:hover:cursor-pointer lg:flex 2xl:gap-x-12"
	>
		<a class={`${page.url.pathname == '/' ? 'text-custom-orange ' : ''} `} href="/">HOME</a>
		<a class={`${page.url.pathname == '/schedule' ? 'text-custom-orange ' : ''} `} href="/schedule"
			>SCHEDULE</a
		>
		<a class={`${page.url.pathname == '/teams' ? 'text-custom-orange ' : ''} `} href="/teams"
			>TEAMS & PLAYERS</a
		>
		<a
			class={`${page.url.pathname == '/live-score' ? 'text-custom-orange ' : ''} `}
			href="/live-score">LIVE SCORE</a
		>
		<a class={`${page.url.pathname == '/results' ? 'text-custom-orange ' : ''} `} href="/results"
			>RESULTS</a
		>
		<a class={`${page.url.pathname == '/gallery' ? 'text-custom-orange ' : ''} `} href="/gallery"
			>GALLERY</a
		>
		<a class={`${page.url.pathname == '/contact' ? 'text-custom-orange ' : ''} `} href="/contact"
			>CONTACT</a
		>
		{#if isLoggedIn && page.url.pathname.includes('/register')}
			<button
				class={`${page.url.pathname.includes('/register') ? 'text-custom-orange ' : ''} `}
				onclick={() => {
					globals.loading = true;
					fetch(PUBLIC_API_URL + '/logout', { method: 'post', credentials: 'include' }).then(
						(res) => {
							if (res.status == 200) {
								StartToastifyInstance({
									text: 'Successfully logged out',
									position: 'right',
									gravity: 'bottom',
									duration: 2000,
									style: {
										background: 'linear-gradient(90deg, #FF1744, #D50000)'
									},
									close: true
								}).showToast();
								invalidateAll();
								goto('/register/login');
							} else {
								StartToastifyInstance({
									text: 'Failed to logged out',
									position: 'right',
									gravity: 'bottom',
									duration: 2000,
									style: {
										background: 'linear-gradient(90deg, #FF1744, #D50000)'
									},
									close: true
								}).showToast();
							}
						}
					);
				}}
			>
				LOGOUT
			</button>
		{:else}
			<a
				class={`${page.url.pathname.includes('/register') ? 'text-custom-orange ' : ''} `}
				href="/register">REGISTER</a
			>
		{/if}
	</div>

	<NavScreenMobile class={`ml-auto h-fit leading-0 text-black lg:hidden`} />
</nav>
