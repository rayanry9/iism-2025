<script lang="ts">
	import { goto } from '$app/navigation';
	import { page } from '$app/state';
	import '../app.css';

	let navMenuOpen = $state(false);
	let { children } = $props();
</script>

{#snippet NavItem(text: string, href: string)}
	<a {href} class="ml-8 {page.url.pathname == '/' + href ? 'text-primary' : 'text-background'}"
		>{text.toUpperCase()}</a
	>
{/snippet}

<nav
	class="bg-foreground text-background sticky top-0 left-0 z-10 flex flex-row items-center py-4 pr-8 pl-8 sm:relative sm:py-0"
>
	<div class="divide-background/50 flex h-full flex-row divide-x">
		<a href="/">
			<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-9 pr-3" />
		</a>

		<a href="https://iith.ac.in">
			<img src="iith-logo.png" alt="IITH Logo" class="h-8 pl-4" />
		</a>
	</div>
	<div class="ml-auto hidden flex-row items-center gap-x-2 sm:flex">
		{@render NavItem('About & Facilities', 'about')}
		{@render NavItem('Gallery', 'gallery')}
		{@render NavItem('team', 'team')}
		<a
			class="bg-primary relative ml-4 flex h-14 -skew-x-12 flex-row items-center px-10"
			href="register"
		>
			<div class="bg-foreground absolute right-1.5 h-full w-1"></div>
			<div class="bg-foreground absolute right-3.5 h-full w-1"></div>
			<p class="skew-x-12">REGISTER</p>
		</a>
	</div>

	<button
		onclick={() => {
			navMenuOpen = !navMenuOpen;
		}}
		class="ml-auto block cursor-pointer sm:hidden"
	>
		{#if !navMenuOpen}
			<img src="icons/menu.svg" alt="menu open" />
		{:else}
			<img src="icons/cross.svg" alt="menu close" />
		{/if}
	</button>
	{#if navMenuOpen}
		<div
			class="bg-foreground text-background *:border-y-background/20 absolute top-[4.25rem] left-0 flex w-full flex-col items-center *:flex *:w-full *:flex-col *:items-center *:border-t *:py-4"
		>
			<a
				onclick={() => {
					navMenuOpen = !navMenuOpen;
				}}
				href="about">ABOUT & FACILITIES</a
			>
			<a
				onclick={() => {
					navMenuOpen = !navMenuOpen;
				}}
				href="gallery">GALLERY</a
			>
			<a
				onclick={() => {
					navMenuOpen = !navMenuOpen;
				}}
				href="team">TEAM</a
			>
			<div class="px-8">
				<button
					onclick={() => {
						goto('register');
						navMenuOpen = !navMenuOpen;
					}}
					class="text-background bg-primary w-full -skew-x-[15deg] py-2 text-lg font-medium hover:cursor-pointer"
				>
					<p class="skew-x-[15deg]">REGISTER NOW</p>
				</button>
			</div>
		</div>
	{/if}
</nav>

{@render children()}

<footer
	class="text-background bg-foreground mt-auto flex flex-col items-center px-6 pt-16 pb-4 sm:px-52 sm:pt-24"
>
	<div class="mb-12 grid w-full grid-cols-1 gap-y-20 sm:mb-20 sm:grid-cols-3 sm:gap-y-0">
		<section class="grid grid-cols-subgrid">
			<div class="row-span-1 mb-8 flex flex-row items-center">
				<div class="divide-background/70 flex flex-row items-center divide-x">
					<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-9 pr-3" />
					<img src="iith-logo.png" alt="IITH Logo" class="h-8 pl-4" />
				</div>
				<p class="ml-6">IIT HYDERABAD</p>
			</div>
			<div class="row-span-1">
				<h3 class="mb-6 text-[2rem] font-medium">
					58th INTER IIT<br />SPORTS MEET <br class="after hidden sm:block" />2025
				</h3>
				<div class="flex flex-row gap-x-4 *:*:skew-x-12 *:-skew-x-12 *:p-2.5">
					<div class="bg-[#D6E8E6]">
						<img src="icons/linkedin.svg" class="size-5" alt="Linkedin" />
					</div>
					<div class="bg-[#D6E8E6]">
						<img src="icons/instagram.svg" class="size-5" alt="Instagram" />
					</div>
				</div>
			</div>
		</section>

		<section class="grid grid-cols-subgrid">
			<h5 class="font mb-8 font-semibold sm:mb-0">QUICK LINKS</h5>
			<div
				class="row-span-1 grid grid-cols-2 flex-col gap-x-4 gap-y-3 *:font-medium sm:flex sm:gap-x-0"
			>
				<a
					class="order-1 w-fit {page.url.pathname == '/home' ? 'text-primary' : 'text-background'}"
					href="/">HOME</a
				>
				<a
					class="order-3 w-fit sm:order-2 {page.url.pathname == '/about'
						? 'text-primary'
						: 'text-background'}"
					href="/about">ABOUT & FACILITIES</a
				>
				<a
					class="order-5 w-fit sm:order-3 {page.url.pathname == '/gallery'
						? 'text-primary'
						: 'text-background'}"
					href="gallery">GALLERY</a
				>
				<a
					class="order-2 w-fit sm:order-4 {page.url.pathname == '/team'
						? 'text-primary'
						: 'text-background'}"
					href="team">TEAM</a
				>
				<a href="register" class="text-primary order-4 w-fit sm:order-5">REGISTER</a>
			</div>
		</section>

		<section class="grid grid-cols-1 sm:grid-cols-subgrid">
			<h5 class="mb-8 font-semibold sm:mb-0">REACH US</h5>
			<div class="grid grid-cols-[0.5fr_1fr] gap-y-4 sm:grid-cols-2 sm:gap-y-0">
				<p>Get in Touch -</p>
				<p>SNCC Sports Complex, IIT Hyderabad, Kandi, 522084</p>
				<p>Call -</p>
				<div class="flex flex-col gap-y-1">
					<p>Pritam (Overall Convenor ) - +91 7602790672</p>
					<p>Health Center - +91 7602790672</p>
					<p>Security Control Office - +91 7602790672</p>
				</div>

				<p>Mail -</p>
				<p>interiit.oc@iith.ac.in</p>
			</div>
		</section>
	</div>
	<p class="opacity-50">© Copyright by Inter IIT Sports Meet 2025</p>
</footer>
