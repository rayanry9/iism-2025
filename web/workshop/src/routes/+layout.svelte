<script lang="ts">
	import '../app.css';

	let { children } = $props();
</script>

{#snippet NavItem(text: string, href: string)}
	<a {href} class="ml-8">{text.toUpperCase()}</a>
{/snippet}

<nav class="bg-foreground text-backgroud flex flex-row items-center pr-8 pl-12">
	<div class="divide-background/50 flex h-full flex-row divide-x">
		<a href="/">
			<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-9 pr-3" />
		</a>

		<a href="https://iith.ac.in">
			<img src="iith-logo.png" alt="IITH Logo" class="h-8 pl-4" />
		</a>
	</div>
	<div class="ml-auto flex flex-row items-center gap-x-2">
		{@render NavItem('About & Facilities', 'about')}
		{@render NavItem('Gallery', 'gallery')}
		{@render NavItem('team', 'team')}
		<a
			class="bg-primary relative ml-4 flex h-14 -skew-x-12 flex-row items-center px-10"
			href="register"
		>
			<div class="bg-foreground absolute right-1.5 h-full w-1"></div>
			<div class="bg-foreground absolute right-3.5 h-full w-1"></div>
			<p class="skew-x-12">REGISTER</p>
		</a>
	</div>
</nav>

{@render children()}

<footer class="text-backgroud bg-foreground flex flex-col items-center px-52 pt-24 pb-4">
	<div class="mb-20 grid w-full grid-cols-3">
		<section class="grid grid-cols-subgrid">
			<div class="row-span-1 mb-8 flex flex-row items-center">
				<div class="divide-backgroud/70 flex flex-row items-center divide-x">
					<img src="interiit-logo.png" alt="Inter IIT Sports Meet Logo" class="h-9 pr-3" />
					<img src="iith-logo.png" alt="IITH Logo" class="h-8 pl-4" />
				</div>
				<p class="ml-6">IIT HYDERABAD</p>
			</div>
			<div class="row-span-1">
				<h3 class="mb-6 text-[2rem] font-medium">58th INTER IIT<br />SPORTS MEET<br />2025</h3>
				<div class="flex flex-row gap-x-4 *:*:skew-x-12 *:-skew-x-12 *:p-2.5">
					<div class="bg-[#D6E8E6]">
						<img src="icons/linkedin.svg" class="size-5" alt="Linkedin" />
					</div>
					<div class="bg-[#D6E8E6]">
						<img src="icons/instagram.svg" class="size-5" alt="Instagram" />
					</div>
				</div>
			</div>
		</section>

		<section class="grid grid-cols-subgrid">
			<h5 class="font font-semibold">QUICK LINKS</h5>
			<div class="row-span-1 flex flex-col gap-y-3 *:font-medium">
				<p>HOME</p>
				<p>ABOUT & FACILITIES</p>
				<p>GALLERY</p>
				<p>TEAM</p>
				<p class="text-primary">REGISTER</p>
			</div>
		</section>

		<section class="grid grid-cols-subgrid">
			<h5 class="font-semibold">REACH US</h5>
			<div class="grid grid-cols-2">
				<p>Get in Touch -</p>
				<p>SNCC Sports Complex, IIT Hyderabad, Kandi, 522084</p>
				<p>Call -</p>
				<div class="flex flex-col">
					<p>Pritam (Overall Convenor ) - +91 7602790672</p>
					<p>Health Center - +91 7602790672</p>
					<p>Security Control Office - +91 7602790672</p>
				</div>

				<p>Mail -</p>
				<p>interiit.oc@iith.ac.in</p>
			</div>
		</section>
	</div>
	<p class="opacity-50">© Copyright by Inter IIT Sports Meet 2025</p>
</footer>
