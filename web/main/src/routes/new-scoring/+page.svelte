<script lang="ts">
	import { PUBLIC_API_URL } from '$env/static/public';
	import type { GetAllPoolMatchesResponse } from '$lib/types/poolMatches';
	import type { GetAllSportsResponse, Sports } from '$lib/types/sports';
	import DaySelector from '$lib/ui/common/DaySelector.svelte';
	import {
		getRegisterableSports,
		getSportFromSportId,
		getSportIdOfSport,
		getSportsAll
	} from '$lib/utility/sport';
	import { onMount } from 'svelte';

	let { data } = $props();
	let showOnlyLiveMatches = $state<boolean>(false);
	let selectedSport = $state<GetAllSportsResponse>();
	let currentDate = $state<Date>(new Date(2025, 11, new Date().getDate()));
	let poolMatchesData = $state<GetAllPoolMatchesResponse[]>([]);
	onMount(() => {
		fetch(PUBLIC_API_URL + '/get-all-pool-matches').then((val) => {
			val.json().then((d) => {
				poolMatchesData = d as GetAllPoolMatchesResponse[];
				console.log(d);
			});
		});
	});

	let filteredMatches = $derived(
		poolMatchesData.length
			? poolMatchesData.filter((e) => {
					return (
						new Date(e.startTime).getDate() == currentDate.getDate() &&
						e.sportId == selectedSport?.id &&
						(!showOnlyLiveMatches || e.status == 2)
					);
				})
			: []
	);

	let selectedMatch = $state<GetAllPoolMatchesResponse>();
	let selectedStatus = $derived(selectedMatch?.status.toString() ?? '0');

	let selectedSet1 = $state(0);
	let givenScore1 = $derived(selectedMatch?.team1Score[selectedSet1]);
	let updatingScore1 = $state(false);
	let selectedSet2 = $state(0);
	let givenScore2 = $derived(selectedMatch?.team2Score[selectedSet2]);
	let updatingScore2 = $state(false);

	let givenWickets1 = $derived(selectedMatch?.team1Wickets);
	let updatingWickets1 = $state(false);
	let givenBalls1 = $derived(selectedMatch?.team1Balls);
	let updatingBalls1 = $state(false);
	let givenWickets2 = $derived(selectedMatch?.team2Wickets);
	let updatingWickets2 = $state(false);
	let givenBalls2 = $derived(selectedMatch?.team2Balls);
	let updatingBalls2 = $state(false);

	let givenLiveLink = $derived(selectedMatch?.liveStreamLink);
	let updatingLiveLink = $state(false);

	function updatePoolMatchDataAfterUpdate(data: GetAllPoolMatchesResponse) {
		let idx = poolMatchesData.findIndex((p) => p.id == selectedMatch!.id);
		let tempSelectedSet1 = selectedSet1;
		let tempSelectedSet2 = selectedSet2;

		poolMatchesData[idx] = data;
		selectedMatch = undefined;
		selectedSet1 = -1;
		selectedSet2 = -1;
		selectedMatch = poolMatchesData[idx];
		selectedSet1 = tempSelectedSet1;
		selectedSet2 = tempSelectedSet2;
	}

	function poolMatchStatusChange(status: string) {
		const formData = new FormData();
		formData.append('id', selectedMatch!.id.toString());
		formData.append('status', status);
		fetch(PUBLIC_API_URL + '/update-pool-match', {
			method: 'POST',
			credentials: 'include',
			body: formData
		})
			.then((res) => {
				if (res.status == 200) {
					res.json().then((val) => {
						updatePoolMatchDataAfterUpdate(val);
					});
				} else {
					res.json().then((val) => {
						alert(JSON.stringify(val));
					});
				}
			})
			.catch((e) => {
				alert(e);
			})
			.finally(() => {
				selectedStatus = selectedMatch?.status.toString() ?? '0';
			});
	}

	function poolMatchScoreUpdate(team: number) {
		updatingScore1 = team == 1;
		updatingScore2 = team == 2;
		fetch(PUBLIC_API_URL + '/update-pool-match', {
			method: 'POST',
			credentials: 'include',
			headers: [['Content-Type', 'application/json']],
			body: JSON.stringify(
				team == 1
					? {
							id: selectedMatch!.id,
							team1Score: selectedMatch!.team1Score.map((v, idx) => {
								if (idx == selectedSet1) {
									return givenScore1;
								}
								return v;
							})
						}
					: {
							id: selectedMatch!.id,
							team2Score: selectedMatch!.team2Score.map((v, idx) => {
								if (idx == selectedSet2) {
									return givenScore2;
								}
								return v;
							})
						}
			)
		})
			.then((res) => {
				if (res.status == 200) {
					res.json().then((val) => {
						updatePoolMatchDataAfterUpdate(val);
					});
				} else {
					res.json().then((val) => {
						alert(JSON.stringify(val));
					});
				}
			})
			.catch((e) => {
				alert(e);
			})
			.finally(() => {
				updatingScore1 = false;
				updatingScore2 = false;
			});
	}

	function poolMatchBallsUpdate(team: number) {
		updatingBalls1 = team == 1;
		updatingBalls2 = team == 2;
		fetch(PUBLIC_API_URL + '/update-pool-match', {
			method: 'POST',
			credentials: 'include',
			headers: [['Content-Type', 'application/json']],
			body: JSON.stringify(
				team == 1
					? {
							id: selectedMatch!.id,
							team1Balls: givenBalls1
						}
					: {
							id: selectedMatch!.id,
							team2Balls: givenBalls2
						}
			)
		})
			.then((res) => {
				if (res.status == 200) {
					res.json().then((val) => {
						updatePoolMatchDataAfterUpdate(val);
					});
				} else {
					res.json().then((val) => {
						alert(JSON.stringify(val));
					});
				}
			})
			.catch((e) => {
				alert(e);
			})
			.finally(() => {
				updatingBalls1 = false;
				updatingBalls2 = false;
			});
	}

	function poolMatchWicketsUpdate(team: number) {
		updatingWickets1 = team == 1;
		updatingWickets2 = team == 2;
		fetch(PUBLIC_API_URL + '/update-pool-match', {
			method: 'POST',
			credentials: 'include',
			headers: [['Content-Type', 'application/json']],
			body: JSON.stringify(
				team == 1
					? {
							id: selectedMatch!.id,
							team1Wickets: givenWickets1
						}
					: {
							id: selectedMatch!.id,
							team2Wickets: givenWickets2
						}
			)
		})
			.then((res) => {
				if (res.status == 200) {
					res.json().then((val) => {
						updatePoolMatchDataAfterUpdate(val);
					});
				} else {
					res.json().then((val) => {
						alert(JSON.stringify(val));
					});
				}
			})
			.catch((e) => {
				alert(e);
			})
			.finally(() => {
				updatingWickets1 = false;
				updatingWickets2 = false;
			});
	}

	function poolMatchLiveLinkUpdate() {
		updatingLiveLink = true;
		fetch(PUBLIC_API_URL + '/update-pool-match', {
			method: 'POST',
			credentials: 'include',
			headers: [['Content-Type', 'application/json']],
			body: JSON.stringify({
				id: selectedMatch!.id,
				liveStreamLink: givenLiveLink
			})
		})
			.then((res) => {
				if (res.status == 200) {
					res.json().then((val) => {
						updatePoolMatchDataAfterUpdate(val);
					});
				} else {
					res.json().then((val) => {
						alert(JSON.stringify(val));
					});
				}
			})
			.catch((e) => {
				alert(e);
			})
			.finally(() => {
				updatingLiveLink = false;
			});
	}
</script>

<section class="p-8">
	<h2 class="mb-4">Pool Matches</h2>

	<DaySelector bind:currentDate />

	<label class="mt-4 flex items-center gap-4">
		Show Live Matches Only
		<input
			type="checkbox"
			bind:checked={
				() => showOnlyLiveMatches,
				(val) => {
					showOnlyLiveMatches = val;
				}
			}
		/>
	</label>
	<label class="flex items-center gap-4">
		Select Sport
		<select bind:value={selectedSport} class="bg-gray my-4 border p-2">
			{#each getRegisterableSports(data.me?.staff ?? false, data.allSports).filter((s) => s.id > 0) as sport}
				<option value={sport}
					>{sport.name}
					{sport.type == 2 || sport.type == 5 || sport.type == 8
						? 'Women'
						: sport.type == 9
							? 'Mixed'
							: 'Men'}</option
				>
			{/each}
		</select>
	</label>

	<label class="flex flex-col">
		Match <select
			bind:value={
				() => selectedMatch,
				(val) => {
					selectedStatus = val?.status.toString() ?? '1';
					selectedMatch = val;
				}
			}
			class="border bg-gray-50 p-2"
		>
			{#each filteredMatches as match}
				<option value={match}
					>{match.id}
					{match.matchName}
					{data.institutes.find((i) => i.id == match.team1Id)?.name} VS {data.institutes.find(
						(i) => i.id == match.team2Id
					)?.name}</option
				>
			{/each}
		</select>
	</label>

	<div class="px-2 py-5">
		Status
		<fieldset class="flex gap-x-4">
			<label>
				Pending
				<input
					type="radio"
					value="1"
					bind:group={selectedStatus}
					name="status"
					onchangecapture={() => {
						poolMatchStatusChange('1');
					}}
				/>
			</label>
			<label>
				Live
				<input
					type="radio"
					bind:group={selectedStatus}
					value="2"
					name="status"
					onchangecapture={() => {
						poolMatchStatusChange('2');
					}}
				/>
			</label>
			<label>
				Done
				<input
					type="radio"
					bind:group={selectedStatus}
					value="3"
					name="status"
					onchangecapture={() => {
						poolMatchStatusChange('3');
					}}
				/>
			</label>
		</fieldset>
	</div>

	{#if selectedMatch}
		<div class="m-4 flex flex-col gap-y-2 p-2">
			<h3 class="text-xl font-bold">
				{data.institutes.find((i) => i.id == selectedMatch!.team1Id)?.name}
			</h3>

			<div class="border p-2">
				{#if getSportFromSportId(selectedSport!.id) == 'Volleyball'}
					<div class="flex gap-x-4">
						<label>Set 1 <input type="radio" bind:group={selectedSet1} value={0} /></label>
						<label>Set 2 <input type="radio" bind:group={selectedSet1} value={1} /></label>
						<label>Set 3 <input type="radio" bind:group={selectedSet1} value={2} /></label>
						<label>Set 4 <input type="radio" bind:group={selectedSet1} value={3} /></label>
						<label>Set 5 <input type="radio" bind:group={selectedSet1} value={4} /></label>
					</div>
				{/if}

				<lable>
					Score <input bind:value={givenScore1} type="number" class="bg-gray my-4 border p-2" />
				</lable>

				<button
					disabled={updatingScore1}
					onclick={() => {
						poolMatchScoreUpdate(1);
					}}
					class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
				>
			</div>

			{#if getSportFromSportId(selectedSport!.id) == 'Cricket'}
				<div class="border p-2">
					<label>
						Balls <input
							bind:value={givenBalls1}
							type="number"
							class="bg-gray my-4 border p-2"
						/></label
					>
					<button
						disabled={updatingBalls1}
						onclick={() => {
							poolMatchBallsUpdate(1);
						}}
						class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
					>
				</div>

				<div class="border p-2">
					<label>
						Wickets <input
							bind:value={givenWickets1}
							type="number"
							class="bg-gray my-4 border p-2"
						/></label
					>
					<button
						disabled={updatingWickets1}
						onclick={() => {
							poolMatchWicketsUpdate(1);
						}}
						class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
					>
				</div>
			{/if}
		</div>

		<div class="m-4 flex flex-col gap-y-2 p-2">
			<h3 class="text-xl font-bold">
				{data.institutes.find((i) => i.id == selectedMatch!.team2Id)?.name}
			</h3>

			<div class="border p-2">
				{#if getSportFromSportId(selectedSport!.id) == 'Volleyball'}
					<div class="flex gap-x-4">
						<label>Set 1 <input type="radio" bind:group={selectedSet2} value={0} /></label>
						<label>Set 2 <input type="radio" bind:group={selectedSet2} value={1} /></label>
						<label>Set 3 <input type="radio" bind:group={selectedSet2} value={2} /></label>
						<label>Set 4 <input type="radio" bind:group={selectedSet2} value={3} /></label>
						<label>Set 5 <input type="radio" bind:group={selectedSet2} value={4} /></label>
					</div>
				{/if}

				<lable>
					Score <input bind:value={givenScore2} type="number" class="bg-gray my-4 border p-2" />
				</lable>

				<button
					disabled={updatingScore2}
					onclick={() => {
						poolMatchScoreUpdate(2);
					}}
					class="bg-custom-orange px-6 py-2 text-white">Submit</button
				>
			</div>

			{#if getSportFromSportId(selectedSport!.id) == 'Cricket'}
				<div class="border p-2">
					<label>
						Balls <input
							bind:value={givenBalls2}
							type="number"
							class="bg-gray my-4 border p-2"
						/></label
					>
					<button
						disabled={updatingBalls2}
						onclick={() => {
							poolMatchBallsUpdate(2);
						}}
						class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
					>
				</div>

				<div class="border p-2">
					<label>
						Wickets <input
							bind:value={givenWickets2}
							type="number"
							class="bg-gray my-4 border p-2"
						/></label
					>
					<button
						disabled={updatingWickets2}
						onclick={() => {
							poolMatchWicketsUpdate(2);
						}}
						class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
					>
				</div>
			{/if}
		</div>
	{/if}

	<div class="border p-2">
		<label class="flex flex-col">
			Live Stream link<input
				bind:value={givenLiveLink}
				type="text"
				class="bg-gray my-4 border p-2"
			/></label
		>
		<button
			disabled={updatingLiveLink}
			onclick={() => {
				poolMatchLiveLinkUpdate();
			}}
			class="bg-custom-orange disabled:bg-custom-gray px-6 py-2 text-white">Submit</button
		>
	</div>
</section>
