<script lang="ts">
	import { registerWebsocketConnection } from '$lib/api/websocket';
	import { onDestroy, onMount } from 'svelte';
	import type { PageProps } from './$types';

	let { data }: PageProps = $props();

	let statefulPoolTeamData = $state(data.poolTeams);

	let conn: (() => void) | undefined;

	onMount(() => {
		conn?.();
		conn = registerWebsocketConnection((data) => {
			statefulPoolTeamData.map((poolTeam) => {
				if ((poolTeam.id = data.poolTeamId)) {
					poolTeam.instituteId = data.instituteId;
				}
				return poolTeam;
			});
		});
	});

	onDestroy(() => {
		conn?.();
	});
</script>

<svelte:head></svelte:head>
