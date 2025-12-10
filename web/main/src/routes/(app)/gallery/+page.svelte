<script lang="ts">
	import FlairedTitle from '$lib/ui/components/FlairedTitle.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import arrowLeft from '$lib/assets/icons/arrow-left.svg';
	import cameraIcon from '$lib/assets/icons/camera.svg';
	import { PUBLIC_API_URL } from '$env/static/public';

	let activePage = $state<number>(1);
	let totalImages = $state<number>(0);
	let numberOfPages = $state<number>(1);
	let images = $state<string[]>([]);
	let isMobile = $state<boolean>(false);

	// ✅ Fetch total image count
	$effect(() => {
		fetch(`${PUBLIC_API_URL}/get-gallery-count`)
			.then((res) => res.json())
			.then((data) => {
				totalImages = parseInt(data.count, 10) || 0;

				// ✅ If there are NO images, force 0/0 state
				if (totalImages === 0) {
					numberOfPages = 0;
					activePage = 0;
					images = [];
				}
			})
			.catch((err) => {
				console.error('Error fetching image count:', err);
				totalImages = 0;
				numberOfPages = 0;
				activePage = 0;
				images = [];
			});
	});


	// ✅ Fetch paginated images (mobile = 4, desktop = 8)
	$effect(() => {
		// ✅ If no images exist, do NOT call gallery API
		if (totalImages === 0) return;

		const perPage = isMobile ? 4 : 8;

		numberOfPages = Math.ceil(totalImages / perPage);

		// ✅ If activePage was 0 (from empty state), reset to 1 safely
		if (activePage === 0) {
			activePage = 1;
			return;
		}

		// ✅ Prevent overflow
		if (activePage > numberOfPages) {
			activePage = numberOfPages;
			return;
		}

		fetch(`${PUBLIC_API_URL}/get-gallery?page=${activePage}&limit=${perPage}`)
			.then((res) => res.json())
			.then((data) => {
				images = data.images ?? [];
			})
			.catch((err) => {
				console.error('Error fetching gallery images:', err);
				images = [];
			});
	});

</script>


{#if true}
	<main class="flex w-full flex-col items-center">

		<!-- ================= MOBILE HEADER ================= -->
		<div class="w-full flex flex-col items-center gap-4 py-4 md:hidden">
			<h1 class="text-2xl font-semibold">GALLERY</h1>

			<div class="bg-custom-orange flex h-[42px] w-[170px] items-center justify-center gap-2">
				<img src={cameraIcon} class="h-5 w-5" alt="" />
				<span class="text-white text-sm">GET YOUR PHOTOS</span>
			</div>
		</div>

		<!-- ================= MOBILE IMAGES ================= -->
	<div class="w-[92%] grid grid-cols-1 grid-rows-[auto_auto_auto_auto_auto] gap-6 md:hidden">

		<!-- Image 1 -->
		{#if images[0]}
			<div class="overflow-hidden">
				<img src={images[0]} class="w-full h-auto object-cover" alt="" />
			</div>
		{/if}

		<!-- Image 2 -->
		{#if images[1]}
			<div class="overflow-hidden">
				<img src={images[1]} class="w-full h-auto object-cover" alt="" />
			</div>
		{/if}

		<!-- Image 3 (DOUBLE HEIGHT ✅) -->
		{#if images[2]}
			<div class="row-span-2 overflow-hidden">
				<img src={images[2]} class="w-full h-full object-cover" alt="" />
			</div>
		{/if}

		<!-- Image 4 -->
		{#if images[3]}
			<div class="overflow-hidden">
				<img src={images[3]} class="w-full h-auto object-cover" alt="" />
			</div>
		{/if}

	</div>


		<!-- ================= MOBILE PAGINATION ================= -->
		<div class="flex items-center gap-4 py-8 md:hidden">
			<Button
				onclick={() => activePage > 1 && activePage--}
				class="border border-custom-light-blue w-10 h-10 flex items-center justify-center"
			>
				<img src={arrowLeft} class="h-4" alt="" />
			</Button>

			<span class="text-lg">{activePage}/{numberOfPages}</span>

			<Button
				onclick={() => activePage < numberOfPages && activePage++}
				class="border border-custom-light-blue w-10 h-10 flex items-center justify-center"
			>
				<img src={arrowLeft} class="h-4 rotate-180" alt="" />
			</Button>
		</div>

		<!-- ================= DESKTOP HEADER ================= -->
		<div class="hidden md:flex h-[10rem] w-[95%] flex-row items-center justify-between">

			<div class="flex flex-row items-center gap-[3rem]">
				<span class="text-4xl font-semibold">GALLERY</span>

				<div class="flex flex-row items-center gap-[0.5rem]">

					<Button
						onclick={() => activePage > 1 && activePage--}
						class="border-custom-light-blue flex size-11 items-center justify-center rounded-sm border-1 p-1.5"
					>
						<img src={arrowLeft} class="h-4" alt="" />
					</Button>

					<div class="border-custom-light-blue flex size-11 -skew-x-12 items-center justify-center rounded-sm border-1 p-1.5">
						<span class="skew-x-12 text-xl">
							{activePage}/{numberOfPages}
						</span>
					</div>

					<Button
						onclick={() => activePage < numberOfPages && activePage++}
						class="border-custom-light-blue flex size-11 items-center justify-center rounded-sm border-1 p-1.5"
					>
						<img src={arrowLeft} class="h-4 rotate-180" alt="" />
					</Button>

				</div>
			</div>

			<div class="bg-custom-orange flex h-[3rem] w-[14rem] -skew-x-12 flex-row items-center justify-center gap-[1rem] p-[0.5rem]">
				<img src={cameraIcon} alt="" class="w-[2rem] skew-x-12" />
				<span class="skew-x-12 text-white">GET YOUR PHOTOS</span>
			</div>

		</div>

		<!-- ================= DESKTOP GRID ================= -->
		<div class="hidden md:grid w-[95%] grid-cols-5 grid-rows-3 gap-6 pb-10">

			{#if images[0]}
				<div class="col-start-1 col-span-2 row-start-1 row-span-2 overflow-hidden">
					<img src={images[0]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[1]}
				<div class="col-start-3 row-start-1 overflow-hidden">
					<img src={images[1]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[2]}
				<div class="col-start-4 row-start-1 overflow-hidden">
					<img src={images[2]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[3]}
				<div class="col-start-5 row-start-1 overflow-hidden">
					<img src={images[3]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[4]}
				<div class="col-start-3 row-start-2 row-span-2 overflow-hidden">
					<img src={images[4]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[5]}
				<div class="col-start-4 col-span-2 row-start-2 row-span-2 overflow-hidden">
					<img src={images[5]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[6]}
				<div class="col-start-1 row-start-3 overflow-hidden">
					<img src={images[6]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

			{#if images[7]}
				<div class="col-start-2 row-start-3 overflow-hidden">
					<img src={images[7]} class="w-full h-full object-cover" alt="" />
				</div>
			{/if}

		</div>

	</main>

{/if}
