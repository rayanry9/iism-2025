<script lang="ts">
	import SocialButtons from '$lib/ui/common/SocialButtons.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import iithLogoFull from '$lib/assets/iith-logo-full.png';
	import footerLogo from '$lib/assets/footer-logo.webp';
	import arrowUpRight from '$lib/assets/icons/diag-up-right-arrow.svg';
	import Navbar from '$lib/ui/common/Navbar.svelte';
	import { globals } from '$lib/state.svelte';

	let { children } = $props();
</script>

<Navbar />

{@render children()}

<footer class="bg-custom-dark-blue flex flex-col items-center py-4 text-white">
	<div
		class="3xl:px-56 grid w-full auto-rows-auto grid-cols-1 gap-y-20 px-8 pt-12 pb-20 md:px-16 lg:grid-cols-2 lg:px-24 lg:last:col-span-2 xl:px-32 2xl:grid-cols-3 2xl:gap-y-0 2xl:px-44"
	>
		<div class="grid grid-cols-1 2xl:col-span-1 2xl:row-span-3 2xl:grid-rows-subgrid">
			<div class="">
				<img class="h-10 2xl:h-12" src={iithLogoFull} alt="iith logo" />
			</div>
			<div class="mt-8 mb-8 2xl:mt-12 2xl:mb-24">
				<img src={footerLogo} class="h-28" alt="IISM Logo" />
			</div>
			<div>
				<Button
					data-umami-event="switch-to-iissm"
					class="bg-custom-blue my-auto border border-white px-6 py-3 text-white 2xl:px-8"
					onclick={() => {
						globals.staff = !globals.staff;
						localStorage.setItem('staff', globals.staff.toString());
						setTimeout(() => {
							scrollTo({ behavior: 'smooth', top: 0 });
						}, 500);
					}}
				>
					<div class="flex gap-x-4">
						SWITCH TO {globals.staff ? 'IISM' : 'IISSM'} 25
						<img src={arrowUpRight} alt="Diagonal Upper Right Arrow" />
					</div>
				</Button>
			</div>
		</div>
		<div class="grid grid-cols-1 2xl:col-span-1 2xl:row-span-3 2xl:grid-rows-subgrid">
			<div class="my-auto"><p>QUICK LINKS</p></div>
			<div class="mt-12 mb-12 grid h-fit w-fit grid-cols-2 gap-x-20 gap-y-6 2xl:mb-0">
				<a href="/" class="tags-text">HOME</a>
				<a href="/results" class="tags-text">RESULTS</a>
				<a href="/schedule" class="tags-text">SCHEDULE</a>
				<a href="/gallery" class="tags-text">GALLERY</a>
				<a href="/teams" class="tags-text">TEAMS & PLAYERS</a>
				<a href="/contact" class="tags-text">CONTACT</a>
				<a href="/live-score" class="tags-text">LIVE SCORES</a>
				<a href="/privacy-policy" class="tags-text">PRIVACY POLICY</a>
			</div>
			<div>
				<SocialButtons />
			</div>
		</div>
		<div class="grid grid-cols-1 2xl:col-span-1 2xl:row-span-3 2xl:grid-rows-subgrid">
			<div class="my-auto"><p>REACH US</p></div>
			<div class="row-span-2 mt-12">
				<div class="grid auto-cols-auto gap-x-12 gap-y-3">
					<div class="col-span-2 grid grid-cols-subgrid">
						<p>Get in touch -</p>
						<p>SNCC Sports Complex, IIT Hyderabad, Kandi, 522085</p>
					</div>
					<div class="col-span-2 grid grid-cols-subgrid">
						<p>Call -</p>
						<p>Nikhil Deshmukh - +91 7499816792<br />Sai kumar - +91 7396641098</p>
					</div>
					<div class="col-span-2 grid grid-cols-subgrid">
						<p>Hospitality &<br />Operation -</p>
						<p>
							Gayatri Priya - +91 6305430598<br />Utkarsh - +91 8052492889<br />Nihar - +91
							7670981506
						</p>
					</div>
					<div class="col-span-2 grid grid-cols-subgrid">
						<p>Mail -</p>
						<p>interiit.oc@iith.ac.in</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<p class="w-fit px-6 text-center text-white opacity-40 2xl:px-0">
		© Official Website of INTER IIT Sports Meet 2025 Copyright © 2025, IIT Hyderabad, All rights
		reserved
	</p>
</footer>
