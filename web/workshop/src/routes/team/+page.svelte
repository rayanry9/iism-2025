<script lang="ts"></script>

{#snippet TeamItem(name: string, designation: string, imgSrc: string, phone: string, email: string)}
	<div class="flex flex-col">
		<div class="flex flex-row">
			<div class="relative size-[16rem]">
				<img src={imgSrc} alt="face" class="absolute left-4" />
			</div>
			<div class="mt-auto flex flex-col items-end">
				<p class="text-[1.75rem] font-medium">{name}</p>
				<p class="text-xl">{designation}</p>
				<div
					class="mt-4 -skew-x-[15deg] border border-[#AE9C74] bg-[#E9E4CE] px-4 py-4 text-2xl text-[#AE9C74]"
				>
					<p class="skew-x-12">{phone}</p>
				</div>
			</div>
		</div>

		<div
			class="mt-4 mr-5 -skew-x-[15deg] border border-[#AE9C74] bg-[#E9E4CE] px-6 py-4 text-2xl text-[#AE9C74]"
		>
			<p class="flex skew-x-12 flex-row items-center gap-x-4">
				<span>
					<img src="icons/mail.svg" alt="mail" />
				</span>
				{email}
			</p>
		</div>
	</div>
{/snippet}

{#snippet Header(text: string)}
	<div class="bg-primary w-fit skew-2">
		<div class="text-backgroud -skew-6 bg-black px-24 py-5">
			<p class="skew-4 text-2xl font-medium">{text}</p>
		</div>
	</div>
{/snippet}

<main class="flex flex-col items-center gap-y-32 px-52 pt-32 pb-24">
	{@render Header('STUDENT HEADS')}
	<section class="grid grid-cols-3 gap-4">
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
	<section class="grid grid-cols-3 gap-x-4 gap-y-14">
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
