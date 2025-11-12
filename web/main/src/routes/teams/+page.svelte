<script lang="ts">
	import { getAllIITNames, getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc.js';
	import { getSportIdOfSport, getSportsAll, isSportFemale } from '$lib/utility/sport';
	import playerBgImg from '$lib/assets/player-bg.webp';
	import { PUBLIC_API_URL } from '$env/static/public';
	import type { GetPlayers, GetPlayerCount } from '$lib/types/user';
	import logoNoText from '$lib/assets/logo-no-text.svg';
	import type { IITNames } from '$lib/types/iitNames';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import { ToggleTabs } from '$lib/ui/components/toggleTabs';
	import { globals } from '$lib/state.svelte';
	import type { Sports } from '$lib/types/sports';
	import CustomSelect2 from '$lib/ui/teams/CustomSelect2.svelte';
	import men from '$lib/assets/icons/men.svg';
	import women from '$lib/assets/icons/female.svg';
	import TeamHeader from '$lib/ui/teams/TeamHeader.svelte';
	import TeamAsideBar from '$lib/ui/teams/TeamAsideBar.svelte';
	import { untrack } from 'svelte';
	import { getJerseyFromIITName } from '$lib/utility/jersey';

	let sports = $derived.by(() => {
		return getSportsAll(globals.staff);
	});
	let activeSport = $state<Sports | undefined>('Athletics');
	let activeIIT = $state<IITNames | undefined | ''>();
	let activeGender = $state<'MEN' | 'WOMEN' | undefined>('MEN');
	$effect(() => {
		activeIIT;
		activeSport;
		untrack(() => (activeGender = 'MEN'));
	});
	let playerData = $state<GetPlayers[]>([]);
	let playerCount = $state<GetPlayerCount | null>(null);
	$effect(() => {
		if (activeSport && activeIIT) {
			try {
				(window as any)?.umami.track('Team Search', {
					iit: activeIIT,
					sport: activeSport,
					gender: activeGender
				});
			} catch (e) {
				console.error(e);
			}
			// Fetch players
			// fetch(
			// 	`${PUBLIC_API_URL}/get-players?sport_id=${getSportIdOfSport(activeSport, activeGender == 'MEN' ? 1 : 2, globals.staff)}&institute=${activeIIT}`
			// )
			// 	.then((res) => res.json())
			// 	.then((data: GetPlayers[]) => {
			// 		playerData = data;
			// 	});
			//
			// // Fetch player count
			// fetch(
			// 	`${PUBLIC_API_URL}/get-player-count?sport_id=${getSportIdOfSport(activeSport, activeGender == 'MEN' ? 1 : 2, globals.staff)}&institute=${activeIIT}`
			// )
			// 	.then((res) => res.json())
			// 	.then((data: GetPlayerCount) => {
			// 		playerCount = data;
			// 	});
		} else {
			// Clear data if sport or IIT not selected
			//   playerData.set([]);
			//   playerCount.set(null);
		}
	});
</script>

<div class="flex flex-col overflow-x-clip xl:flex-row">
	<TeamAsideBar bind:activeIIT />
	<MobileHeaderFrame>
		<CustomSelect2
			items={[
				...getAllIITNames().map((iit) => ({
					value: iit,
					label: `IIT ${iit}`,
					imgSrc: getIITImgSrc(iit)
				}))
			]}
			bind:value={activeIIT}
			placeholder="Select a College"
			type="single"
		/>
	</MobileHeaderFrame>

	{#if activeIIT == undefined || activeIIT == ''}
		<main class="flex grow items-center justify-center">
			<section class="mt-32 flex flex-col items-center gap-y-6 text-center max-xl:mb-32 xl:mt-64">
				<div class="relative">
					<div
						style="filter: invert(48%) sepia(79%) saturate(26%) hue-rotate(86deg) brightness(118%) contrast(119%) opacity(70%); clip-path: polygon(100% 0%, 100% 100%, 0% 50%);"
						class="absolute -top-20 left-0 mx-auto h-12 w-4 bg-black max-xl:right-0 max-xl:rotate-90 xl:top-[calc(50%-1.5rem)] xl:-left-24"
					></div>
					<img
						src={logoNoText}
						alt="logo"
						class="h-fit"
						style="filter: invert(48%) sepia(79%) saturate(26%) hue-rotate(86deg) brightness(118%) contrast(119%) opacity(70%);"
					/>
				</div>
				<p>Select a College to see their<br />teams and players.</p>
			</section>
		</main>
	{:else}
		<main
			class="my-8 flex grow flex-col px-8 xl:my-12 xl:h-[calc(100vh-10rem)] xl:overflow-y-auto xl:px-12"
		>
			<TeamHeader {sports} bind:activeSport {activeIIT} />

			{#if activeSport}
				<div class="mt-12 flex">
					<div class="flex flex-row items-center gap-2 sm:gap-4 xl:gap-8">
						<img
							class="h-12 sm:h-20 xl:h-16 2xl:h-20"
							alt="sport logo"
							src={getSportImageSrc(activeSport)}
						/>
						<div class="flex flex-col items-center justify-center gap-x-2 sm:flex-row">
							<span class="title-text">{activeSport}</span>
							<p class="text-custom-blue flex gap-x-1">
								<span class="hidden sm:block">- </span>Team Players
							</p>
						</div>
					</div>

					{#key activeSport}
						<ToggleTabs.Root class="ml-auto h-fit">
							<ToggleTabs.Item
								onclick={() => {
									activeGender = 'MEN';
								}}
								class="!px-5 !py-2"
								><div class="flex flex-row items-center justify-center gap-2">
									<div class="hidden leading-none sm:block">MEN</div>
									<img src={men} alt="Male logo" class="h-6" />
								</div></ToggleTabs.Item
							>
							{#if getSportIdOfSport(activeSport, 1, globals.staff) != getSportIdOfSport(activeSport, 2, globals.staff)}
								<ToggleTabs.Item
									onclick={() => {
										activeGender = 'WOMEN';
									}}
									class="!px-5 !py-2"
									><div class="flex flex-row items-center gap-2">
										<div class="hidden leading-none sm:block">WOMEN</div>
										<img src={women} alt="Female logo" class="h-6" />
									</div></ToggleTabs.Item
								>
							{/if}
						</ToggleTabs.Root>
					{/key}
				</div>
				<section class="flex flex-wrap justify-center gap-y-4">
					{#if playerData.length == 0}
						<h2 class="mt-12">Team has not been decided yet</h2>
					{:else}
						{#each playerData as player (player.profilePic)}
							<div class="relative my-1 flex w-min flex-col">
								<div
									class="relative"
									style=" 
									clip-path: polygon(20% 0%, 100% 0%, 80% 100%, 0% 100%);
							"
								>
									<img
										alt="profile"
										class="z-20 min-h-40 min-w-40 -translate-x-3 object-cover sm:min-h-64 sm:min-w-64 xl:min-h-80 xl:min-w-80"
										src={'/teams/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}
									/>
									<div
										class="absolute bottom-0 -z-10 h-3/5 w-full"
										style="background-color: {getJerseyFromIITName(
											activeIIT ?? 'Hyderabad',
											globals.staff
										).major};
									"
									>
										<div
											class="h-full mask-cover mask-bottom mask-repeat"
											style="mask-image: url({playerBgImg}); background-color: {getJerseyFromIITName(
												activeIIT ?? 'Hyderabad',
												globals.staff
											).minor}"
										></div>
									</div>
								</div>
								<span class="title-text mt-4 w-[calc(100%-2rem)] font-bold xl:mt-8">
									{player.firstName.trim()}
									{player.middleName?.trim() ?? ''}
									{player.lastName?.trim() ?? ''}
								</span>
								<p class="mt-1 w-[calc(100%-2rem)] xl:mt-2">{player.extra?.trim()}</p>
							</div>
						{/each}
					{/if}
				</section>
			{/if}
		</main>
	{/if}
</div>
