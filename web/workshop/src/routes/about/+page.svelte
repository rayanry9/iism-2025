<script lang="ts">
	import { goto } from '$app/navigation';
	import { SportItem } from '../+page.svelte';
</script>

<svelte:head>
	<title>IISM 2025 About</title>
	<meta
		name="description"
		content="Inter IIT Sports Meet 2025 About Page. Details about the inter iit 2025 sports meet workshop, which is being conducted in IIT Hyderabad."
	/>
	<meta
		name="keywords"
		content="Inter IIT Sports Meet 2025, IISM 2025, IISM, IISSM, IISSM 2025, Workshop, Hyderabad, IIT, IIT Hyderabad, IIT Hyderabad Sports Meet, IISM 2024, Inter IIT, Sports Meet, About, Details, Info, Information "
	/>
</svelte:head>

<header class="relative h-56 sm:h-96 xl:h-auto">
	<div
		class="absolute top-0 bottom-0 flex flex-col items-center justify-center bg-gradient-to-r from-[#5A85D0] to-[#5B84D3]/0 pl-8 sm:h-auto sm:pr-96 sm:pl-32"
	>
		<p class="text-background text-4xl leading-snug font-medium sm:text-[4rem]">
			ABOUT & <br />FACILITIES
		</p>
		<div class=" relative w-full">
			<hr class="bg-background text-background top-0 mt-2 h-1.5 w-full sm:absolute sm:mt-4" />
		</div>
		<img
			src="icons/triple-chevron-down.svg"
			alt="chevron down"
			class="mt-4 size-7 self-start sm:hidden"
		/>
	</div>
	<img
		src="about/arrows.webp"
		alt="arrows"
		class="absolute top-0 bottom-0 left-0 hidden h-full sm:block"
	/>
	<img src="about/header.webp" alt="header" class="h-full object-cover" />
</header>

<article
	class="body-spacing grid grid-cols-1 gap-x-28 gap-y-12 py-12 sm:py-24 xl:grid-cols-2 xl:flex-row xl:gap-y-0"
>
	<section class="flex flex-col gap-y-4 sm:gap-y-8">
		<h2 class="text-[2rem] font-medium sm:text-5xl">About The Sports Workshop...</h2>
		<div class="flex flex-col gap-y-4 sm:text-xl">
			<p>Are you looking for an active and meaningful way to spend your summer break?</p>

			<p>
				Join us at the 5-Day Sports Summer Camp hosted at the prestigious IIT Hyderabad. This
				immersive camp combines sports training, engaging activities, and a first-hand experience of
				the student lifestyle at one of India’s top institutes.
			</p>

			<p>
				Participants will stay on campus, receive expert coaching, and explore IITH's world-class
				academic and sports infrastructure. Whether you're a beginner or just curious about trying
				new sports, this is the perfect way to beat summer boredom.
			</p>
		</div>
	</section>

	<section class="flex flex-col gap-y-4 sm:gap-y-8">
		<h2 class="text-[2rem] font-medium sm:text-5xl">Sports</h2>
		<p class="mb-4 sm:mb-0 sm:text-xl">
			This workshop will focus on Sports like Football, Volleyball, Cricket, Hockey, Athletics and
			more which will lorem ipsum lorem ipsum
		</p>

		<div class="grid grid-cols-1 gap-8 sm:grid-cols-2">
			{@render SportItem('FOOTBALL', 'home/football.svg')}
			{@render SportItem('BASKETBALL', 'home/basketball.svg')}
			{@render SportItem('BADMINTON', 'home/badminton.svg')}
			{@render SportItem('HOCKEY', 'home/hockey.svg')}
		</div>
	</section>
</article>

<article class="body-spacing flex flex-col py-8">
	<h2 class="text-[2rem] font-medium sm:text-5xl">
		Schedule <span class="text-primary text-[2rem] font-normal">(Tentative)</span>
	</h2>

	<!-- Mobile Version -->
	{#snippet Card1(day: number, morning: string, evening: string)}
		<div class="flex flex-col">
			<div class="bg-[#CAC19B]">
				<div
					style="clip-path: polygon(0% 0%, 100% 0%, 97% 100%, 0% 100%);"
					class="text-background bg-[#AE9C74] py-4 pl-8 text-xl font-medium"
				>
					Day {day}
				</div>
			</div>

			<div class="flex flex-col gap-y-4 bg-[#E9E4CE] px-8 py-4">
				<div class="flex flex-col gap-y-1">
					<p class="text-[#AE9C74]">Morning- 7:00 AM - 10:00 AM</p>
					<p class="text-xl font-medium text-[#605439]">{morning}</p>
				</div>

				<div class="flex flex-col gap-y-1">
					<p class="text-[#AE9C74]">Evening (Optional)</p>
					<p class="text-xl font-medium text-[#605439]">{evening}</p>
				</div>
			</div>
		</div>
	{/snippet}

	<section class="mt-8 grid grid-cols-1 gap-y-4 sm:hidden">
		{@render Card1(1, 'Welcome, Orientation, Light Training', 'Campus Tour, Icebreaker Sessions')}
		{@render Card1(2, 'Sports Training', 'Group Games, Fitness Challenges')}
		{@render Card1(3, 'Sports Rotation', 'Team Building, Fun Quiz')}
		{@render Card1(4, 'Team Building, Fun Quiz', 'Movie Night or Talent Hour')}
		{@render Card1(5, 'Mini Tournament, Closing Ceremony', 'Departure')}
	</section>

	<!-- Desktop Version -->
	<section
		class="my-16 hidden grid-cols-[10%_45%_45%] gap-y-2 text-center text-2xl font-medium *:bg-[#E9E4CE] *:text-[#AE9C74] *:odd:mr-4 sm:grid"
	>
		<div class="!text-background grid-cell !bg-[#AE9C74]">Day</div>
		<div class="!text-background col-span-2 grid grid-cols-subgrid !bg-[#AE9C74]">
			<div class="grid-cell">Morning- 7:00 AM - 10:00 AM</div>
			<div class="grid-cell">Evening (Optional)</div>
		</div>

		<div class="!bg-[#CAC19B]">
			<div
				class="flex h-full w-full flex-col items-center justify-center bg-[#E9E4CE]"
				style="clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);"
			>
				1
			</div>
		</div>
		<div class=" col-span-2 grid grid-cols-subgrid">
			<div class="grid-cell">Welcome, Orientation, Light Training</div>
			<div class="grid-cell">Campus Tour, Icebreaker Sessions</div>
		</div>

		<div class="!bg-[#CAC19B]">
			<div
				class="flex h-full w-full flex-col items-center justify-center bg-[#E9E4CE]"
				style="clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);"
			>
				2
			</div>
		</div>
		<div class="col-span-2 grid grid-cols-subgrid">
			<div class="grid-cell">Sports Training</div>
			<div class="grid-cell">Group Games, Fitness Challenges</div>
		</div>

		<div class="!bg-[#CAC19B]">
			<div
				class="flex h-full w-full flex-col items-center justify-center bg-[#E9E4CE]"
				style="clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);"
			>
				3
			</div>
		</div>
		<div class="col-span-2 grid grid-cols-subgrid">
			<div class="grid-cell">Sports Rotation</div>
			<div class="grid-cell">Team Building, Fun Quiz</div>
		</div>

		<div class="!bg-[#CAC19B]">
			<div
				class="flex h-full w-full flex-col items-center justify-center bg-[#E9E4CE]"
				style="clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);"
			>
				4
			</div>
		</div>
		<div class="col-span-2 grid grid-cols-subgrid">
			<div class="grid-cell">Focused Coaching</div>
			<div class="grid-cell">Movie Night or Talent Hour</div>
		</div>

		<div class="!bg-[#CAC19B]">
			<div
				class="flex h-full w-full flex-col items-center justify-center bg-[#E9E4CE]"
				style="clip-path: polygon(10% 0%, 100% 0%, 90% 100%, 0% 100%);"
			>
				5
			</div>
		</div>
		<div class="col-span-2 grid grid-cols-subgrid">
			<div class="grid-cell">Mini Tournament, Closing Ceremony</div>
			<div class="grid-cell">Departure</div>
		</div>
	</section>
</article>

<article class="relative my-12 sm:my-24">
	<div
		class=" absolute hidden h-full w-full bg-[#D6E8E6] lg:block"
		style="clip-path: polygon(0% 0%, 100% 20%, 100% 100%, 0% 80%);"
	></div>

	<div
		class=" absolute h-full w-full bg-[#D6E8E6] lg:hidden"
		style="clip-path: polygon(0% 0%, 100% 2%, 100% 100%, 0% 98%);"
	></div>

	{#snippet Card(imgSrc: string, header: string, text: string)}
		<div class="grid grid-cols-[20%_80%] flex-row gap-x-4 sm:flex sm:gap-x-8 lg:gap-x-4">
			<img src={imgSrc} alt={header} />
			<div class="flex flex-col justify-center gap-y-2">
				<p class="text-xl font-medium sm:text-2xl">{header}</p>
				<p class="sm:text-xl">{text}</p>
			</div>
		</div>
	{/snippet}

	<div
		class="bg-foreground text-background flex flex-col px-8 py-12 sm:px-12 sm:py-16 lg:hidden lg:px-52 lg:py-44"
		style="clip-path: polygon(0% 3%, 100% 0%, 100% 97%, 0% 100%);"
	>
		<h2 class="mt-16 text-[2rem] font-medium sm:text-5xl lg:mt-20">What You will Receive!</h2>
		<div class="mt-20 mb-16 grid grid-cols-1 gap-x-20 gap-y-16 lg:mb-0 lg:grid-cols-2">
			{@render Card(
				'about/1.svg',
				'CERTIFICATE',
				'Official Certificate of Participation from IIT Hyderabad'
			)}
			{@render Card(
				'about/2.svg',
				'CAMP KIT (TBD)',
				'Includes T-shirt, wristband, water bottle (subject to sponsors)'
			)}
			{@render Card(
				'about/3.svg',
				'ACCOMMODATION',
				'Hostel stay and meals for the full 5-day duration'
			)}
			{@render Card('about/4.svg', 'SKILL FEEDBACK SHEET', 'Optional feedback from coaches')}
			{@render Card(
				'about/5.svg',
				'CAMPUS TOUR',
				'Guided exploration of campus facilities and labs'
			)}
			{@render Card('about/6.svg', 'PHOTOS & VIDEOS', 'Access to media content post-camp')}
			{@render Card(
				'about/7.svg',
				'COMPETITION & PRIZES',
				'Friendly finale tournament with awards'
			)}
		</div>
	</div>

	<div
		class="bg-foreground text-background body-spacing hidden flex-col py-44 lg:flex"
		style="clip-path: polygon(0% 10%, 100% 0%, 100% 90%, 0% 100%);"
	>
		<h2 class="mt-20 text-5xl font-medium sm:text-5xl">What You will Receive!</h2>
		<div class="mt-20 grid grid-cols-2 gap-x-20 gap-y-16">
			{@render Card(
				'about/1.svg',
				'CERTIFICATE',
				'Official Certificate of Participation from IIT Hyderabad'
			)}
			{@render Card(
				'about/5.svg',
				'CAMPUS TOUR',
				'Guided exploration of campus facilities and labs'
			)}
			{@render Card(
				'about/2.svg',
				'CAMP KIT (TBD)',
				'Includes T-shirt, wristband, water bottle (subject to sponsors)'
			)}
			{@render Card('about/6.svg', 'PHOTOS & VIDEOS', 'Access to media content post-camp')}
			{@render Card(
				'about/3.svg',
				'ACCOMMODATION',
				'Hostel stay and meals for the full 5-day duration'
			)}
			{@render Card(
				'about/7.svg',
				'COMPETITION & PRIZES',
				'Friendly finale tournament with awards'
			)}
			{@render Card('about/4.svg', 'SKILL FEEDBACK SHEET', 'Optional feedback from coaches')}
		</div>
	</div>
</article>

<article class="body-spacing mb-32 grid grid-cols-1 py-12 sm:mb-48 xl:grid-cols-2">
	<section class="flex flex-col gap-y-12 sm:gap-y-16">
		<h2 class="text-[2rem] font-medium sm:text-5xl">Registration & Fees</h2>

		<div
			class="grid grid-cols-1 gap-y-2 text-xl font-medium sm:mt-6 sm:grid-cols-[35%_60%] sm:gap-y-4 sm:text-2xl"
		>
			<p>EARLY BIRD OFFER:</p>
			<p class="mb-5"><span class="text-primary">XXXX/-</span> (VALID TILL 20 JULY)</p>

			<p>STANDARD FEE:</p>
			<p>XXXX/- (POST EARLY BIRD PERIOD)</p>
		</div>

		<div class="flex flex-col">
			<h4 class="text-2xl font-medium">THE FEE INCLUDES:</h4>
			<ul class="mt-4 list-disc pl-8 text-lg">
				<li>Accommodation (5 days, 4 nights)</li>
				<li>Meals and refreshments</li>
				<li>Sports coaching and facility access</li>
				<li>Participation in all camp sessions and events</li>
				<li>Camp merchandise</li>
				<li>Certification and entry into the final tournament</li>
			</ul>
			<ul class="mt-8 list-disc pl-8 text-lg">
				<li>Note: Limited slots per sport. Register early to secure your place.</li>
			</ul>
		</div>

		<button
			onclick={() => {
				goto('register');
			}}
			class="bg-primary text-background -skew-x-[15deg] py-2 text-xl font-medium hover:cursor-pointer sm:mx-auto sm:px-48 lg:mx-0 lg:w-fit"
		>
			<p class="skew-x-[15deg]">REGISTER</p>
		</button>
	</section>
	<div class="relative hidden h-full flex-col items-center px-8 xl:flex">
		<div class="absolute z-[-1] h-full w-full px-8">
			<div
				class=" h-full w-full bg-[#016064]"
				style="clip-path: polygon(0% 30%, 100% 70%, 100% 100%, 0% 100%);"
			></div>
		</div>
		<img
			src="home/sncc.webp"
			style="clip-path: polygon(0% 30%, 100% 0%, 100% 100%, 0% 100%);"
			alt="sncc"
			class="mx-auto mt-auto"
		/>
	</div>
</article>

<style>
	@reference "../../app.css";

	.grid-cell {
		@apply flex flex-col items-center px-2 py-4;
	}
</style>
