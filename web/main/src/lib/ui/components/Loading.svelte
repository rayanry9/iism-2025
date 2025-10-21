<script lang="ts">
	let { loading }: { loading: boolean } = $props();
</script>

<div
	hidden={!loading}
	class="fixed top-0 right-0 bottom-0 left-0 z-[10000] h-screen w-screen bg-black/30 hover:cursor-progress"
></div>
