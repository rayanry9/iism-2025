<script lang="ts">
	import { goto } from '$app/navigation';
</script>

<section class="text-background relative hidden">
	<img src="home/landing.jpg" alt="Landing" />
	<div
		class="from-foreground absolute top-0 bottom-0 flex flex-col justify-center gap-y-6 bg-linear-to-r to-transparent pr-20 pl-52"
	>
		<div class="flex flex-row items-center gap-x-6">
			<div class="divide-background/70 flex flex-row items-center divide-x">
				<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-9 pr-3" />
				<img src="iith-logo.png" alt="IITH Logo" class="h-8 pl-4" />
			</div>
		</div>
		<div class="flex flex-col gap-y-3">
			<p class="text-[3.5rem] leading-[4.5rem] font-medium">5-Day Sports<br />Summer Camp</p>
			<div
				class="flex w-fit flex-row gap-x-3 rounded-full border border-[#707070] bg-black/30 px-6 py-2 text-nowrap"
			>
				<img src="home/pin.svg" alt="pin" />
				IIT HYDERABAD
			</div>
		</div>
		<p class="text-xl font-medium">
			Experience Student Life.<br />
			Explore Sports.<br />
			Escape Boring Holidays.
		</p>

		<div class="flex flex-col gap-y-4">
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
		<div class=" absolute bottom-12 self-center">
			<img src="icons/triple-chevron-down.svg" alt="Chevron Down" />
		</div>
	</div>
</section>

<article class="flex flex-row gap-x-28 py-24 pr-32 pl-52">
	<div class="flex w-[84rem] flex-col gap-y-16">
		<section class="flex flex-col gap-y-8">
			<h2 class="text-5xl font-medium">About Inter IIT Workshop...</h2>
			<div class="flex flex-col gap-y-4 text-xl">
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

		<section class="flex flex-col gap-y-8">
			{#snippet SportItem(text: string, imgSrc: string)}
				<div
					class="relative grid -skew-x-[15deg] grid-cols-2 border-2 border-[#016064] bg-[#D6E8E6] py-4 pl-8 text-[1.375rem] font-medium text-[#016064]"
				>
					<p class="skew-x-[15deg]">{text}</p>
					<img src={imgSrc} alt={text} class="absolute right-8 bottom-0 skew-x-[15deg]" />
				</div>
			{/snippet}

			<h2 class="text-5xl font-medium">Sports</h2>
			<p class="text-xl">
				This workshop will focus on Sports like Football, Volleyball, Cricket, Hockey, Athletics and
				more which will lorem ipsum lorem ipsum
			</p>

			<div class="grid grid-cols-2 gap-8">
				{@render SportItem('FOOTBALL', 'home/football.svg')}
				{@render SportItem('BASKETBALL', 'home/basketball.svg')}
				{@render SportItem('BADMINTON', 'home/badminton.svg')}
				{@render SportItem('HOCKEY', 'home/hockey.svg')}
			</div>

			<button
				onclick={() => {
					goto('about');
				}}
				class="bg-foreground text-background mt-auto flex -skew-x-[15deg] flex-row px-8 py-4 text-xl font-medium hover:cursor-pointer"
			>
				<p class="skew-x-[15deg]">SCHEDULE, REWARDS & MORE...</p>
				<img
					src="icons/triple-chevron-right.svg"
					alt="Chevron Right"
					class="text-background ml-auto skew-x-[15deg]"
				/>
			</button>
		</section>
	</div>

	<section class="flex w-full grow flex-col gap-y-8">
		<h2 class="text-5xl font-medium">What To Expect ?</h2>

		{#snippet ExpectCard(title: string, points: string[], imgSrc: string, index: number)}
			<div class="relative max-h-full w-full">
				<div class="absolute top-0 left-0 h-full w-12 skew-x-[10deg] bg-[#D6E8E6] p-2">
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

		<div class="grid h-full grid-cols-1 gap-y-6">
			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Soak in the energy and culture of a top-ranked institution',
					'Stay in campus hostels and dine in mess halls',
					'Explore academic zones, & Open spaces'
				],
				'gallery/image-4.png',
				1
			)}

			{@render ExpectCard(
				'Hands-On Sports Training',
				[
					'Professionally guided beginner-friendly sessions<br/>in selected sports',
					'Structured schedules and skill-building drills'
				],
				'gallery/image-4.png',
				2
			)}

			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Capture your journey through group photographs<br/>& video highlights',
					'Participate in fun events like campus tours &  activities'
				],
				'gallery/image-4.png',
				3
			)}

			{@render ExpectCard(
				'Live the IIT Hyderabad Student Experience',
				[
					'Camp finale features a mini-competition',
					'Prizes and recognition for standout performances'
				],
				'gallery/image-4.png',
				4
			)}
		</div>
	</section>
</article>

<section class="bg-foreground text-background flex flex-row pl-52">
	<div class="flex flex-col py-48 pr-24">
		<h2 class="text-5xl font-medium text-nowrap">About Campus</h2>
		<div class="mt-16 flex max-w-[64rem] flex-col gap-y-4">
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
				goto('register');
			}}
			class="bg-primary mt-auto flex -skew-x-[15deg] flex-row px-8 py-4 text-xl font-medium hover:cursor-pointer"
		>
			<p class="skew-x-[15deg]">EXPLORE FACILITES</p>
			<img
				src="icons/triple-chevron-right.svg"
				alt="Chevron Right"
				class="ml-auto skew-x-[15deg]"
			/>
		</button>
	</div>
	<div class="grow">
		<img src="home/sncc.png" class="w-fit" alt="SNCC" />
	</div>
</section>

<section class="text-foreground overflow-x-clip py-48">
	<div class="grid scale-110 -skew-x-[15deg] grid-cols-6 gap-2.5">
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<div class="flex flex-col pt-8">
			<h2 class="mr-4 skew-x-[15deg] self-end text-5xl font-medium">Gallery</h2>
			<div class="bg-foreground mt-auto flex h-8 w-full flex-row items-center px-4 py-8">
				<h4 class="text-background skew-x-[15deg] text-2xl font-medium">SHOW ALL</h4>
				<img src="icons/triple-chevron-right.svg" alt="Go To" class="ml-auto skew-x-[15deg]" />
			</div>
		</div>
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img class="col-span-2 row-span-2" src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
	</div>
</section>

<section class="flex flex-row items-center border-t border-t-[#016064] bg-[#D6E8E6] px-52 py-12">
	<h3 class="text-3xl font-medium">Ready to take the field?</h3>
	<button
		onclick={() => {
			goto('register');
		}}
		class="border-background text-background bg-secondary ml-auto -skew-x-[15deg] border px-24 py-2 text-xl font-medium hover:cursor-pointer"
	>
		<p class="skew-x-[15deg]">REGISTER NOW</p>
	</button>
</section>
