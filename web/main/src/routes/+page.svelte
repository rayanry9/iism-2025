<script lang="ts">
</script>

<svelte:head>
	<title>58th Inter IIT Sports Meet 2025</title>
	<meta
		name="description"
		content="Official page for 58th Inter IIT Sports Meet 2025 hosted by IIT Hyderabad in joint collaboration with IIT Madras and IIT Tirupati."
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
			class="absolute top-0 left-0 flex -skew-x-15 items-center space-x-3 rounded-br-2xl bg-white pt-4 pr-8 pb-4 pl-8"
		>
			<div
				class="absolute top-0 -right-[26px] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="absolute -bottom-4 left-7 size-4 skew-x-15 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<img src="/logo.png" alt="Logo" class=" size-20 skew-x-15" />
			<div class="skew-x-15 text-sm leading-tight font-semibold text-gray-800">
				58TH<br />
				INTER IIT<br />
				SPORTS MEET<br />
				2025
			</div>
		</div>

		<!-- Right side: Navigation menu -->
		<nav class="absolute top-10 right-15 flex space-x-10 font-semibold text-white">
			<a href="#schedule" class="cursor-pointer hover:underline">SCHEDULE</a>
			<a href="#teams" class="cursor-pointer hover:underline">TEAMS AND PLAYERS</a>
			<a href="#live-score" class="cursor-pointer hover:underline">LIVE SCORE</a>
			<a href="#results" class="cursor-pointer hover:underline">RESULTS</a>
			<a href="#gallery" class="cursor-pointer hover:underline">GALLERY</a>
			<a href="#contact" class="cursor-pointer hover:underline">CONTACT</a>
		</nav>

		<div
			class="absolute top-1/2 left-24 flex max-w-xs -translate-y-1/2 flex-col gap-4 rounded-md p-4 text-white"
		>
			<!-- IITH logo -->
			<div class="flex justify-start">
				<img src="/iith-logo-full.png" alt="IITH Logo" class="mb-6 h-10 sm:h-12" />
			</div>

			<!-- Event Title -->
			<div class="text-xs leading-tight font-semibold text-nowrap italic sm:text-[4rem]">
				<p>58TH</p>
				<p>INTER IIT</p>
				<p>SPORTS MEET</p>
				<p>2025</p>
			</div>

			<!-- IIT HYDERABAD location -->
			<div
				class="inline-flex w-fit items-center gap-2 rounded-full border border-white/80 bg-black/30 px-4 py-1 text-xs font-medium sm:text-xl"
			>
				<img src="/pin.svg" alt="pin" class="h-3 w-3" />
				IIT HYDERABAD
			</div>

			<!-- Dates -->
			<div
				class="bg-custom-blue/60 inline-flex w-fit items-center gap-2 rounded-sm border border-white/80 px-4 py-1 text-xs font-medium sm:text-xl"
			>
				10th to 17th December 2025
			</div>
		</div>

		<div
			class="absolute -right-8 -bottom-[0.2px] flex w-fit -skew-x-15 flex-col gap-3 rounded-tl-2xl bg-white pt-8 pr-20 pb-4 pl-8 text-white"
		>
			<div
				class="absolute -top-[1rem] right-[5.56rem] size-4 skew-x-15 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="absolute -bottom-[0.2px] -left-[0.98rem] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div class="flex skew-x-15 flex-col gap-3 pb-4 pl-12 text-black">
				<!-- Top Row: Circle + Heading -->
				<div class="flex items-center gap-2">
					<div
						class="border-custom-orange/50 flex size-7 animate-pulse flex-row items-center justify-center rounded-full border"
					>
						<div
							class="border-custom-orange flex size-5 animate-pulse flex-row items-center justify-center rounded-full border"
						>
							<div class="bg-custom-orange size-3 rounded-full"></div>
						</div>
					</div>
					<p class="text-custom-orange ml-2 text-xl font-medium">What's happening?</p>
					<div class="flex items-center gap-1">
						<img src="basketball.svg" alt="event 1" class="h-3 w-3 rounded-full" />
						<img src="football.svg" alt="event 2" class="h-3 w-3 rounded-full" />
						<img src="hockey.svg" alt="event 3" class="h-3 w-3 rounded-full" />
						<img src="badminton.svg" alt="event 4" class="h-3 w-3 rounded-full" />
					</div>
				</div>

				<!-- Title -->
				<p class="text-[2.5rem] leading-snug font-semibold">5-DAY SPORTS SUMMER CAMP</p>

				<!-- Two lines of text -->
				<div class="text-xl leading-relaxed">
					<p>Open to school and college students in Hyderabad.</p>
					<p>Train at IIT Hyderabad this summer with expert coaches and top facilites.</p>
				</div>

				<!-- Buttons -->
				<div class="mt-2 flex -skew-x-15 gap-x-8 *:py-3">
					<!-- Skewed Button -->
					<button
						class="bg-custom-orange hover:bg-custom-orange/90 flex flex-row flex-nowrap items-center rounded px-12 text-lg font-bold text-white transition hover:cursor-pointer"
					>
						<a href="/workshop" target="_blank" class="flex flex-nowrap items-center">
							<p class="skew-x-15">KNOW MORE & REGISTER</p>
							<div class="my-auto ml-3 size-4 skew-x-15">
								<img src="diag-up-arrow.svg" alt="Arrow" />
							</div>
						</a>
					</button>

					<!-- Skewed Date Box -->
					<div
						class="flex flex-row items-center rounded border border-black/20 bg-white px-6 text-lg font-semibold text-black"
					>
						<p class="skew-x-15">DATES – 6–11 JULY 2025</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
