<script lang="ts">
	let showMenu = false;

	const toggleMenu = () => {
		showMenu = !showMenu;
	};
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
			class="3xl:h-[10800px] my-4 h-[calc(100vh-4rem)] w-full rounded-xl object-cover object-[30%_50%] sm:h-[calc(100vh-3rem)] sm:object-center lg:h-[80vh] xl:h-[720px] 2xl:h-[900px]"
		/>

		<!-- Logo + Text container positioned on top of the image -->
		<div
			class="-skew-x-15 absolute left-0 top-0 flex items-center space-x-3 rounded-br-2xl bg-white pb-2 pl-3 pr-3 pt-2 sm:pb-3 sm:pl-5 sm:pr-5 sm:pt-3 lg:pl-6 lg:pr-6 xl:pl-6 xl:pr-6 2xl:pl-7 2xl:pr-7"
		>
			<div
				class="absolute -right-[26px] top-0 size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="skew-x-15 absolute -bottom-4 left-7 size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at bottom right, transparent 0%, transparent 100%,black 100%);"
			></div>

			<img
				src="/logo.png"
				alt="Logo"
				class="skew-x-15 lg:size-18 size-14 sm:size-16 xl:size-20 2xl:size-24"
			/>

			<div
				class="skew-x-15 text-[0.65rem] font-semibold leading-tight text-gray-800 sm:text-sm lg:text-base xl:text-base 2xl:text-lg"
			>
				58TH<br />
				INTER IIT<br />
				SPORTS MEET<br />
				2025
			</div>
		</div>
		<!--Nav bar for the layouts other than mobile-->
		<!-- <div
			class="3xl:gap-x-12 3xl:text-xl hidden flex-wrap justify-end gap-x-2 text-[0.65rem] font-semibold sm:flex sm:gap-x-4 sm:text-xs lg:gap-x-6 lg:text-sm xl:gap-x-8 xl:text-base 2xl:gap-x-10 2xl:text-lg"
		>
			<a href="#schedule" class="hover:underline">SCHEDULE</a>
			<a href="#teams" class="hover:underline">TEAMS AND PLAYERS</a>
			<a href="#live-score" class="hover:underline">LIVE SCORE</a>
			<a href="#results" class="hover:underline">RESULTS</a>
			<a href="#gallery" class="hover:underline">GALLERY</a>
			<a href="#contact" class="hover:underline">CONTACT</a>
		</div> -->

		<!-- Mobile dropdown menu-->
		<div class="absolute left-0 top-0 z-50 w-full">
			<!-- Menu button at top right -->
			<div class="relative py-4">
				<!-- Increased horizontal padding -->
				<button
					on:click={toggleMenu}
					class="absolute right-10 text-4xl italic text-white focus:outline-none"
					aria-label="Toggle menu"
				>
					☰
				</button>
			</div>

			<!-- Full-screen menu content -->
			{#if showMenu}
				<div class="fixed inset-0 z-40 bg-[#283891] pt-20">
					<!-- Close Button (X mark) -->

					<div class="fixed left-0 top-0 z-40 flex items-center rounded-br-xl p-3">
						<img src="/logo.png" alt="Logo" class="h-12 w-12" />
						<div class="ml-2 text-xs leading-tight text-white">
							58TH<br />
							INTER IIT<br />
							SPORTS MEET<br />
							2025
						</div>
					</div>
					<button
						on:click={toggleMenu}
						class="absolute right-6 top-6 text-5xl font-bold text-white"
						aria-label="Close menu"
					>
						×
					</button>

					<div class="flex flex-col space-y-4 pt-10">
						<!-- Regular Menu Items -->
						<a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							HOME
						</a>
						<a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							SCHEDULE
						</a><a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							TEAMS AND PLAYERS
						</a><a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							LIVE SCORE
						</a><a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							RESULTS
						</a><a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							GALLERY
						</a><a
							href="#"
							class="hover:border-l-5 py-2 pl-10 text-lg font-semibold text-white transition-colors duration-200 hover:border-[#fdb424] hover:text-[#fdb424]"
						>
							CONTACT
						</a>
					</div>
					<div
						class="absolute bottom-20 left-0 right-0 mx-4 mb-10 rounded-lg bg-white p-6 shadow-lg"
					>
						<div class="flex flex-col items-start gap-4">
							<p class="text-center text-3xl font-bold text-black">
								5-DAY SPORTS<br />SUMMER CAMP
							</p>
							<div class="flex items-center gap-1 *:size-6">
								<img src="basketball.webp" alt="event 1" />
								<img src="football.webp" alt="event 2" />
								<img src="hockey.webp" alt="event 3" />
								<img src="badminton.webp" alt="event 4" />
							</div>
							<div class="flex items-center justify-center">
								<!-- Center alignment container -->
								<p class="text-black-600">Open to school and college students</p>

								<button
									class="h-15 w-15 -skew-x-15 ml-3 flex items-center justify-center rounded-md bg-[#ef4823] transition-all hover:bg-blue-600"
								>
									<img
										src="/arrow.svg"
										alt="Northeast arrow"
										class="h-4 w-4 rotate-45 transform text-white"
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
		</div>

		<div
			class="absolute left-24 top-1/2 flex max-w-xs -translate-y-1/2 flex-col gap-4 rounded-md p-4 text-white"
		>
			<!-- IITH logo -->
			<div class="flex justify-start">
				<img src="/iith-logo-full.png" alt="IITH Logo" class="mb-6 h-10 sm:h-12" />
			</div>

			<!-- Event Title -->
			<div class="text-nowrap text-xs font-semibold italic leading-tight sm:text-[4rem]">
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
			class="-skew-x-15 absolute -bottom-[0.2px] -right-8 flex w-fit flex-col gap-3 rounded-tl-2xl bg-white pb-4 pl-8 pr-20 pt-8 text-white"
		>
			<div
				class="skew-x-15 absolute -top-[1rem] right-[5.56rem] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div
				class="absolute -bottom-[0.2px] -left-[0.98rem] size-4 bg-white"
				style="mask-composite: exclude;mask-image: radial-gradient(circle 1rem at top left, transparent 0%, transparent 100%,black 100%);"
			></div>

			<div class="skew-x-15 flex flex-col gap-3 pb-4 pl-12 text-black">
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
					<div class="flex items-center gap-1 *:size-6">
						<img src="basketball.webp" alt="event 1" />
						<img src="football.webp" alt="event 2" />
						<img src="hockey.webp" alt="event 3" />
						<img src="badminton.webp" alt="event 4" />
					</div>
				</div>

				<!-- Title -->
				<p class="text-[2.5rem] font-semibold leading-snug">5-DAY SPORTS SUMMER CAMP</p>

				<!-- Two lines of text -->
				<div class="text-xl leading-relaxed">
					<p>Open to school and college students in Hyderabad.</p>
					<p>Train at IIT Hyderabad this summer with expert coaches and top facilites.</p>
				</div>

				<!-- Buttons -->
				<div class="-skew-x-15 mt-2 flex gap-x-8 *:py-3">
					<!-- Skewed Button -->
					<button
						class="bg-custom-orange hover:bg-custom-orange/90 flex flex-row flex-nowrap items-center rounded px-12 text-lg font-bold text-white transition hover:cursor-pointer"
					>
						<a href="/workshop" target="_blank" class="flex flex-nowrap items-center">
							<p class="skew-x-15">KNOW MORE & REGISTER</p>
							<div class="skew-x-15 my-auto ml-3 size-4">
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
