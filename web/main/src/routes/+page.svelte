<script lang="ts">
	import { goto } from '$app/navigation';
</script>

<svelte:head>
	<title>58th Inter IIT Spors Meet 2025</title>
	<meta
		name="description"
		content="Official page for 58th Inter IIT Sports Meet 2025 hosted by IIT Hyderabad in join collaboration with IIT Madras and IIT Tirupati."
	/>
</svelte:head>

<section class="text-background relative overflow-x-clip">
	<div class="relative px-4">
		<!-- Main image -->
		<img
			src="image-5.webp"
			alt="Official Website"
			class="my-4 h-[calc(100vh-4rem)] w-full rounded-xl object-cover object-[30%_50%] sm:h-[calc(100vh-3rem)] sm:object-center xl:h-auto"
		/>

		<!-- Logo + Text container positioned on top of the image -->
		<div
			class="absolute left-0 top-0 flex -skew-x-[20deg] items-center space-x-3 rounded-br-2xl bg-white pb-2 pl-8 pr-8 pt-2"
		>
			<div
				class="absolute -right-[26px] top-0 size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="absolute -bottom-4 left-7 size-4 skew-x-[20deg] bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>
			<img src="/logo.png" alt="Logo" class="h-10 w-10 skew-x-[20deg]" />
			<div class="skew-x-[20deg] text-xs font-semibold leading-tight text-gray-800">
				58TH<br />
				INTER IIT<br />
				SPORTS MEET<br />
				2025
			</div>
		</div>

		<!-- Right side: Navigation menu -->
		<nav class="right-15 absolute top-6 flex space-x-10 text-sm font-medium text-white">
			<a href="#schedule" class="cursor-pointer hover:underline">SCHEDULE</a>
			<a href="#teams" class="cursor-pointer hover:underline">TEAMS AND PLAYERS</a>
			<a href="#live-score" class="cursor-pointer hover:underline">LIVE SOCRE</a>
			<a href="#results" class="cursor-pointer hover:underline">RESULTS</a>
			<a href="#gallery" class="cursor-pointer hover:underline">GALLERY</a>
			<a href="#contact" class="cursor-pointer hover:underline">CONTACT</a>
		</nav>

		<div
			class="absolute left-12 top-1/2 flex max-w-xs -translate-y-1/2 flex-col gap-4 rounded-md p-4 text-white"
		>
			<!-- IITH logo -->
			<div class="flex justify-start">
				<img src="/iith-logo-full.png" alt="IITH Logo" class="h-10 sm:h-12" />
			</div>

			<!-- Event Title -->
			<div class="text-xs font-semibold leading-tight sm:text-5xl">
				<p>58TH</p>
				<p>INTER IIT</p>
				<p>SPORTS MEET</p>
				<p>2025</p>
			</div>

			<!-- IIT HYDERABAD location -->
			<div
				class="inline-flex w-fit items-center gap-2 rounded-full border border-[#707070] bg-black/30 px-4 py-1 text-xs font-normal sm:text-sm"
			>
				<img src="/pin.svg" alt="pin" class="h-3 w-3" />
				IIT HYDERABAD
			</div>

			<!-- Dates -->
			<div
				class="inline-flex w-fit items-center gap-2 border border-[#707070] bg-black/30 px-4 py-1 text-xs font-normal sm:text-sm"
			>
				10th to 17th December 2025
			</div>
		</div>

		<div
			class="absolute -bottom-[0.2px] -right-8 flex w-fit -skew-x-[20deg] flex-col gap-3 rounded-tl-2xl bg-white pb-4 pl-16 pr-24 pt-4 text-white"
		>
			<div
				class="absolute -top-4 right-[6rem] size-4 skew-x-[20deg] bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="absolute -bottom-[0.2px] -left-[0.98rem] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div class="flex skew-x-[20deg] flex-col gap-3 pl-10 text-black">
				<!-- Top Row: Circle + Heading -->
				<div class="flex items-center gap-2">
					<div class="h-3 w-3 rounded-full bg-orange-500"></div>
					<p class="text-lg font-medium text-orange-500">What's happening?</p>
					<div class="flex items-center gap-1">
						<img src="basketball.svg" alt="event 1" class="h-3 w-3 rounded-full" />
						<img src="football.svg" alt="event 2" class="h-3 w-3 rounded-full" />
						<img src="hockey.svg" alt="event 3" class="h-3 w-3 rounded-full" />
						<img src="badminton.svg" alt="event 4" class="h-3 w-3 rounded-full" />
					</div>
				</div>

				<!-- Title -->
				<p class="text-3xl font-semibold leading-snug">5-DAY SPORTS SUMMER CAMP</p>

				<!-- Two lines of text -->
				<div class="text-sm leading-relaxed">
					<p>Open to school and college students in Hyderabad.</p>
					<p>Train at IIT Hyderabad this summer with expert coaches and top facilites.</p>
				</div>

				<!-- Buttons -->
				<div class="mt-4 flex -skew-x-[20deg] gap-4">
					<!-- Skewed Button -->
					<button
						onclick={() => goto('/register')}
						class="rounded bg-orange-500 px-6 py-2 text-lg font-semibold text-white transition hover:bg-orange-600"
					>
						<p class="skew-x-[20deg]">KNOW MORE & REGISTER</p>
					</button>

					<!-- Skewed Date Box -->
					<div
						class="rounded border border-black/50 bg-white px-6 py-2 text-lg font-semibold text-black"
					>
						<p class="skew-x-[20deg]">DATES – 6–11 JULY 2025</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
