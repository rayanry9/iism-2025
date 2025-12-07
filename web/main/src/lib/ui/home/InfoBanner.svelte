<script lang="ts">
	import patternImg from '$lib/assets/pattern.webp';
	import mainImg from '$lib/assets/legacy-desktop.webp';
	import mobileImg from '$lib/assets/legacy-mobile.webp';
</script>

<section class="relative mt-16 md:mt-40">
	<img
		src={mainImg}
		alt="stylised img"
		class="absolute right-0 bottom-[5%] z-30 hidden w-[65vw] xl:block 2xl:w-[75vw]"
	/>
	<div class="bg-custom-blue blue-bg absolute -z-30 h-full w-full overflow-hidden">
		<div
			class="absolute h-1/2 w-full -translate-x-12 -skew-x-8 skew-y-8 opacity-20"
			style="background-size: 8.5rem;background-image: url({patternImg});"
		></div>

		<div
			class="mt-12 ml-4 flex flex-col text-white md:mt-14 xl:ml-20 xl:gap-y-4 2xl:mt-16 2xl:ml-28"
		>
			<p class="relative hidden xl:block">About</p>
			<h1>THE <br class="sm:hidden" />LEGACY</h1>
		</div>
	</div>
	<div class="bg-custom-yellow yellow-bg absolute h-full w-full"></div>
	<div
		class="bg-custom-dark-blue dark-blue-bg z-40 flex flex-col gap-y-6 px-4 pt-32 pb-24 text-white xl:pt-64 xl:pb-32 xl:pl-20 xl:*:w-[35rem] 2xl:px-28 2xl:pt-80 2xl:pb-40"
	>
		<img
			src={mobileImg}
			alt="stylised img"
			class=" z-30 sm:right-0 sm:left-0 sm:mx-auto sm:w-[50%] xl:hidden"
		/>
		<p>
			Started in 1961, the Inter IIT Sports Meet has an illustrious legacy as the longest-running
			inter-collegiate sports event, showcasing the prowess of India's top engineering institutions.
		</p>
		<p>
			With unwavering dedication and a commitment to excellence, this event brings together over
			4,000 talented athletes from all 23 IITs, competing in 13 diverse sports, all vying for the
			coveted General Championship Trophy.
		</p>
		<p>
			The Inter IIT Sports Meet is an eagerly anticipated annual sports tournament of the Indian
			Institutes of Technology. Typically organized in December, the Aquatics events are held
			separately in October, making it a highlight on the academic calendar.
		</p>
		<p>
			Preparation for the inter IITs starts way before the event with hundreds of students involved
			in the success of the event.
		</p>
	</div>
</section>

<style>
	.blue-bg {
		clip-path: polygon(0% 0%, 100% 10%, 100% 90%, 0% 90%);
		@media (width >= 80rem) {
			clip-path: polygon(0% 0%, 100% 15%, 100% 90%, 0% 90%);
		}
		@media (width >= 96rem) {
			clip-path: polygon(0% 0%, 100% 30%, 100% 90%, 0% 90%);
		}
	}
	.yellow-bg {
		clip-path: polygon(0% 15%, 100% 5%, 100% 98%, 0% 100%);
		@media (width >= 80rem) {
			clip-path: polygon(0% 25%, 100% 7.5%, 100% 95%, 0% 100%);
		}
		@media (width >= 96rem) {
			clip-path: polygon(0% 25%, 100% 5%, 100% 97.5%, 0% 100%);
		}
	}

	.dark-blue-bg {
		clip-path: polygon(0% 15%, 100% 7.5%, 100% 97.5%, 0% 97.5%);
		@media (width >= 80rem) {
			clip-path: polygon(0% 25%, 100% 10%, 100% 95%, 0% 95%);
		}
	}
</style>
