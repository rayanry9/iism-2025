<script>
	import Navbar from '$lib/ui/common/Navbar.svelte';
	let { children } = $props();
</script>

<Navbar />

{@render children()}
