<script>
	import FlairedTitle from '$lib/ui/components/FlairedTitle.svelte';
	import { ToggleTabs } from '$lib/ui/components/toggleTabs';
	import ContactCard from '$lib/ui/contact/ContactCard.svelte';

	import pritamImg from '$lib/assets/team/pritam.webp';
	import aryanImg from '$lib/assets/team/aryan.webp';
	import parthImg from '$lib/assets/team/parth.webp';

	import NikhilImg from '$lib/assets/team/nikhil.webp';
	import SaiKumarImg from '$lib/assets/team/sai-kumar.webp';
	import ShivenImg from '$lib/assets/team/shiven.webp';
	import GayatriImg from '$lib/assets/team/gayatri.webp';
	import UtkarshImg from '$lib/assets/team/utkarsh.webp';
	import NiharImg from '$lib/assets/team/nihar.webp';
	import EshaaniImg from '$lib/assets/team/eshaani.webp';
	import ShreevelImg from '$lib/assets/team/shreevel.webp';
	import RohitImg from '$lib/assets/team/rohit.webp';
	import KushImg from '$lib/assets/team/kush.webp';
	import SiyaImg from '$lib/assets/team/siya.webp';
	import HanzalaImg from '$lib/assets/team/hanzala.webp';
	import RayanImg from '$lib/assets/team/rayan.webp';
	import SheesImg from '$lib/assets/team/shees.webp';
	import VinitImg from '$lib/assets/team/vinit.webp';
	import SimarImg from '$lib/assets/team/simar.webp';
	import { globals } from '$lib/state.svelte';

	let team = $state(0);
</script>

<main class="my-12 flex flex-col items-center gap-y-12 xl:my-20 xl:gap-y-20 2xl:my-24 2xl:gap-y-24">
	<ToggleTabs.Root>
		<ToggleTabs.Item
			onclick={() => {
				team = 0;
			}}>CORE TEAM</ToggleTabs.Item
		>
		<ToggleTabs.Item
			onclick={() => {
				team = 1;
			}}>KEY OFFICIALS</ToggleTabs.Item
		>
	</ToggleTabs.Root>
	{#if team == 0}
		<div class="flex w-full flex-col items-center gap-y-16 xl:gap-y-20 2xl:gap-y-24">
			<FlairedTitle>CONVENOR</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={pritamImg}
					designation="Overall Convenor"
					phone="+91 7602790672"
					mail="interiit.convenor@iith.ac.in"
					name="Pritam Kumar M."
				/>

				<ContactCard
					imgSrc={aryanImg}
					designation="Co-Convenor"
					phone="+91 9650896994"
					mail="interiit.convenor@iith.ac.in"
					name="Aryan Jain"
				/>
				<ContactCard
					imgSrc={parthImg}
					designation="Co-Convenor"
					phone="+91 9099781308"
					mail="interiit.convenor@iith.ac.in"
					name="Parth B."
				/>
			</div>
		</div>

		<div
			class="mt-12 flex w-full flex-col items-center gap-y-16 xl:mt-20 xl:gap-y-20 2xl:mt-24 2xl:gap-y-24"
		>
			<FlairedTitle>HEADS</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={NikhilImg}
					designation="Events Head"
					phone="+91 7499816792"
					mail="interiit.oc@iith.ac.in"
					name="Nikhil D."
				/>
				<ContactCard
					imgSrc={SaiKumarImg}
					designation="Events Head"
					phone="+91 7396641098"
					mail="interiit.oc@iith.ac.in"
					name="Sai Kumar R."
				/>
				<ContactCard
					imgSrc={GayatriImg}
					designation="Hospitality Head"
					phone="+91 6305430598"
					mail="interiit.oc@iith.ac.in"
					name="Gayatri Priya"
				/>
				<ContactCard
					imgSrc={UtkarshImg}
					designation="Hospitality Head"
					phone="+91 8052492889"
					mail="interiit.oc@iith.ac.in"
					name="Utkarsh Dwivedi"
				/>
				<ContactCard
					imgSrc={SheesImg}
					designation="Production Head"
					phone="+91 7081770180"
					mail="interiit.oc@iith.ac.in"
					name="M. Shees"
				/>
				<ContactCard
					imgSrc={NiharImg}
					designation="Operations Head"
					phone="+91 7670981506"
					mail="interiit.oc@iith.ac.in"
					name="Nihar Kartikeye"
				/>
				<ContactCard
					imgSrc={RohitImg}
					designation="Medical & Security Head"
					phone="+91 8010410993"
					mail="interiit.oc@iith.ac.in"
					name="Rohit Gundeti"
				/>
				<ContactCard
					imgSrc={HanzalaImg}
					designation="Transport Head"
					phone="+91 9102003098"
					mail="interiit.oc@iith.ac.in"
					name="Hanzala Akhter"
				/>
				<ContactCard
					imgSrc={ShivenImg}
					designation="Sponsorship Head"
					phone="+91 7878435233"
					mail="outreach.interiit@iith.ac.in "
					name="Shiven Mathur"
				/>
				<ContactCard
					imgSrc={EshaaniImg}
					designation="Design & Creatives Head"
					phone="+91 7829878939"
					mail="interiit.oc@iith.ac.in"
					name="Eshaani Gupta"
				/>
				<ContactCard
					imgSrc={ShreevelImg}
					designation="Design & Creatives Head"
					phone="+91 9344702682"
					mail="interiit.oc@iith.ac.in"
					name="KJ Shreevel"
				/>
				<ContactCard
					imgSrc={KushImg}
					designation="Media Head"
					phone="+91 9032066698"
					mail="interiit.oc@iith.ac.in"
					name="Kush Upadhyay"
				/>
				<ContactCard
					imgSrc={SiyaImg}
					designation="Media Head"
					phone="+91 8657484442"
					mail="interiit.oc@iith.ac.in"
					name="Siya Shah"
				/>
				<ContactCard
					imgSrc={SimarImg}
					designation="Media & PR Head"
					phone="+91 9422584709"
					mail="interiit.oc@iith.ac.in"
					name="Simar Bajwa"
				/>
				<ContactCard
					imgSrc={RayanImg}
					designation="Web Head"
					phone="+91 9836025700"
					mail="interiit.oc@iith.ac.in"
					name="Rayan Halder"
				/>
				<ContactCard
					imgSrc={VinitImg}
					designation="UX Design - Web & App"
					phone="+91 9766500673"
					mail="interiit.oc@iith.ac.in"
					name="Vinit Shimpi"
				/>
			</div>
		</div>
	{:else if team == 1 && !globals.staff}
		<div class="flex w-full flex-col items-center gap-y-16 xl:gap-y-20 2xl:gap-y-24">
			<FlairedTitle>CONVENORS</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Chairperson"
					phone="Dean (Students)"
					mail=""
					name="Prof. Prasanth Kumar R"
				/>

				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Convenor"
					phone="FiC (Sports)"
					mail=""
					name="Dr. Himanshu Joshi"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Co-Convenor"
					phone="HoS (F&A)"
					mail=""
					name="Mr. Jagadeshwarar Rao B"
				/>
			</div>
		</div>

		<div
			class="mt-12 flex w-full flex-col items-center gap-y-16 xl:mt-20 xl:gap-y-20 2xl:mt-24 2xl:gap-y-24"
		>
			<FlairedTitle>Organizing Secrataries</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Organizing Secratary"
					phone="Sports Officer"
					mail=""
					name="Mr. Vikram Pratap Singh"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Organizing Secratary"
					phone="Sports Officer"
					mail=""
					name="Mr. Hardeep"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/girl'}
					designation="Organizing Secratary"
					phone="Sports Officer"
					mail=""
					name="Mrs. Ruchi Yadav"
				/>
			</div>
		</div>
	{:else if globals.staff && team == 1}
		<div class="flex w-full flex-col items-center gap-y-16 xl:gap-y-20 2xl:gap-y-24">
			<FlairedTitle>CONVENORS</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Chairperson"
					phone="Dean (Admin)"
					mail=""
					name="Prof. Prem Pal"
				/>

				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Convenor"
					phone="FiC (Sports)"
					mail=""
					name="Dr. Himanshu Joshi"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Co-Convenor"
					phone="Sr. AR(SRC)"
					mail=""
					name="Mr. N Srisailam"
				/>
			</div>
		</div>

		<div
			class="mt-12 flex w-full flex-col items-center gap-y-16 xl:mt-20 xl:gap-y-20 2xl:mt-24 2xl:gap-y-24"
		>
			<FlairedTitle>Organizing Secrataries</FlairedTitle>

			<div
				class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
			>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Organizing Secratary"
					phone="Sports Officer"
					mail=""
					name="Mr. Md. Akbar"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/boy'}
					designation="Organizing Secratary"
					phone="Sports Officer"
					mail=""
					name="Mr. Baba Aditya Varma"
				/>
				<ContactCard
					imgSrc={'https://avatar.iran.liara.run/public/girl'}
					designation="Organizing Secratary"
					phone="PTI"
					mail=""
					name="Mrs. Purva Kherkar"
				/>
			</div>
		</div>
	{/if}
</main>
