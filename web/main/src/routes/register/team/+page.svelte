<script lang="ts">
	import { page } from '$app/state';
	import plusSVG from '$lib/assets/icons/plus.svg';
	import type { Sports } from '$lib/types/sports';
	import PlayerCard from '$lib/ui/register/PlayerCard.svelte';
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportFromSportId, isSportFemale } from '$lib/utility/sport';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import Button from '$lib/ui/components/Button.svelte';
	import { PUBLIC_API_URL } from '$env/static/public';
	const sportId = page.url.searchParams.get('sport');
	const totalRegistrants = 12;
	let { data } = $props();
	let currentRegistrants = $state(data.playerData.length);
</script>

<section class="my-12 flex">
	{#if sportId != null}
		<div class="flex items-center gap-x-4 leading-0">
			<img
				class="h-20"
				src={getSportImageSrc(getSportFromSportId(parseInt(sportId)) as Sports)}
				alt="sport img"
			/>
			<div class="flex flex-col">
				<h2>{getSportFromSportId(parseInt(sportId))?.toUpperCase()} TEAM</h2>
				<p>IIT {data.me?.institute} - {isSportFemale(parseInt(sportId)) ? 'Women' : 'Men'}</p>
			</div>
		</div>
	{:else}
		<h2>Invalid</h2>
	{/if}
	<img src={getIITImgSrc(data.me!.institute)} class="ml-auto h-20" alt="iit logo" />
</section>
<hr class="mb-2" />
<section class="my-8 flex items-center">
	<div>
		<div class="title-text">Current Members</div>
		<div class="bg-custom-gray mt-5 h-2 w-[24rem] -skew-x-12">
			<div
				class="bg-custom-teal h-full"
				style="width: calc({Math.floor((currentRegistrants * 100) / totalRegistrants)}%);"
			></div>
		</div>
		<div class="button-text mt-2">{currentRegistrants}/{totalRegistrants} registered</div>
	</div>

	<a class="ml-auto" href="/register/team/add?sport={sportId}">
		<Button
			class="bg-custom-orange ml-auto h-fit rounded-sm px-4 py-2  text-white *:flex *:gap-x-4"
			disabled={currentRegistrants == totalRegistrants}
			><img src={plusSVG} class="h-6" alt="add" />Add New Member</Button
		>
	</a>
</section>

<section class="flex flex-wrap gap-10">
	{#each data.playerData as player}
		<PlayerCard
			playerName={(
				player.firstName +
				' ' +
				(player.middleName ?? '') +
				' ' +
				(player.lastName ?? '')
			).trim()}
			photoUrl={PUBLIC_API_URL + '/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}
			onRemove={() => {}}
			subText={player.extra ?? ''}
		/>
	{/each}
</section>
