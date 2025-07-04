<script lang="ts">
	import { ToggleTabs } from '$lib/ui/components/toggleTabs';
	import '../app.css';

	let { children } = $props();
</script>

{@render children()}

<ToggleTabs.Root>
	<ToggleTabs.Item class="button-text px-10 py-5">ONGOING MATCHES</ToggleTabs.Item>
	<ToggleTabs.Item class="button-text px-10 py-5">UPCOMING MATCHES</ToggleTabs.Item>
</ToggleTabs.Root>

<footer></footer>
