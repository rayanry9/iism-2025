<script>
	// import FlairedTitle from '$lib/ui/components/FlairedTitle.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';

</script>

<main class="flex h-screen w-screen flex-col items-center ">
	<div class="flex flex-row h-[10rem] border-2 border-black w-[95%] items-center justify-between">
		<div class ="flex flex-row gap-[3rem] items-center">
			<span class="text-4xl font-semibold">GALLERY</span>
			<div class="flex flex-row gap-[0.5rem] items-center">
				<Button
					onclick={() => {
						// activeSport = sport;
					}}
					class={`border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<img src={arrowLeft} class="mx-auto my-auto h-4" alt="left arrow" />
				</Button>
				<div
					class={`-skew-x-12 border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<span class=" text-xl skew-x-12">1/3</span>
					<!-- <img src={getSportImageSrc(sport)} class="mx-auto my-auto h-8" alt="sport" /> -->
				</div>
				<Button
					onclick={() => {
						// activeSport = sport;
					}}
					class={`border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<img src={arrowLeft} class="mx-auto my-auto h-4 rotate-180" alt="left arrow" />

				</Button>
			</div>
		</div>
		<div class = "w-[10rem]">
			<span>GET YOUR PHOTOS</span>
		</div>
	</div>
	<div>
		MAIN
	</div>

</main>
