<script lang="ts">
	import { afterNavigate, beforeNavigate, goto } from '$app/navigation';
	import { globals } from '$lib/state.svelte.js';
	import type { Sports } from '$lib/types/sports.js';
	import Loading from '$lib/ui/components/Loading.svelte';
	import SportCard from '$lib/ui/register/SportCard.svelte';
	import { getRegisterableSports, getSportMaxRegistrants } from '$lib/utility/sport';
	let { data } = $props();
	$effect(() => {
		if (data.me?.staff != globals.staff) {
			goto('/register/login');
		}
	});

	beforeNavigate(() => {
		globals.loading = true;
	});
	afterNavigate(() => {
		globals.loading = false;
	});
</script>

<Loading loading={globals.loading} />

<main class="flex flex-col items-center gap-y-12 pt-24 pb-40">
	<div class="flex flex-col items-center gap-y-5">
		<div class="title-text text-custom-orange">
			Welcome {data.me?.firstName + ' ' + data.me?.lastName}!
		</div>
		<h2>SELECT A SPORT</h2>
		<p>
			Select a sport to register the Team {globals.staff
				? 'for Inter IIT Staff Sports Meet'
				: 'for Inter IIT Sports Meet'}
		</p>
	</div>

	<section class="flex flex-wrap justify-center gap-12 px-24 2xl:gap-16 2xl:px-32">
		{#each getRegisterableSports(globals.staff, data.sports!) as sport}
			<a href="register/team?sport={sport.id}">
				<SportCard
					sport={sport.name as Sports}
					extraText={sport.type == 1
						? '(M)'
						: sport.type == 2
							? '(W)'
							: sport.type == -1
								? ''
								: '(MX)'}
					currentCount={(data.playerCountData!.find((val) => val.sportId == sport.id)?.count || 0) +
						(data.playerCountData!.find((val) => val.sportId == sport.id)?.reserveCount || 0) +
						(data.playerCountData!.find((val) => val.sportId == sport.id)?.secondaryCount || 0)}
					totalCount={getSportMaxRegistrants(sport.id)}
					maxCount={globals.staff ? 41 : 60}
				/>
			</a>
		{/each}
	</section>
</main>
