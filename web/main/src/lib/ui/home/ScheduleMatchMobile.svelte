<script>
	import IitFig from '../components/IitFig.svelte';
</script>

<div
	class="border-custom-teal-light 3xl:hidden 3xl:rounded-2xl flex flex-col items-center rounded-lg border *:px-6"
>
	<div
		class="border-b-custom-teal-light bg-custom-light-gray flex w-full flex-col items-center border-b"
	>
		<div
			class="button-text bg-custom-pastel-blue border-custom-teal-light w-fit border px-8 py-1.5"
		>
			FOOTBALL
		</div>

		<div class="flex w-full flex-row py-2">
			<div class=" flex flex-col">
				<p class="text-custom-orange">Started at</p>
				<h2>12:10 PM</h2>
			</div>

			<div class="tags-text ml-auto flex items-center gap-x-2 *:rounded-full">
				<div class="border-custom-gray h-fit w-fit border bg-white px-4 py-2">Open Ground</div>
				<div class="bg-custom-orange size-10"></div>
			</div>
		</div>
	</div>

	<div class="flex w-full flex-row items-center py-4">
		<IitFig iit={'Madras'} />
		<div class="button-text border-custom-teal-light mx-auto -skew-x-12 border px-2.5 py-1.5">
			<div class="skew-x-12">VS</div>
		</div>
		<IitFig iit={'Guwahati'} />
	</div>
</div>
