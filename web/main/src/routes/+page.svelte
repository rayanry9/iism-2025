<script lang="ts">
	let showMenu = false;

	const toggleMenu = () => {
		showMenu = !showMenu;
	};
</script>

<svelte:head>
	<title>Inter IIT Sports Meet 2025 Hyderabad</title>
	<meta
		name="description"
		content="Official page for 58th Inter IIT Sports Meet 2025 hosted by IIT Hyderabad in joint collaboration with IIT Madras and IIT Tirupati."
	/>
</svelte:head>

<header class="relative h-full overflow-x-clip rounded-2xl p-6">
	<div class="relative z-10 h-full">
		<!-- Gradients -->
		<div
			class="absolute z-0 h-1/3 w-full rounded-2xl bg-gradient-to-b from-black/60 to-transparent"
		></div>
		<div
			class="absolute z-0 h-full w-1/2 rounded-2xl bg-gradient-to-r from-black/60 to-transparent"
		></div>

		<!-- Main image -->
		<img
			src="image-5.webp"
			alt="Official Website"
			class="h-full w-full rounded-xl object-cover object-[65%_10%]"
		/>

		<!-- Logo + Text container positioned on top left of the image -->
		<section
			class="absolute -top-[0.3px] -left-4 flex -skew-x-15 items-center gap-x-5 rounded-br-2xl bg-white py-5 pr-7 pl-9"
		>
			<!-- Rounded Corner top right -->
			<div
				class="absolute top-0 -right-4 size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>
			<!-- Rounded Corner bottom left-->
			<div
				class="absolute -bottom-[15px] left-8 size-4 skew-x-15 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<img src="/logo.png" alt="Logo" class="size-[4.5rem] skew-x-15" />

			<div class="skew-x-15 text-sm leading-none font-medium text-gray-800">
				58TH<br />
				INTER IIT<br />
				SPORTS MEET<br />
				2025
			</div>
		</section>

		<!--Nav bar for the layouts other than mobile-->
		<nav class="absolute top-0 right-0 flex justify-end gap-x-12 p-12 font-semibold text-white">
			<a href="#schedule" class="hover:underline">SCHEDULE</a>
			<a href="#teams" class="hover:underline">TEAMS AND PLAYERS</a>
			<a href="#live-score" class="hover:underline">LIVE SCORE</a>
			<a href="#results" class="hover:underline">RESULTS</a>
			<a href="#gallery" class="hover:underline">GALLERY</a>
			<a href="#contact" class="hover:underline">CONTACT</a>
		</nav>

		<!-- Mobile dropdown menu-->
		<nav class="absolute top-0 left-0 z-50 hidden w-full">
			<!-- Menu button at top right -->
			<div class="relative py-4">
				<!-- Increased horizontal padding -->
				<button
					on:click={toggleMenu}
					class="absolute right-10 text-4xl text-white italic focus:outline-none"
					aria-label="Toggle menu"
				>
					☰
				</button>
			</div>

			<!-- Full-screen menu content -->
			{#if showMenu}
				<div class="bg-custom-blue fixed inset-0 z-40 pt-20">
					<!-- Close Button (X mark) -->

					<div class="fixed top-2 left-0 z-40 flex items-center rounded-br-xl p-3">
						<img src="/logo-white.svg" alt="Logo" class="h-12 w-12" />
						<div class="ml-2 text-xs leading-tight text-white" style="font-size: 8px;">
							58TH<br />
							INTER IIT<br />
							SPORTS MEET<br />
							2025
						</div>
					</div>
					<button
						on:click={toggleMenu}
						class="absolute top-4 right-6 text-5xl font-bold text-white"
						aria-label="Close menu"
					>
						×
					</button>

					<div class="flex flex-col space-y-4 pt-10">
						<!-- Regular Menu Items -->
						<a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							HOME
						</a>
						<a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							SCHEDULE
						</a><a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							TEAMS AND PLAYERS
						</a><a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							LIVE SCORE
						</a><a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							RESULTS
						</a><a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							GALLERY
						</a><a
							href="#"
							class="hover:border-custom-yellow hover:text-custom-yellow py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-l-5"
						>
							CONTACT
						</a>
					</div>

					<div
						class="absolute right-0 bottom-20 left-0 mx-4 mb-10 rounded-lg bg-white p-6 shadow-lg"
					>
						<div class="flex flex-col items-start gap-1">
							<p class="text-center text-3xl font-bold text-black">
								5-DAY SPORTS<br />SUMMER CAMP
							</p>
							<div class="flex items-center gap-1 *:size-6">
								<img src="basketball.webp" alt="event 1" />
								<img src="football.webp" alt="event 2" />
								<img src="hockey.webp" alt="event 3" />
								<img src="badminton.webp" alt="event 4" />
							</div>
							<div class="flex items-end justify-evenly gap-1">
								<!-- Center alignment container -->
								<p class="text-black-600">Open to school and college students</p>

								<button
									class="bg-custom-orange ml-3 flex h-15 w-15 -skew-x-15 items-center justify-center rounded-md"
								>
									<img
										src="/diag-up-arrow.svg"
										alt="Northeast arrow"
										class="h-4 w-4 rotate-45 skew-x-15 transform text-white"
									/>
								</button>
							</div>
						</div>
					</div>
					<div class="absolute bottom-10 ml-10 flex items-center gap-8 *:size-8">
						<img src="instagram.svg" alt="event 1" />
						<img src="linkedin.svg" alt="event 2" />
						<img src="medium.svg" alt="event 3" />
					</div>
				</div>
			{/if}
		</nav>

		<!-- Header Text -->
		<section class="absolute top-0 bottom-0 flex flex-col justify-center gap-8 pl-28 text-white">
			<!-- IITH logo -->
			<div class="flex justify-start">
				<img src="/iith-logo-full.png" alt="IITH Logo" class="mb-4 h-10" />
			</div>

			<!-- Event Title -->
			<div class="text-[4rem] leading-none font-semibold text-nowrap italic">
				<p>58TH</p>
				<p>INTER IIT</p>
				<p>SPORTS MEET</p>
				<p>2025</p>
			</div>

			<!-- IIT HYDERABAD location -->
			<div
				class="-mt-2 flex w-fit items-center gap-2 rounded-full border border-white bg-[#020202] px-3.5 py-2.5 text-xl leading-none font-medium"
			>
				<img src="/pin.svg" alt="pin" class="-mt-0.5" />
				<p>IIT HYDERABAD</p>
			</div>

			<!-- Dates -->
			<div
				class="bg-custom-blue/60 inline-flex w-fit items-center gap-2 rounded-sm border border-white/80 px-4 py-1 text-xl font-medium"
			>
				10th to 17th December 2025
			</div>
		</section>

		<!-- Bottom Right Announcement -->
		<section
			class="absolute -right-10 -bottom-[0.3px] flex w-fit -skew-x-15 flex-col gap-3 rounded-tl-2xl bg-white pt-10 pr-20 pb-4 pl-8 text-white"
		>
			<!-- Rounded Corner top right -->
			<div
				class="absolute -top-[1rem] right-[5.3rem] size-4 skew-x-15 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<!-- Rounded Corner bottom left -->
			<div
				class="absolute -bottom-[0.2px] -left-[0.98rem] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div class="flex skew-x-15 flex-col gap-3 pb-4 pl-6 text-black">
				<!-- Top Row: Circle + Heading -->
				<div class="flex items-center gap-1 pl-6">
					<div
						class="border-custom-orange/50 flex size-7 animate-pulse flex-row items-center justify-center rounded-full border"
					>
						<div
							class="border-custom-orange flex size-5 animate-pulse flex-row items-center justify-center rounded-full border"
						>
							<div class="bg-custom-orange size-3 rounded-full"></div>
						</div>
					</div>

					<p class="text-custom-orange ml-1 text-xl font-medium">What's happening?</p>
					<div class="flex items-center gap-1 *:size-6">
						<img src="basketball.webp" alt="event 1" />
						<img src="football.webp" alt="event 2" />
						<img src="hockey.webp" alt="event 3" />
						<img src="badminton.webp" alt="event 4" />
					</div>
				</div>

				<!-- Title -->
				<p class="pl-6 text-[2.5rem] leading-snug font-semibold">5-DAY SPORTS SUMMER CAMP</p>

				<!-- Two lines of text -->
				<div class="pl-6 text-xl leading-relaxed">
					<p>Open to school and college students in Hyderabad.</p>
					<p>Train at IIT Hyderabad this summer with expert coaches and top facilites.</p>
				</div>

				<!-- Buttons -->
				<div class="mt-2 flex -skew-x-15 gap-x-8 *:py-3">
					<!-- Skewed Button -->
					<button
						class="bg-custom-orange hover:bg-custom-orange/90 flex grow flex-row flex-nowrap items-center justify-center rounded text-lg font-bold text-white transition hover:cursor-pointer"
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
						class="flex flex-row items-center rounded border border-black/10 bg-white px-6 text-lg font-semibold text-black"
					>
						<p class="skew-x-15">DATES – 6–11 JULY 2025</p>
					</div>
				</div>
			</div>
		</section>
	</div>
</header>
