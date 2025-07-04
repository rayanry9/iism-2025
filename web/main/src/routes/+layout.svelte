<script lang="ts">
	import SocialButtons from '$lib/ui/common/SocialButtons.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import iithLogoFull from '$lib/assets/iith-logo-full.png';
	import footerLogo from '$lib/assets/footer-logo.webp';
	import '../app.css';

	let { children } = $props();
</script>

{@render children()}

<footer class="flex flex-col items-center bg-black py-4 text-white">
	<div class="3xl:grid-cols-3 grid w-full auto-rows-auto grid-cols-1 px-64 pt-12 pb-20">
		<div class="col-span-1 row-span-3 grid grid-rows-subgrid">
			<div class="">
				<img class="h-12" src={iithLogoFull} alt="iith logo" />
			</div>
			<div class="mt-12 mb-24">
				<img src={footerLogo} class="h-28" alt="IISM Logo" />
			</div>
			<div>
				<Button class="bg-custom-blue my-auto border border-white px-8 py-3 text-white"
					>SWITCH TO IISSM 25</Button
				>
			</div>
		</div>
		<div class="col-span-1 row-span-3 grid grid-rows-subgrid">
			<div class="my-auto"><p>QUICK LINKS</p></div>
			<div class="mt-12 grid h-fit w-fit grid-cols-2 gap-x-20 gap-y-6">
				<a href="/" class="tags-text">HOME</a>
				<a href="/result" class="tags-text">RESULTS</a>
				<a href="/schedule" class="tags-text">SCHEDULE</a>
				<a href="/gallery" class="tags-text">GALLERY</a>
				<a href="/teams" class="tags-text">TEAMS & PLAYERS</a>
				<a href="/contact" class="tags-text">CONTACT</a>
				<a href="/live-scores" class="tags-text">LIVE SCORES</a>
			</div>
			<div>
				<SocialButtons />
			</div>
		</div>
		<div class="col-span-1 row-span-3 grid grid-rows-subgrid">
			<div class="my-auto"><p>REACH US</p></div>
			<div class="row-span-2 mt-12">
				<div class="grid auto-cols-auto gap-x-12 gap-y-3">
					<div class="col-span-2 grid grid-cols-subgrid">
						<p>Get in touch -</p>
						<p>SNCC Sports Complex, IIT Hyderabad, Kandi, 522084</p>
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

	<p class="w-fit text-white opacity-40">
		© Official Website of INTER IIT Sports Meet 2026 Copyright © 2026, IIT Hyderabad, All rights
		reserved
	</p>
</footer>
