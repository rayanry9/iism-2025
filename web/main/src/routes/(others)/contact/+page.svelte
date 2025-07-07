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
	import PalemImg from '$lib/assets/team/palem.webp';
	import GayatriImg from '$lib/assets/team/gayatri.webp';
	import UtkarshImg from '$lib/assets/team/utkarsh.webp';
	import NiharImg from '$lib/assets/team/nihar.webp';
	import EshaaniImg from '$lib/assets/team/eshaani.webp';
	import SmaronImg from '$lib/assets/team/smaron.webp';
	import RohitImg from '$lib/assets/team/rohit.webp';
	import KushImg from '$lib/assets/team/kush.webp';
	import SiyaImg from '$lib/assets/team/siya.webp';
	import HanzalaImg from '$lib/assets/team/hanzala.webp';
	import RayanImg from '$lib/assets/team/rayan.webp';
	import DhruvImg from '$lib/assets/team/dhruv.webp';
	import SheesImg from '$lib/assets/team/shees.webp';
	import VinitImg from '$lib/assets/team/vinit.webp';
</script>

<main class="my-12 flex flex-col items-center gap-y-12 xl:my-20 xl:gap-y-20 2xl:my-24 2xl:gap-y-24">
	<ToggleTabs.Root>
		<ToggleTabs.Item>STUDENT TEAM</ToggleTabs.Item>
		<ToggleTabs.Item>KEY OFFICIALS</ToggleTabs.Item>
	</ToggleTabs.Root>

	<div class="flex w-full flex-col items-center gap-y-16 xl:gap-y-20 2xl:gap-y-24">
		<FlairedTitle>CONVENOR</FlairedTitle>

		<div
			class="3xl:px-32 grid grid-cols-1 gap-14 px-8 lg:grid-cols-2 xl:px-16 2xl:grid-cols-3 2xl:gap-20 2xl:px-24"
		>
			<ContactCard
				imgSrc={pritamImg}
				designation="Overall Convenor"
				phone="+91 7602790672"
				mail="interiit.oc@iith.ac.in"
				name="Pritam Kumar M."
			/>

			<ContactCard
				imgSrc={aryanImg}
				designation="Co-Convenor"
				phone="+91 9650896994"
				mail="interiit.oc@iith.ac.in"
				name="Aryan Jain"
			/>
			<ContactCard
				imgSrc={parthImg}
				designation="Co-Convenor"
				phone="+91 9099781308"
				mail="interiit.oc@iith.ac.in"
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
				mail="ch22btech11025@iith.ac.in"
				name="Nikhil D."
			/>
			<ContactCard
				imgSrc={SaiKumarImg}
				designation="Events Head"
				phone="+91 7396641098"
				mail="ce23btech11021@iith.ac.in"
				name="Sai Kumar R."
			/>

			<ContactCard
				imgSrc={ShivenImg}
				designation="Sponsorship Head"
				phone="+91 7878435233"
				mail="outreach.interiit@iith.ac.in "
				name="Shiven Mathur"
			/>
			<ContactCard
				imgSrc={PalemImg}
				designation="Sponsorship Head"
				phone="+91 6281086630"
				mail="outreach.interiit@iith.ac.in"
				name="Palem Rakesh V."
			/>
			<ContactCard
				imgSrc={GayatriImg}
				designation="Hospitality Head"
				phone="+91 6305430598"
				mail="ep23btech11032 @iith.ac.in"
				name="Gayatri Priya"
			/>
			<ContactCard
				imgSrc={UtkarshImg}
				designation="Hospitality Head"
				phone="+91 8052492889"
				mail="me22btech11055@iith.ac.in"
				name="Utkarsh Dwivedi"
			/>
			<ContactCard
				imgSrc={NiharImg}
				designation="Operations Head"
				phone="+91 7670981506"
				mail="ep22btech11005@iith.ac.in"
				name="Nihar Kartikeye"
			/>
			<ContactCard
				imgSrc={EshaaniImg}
				designation="Design & Creatives Head"
				phone="+91 7829878939"
				mail="bd24bdes11015@iith.ac.in"
				name="Eshaani Gupta"
			/>
			<ContactCard
				imgSrc={SmaronImg}
				designation="Design & Creatives Head"
				phone="+91 7637809156"
				mail="bd23bdes11022@iith.ac.in"
				name="Smaron Boruah"
			/>
			<ContactCard
				imgSrc={RohitImg}
				designation="Medical & Security Head"
				phone="+91 8010410993"
				mail="cc24mtech11002@iith.ac.in"
				name="Rohit Gundeti"
			/>
			<ContactCard
				imgSrc={KushImg}
				designation="Media Head"
				phone="+91 9032066698"
				mail="bd23bdes11011@iith.ac.in "
				name="Kush Upadhyay"
			/>
			<ContactCard
				imgSrc={SiyaImg}
				designation="Media Head"
				phone="+91 8657484442"
				mail="bd23bdes11021@iith.ac.in"
				name="Siya Shah"
			/>
			<ContactCard
				imgSrc={HanzalaImg}
				designation="Transport Head"
				phone="+91 9102003098"
				mail="ce23btech11023@iith.ac.in"
				name="Hanzala Akhter"
			/>
			<ContactCard
				imgSrc={RayanImg}
				designation="Web Head"
				phone="+91 9836025700"
				mail="ma24btech11018@iith.ac.in"
				name="Rayan Halder"
			/>
			<ContactCard
				imgSrc={DhruvImg}
				designation="PR & Web Head"
				phone="+91 8712831015"
				mail="es22btech11012@iith.ac.in"
				name="Dhruv Sharma"
			/>
			<ContactCard
				imgSrc={SheesImg}
				designation="Production Head"
				phone="+91 7081770180"
				mail="me22btech11035@iith.ac.in"
				name="M. Shees"
			/>
			<ContactCard
				imgSrc={VinitImg}
				designation="UX Design - Web & App"
				phone="+91 9766500673"
				mail="bd23bdes11026@iith.ac.in"
				name="Vinit Shimpi"
			/>
		</div>
	</div>
</main>
