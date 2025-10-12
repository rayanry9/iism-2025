<script lang="ts">
	import { page } from '$app/state';
	import logoWithText from '$lib/assets/logo-text.webp';
	import NavScreenMobile from '../components/NavScreenMobile.svelte';
</script>

<nav class="border-b-custom-gray flex flex-row items-center border-b bg-white px-8 py-3">
	<img src={logoWithText} alt="Logo IISM" class="h-10" />
	<div class="button-text ml-auto hidden flex-row items-center gap-x-12 lg:flex">
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
		<a
			class={`${page.url.pathname.includes('/register') ? 'text-custom-orange ' : ''} `}
			href="/register">REGISTER</a
		>
	</div>

	<NavScreenMobile class={`ml-auto h-fit leading-0 text-black lg:hidden`} />
</nav>
