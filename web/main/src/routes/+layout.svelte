<script lang="ts">
	import '../app.css';

	let { children } = $props();
</script>

{@render children()}

<footer class="flex flex-col items-center bg-black py-4">
	<div></div>

	<p class="w-fit text-white opacity-40">
		© Official Website of INTER IIT Sports Meet 2026 Copyright © 2026, IIT Hyderabad, All rights
		reserved
	</p>
</footer>
