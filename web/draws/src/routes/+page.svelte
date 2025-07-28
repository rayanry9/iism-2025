<script lang="ts">
	import { untrack } from 'svelte';
	import type { PageProps } from './$types';
	import { goto } from '$app/navigation';

	let { data }: PageProps = $props();

	let meetType = $state('student');
	$effect(() => {
		meetType;
		untrack(() => {
			sportId = -1;
		});
	});
	let sportId = $state<number>(-1);
</script>

<svelte:head></svelte:head>

<div class="mx-auto flex h-screen w-fit flex-col items-center justify-center gap-y-6">
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
	<button
		type="button"
		onclick={() => {
			goto(`/${sportId}`);
		}}
		class="btn w-full btn-primary">GO</button
	>
</div>
