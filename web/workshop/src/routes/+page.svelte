<script module>
	export { SportItem };
</script>

<script lang="ts">
	import { goto } from '$app/navigation';
	let expectCards = $state(new Array(5));
	let currentCard = $state(1);
</script>

<svelte:head>
	<title>Inter IIT Sports Meet 2025</title>
	<meta
		name="description"
		content="Inter IIT Sports Meet 2025 Home Page. Landing page for IISM 2025. Gives an overview for the workshop attendees."
	/>
	<meta
		name="keywords"
		content="Inter IIT Sports Meet 2025, IIT, Hyderabad, Sports, Sports Meet, Neet, 2025, IISM 2025, IISM, IISSM, IISSM 2025, Workshop, IIT Hyderabad, IIT Hyderabad Sports Meet, Home page, Landing page"
	/>
</svelte:head>

{#snippet SportItem(text: string, imgSrc: string)}
	<div
		class="relative grid -skew-x-[15deg] grid-cols-2 border-2 border-[#016064] bg-[#D6E8E6] py-4 pl-8 text-xl font-medium text-[#016064] sm:text-[1.375rem]"
	>
		<p class="skew-x-[15deg]">{text}</p>
		<img src={imgSrc} alt={text} class="absolute right-4 bottom-0 skew-x-[15deg]" />
	</div>
{/snippet}

<section class="text-background relative">
	<img
		src="home/landing.webp"
		alt="Landing"
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

<article class="body-spacing flex flex-col gap-x-28 gap-y-16 py-24 xl:flex-row xl:gap-y-0">
	<div class="flex flex-col gap-y-16 xl:w-[90rem]">
		<section class="flex flex-col gap-y-4 sm:gap-y-8">
			<h2 class="text-[2rem] font-medium sm:text-5xl">About The Sports Workshop...</h2>
			<div class="flex flex-col gap-y-4 sm:text-xl">
				<p>Are you looking for an active and meaningful way to spend your summer break?</p>

				<p>
					Join us at the 5-Day Sports Summer Camp hosted at the prestigious IIT Hyderabad. This
					immersive camp combines sports training, engaging activities, and a first-hand experience
					of the student lifestyle at one of India’s top institutes.
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

			<button
				onclick={() => {
					goto('about');
				}}
				class="bg-foreground text-background mt-4 flex -skew-x-[15deg] flex-row px-8 py-4 text-xl font-medium hover:cursor-pointer sm:mt-auto"
			>
				<p class="hidden skew-x-[15deg] sm:block">SCHEDULE, REWARDS & MORE...</p>
				<p class="block skew-x-[15deg] sm:hidden">SCHEDULE & MORE...</p>
				<img
					src="icons/triple-chevron-right.svg"
					alt="Chevron Right"
					class="text-background ml-auto skew-x-[15deg]"
				/>
			</button>
		</section>
	</div>

	<section class="flex w-full grow flex-col gap-y-8">
		<h2 class="text-[2rem font-medium sm:text-5xl">What To Expect ?</h2>

		{#snippet ExpectCard(title: string, points: string[], imgSrc: string, index: number)}
			<div class="relative max-h-full w-full">
				<div class="absolute top-0 left-0 h-full w-24 skew-x-[10deg] bg-[#D6E8E6] p-2">
					<p class="-skew-x-[10deg] text-xl font-medium text-[#016064]">{index}</p>
				</div>
				<div
					class="flex h-full -skew-x-[15deg] flex-row border-2 border-l-8 border-[#D4D4D4] border-l-[#016064] bg-[#EFEFEF]"
				>
					<div class="flex skew-x-[15deg] flex-col py-6 pr-4 pl-10">
						<h3 class="mb-4 text-2xl font-medium">{title}</h3>
						<ul class="list-disc pl-4 text-xl leading-tight font-normal">
							{#each points as point, idx (idx)}
								<li>{@html point}</li>
							{/each}
							{#if index == 4}
								<li class="invisible"></li>
							{/if}
						</ul>
					</div>
					<div class="ml-auto h-full w-[10rem] skew-x-[15deg]">
						<div class="h-full -skew-x-[15deg] overflow-hidden">
							<img src={imgSrc} alt={title} class="h-full scale-150 skew-x-[15deg] object-cover" />
						</div>
					</div>
				</div>
			</div>
		{/snippet}

		<!-- Mobile Version -->
		<div
			style="scrollbar-width: none; -ms-overflow-style: none; ::-webkit-scrollbar:display: none;"
			class="flex w-full snap-x snap-mandatory flex-row gap-x-12 overflow-x-scroll sm:hidden"
		>
			{#snippet ExpectMobileCard(title: string, points: string[], imgSrc: string, index: number)}
				<div
					bind:this={expectCards[index]}
					class="relative flex w-full shrink-0 snap-center snap-always flex-col"
				>
					<div class="absolute top-0 left-1 mx-7 h-[10rem] w-12 skew-x-[10deg] bg-[#D6E8E6] p-2">
						<p class="-skew-x-[10deg] text-xl font-medium text-[#016064]">{index}</p>
					</div>
					<div
						class="mx-7 flex -skew-x-[15deg] flex-col border-2 border-l-8 border-l-[#016064] bg-[#EFEFEF]"
					>
						<div class="ml-auto h-full skew-x-[15deg]">
							<div class="h-full -skew-x-[15deg] overflow-hidden">
								<img
									src={imgSrc}
									alt={title}
									class="h-full scale-150 skew-x-[15deg] object-cover"
								/>
							</div>
						</div>
					</div>

					<div class="mt-8 flex flex-col">
						<h3 class="mb-4 text-xl font-semibold">{title}</h3>
						<ul class="list-disc pl-4 text-xl leading-5 font-normal *:mb-2">
							{#each points as point, idx (idx)}
								<li>{@html point}</li>
							{/each}
							{#if index == 4}
								<li class="invisible"></li>
							{/if}
						</ul>
					</div>
				</div>
			{/snippet}

			{@render ExpectMobileCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Soak in the energy and culture of a top-ranked institution',
					'Stay in campus hostels and dine in mess halls',
					'Explore academic zones, & Open spaces'
				],
				'gallery/image-4.webp',
				1
			)}

			{@render ExpectMobileCard(
				'Hands-On Sports Training',
				[
					'Professionally guided beginner-friendly sessions<br/>in selected sports',
					'Structured schedules and skill-building drills'
				],
				'gallery/image-4.webp',
				2
			)}

			{@render ExpectMobileCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Capture your journey through group photographs<br/>& video highlights',
					'Participate in fun events like campus tours &  activities'
				],
				'gallery/image-4.webp',
				3
			)}

			{@render ExpectMobileCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Camp finale features a mini-competition',
					'Prizes and recognition for standout performances'
				],
				'gallery/image-4.webp',
				4
			)}
		</div>

		<div class="flex flex-row sm:hidden">
			<button
				class="size-12 -skew-x-[15deg] border-2 border-[#B6CAC8]"
				onclick={() => {
					if (currentCard <= 1) {
						(expectCards[4] as HTMLDivElement).scrollIntoView({
							behavior: 'smooth',
							block: 'nearest'
						});
						currentCard = 4;
					} else {
						(expectCards[currentCard - 1] as HTMLDivElement).scrollIntoView({
							behavior: 'smooth',
							block: 'nearest'
						});
						currentCard -= 1;
					}
				}}
			>
				<img class="mx-auto skew-x-[15deg]" src="icons/chevron-left.svg" alt="scroll left" />
			</button>

			<div class="mx-auto my-auto flex -skew-x-[15deg] flex-row gap-x-1.5">
				<div class="{currentCard == 1 ? 'bg-primary' : 'bg-[#B6CAC8]'} size-3"></div>
				<div class="{currentCard == 2 ? 'bg-primary' : 'bg-[#B6CAC8]'} size-3"></div>
				<div class="{currentCard == 3 ? 'bg-primary' : 'bg-[#B6CAC8]'} size-3"></div>
				<div class="{currentCard == 4 ? 'bg-primary' : 'bg-[#B6CAC8]'} size-3"></div>
			</div>

			<button
				class=" size-12 -skew-x-[15deg] border-2 border-[#B6CAC8]"
				onclick={() => {
					if (currentCard >= 4) {
						(expectCards[1] as HTMLDivElement).scrollIntoView({
							behavior: 'smooth',
							block: 'nearest'
						});
						currentCard = 1;
					} else {
						(expectCards[currentCard + 1] as HTMLDivElement).scrollIntoView({
							behavior: 'smooth',
							block: 'nearest'
						});
						currentCard += 1;
					}
				}}
			>
				<img src="icons/chevron-right.svg" class="mx-auto skew-x-[15deg]" alt="scroll right" />
			</button>
		</div>

		<!-- Desktop Version -->
		<div class="hidden h-full grid-cols-1 gap-y-6 sm:grid">
			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Soak in the energy and culture of a top-ranked institution',
					'Stay in campus hostels and dine in mess halls',
					'Explore academic zones, & Open spaces'
				],
				'gallery/image-4.webp',
				1
			)}

			{@render ExpectCard(
				'Hands-On Sports Training',
				[
					'Professionally guided beginner-friendly sessions<br/>in selected sports',
					'Structured schedules and skill-building drills'
				],
				'gallery/image-4.webp',
				2
			)}

			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Capture your journey through group photographs<br/>& video highlights',
					'Participate in fun events like campus tours &  activities'
				],
				'gallery/image-4.webp',
				3
			)}

			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Camp finale features a mini-competition',
					'Prizes and recognition for standout performances'
				],
				'gallery/image-4.webp',
				4
			)}
		</div>
	</section>
</article>

<section
	class="lg:bg-foreground text-background grid h-full grid-cols-1 lg:grid-cols-[55%_45%] xl:grid-cols-[35%_65%] xl:pl-52"
>
	<div style="" class="relative h-full lg:hidden">
		<div
			style="clip-path: polygon(0% 15%, 100% 40%, 100% 100%, 0% 100%);"
			class="absolute top-0 left-0 h-full w-full bg-[#016064] lg:hidden"
		></div>

		<img
			src="home/sncc.webp"
			style="clip-path: polygon(0% 30%, 100% 10%, 100% 100%, 0% 100%);"
			class="h-full object-cover sm:hidden"
			alt="SNCC"
		/>
		<img
			src="home/sncc.webp"
			style="clip-path: polygon(0% 30%, 100% 0%, 100% 100%, 0% 100%);"
			class="hidden h-full object-cover sm:block"
			alt="SNCC"
		/>
	</div>
	<div
		class="bg-foreground flex flex-col py-16 pr-8 pl-8 sm:py-24 sm:pr-12 sm:pl-12 lg:pl-16 xl:py-48 xl:pr-24 xl:pl-8"
	>
		<h2 class="text-[2rem] font-medium text-nowrap sm:text-5xl">About Campus</h2>
		<div class="mt-12 flex flex-col gap-y-4 sm:mt-16 sm:max-w-[64rem]">
			<p>
				IIT Hyderabad is located just outside the city near Kandi, Sngareddy, with a peaceful and
				modern campus. Along with academics, sports is a big part of campus life here.
			</p>
			<p>
				The main sports area is the SNCC – Sports and Cultural Complex. It has a big football
				ground, athletics track, indoor and outdoor courts for volleyball and cricket, table tennis,
				a gym, and more. This is where all the training and matches will happen during the workshop.
			</p>
			<p>
				IIT Hyderabad has a modern and spacious campus with everything students need — classrooms,
				hostels, mess, medical facilities, and green open spaces. The campus is well-connected and
				safe, making it a great place to learn, play, and explore.
			</p>
		</div>

		<button
			onclick={() => {
				goto('about');
			}}
			class="bg-primary mt-16 flex -skew-x-[15deg] flex-row px-8 py-4 text-xl font-medium hover:cursor-pointer sm:mt-24"
		>
			<p class="skew-x-[15deg]">EXPLORE FACILITES</p>
			<img
				src="icons/triple-chevron-right.svg"
				alt="Chevron Right"
				class="ml-auto skew-x-[15deg]"
			/>
		</button>
	</div>

	<div style="clip-path: polygon(20% 0%, 100% 0%, 100% 100%, 0% 100%);" class="h-full">
		<img src="home/sncc.webp" class="hidden h-full object-cover lg:block" alt="SNCC" />
	</div>
</section>

<section
	class="text-foreground mb-32 flex w-full flex-col overflow-x-clip sm:mt-0 sm:mb-0 sm:py-24 lg:mt-12 lg:mb-24 lg:block xl:py-48"
>
	<h2
		class="mx-auto mt-24 mb-20 w-fit text-[2rem] font-medium text-nowrap sm:mt-0 sm:mb-32 sm:text-5xl lg:hidden"
	>
		Gallery
	</h2>
	<div
		class="grid scale-125 -skew-x-[15deg] grid-cols-2 gap-2.5 lg:scale-110 lg:grid-cols-4 xl:grid-cols-6"
	>
		<img
			src="gallery/image-2.webp"
			alt="gallery img"
			class="-translate-x-8 lg:translate-x-0 xl:-translate-x-0"
		/>
		<img
			src="gallery/image-2.webp"
			alt="gallery img"
			class="-translate-x-8 lg:translate-x-0 xl:-translate-x-0"
		/>
		<img
			src="gallery/image-2.webp"
			alt="gallery img"
			class="translate-x-12 lg:hidden lg:translate-x-0 xl:block xl:translate-x-0"
		/>
		<div class="hidden flex-col pt-8 lg:flex">
			<h2 class="skew-x-[15deg] self-end text-4xl font-medium xl:mr-4 xl:text-5xl">Gallery</h2>
			<a
				href="gallery"
				class="bg-foreground mt-auto flex h-8 w-full flex-row items-center px-4 py-8"
			>
				<h4 class="text-background skew-x-[15deg] text-xl font-medium xl:text-2xl">SHOW ALL</h4>
				<img src="icons/triple-chevron-right.svg" alt="Go To" class="ml-auto skew-x-[15deg]" />
			</a>
		</div>
		<img
			src="gallery/image-2.webp"
			alt="gallery img"
			class="translate-x-12 lg:translate-x-0 xl:translate-x-0"
		/>
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden lg:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden lg:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden lg:block" />
		<img
			class="col-span-2 row-span-2 hidden xl:block"
			src="gallery/image-2.webp"
			alt="gallery img"
		/>
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden lg:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden xl:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden xl:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden xl:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden xl:block" />
		<img src="gallery/image-2.webp" alt="gallery img" class="hidden xl:block" />
	</div>

	<div class="mt-24 w-full grow self-center px-8 lg:hidden">
		<button
			onclick={() => {
				goto('gallery');
			}}
			class="bg-foreground text-background flex w-full -skew-x-[15deg] flex-row self-center px-8 py-4 text-xl font-medium hover:cursor-pointer lg:mt-24"
		>
			<p class="skew-x-[15deg]">SHOW ALL</p>
			<img
				src="icons/triple-chevron-right.svg"
				alt="Chevron Right"
				class="ml-auto skew-x-[15deg]"
			/>
		</button>
	</div>
</section>

<section
	class="body-spacing flex flex-col items-center gap-y-8 border-t border-t-[#016064] bg-[#D6E8E6] py-12 sm:flex-row sm:gap-y-0"
>
	<h3 class="text-[2rem] font-medium sm:text-3xl">Ready to take the field?</h3>
	<button
		onclick={() => {
			goto('register');
		}}
		class="border-background text-background bg-secondary ml-auto w-full -skew-x-[15deg] border py-4 text-xl font-medium hover:cursor-pointer sm:w-auto sm:px-24 sm:py-2"
	>
		<p class="skew-x-[15deg]">REGISTER NOW</p>
	</button>
</section>
