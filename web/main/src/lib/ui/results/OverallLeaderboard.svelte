<script lang="ts">
	import type { GetAllInstitutesResponse } from '$lib/types/insitutes';
	import { ToggleTabs } from '$lib/ui/components/toggleTabs';
	import { onMount } from 'svelte';
	import rank1 from '$lib/assets/rank1.webp';
	import rank2 from '$lib/assets/rank2.webp';
	import rank3 from '$lib/assets/rank3.webp';
	import { innerWidth } from 'svelte/reactivity/window';
	let {
		institutes,
		leaderboardData
	}: { institutes: GetAllInstitutesResponse[]; leaderboardData: GetLeaderBoardDataResponse[] } =
		$props();

	let overall = $state(true);
	onMount(() => {
		overall = true;
	});
	let sortedPoints = $derived.by(() => {
		if (overall) {
			return institutes
				.map((val) => {
					return {
						name: val.name,
						instituteId: val.id,
						points:
							leaderboardData.find((l) => l.instituteId == val.id) != undefined
								? leaderboardData
										.filter((l) => l.instituteId == val.id)
										.reduce((prev, curr) => {
											const copy = { ...curr };
											copy.points += prev.points;
											return copy;
										}).points
								: 0
					};
				})
				.toSorted((a, b) => {
					return b.points - a.points;
				});
		} else {
			return institutes
				.map((val) => {
					return {
						name: val.name,
						instituteId: val.id,
						points:
							leaderboardData.find((l) => l.instituteId == val.id && l.hostingIIT == 10) !=
							undefined
								? leaderboardData
										.filter((l) => l.instituteId == val.id && l.hostingIIT == 10)
										.reduce((prev, curr) => {
											const copy = { ...curr };
											copy.points += prev.points;
											return copy;
										}).points
								: 0
					};
				})
				.toSorted((a, b) => {
					return b.points - a.points;
				});
		}
	});
</script>

<main class="w-full">
	<div class="flex w-full flex-col gap-y-8 max-xl:items-center max-xl:justify-center">
		<div class="flex flex-col gap-2 xl:flex-row xl:items-center">
			<h2>OVERALL LEADERBOARD</h2>
			<ToggleTabs.Root class="*:first:bg-custom-orange! ml-auto">
				<ToggleTabs.Item
					class="py-2!"
					onclick={() => {
						overall = true;
					}}>ALL IITS</ToggleTabs.Item
				>
				<ToggleTabs.Item
					class="py-2!"
					onclick={() => {
						overall = false;
					}}>IIT HYDERABAD</ToggleTabs.Item
				>
			</ToggleTabs.Root>
		</div>

		<div class="flex w-full gap-4 max-xl:px-8">
			<table class="button-text w-full table-auto border-separate border-spacing-y-1">
				<thead class="bg-custom-light-blue text-white">
					<tr class="*:py-2.5 *:not-first:border-l *:not-first:border-l-white">
						<th>RANK</th>
						<th class="">TEAM</th>
						<th>POINTS</th>
					</tr>
				</thead>

				<tbody>
					{#each (innerWidth.current ?? 0) < 1280 ? sortedPoints : sortedPoints.slice(0, 12) as insti, idx (insti.instituteId)}
						<tr class="button-text font-semibold *:py-2 *:text-center">
							<td
								class="border-custom-gray z-1 border {idx == 0
									? 'bg-[#EFDA82] '
									: idx == 1
										? 'bg-custom-gray'
										: idx == 2
											? 'bg-[#EBC9A3]'
											: ''}"
							>
								{#if idx <= 2}
									<div class="flex h-full w-full items-center justify-center">
										<div
											class="relative z-10 flex items-center justify-center rounded-full p-2.5 {idx ==
											0
												? 'bg-[#EFDA82] text-[#EFDA82]'
												: idx == 1
													? 'bg-custom-gray '
													: idx == 2
														? 'bg-[#EBC9A3] text-[#EBC9A3]'
														: ''}"
										>
											<img
												src={idx == 0 ? rank1 : idx == 1 ? rank2 : rank3}
												alt="rank 1"
												class="absolute min-h-full"
											/>
											<div
												class="z-20 -mb-1 leading-0 {idx == 0
													? 'text-[#7D5819] '
													: idx == 1
														? 'text-[#828282]'
														: idx == 2
															? 'text-[#884A2B]'
															: ''}
									"
											>
												{idx + 1}
											</div>
										</div>
									</div>
								{:else}
									{idx + 1}
								{/if}
							</td>
							<td class="border-custom-gray border">IIT {insti.name}</td>
							<td class="border-custom-gray border">{insti.points}</td>
						</tr>
					{/each}
				</tbody>
			</table>

			<table
				class="button-text hidden h-fit table-auto border-separate border-spacing-y-1 xl:table xl:w-full"
			>
				<thead class="bg-custom-light-blue text-white">
					<tr class="*:py-2.5 *:not-first:border-l *:not-first:border-l-white">
						<th>RANK</th>
						<th class="">TEAM</th>
						<th>POINTS</th>
					</tr>
				</thead>

				<tbody>
					{#each sortedPoints.slice(12, 23) as insti, idx (insti.instituteId)}
						<tr class="button-text font-semibold *:py-2 *:text-center">
							<td class="border-custom-gray border">
								{idx + 13}
							</td>
							<td class="border-custom-gray border">IIT {insti.name}</td>
							<td class="border-custom-gray border">{insti.points}</td>
						</tr>
					{/each}
				</tbody>
			</table>
		</div>
	</div>
</main>
