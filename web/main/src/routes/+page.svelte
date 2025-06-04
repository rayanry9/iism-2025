<script lang="ts">
    import { goto } from '$app/navigation';
</script>

<svelte:head>
    <title>58TH INTER IIT SPORTS MEET 2025 | IIT Hyderabad</title>
    <meta name="description" content="Official page for 58th Inter IIT Sports Meet 2025 hosted by IIT Hyderabad" />
</svelte:head>

<section class="text-background relative">
	<img
		src="image-5.webp"
		alt="Official Website"
		class="h-[calc(100vh-4rem)] object-cover object-[30%_50%] sm:h-[calc(100vh-3rem)] sm:object-center xl:h-auto"
	/>
	<div
		class="from-foreground to-foreground body-spacing absolute top-0 flex h-full w-full flex-col justify-center gap-y-6 bg-linear-to-b via-transparent py-12 sm:bottom-0 sm:h-auto sm:w-fit sm:bg-linear-to-r sm:via-none sm:to-transparent sm:py-0"
	>
		<div class="hidden flex-row items-center gap-x-6 sm:flex">
			<div class="divide-background/70 flex flex-row items-center divide-x">
				<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-7 pr-3 sm:h-9" />
				<img src="iith-logo.png" alt="IITH Logo" class="h-6 pl-4 sm:h-8" />
			</div>
		</div>

		<div class="flex flex-col gap-y-3">
			<p class="text-4xl leading-snug font-medium sm:text-[3.5rem] sm:leading-[4.5rem]">
				5-Day Sports <br class="hidden sm:block" />Summer Camp

				<span
					class="inline-flex w-fit flex-row gap-x-3 rounded-full border border-[#707070] bg-black/30 px-6 py-2 text-sm font-normal text-nowrap sm:hidden"
				>
					<img src="home/pin.svg" alt="pin" />
					IIT HYDERABAD
				</span>
			</p>
			<div
				class="hidden w-fit flex-row gap-x-3 rounded-full border border-[#707070] bg-black/30 px-6 py-2 text-nowrap sm:flex"
			>
				<img src="home/pin.svg" alt="pin" />
				IIT HYDERABAD
			</div>
		</div>
		<p class="text-base sm:text-xl sm:font-medium">
			Experience Student Life.<br />
			Explore Sports.<br />
			Escape Boring Holidays.
		</p>

		<div class="mt-auto flex flex-col gap-y-4 sm:mt-0">
			<button
				onclick={() => {
					goto('about');
				}}
				class="border-background -skew-x-[15deg] border bg-transparent py-2 text-xl font-medium hover:cursor-pointer"
			>
				<p class="skew-x-[15deg]">KNOW MORE</p>
			</button>
			<button
				onclick={() => {
					goto('register');
				}}
				class="bg-primary -skew-x-[15deg] py-2 text-xl font-medium hover:cursor-pointer"
			>
				<p class="skew-x-[15deg]">REGISTER</p>
			</button>
		</div>
		<div class=" self-center sm:absolute sm:bottom-12">
			<img src="icons/triple-chevron-down.svg" alt="Chevron Down" />
		</div>
	</div>
</section>