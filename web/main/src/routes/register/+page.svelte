<script lang="ts">
	import SportCard from '$lib/ui/register/SportCard.svelte';
	import { getSportIdOfSport } from '$lib/utility/sport';
	let { data } = $props();
	console.log(data);
</script>

<main class="flex flex-col items-center gap-y-12 pt-24 pb-48">
	<div class="flex flex-col items-center gap-y-5">
		<div class="title-text text-custom-orange">
			Welcome {data.me?.firstName + ' ' + data.me?.lastName}!
		</div>
		<h2>SELECT A SPORT</h2>
		<p>Select a sport to register the Team</p>
	</div>

	<section class="flex flex-wrap justify-center gap-x-10 gap-y-16 px-32">
		<a href="register/team?sport=0">
			<SportCard
				sport="Athletics"
				currentCount={data.athletics.count}
				totalCount={12}
				maxCount={16}
			/>
		</a>
		<a href="register/team?sport={getSportIdOfSport('Cricket', 1, false)}">
			<SportCard sport="Cricket" currentCount={data.cricket.count} totalCount={12} maxCount={16} />
		</a>
		<a href="register/team?sport={getSportIdOfSport('Football', 1, false)}">
			<SportCard
				sport="Football"
				currentCount={data.football.count}
				totalCount={12}
				maxCount={16}
			/>
		</a>
		<a href="register/team?sport={getSportIdOfSport('Hockey', 1, false)}">
			<SportCard sport="Hockey" currentCount={data.hockey.count} totalCount={12} maxCount={16} />
		</a>
		<a href="register/team?sport={getSportIdOfSport('Volleyball', 1, false)}">
			<SportCard
				sport="Volleyball"
				currentCount={data.volleyball.count}
				totalCount={12}
				maxCount={16}
			/>
		</a>
		<a href="register/team?sport={getSportIdOfSport('Volleyball', 2, false)}">
			<SportCard
				sport="Volleyball"
				extraText={'(W)'}
				currentCount={data.volleyballWomen.count}
				totalCount={12}
				maxCount={16}
			/>
		</a>
	</section>
</main>
