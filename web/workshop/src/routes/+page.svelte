<script lang="ts">
	import { goto } from '$app/navigation';
</script>

<section class="text-backgroud relative">
	<img src="home/landing.jpg" alt="Landing" />
	<div
		class="from-foreground absolute top-0 bottom-0 flex flex-col justify-center gap-y-6 bg-linear-to-r to-transparent pr-20 pl-52"
	>
		<div class="flex flex-row items-center gap-x-6">
			<div class="divide-backgroud/70 flex flex-row items-center divide-x">
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
				class="border-backgroud -skew-x-12 border bg-transparent py-2 text-xl font-medium hover:cursor-pointer"
			>
				<p class="skew-x-12">KNOW MORE</p>
			</button>
			<button
				onclick={() => {
					goto('register');
				}}
				class="border-backgroud bg-primary -skew-x-12 border py-2 text-xl font-medium hover:cursor-pointer"
			>
				<p class="skew-x-12">REGISTER</p>
			</button>
		</div>
		<div class=" absolute bottom-12 self-center">
			<img src="icons/triple-chevron-down.svg" alt="Chevron Down" />
		</div>
	</div>
</section>

<article class="flex flex-row gap-x-8 px-52 py-24">
	<div class="flex flex-col gap-y-16">
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
			<h2 class="text-5xl font-medium">Sports</h2>
			<p class="text-xl">
				This workshop will focus on Sports like Football, Volleyball, Cricket, Hockey, Athletics and
				more which will lorem ipsum lorem ipsum
			</p>
		</section>
	</div>

	<div class="flex flex-col gap-y-16">
		<section class="flex flex-col gap-y-8">
			<h2 class="text-5xl font-medium">Sports</h2>
			<p class="text-lg font-medium">
				This workshop will focus on Sports like Football, Volleyball, Cricket, Hockey, Athletics and
				more which will lorem ipsum lorem ipsum
			</p>
		</section>
	</div>
</article>

<section class="bg-foreground text-backgroud flex flex-row pl-52">
	<div class="flex flex-col pt-48 pr-24">
		<h2 class="text-5xl font-medium text-nowrap">About Campus</h2>
		<p class="max-w-[64rem]">
			This summer, IIT Hyderabad invites you to a dynamic sports workshop open to all IITs. With
			expert coaching, world-class facilities, and exciting matches, it’s your chance to elevate
			your game. Sop open to all IITs. With expert coaching, world- fcsfdf fesadfefe feef efefr e
			fwfdwfwff Lorem ipsunm This summer, IIT Hyderabad invites you to a dynamic sports workshop
			open to all II
		</p>

		<button
			onclick={() => {
				goto('register');
			}}
			class="border-backgroud bg-primary -skew-x-12 border py-2 text-xl font-medium hover:cursor-pointer"
		>
			<p class="skew-x-12">EXPLORE FACILITES</p>
		</button>
	</div>
	<div class="grow">
		<img src="home/sncc.png" class="w-fit" alt="SNCC" />
	</div>
</section>

<section class="text-foreground overflow-x-clip py-48">
	<div class="grid scale-110 -skew-x-12 grid-cols-6 gap-2.5">
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<img src="gallery/image-2.png" alt="gallery img" />
		<div class="flex flex-col pt-8">
			<h2 class="mr-4 skew-x-12 self-end text-5xl font-medium">Gallery</h2>
			<div class="bg-foreground mt-auto flex h-8 w-full flex-row items-center px-4 py-8">
				<h4 class="text-backgroud skew-x-12 text-2xl font-medium">SHOW ALL</h4>
				<img src="icons/triple-chevron-right.svg" alt="Go To" class="ml-auto skew-x-12" />
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
		class="border-backgroud text-backgroud bg-secondary ml-auto -skew-x-12 border px-24 py-2 text-xl font-medium hover:cursor-pointer"
	>
		<p class="skew-x-12">REGISTER NOW</p>
	</button>
</section>
