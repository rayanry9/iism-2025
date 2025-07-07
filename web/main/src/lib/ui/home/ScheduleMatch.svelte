<script>
	import IitFig from '../components/IitFig.svelte';
</script>

<div
	class="border-custom-gray 3xl:rounded-2xl 3xl:flex hidden flex-row items-center rounded-lg border px-8"
>
	<IitFig iit={'Hyderabad'} class={'my-auto'} />
	<div class="mx-auto flex flex-col items-center gap-y-3 pb-6">
		<div class="button-text bg-custom-pastel-blue border-custom-teal-light border px-12 py-2">
			FOOTBALL
		</div>
		<div class="flex flex-col items-center">
			<p class="text-custom-orange">Started at</p>
			<h2>12:10 PM</h2>
		</div>

		<div class="tags-text flex gap-x-4 *:rounded-full *:px-6 *:py-2">
			<div class="border-custom-gray border">Open Ground</div>
			<button
				class="bg-custom-orange hover:bg-custom-orange/80 text-white transition-colors hover:cursor-pointer active:brightness-95"
			>
				Watch Online</button
			>
		</div>
	</div>
	<IitFig iit={'Roorkee'} />
</div>
