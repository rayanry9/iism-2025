<script lang="ts"></script>

{#snippet TeamItem(name: string, designation: string, imgSrc: string, phone: string, email: string)}
	<div class="flex flex-col">
		<div class="flex flex-row">
			<div class="relative size-[10rem] sm:size-[16rem]">
				<img src={imgSrc} alt="face" class="absolute bottom-0 left-4" />
			</div>
			<div class="mt-auto ml-3 flex flex-col items-end sm:ml-0">
				<p class="text-xl font-semibold sm:text-[1.75rem]">{name}</p>
				<p class="text-sm sm:text-xl">{designation}</p>
				<div
					class="mt-4 flex w-[10rem] -skew-x-[15deg] flex-col items-center border border-[#AE9C74] bg-[#E9E4CE] px-2 py-2 text-base text-[#AE9C74] sm:w-auto sm:px-4 sm:py-4 sm:text-2xl"
				>
					<p class="skew-x-12">{phone}</p>
				</div>
			</div>
		</div>

		<div
			class="mt-2 mr-4 ml-1 -skew-x-[15deg] border border-[#AE9C74] bg-[#E9E4CE] px-4 py-2 text-base text-[#AE9C74] sm:mt-4 sm:mr-5 sm:ml-0 sm:px-6 sm:py-4 sm:text-2xl"
		>
			<p class="flex skew-x-12 flex-row items-center gap-x-2 sm:gap-x-4">
				<span>
					<img src="icons/mail.svg" class="size-4 sm:size-8" alt="mail" />
				</span>
				{email}
			</p>
		</div>
	</div>
{/snippet}

{#snippet Header(text: string)}
	<div class="bg-primary w-fit skew-2">
		<div class="text-background -skew-6 bg-black px-16 py-4 sm:px-24 sm:py-5">
			<p class="skew-4 text-xl font-medium sm:text-2xl">{text}</p>
		</div>
	</div>
{/snippet}

<main class="flex flex-col items-center gap-y-12 px-8 pt-16 pb-24 sm:gap-y-32 sm:px-52 sm:pt-32">
	{@render Header('STUDENT HEADS')}
	<section class="grid grid-cols-1 gap-4 sm:grid-cols-3">
		{@render TeamItem(
			'Pritam Kumar M.',
			'Overall Convenor',
			'team/pritam.png',
			'+91 7602790672',
			'interiit.oc@iith.ac.in'
		)}
		{@render TeamItem(
			'Aryan Jain',
			'Co-Convenor',
			'team/aryan.png',
			'director@iith.ac.in',
			'interiit.oc@iith.ac.in'
		)}
		{@render TeamItem(
			'Parth B.',
			'Co-Convenor',
			'team/parth.png',
			'+91 9650896994',
			'interiit.oc@iith.ac.in'
		)}
	</section>

	{@render Header('CORE TEAM')}
	<section class="grid grid-cols-1 gap-x-4 gap-y-8 sm:grid-cols-3 sm:gap-y-14">
		{@render TeamItem(
			'Shiven Mathur',
			'Sponsorship Head',
			'team/shiven.png',
			'+91 7878435233',
			'outreach.interiit@iith.ac.in '
		)}
		{@render TeamItem(
			'Palem Rakesh V.',
			'Sponsorship Head',
			'team/palem.png',
			'+91 6281086630',
			'outreach.interiit@iith.ac.in '
		)}
		{@render TeamItem(
			'Sai Kumar R.',
			'Events Head',
			'team/sai-kumar.png',
			'+91 7396641098',
			'ce23btech11021@iith.ac.in'
		)}

		{@render TeamItem(
			'Nikhil Deshmukh',
			'Events Head',
			'team/nikhil.png',
			'+91 7499816792',
			'ch22btech11025@iith.ac.in'
		)}
		{@render TeamItem(
			'Kush Upadhyay',
			'Media Head',
			'team/kush.png',
			'+91  9032066698',
			'bd23bdes11011@iith.ac.in '
		)}
		{@render TeamItem(
			'Siya Shah',
			'Media Head',
			'team/siya.png',
			'+91 8657484442',
			'bd23bdes11021@iith.ac.in'
		)}

		{@render TeamItem(
			'Smaron Boruah',
			'Design & Creatives Head',
			'team/smaron.png',
			'+91 7637809156',
			'bd23bdes11022@iith.ac.in'
		)}
		{@render TeamItem(
			'Eshaani Gupta',
			'Design & Creatives Head',
			'team/eshaani.png',
			'+91 7829878939',
			'bd24bdes11015@iith.ac.in'
		)}
		{@render TeamItem(
			'Nihar Kartikeya',
			'Operations Head',
			'team/nihar.png',
			'+91 7670981506',
			'ep22btech11005@iith.ac.in'
		)}

		{@render TeamItem(
			'Rohit Gundeti',
			'Medical & Security Head',
			'team/rohit.png',
			'+91 8010410993',
			'cc24mtech11002@iith.ac.in'
		)}
		{@render TeamItem(
			'Gayatri Priya',
			'Hospitality Head',
			'team/gayatri.png',
			'+91 6305430598',
			'ep23btech11032@iith.ac.in'
		)}
		{@render TeamItem(
			'Utkarsh Dwivedi',
			'Hospitality Head',
			'team/gayatri.png',
			'+91 8052492889',
			'me22btech11055@iith.ac.in'
		)}

		{@render TeamItem(
			'Hanzala Akhter',
			'Transport Head',
			'team/hanzala.png',
			'+91 9102003098',
			'ce23btech11023@iith.ac.in'
		)}
		{@render TeamItem(
			'Rayan Halder',
			'Web Head',
			'team/rayan.png',
			'+91 9836025700',
			'ma24btech11018@iith.ac.in'
		)}
		{@render TeamItem(
			'Dhruv Sharma',
			'PR & Web Head',
			'team/dhruv.png',
			'+91 8712831015',
			'es22btech11012@iith.ac.in'
		)}

		{@render TeamItem(
			'M. Shees',
			'Production Head',
			'team/shees.png',
			'+91 7081770180',
			'me22btech11035@iith.ac.in'
		)}
		{@render TeamItem(
			'Vinit Shimpi',
			'UX Design - Web & App',
			'team/vinit.png',
			'+91 9766500673',
			'bd23bdes11026@iith.ac.in'
		)}
	</section>
</main>
