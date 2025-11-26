<script lang="ts">
	import FlairedTitle from '$lib/ui/components/FlairedTitle.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';
	import cameraIcon from '$lib/assets/icons/camera.svg'
	import { PUBLIC_API_URL  } from '$env/static/public';
	let activePage = $state<number >(1);
	let totalImages = $state<number>(0);
	let numberOfPages = $state<number>(3);	
	
	$effect(() => {
		fetch(`${PUBLIC_API_URL}/get-gallery-count`)
			.then(res => res.json())
			.then(data => {
				totalImages = parseInt(data.count, 10);
				numberOfPages = Math.ceil(totalImages / 5);
			})
			.catch(err => {
				console.error(" Error fetching image count:", err);
				numberOfPages = 1;
			});
	});

</script>

<main class="flex h-screen w-screen flex-col items-center ">
	<div class="flex flex-row h-[10rem]  w-[95%] items-center justify-between">
		<div class ="flex flex-row gap-[3rem] items-center">
			<span class="text-4xl font-semibold">GALLERY</span>
			<div class="flex flex-row gap-[0.5rem] items-center">
				<Button
					onclick={() => {
						// activeSport = sport;
						if(activePage != 1)
						activePage = activePage-1;
					}}
					class={`border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<img src={arrowLeft} class="mx-auto my-auto h-4" alt="left arrow" />
				</Button>
				<div
					class={`-skew-x-12 border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<span class=" text-xl skew-x-12">{activePage}/{totalImages}</span>
					<!-- <img src={getSportImageSrc(sport)} class="mx-auto my-auto h-8" alt="sport" /> -->
				</div>
				<Button
					onclick={() => {
						// activeSport = sport;
						if(activePage != numberOfPages)
						activePage = activePage+1;

					}}
					class={`border-custom-light-blue flex size-11 flex-col items-center justify-center rounded-sm border-1 p-1.5 'bg-custom-white'`}
				>
					<img src={arrowLeft} class="mx-auto my-auto h-4 rotate-180" alt="left arrow" />

				</Button>
			</div>
		</div>
		<div class = "w-[14rem] h-[3rem]  -skew-x-12 flex flex-row items-center gap-[1rem] bg-custom-orange justify-center p-[0.5rem]">
			<img src={cameraIcon} alt="camera icon" class="w-[2rem] skew-x-12"/>
			<span class="text-white skew-x-12">GET YOUR PHOTOS</span>
		</div>
	</div>
	<div>
		MAIN
	</div>

</main>
