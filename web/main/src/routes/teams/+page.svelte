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
	import Button from '$lib/ui/components/Button.svelte';
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
	let activeIIT = $state<IITNames | undefined | ''>('Hyderabad');
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
			// Fetch players
			fetch(
				`${PUBLIC_API_URL}/get-players?sport_id=${getSportIdOfSport(activeSport, activeGender == 'MEN' ? 1 : 2, globals.staff)}&institute=${activeIIT}`
			)
				.then((res) => res.json())
				.then((data: GetPlayers[]) => {
					playerData = data;
				});

			// Fetch player count
			fetch(
				`${PUBLIC_API_URL}/get-player-count?sport_id=${getSportIdOfSport(activeSport, activeGender == 'MEN' ? 1 : 2, globals.staff)}&institute=${activeIIT}`
			)
				.then((res) => res.json())
				.then((data: GetPlayerCount) => {
					playerCount = data;
				});
		} else {
			// Clear data if sport or IIT not selected
			//   playerData.set([]);
			//   playerCount.set(null);
		}
	});
	let isMobile = $state<boolean>(false);
	function checkIsMobile() {
		isMobile = window.innerWidth < 1280;
		if (!isMobile) {
			// activeIIT = undefined;
		} // Tailwind's lg breakpoint is 1280px
	}
	// $effect(() => {
	// 	if (browser) {
	// 		checkIsMobile();
	// 		window.addEventListener('resize', checkIsMobile);
	// 	}
	// 	return () => {
	// 		if (browser) {
	// 			window.removeEventListener('resize', checkIsMobile);
	// 		}
	// 	};
	// });
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
			<section
				class="mt-32 hidden flex-col items-center gap-y-6 text-center max-lg:mb-32 xl:mt-64 xl:flex"
			>
				<div class="relative">
					<div
						style="filter: invert(48%) sepia(79%) saturate(26%) hue-rotate(86deg) brightness(118%) contrast(119%) opacity(70%); clip-path: polygon(100% 0%, 100% 100%, 0% 50%);"
						class="absolute top-[calc(50%-1.5rem)] -left-24 h-12 w-4 bg-black"
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
		<main class="my-12 flex h-[calc(100vh-10rem)] grow flex-col overflow-y-auto px-12">
			<TeamHeader {sports} bind:activeSport {activeIIT} />

			{#if activeSport}
				<!-- <h2>Team has not been decided yet.</h2> -->

				<div class="mt-12 flex">
					<div class="flex flex-row items-center gap-[2rem]">
						<img class="xl:h-16 2xl:h-20" alt="sport logo" src={getSportImageSrc(activeSport)} />
						<div>
							<span class="text-3xl uppercase">{activeSport}</span>
							<span class="text-custom-blue text-2xl"> - Team Players</span>
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
									MEN <img src={men} alt="Male logo" />
								</div></ToggleTabs.Item
							>
							{#if getSportIdOfSport(activeSport, 1, globals.staff) != getSportIdOfSport(activeSport, 2, globals.staff)}
								<ToggleTabs.Item
									onclick={() => {
										activeGender = 'WOMEN';
									}}
									class="!px-5 !py-2"
									><div class="flex flex-row items-center gap-2">
										WOMEN <img src={women} alt="Female logo" />
									</div></ToggleTabs.Item
								>
							{/if}
						</ToggleTabs.Root>
					{/key}
				</div>
				<section class="flex flex-wrap">
					{#each playerData as player}
						<div class="relative my-1 flex w-min flex-col">
							<div
								class="relative"
								style=" 
									clip-path: polygon(20% 0%, 100% 0%, 80% 100%, 0% 100%);
							"
							>
								<img
									alt="profile"
									class="z-20 min-h-[25rem] min-w-[25rem] -translate-x-3 object-cover"
									src={'/teams/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}
								/>
								<div
									class=" absolute bottom-0 -z-10 h-3/5 w-full"
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
							<span class="mt-[1rem] w-[calc(100%-2rem)] xl:text-xl 2xl:text-3xl">
								{player.firstName}
								{player.lastName}
							</span>
							<span class="mt-[1rem] w-[calc(100%-2rem)] text-xl xl:text-2xl">{player.extra}</span>
						</div>
					{/each}
				</section>
			{/if}
		</main>
	{/if}
</div>
{#if isMobile}
	<div class="xl:hidden">
		<div class="flex"></div>
		{#if activeIIT}
			<div class="flex flex-col items-center">
				<!-- <SelectSportMobile bind:activeSport /> -->
				<img
					src={getIITImgSrc(activeIIT)}
					class=" mx-auto my-4 h-24"
					alt={'IIT ' + activeIIT + ' logo'}
				/>
				<h2>IIT {activeIIT}</h2>
				<span class="text-custom-orange text-xl">Current Rank in Leaderboard - 1</span>
				<div
					class={`mt-10 flex flex-row flex-wrap justify-center gap-x-5 *:rounded-sm *:p-2  **:[img]:size-9 `}
				>
					{#each sports as sport}
						<Button
							onclick={() => {
								// window.open('https://www.linkedin.com/company/inter-iit-sports-meet-2025/', '_blank');
								activeSport = sport;
							}}
							class={` border-1 border-black ${activeSport == sport ? 'bg-custom-blue' : 'bg-custom-white'}`}
						>
							<img src={getSportImageSrc(sport)} class="" alt="sport" />
						</Button>
					{/each}
				</div>
				{#if activeSport}
					<div class="mt-10 mb-3 h-0 w-[92%] border-t-3 border-t-[#D9D9D9]"></div>
					<div class="flex w-[92%] flex-row items-center justify-between">
						<div class="mt-4 flex flex-row items-center gap-4">
							<img class="h-10" alt="sport logo" src={getSportImageSrc(activeSport)} />
							<div class="flex flex-col items-center">
								<span class="text-xl font-semibold uppercase">{activeSport}</span>
								<span class="text-l text-custom-blue"> Team Players</span>
							</div>
						</div>
						<div>
							<ToggleTabs.Root class="ml-auto h-fit ">
								<ToggleTabs.Item
									onclick={() => {
										// sportType = 'Male';
										activeGender = 'MEN';
									}}
									class="!px-5 !py-2"><img src={men} alt="Male logo" /></ToggleTabs.Item
								>
								<ToggleTabs.Item
									onclick={() => {
										// sportType = 'Female';
										activeGender = 'WOMEN';
									}}
									class="!px-5 !py-2"><img src={women} alt="Female logo" /></ToggleTabs.Item
								>
							</ToggleTabs.Root>
						</div>
					</div>
					<div
						class="mt-10 flex flex-none flex-row flex-wrap gap-[4rem] overflow-y-auto p-[1rem] lg:h-[15rem] xl:mt-[1rem] xl:h-[23rem] 2xl:mt-[2rem] 2xl:h-[35rem] [@media(min-height:900px)]:h-[32rem]"
					>
						{#each playerData as player}
							<div class=" my-1 flex h-auto w-[9.5rem] flex-col p-2">
								<img
									alt="profile"
									class="h-[9rem]"
									src={'/teams/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}
								/>
								<span class="mt-[0.2rem] text-xl"> {player.firstName} {player.lastName} </span>
								<span class="mt-[0.3rem] text-base">{player.extra}</span>
							</div>
						{/each}
					</div>
				{/if}
			</div>
		{/if}
	</div>
{/if}
