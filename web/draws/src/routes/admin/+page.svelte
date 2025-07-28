<script lang="ts">
	import type { PageProps } from './$types';
	import { applyAction, enhance } from '$app/forms';
	import { getAllPoolTeams } from '$lib/api/data';
	import { untrack } from 'svelte';

	let { data, form }: PageProps = $props();
	$effect(() => {
		if (form != undefined) {
			getAllPoolTeams().then((val) => {
				statefulPoolTeamData = val;
			});
		}
	});
	let meetType = $state('student');
	$effect(() => {
		meetType;
		untrack(() => {
			sportId = -1;
			poolId = -1;
			poolTeamId = -1;
		});
	});
	let sportId = $state<number>(-1);
	$effect(() => {
		sportId;
		untrack(() => {
			poolId = -1;
			poolTeamId = -1;
		});
	});
	let poolId = $state<number>(-1);
	$effect(() => {
		poolId;
		untrack(() => {
			poolTeamId = -1;
		});
	});
	let poolTeamId = $state<number>(-1);
	let upcoming = $state<boolean>(true);
	let statefulPoolTeamData = $state(data.poolTeams);
</script>

<form class="p-8" method="POST" action="?/logout">
	<button class="btn btn-accent" type="submit">Logout</button>
</form>

<form
	use:enhance={({ formElement, formData, action, cancel, submitter }) => {
		return async ({ result }) => {
			applyAction(result);
		};
	}}
	class="flex w-full flex-col items-center gap-y-4"
	method="POST"
	action="?/update"
>
	<div class="">
		<input
			class="radio"
			id="radio-staff"
			bind:group={meetType}
			type="radio"
			name="meet"
			value="staff"
		/>
		<label class="label" for="radio-staff">Staff</label>
		<input
			class="radio"
			type="radio"
			id="radio-student"
			bind:group={meetType}
			name="meet"
			value="student"
		/>
		<label class="label" for="radio-student">Student</label>
	</div>

	<label class="select">
		<span class="label">Sport</span>
		<select name="" class="" bind:value={sportId} required>
			{#each data.sports.filter( (sport) => (meetType == 'staff' ? sport.staff : !sport.staff) ) as sport}
				<option value={sport.id}
					>{sport.name} {sport.type == 1 ? 'Men' : sport.type == 2 ? 'Women' : 'Mixed'}</option
				>
			{/each}
		</select>
	</label>

	<label class="select">
		<span class="label">Pool</span>
		<select name="" disabled={sportId == -1} bind:value={poolId} class="" required>
			{#each data.pools.filter((pool) => pool.sportId == sportId) as pool}
				<option value={pool.id}>{pool.name}</option>
			{/each}
		</select>
	</label>

	<label class="select">
		<span class="label">Pool Team</span>
		<select name="poolTeamId" class="" disabled={poolId == -1} bind:value={poolTeamId} required>
			{#each statefulPoolTeamData.filter((team) => team.poolId == poolId) as team}
				<option value={team.id}
					>{team.tempName}
					{#if team.instituteId != null}
						Assigned to IIT {data.institutes.find((i) => i.id == team.instituteId)?.name}
					{/if}</option
				>
			{/each}
		</select>
	</label>

	<div class="flex gap-x-4">
		<input
			class="checkbox"
			id="upcoming"
			disabled={poolTeamId == -1}
			bind:checked={upcoming}
			value="true"
			type="checkbox"
			name="upcoming"
		/>
		<label class="label" for="upcoming">Upcoming</label>
	</div>

	<label class="select">
		<span class="label">Assign To Institute</span>
		<select name="instituteId" value={-1} disabled={upcoming || poolTeamId == -1} class="" required>
			{#each data.institutes as institute}
				<option value={institute.id}>IIT {institute.name}</option>
			{/each}
		</select>
	</label>

	<button
		class="btn w-fit btn-primary"
		type="submit"
		onclick={() => {
			setTimeout(() => {
				form = null;
			}, 2500);
		}}>Submit</button
	>
</form>

<div hidden={form == undefined || form == null} class="toast">
	<div class="alert {form?.valueOf() ? 'alert-success' : 'alert-error'}">
		<span hidden={!form?.valueOf()}>Pool Team Updated</span>
		<span hidden={form?.valueOf()}>Failed to Update Pool Team</span>
	</div>
</div>
