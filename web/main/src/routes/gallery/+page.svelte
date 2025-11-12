<script>
	import FlairedTitle from '$lib/ui/components/FlairedTitle.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';
</script>

<main class="my-auto flex h-screen w-screen flex-col items-center justify-center">
	<FlairedTitle>In Progress</FlairedTitle>
	{#if false}
		<div class="flex h-[10rem] w-[95%] flex-row items-center justify-between border-2 border-black">
			<div class="flex flex-row items-center gap-[3rem]">
				<span class="text-4xl font-semibold">GALLERY</span>
				<div class="flex flex-row items-center gap-[0.5rem]">
					<Button
						onclick={() => {
							// activeSport = sport;
						}}
						class={`border-custom-light-blue 'bg-custom-white' flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5`}
					>
						<img src={arrowLeft} class="mx-auto my-auto h-4" alt="left arrow" />
					</Button>
					<div
						class={`border-custom-light-blue 'bg-custom-white' flex size-11 -skew-x-12 flex-col items-center justify-center rounded-sm border-1 p-1.5`}
					>
						<span class=" skew-x-12 text-xl">1/3</span>
						<!-- <img src={getSportImageSrc(sport)} class="mx-auto my-auto h-8" alt="sport" /> -->
					</div>
					<Button
						onclick={() => {
							// activeSport = sport;
						}}
						class={`border-custom-light-blue 'bg-custom-white' flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5`}
					>
						<img src={arrowLeft} class="mx-auto my-auto h-4 rotate-180" alt="left arrow" />
					</Button>
				</div>
			</div>
			<div class="w-[10rem]">
				<span>GET YOUR PHOTOS</span>
			</div>
		</div>
		<div>MAIN</div>
	{/if}
</main>
