<script lang="ts">
	import Button from '../components/Button.svelte';
	import igIcon from '$lib/assets/icons/instagram.svg';
	import fbIcon from '$lib/assets/icons/fb.svg';
	import ytIcon from '$lib/assets/icons/youtube.webp';
	import linkedinIcon from '$lib/assets/icons/linkedin.svg';

	import type { ClassValue } from 'svelte/elements';

	let { class: className }: { class?: ClassValue } = $props();
</script>

<div
	class={`3xl:gap-x-5 flex flex-row gap-x-3 *:rounded-sm *:p-3 lg:*:p-3.5 xl:gap-x-4 2xl:*:p-4 **:[img]:size-5 xl:**:[img]:size-[1.5rem] 2xl:**:[img]:size-8 ${className}`}
>
	<Button
		onclick={() => {
			window.open('https://www.youtube.com/@interiit_sportsmeet/', '_blank');
		}}
		class="bg-custom-orange"
	>
		<img src={ytIcon} class="!h-4 xl:!h-5 2xl:!h-6" alt="Youtube Icon" />
	</Button>

	<Button
		onclick={() => {
			window.open('https://www.instagram.com/interiit_sportsmeet/', '_blank');
		}}
		class="bg-custom-orange"
		data-umami-event="social-instagram"
	>
		<img src={igIcon} class="" alt="Instagram" />
	</Button>

	<Button
		onclick={() => {
			window.open('https://www.facebook.com/iithyderabad/', '_blank');
		}}
		class="bg-custom-orange"
		data-umami-event="social-facebook"
	>
		<img src={fbIcon} class="" alt="Facebook" />
	</Button>

	<Button
		onclick={() => {
			window.open('https://www.linkedin.com/company/inter-iit-sports-meet-2025/', '_blank');
		}}
		class="bg-custom-orange"
		data-umami-event="social-linkedin"
	>
		<img src={linkedinIcon} class="" alt="Linkedin" />
	</Button>
</div>
