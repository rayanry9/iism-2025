<script lang="ts">
	import { registerWebsocketConnection } from '$lib/api/websocket';
	import { onDestroy, onMount } from 'svelte';
	import iismLogo from '$lib/assets/iism-logo.webp';
	import type { PageProps } from './$types';
	import PoolCard from '$lib/ui/PoolCard.svelte';
	import CoinDeciding from '$lib/ui/CoinDeciding.svelte';
	import type { IITNames } from '$lib/types/other';

	let { data, params }: PageProps = $props();

	let statefulPoolTeamData = $state(data.poolTeams);
	let sportId = $state<number>(parseInt(params.sport));
	let upcomingPoolTeamId = $state<number>(-1);
	let lastUpcomingPoolTeamId = $state<number>(-1);

	let conn: (() => void) | undefined;

	onMount(() => {
		conn?.();
		conn = registerWebsocketConnection((data) => {
			statefulPoolTeamData.map((poolTeam) => {
				if (poolTeam.id == data.poolTeamId) {
					poolTeam.instituteId = data.instituteId;
				}
				return poolTeam;
			});

			lastUpcomingPoolTeamId = upcomingPoolTeamId;
			if (data.upcoming) {
				upcomingPoolTeamId = data.poolTeamId;
			} else {
				upcomingPoolTeamId = -1;
			}
		});
	});

	onDestroy(() => {
		conn?.();
	});
</script>

<svelte:head></svelte:head>

<div class="relative flex h-screen flex-col bg-custom-dark-blue text-white *:px-32">
	<div class="absolute top-12 flex h-fit w-full grow">
		<img src={iismLogo} alt="iism logo" class="h-24" />
		<div class="ml-auto">
			<h2 class="">{data.sports.find((val) => val.id == sportId)?.name}</h2>
		</div>
	</div>

	<div class="mt-auto flex flex-col items-center gap-y-10 self-center justify-self-end pb-32">
		<h2 class="">POOL DRAW</h2>

		<div class="grid grid-flow-row grid-cols-4 gap-8 *:h-fit">
			{#each data.pools.filter((pool) => pool.sportId == sportId) as pool}
				<PoolCard
					data={{
						PoolName: pool.name,
						Items: statefulPoolTeamData
							.filter((poolTeam) => poolTeam.poolId == pool.id)
							.sort((a, b) => a.tempName.localeCompare(b.tempName))
							.map((poolTeam) => {
								return {
									PoolTeamId: poolTeam.id,
									PoolTeamTempName: poolTeam.tempName,
									Upcoming: upcomingPoolTeamId == poolTeam.id,
									InstituteName:
										poolTeam.instituteId == null
											? undefined
											: data.institutes.find((val) => val.id == poolTeam.instituteId)?.name
								};
							})
					}}
				/>
			{/each}
		</div>

		{#if data.pools.filter((pool) => pool.sportId == sportId).length == 4}
			<div class="h-[4rem] w-4"></div>
		{/if}

		<CoinDeciding
			poolName={data.pools.find(
				(val) => val.id == data.poolTeams.find((team) => team.id == upcomingPoolTeamId)?.poolId
			)?.name ??
				data.pools.find(
					(val) =>
						val.id == data.poolTeams.find((team) => team.id == lastUpcomingPoolTeamId)?.poolId
				)?.name ??
				'X'}
			poolTeamTempName={data.poolTeams.find((val) => val.id == upcomingPoolTeamId)?.tempName ??
				data.poolTeams.find((val) => val.id == lastUpcomingPoolTeamId)?.tempName ??
				'X'}
			iit={data.institutes.find(
				(i) =>
					i.id == statefulPoolTeamData.find((val) => val.id == lastUpcomingPoolTeamId)?.instituteId
			)?.name as IITNames}
		/>
	</div>
</div>
