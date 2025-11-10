<script lang="ts">
	import { page } from '$app/state';
	import plusSVG from '$lib/assets/icons/plus.svg';
	import type { Sports } from '$lib/types/sports';
	import PlayerCard from '$lib/ui/register/PlayerCard.svelte';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import {
		getSportFromSportId,
		getSportMaxRegistrants,
		isSportFemale,
		isSportIdStaff
	} from '$lib/utility/sport';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import Button from '$lib/ui/components/Button.svelte';
	import { PUBLIC_API_URL } from '$env/static/public';
	import { afterNavigate, beforeNavigate, goto, invalidateAll } from '$app/navigation';
	import { globals } from '$lib/state.svelte.js';
	import Loading from '$lib/ui/components/Loading.svelte';
	import { browser } from '$app/environment';
	const sportId = page.url.searchParams.get('sport');
	const totalRegistrants = getSportMaxRegistrants(parseInt(sportId!));
	let { data } = $props();
	let currentRegistrants = $derived(
		data.playerCount.count + data.playerCount.reserveCount + data.playerCount.secondaryCount
	);
	if (browser) {
		if (globals.staff != isSportIdStaff(parseInt(sportId ?? '0'))) {
			goto('/register');
		}
	}

	beforeNavigate(() => {
		globals.loading = true;
	});
	afterNavigate(() => {
		globals.loading = false;
	});
</script>

<Loading loading={globals.loading} />

<section class="my-8 flex 2xl:my-12">
	{#if sportId != null}
		<div class="flex items-center gap-x-4 leading-0">
			<img
				class="h-20"
				hidden={parseInt(sportId) <= -10}
				src={getSportImageSrc(getSportFromSportId(parseInt(sportId)) as Sports)}
				alt="sport img"
			/>
			<div class="flex flex-col">
				<h2 hidden={parseInt(sportId) <= -10}>
					{getSportFromSportId(parseInt(sportId))?.toUpperCase()} TEAM
				</h2>
				<h2 hidden={parseInt(sportId) > -10}>SPORTS OFFICER/COACH/PTI/STAFF TEAM</h2>
				<p>
					IIT {data.me?.institute}{parseInt(sportId) > -10
						? isSportFemale(parseInt(sportId))
							? ' - Women'
							: parseInt(sportId) == -2 || parseInt(sportId) == 59
								? ' - Mixed'
								: ' - Men'
						: ''}
					{globals.staff ? '( Staff )' : ''}
				</p>
			</div>
		</div>
	{:else}
		<h2>Invalid</h2>
	{/if}
	<img src={getIITImgSrc(data.me!.institute)} class="ml-auto h-20" alt="iit logo" />
</section>
<hr class="mb-2" />
<section class="my-6 flex items-center 2xl:my-8">
	<div>
		<div class="title-text">Current Members</div>
		<div class="bg-custom-gray mt-5 h-2 w-[24rem] -skew-x-12">
			<div
				class="bg-custom-teal h-full"
				style="width: calc({Math.floor((currentRegistrants * 100) / totalRegistrants)}%);"
			></div>
		</div>
		<div class="button-text mt-2">{currentRegistrants}/{totalRegistrants} spots registered</div>
	</div>

	<a class="ml-auto" href="/register/team/add?sport={sportId}">
		<Button
			class="bg-custom-orange disabled:bg-custom-gray ml-auto h-fit rounded-sm px-4 py-2 text-white *:flex  *:gap-x-4 disabled:cursor-not-allowed disabled:active:brightness-100"
			disabled={currentRegistrants >= totalRegistrants}
			><img src={plusSVG} class="h-6" alt="add" />Add New Member</Button
		>
	</a>
</section>

<section class="flex flex-wrap gap-8 2xl:gap-10">
	{#each data.playerData as player}
		<PlayerCard
			editVisible={sportId == '-2' || sportId == '-5'
				? player.extra == '4x400 M Relay ( Mixed ) (R)' || player.extra == '4x400 M Relay ( Mixed )'
					? true
					: false
				: true}
			playerName={(
				player.firstName +
				' ' +
				(player.middleName ?? '') +
				(player.middleName ? ' ' : '') +
				(player.lastName ?? '')
			).trim()}
			photoUrl={PUBLIC_API_URL + '/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}
			onEdit={() => {
				goto(`/register/team/add?sport=${sportId}&edit=${player.userId}`);
			}}
			onRemove={() => {
				if (
					confirm(
						'Are you sure you want to remove ' +
							player.firstName +
							' ' +
							(player.middleName ?? '') +
							(player.middleName ? ' ' : '') +
							(player.lastName ?? '') +
							' ?'
					)
				) {
					fetch(PUBLIC_API_URL + '/remove-player', {
						method: 'POST',
						credentials: 'include',
						headers: {
							'Content-Type': 'application/json'
						},
						body: JSON.stringify({
							userId: parseInt(player.userId)
						})
					})
						.then((res) => {
							if (res.status == 200) {
								alert('Succesfully Removed');
							} else {
								res.json().then((data) => {
									alert(data.message);
								});
							}
							invalidateAll();
						})
						.catch((_) => {
							alert('Failed to remove player');
						});
				}
			}}
			subText={player.extra ?? ''}
		/>
	{/each}
</section>
