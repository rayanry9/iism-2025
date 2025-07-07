<script lang="ts">
	import Button from '../components/Button.svelte';
	import igIcon from '$lib/assets/icons/instagram.svg';
	import fbIcon from '$lib/assets/icons/fb.svg';
	import xIcon from '$lib/assets/icons/x.svg';
	import linkedinIcon from '$lib/assets/icons/linkedin.svg';
	import type { ClassValue } from 'svelte/elements';

	let { class: className }: { class?: ClassValue } = $props();
</script>

<div
	class={`3xl:gap-x-5 flex flex-row gap-x-3 *:p-3 lg:*:p-3.5 xl:gap-x-4 2xl:*:p-4 **:[img]:size-5 xl:**:[img]:size-[1.5rem] 2xl:**:[img]:size-8 ${className}`}
>
	<Button
		onclick={() => {
			window.location.href = 'https://www.instagram.com/interiit_sportsmeet/';
		}}
		class="bg-custom-orange"
	>
		<img src={igIcon} class="" alt="Instagram" />
	</Button>

	<Button
		onclick={() => {
			window.location.href = 'https://www.facebook.com/iithyderabad/';
		}}
		class="bg-custom-orange"
	>
		<img src={fbIcon} class="" alt="Facebook" />
	</Button>

	<Button
		onclick={() => {
			window.location.href = 'https://x.com/IITHyderabad';
		}}
		class="bg-custom-orange"
	>
		<img src={xIcon} class="" alt="Twitter / X" />
	</Button>

	<Button
		onclick={() => {
			window.location.href = 'https://www.linkedin.com/company/inter-iit-sports-meet-2025/';
		}}
		class="bg-custom-orange"
	>
		<img src={linkedinIcon} class="" alt="Linkedin" />
	</Button>
</div>
