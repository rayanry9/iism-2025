<script lang="ts">
	import { getAllIITNames, getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
	import {getSportImageSrc} from '$lib/utility/sportImgSrc.js'
	import {getSportIdOfSport} from '$lib/utility/sport'
	import { PUBLIC_API_URL } from '$env/static/public';
	import type {GetPlayers, GetPlayerCount} from '$lib/types/user';
	import asideBg from '$lib/assets/team-aside-bg.webp';
	import logoNoText from '$lib/assets/logo-no-text.svg';
	import type { IITNames } from '$lib/types/iitNames';
	import MobileHeaderFrame from '$lib/ui/common/MobileHeaderFrame.svelte';
	import {ToggleTabs} from '$lib/ui/components/toggleTabs';
	import { globals } from '$lib/state.svelte';
	import type { Sports } from '$lib/types/sports';
	import Button from '$lib/ui/components/Button.svelte';
	import CustomSelect2 from '$lib/ui/teams/CustomSelect2.svelte';
	import { browser } from '$app/environment';
	import men from '$lib/assets/icons/men.svg'
	import women from '$lib/assets/icons/female.svg'
	
	let sports = $derived.by(() => {
		if (!globals.staff) {
			return ['Athletics', 'Cricket', 'Football', 'Hockey', 'Volleyball'] satisfies Array<Sports>;
		} else {
			return [
				'Athletics',
				'Badminton',
				'Basketball',
				'Chess',
				'Cricket',
				'Football',
				'Table Tennis',
				'Tennis',
				'Volleyball',
				'Squash'
			] satisfies Array<Sports>;
		}
	});
	let activeSport = $state<Sports | undefined>('Athletics');
	let activeIIT = $state<IITNames | undefined>('Hyderabad');
	let activeGender = $state<'MEN' | 'WOMEN' | undefined>('MEN');
	let playerData = $state<GetPlayers[]>([]);
  	let playerCount = $state<GetPlayerCount | null>(null);
	 $effect(() => {
    if (activeSport && activeIIT) {
      // Fetch players
      fetch(`${PUBLIC_API_URL}/get-players?sport_id=${getSportIdOfSport(activeSport,activeGender == 'MEN' ? 1 : 2,globals.staff)}&institute=${activeIIT}`)
        .then(res => res.json())
        .then((data: GetPlayers[]) => {
          playerData = data;
        });

      // Fetch player count
      fetch(`${PUBLIC_API_URL}/get-player-count?sport_id=${getSportIdOfSport(activeSport,activeGender == 'MEN' ? 1 : 2,globals.staff)}&institute=${activeIIT}`)
        .then(res => res.json())
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
		if(!isMobile){
			activeIIT = undefined;
		}// Tailwind's lg breakpoint is 1280px
	}
	$effect(() => {
		if (browser) {
			checkIsMobile();
			window.addEventListener('resize', checkIsMobile);
		}
		return () => {
			if (browser) {
				window.removeEventListener('resize', checkIsMobile);
			}
		};
	});
</script>

<div class="hidden lg:flex flex-col overflow-x-clip xl:flex-row">
	
	<aside class="mr-32 -ml-64 hidden -skew-x-12 flex-row xl:flex">
		<div class="bg-custom-dark-blue relative mr-8 flex w-[20rem] flex-row overflow-x-clip">
			<img
				src={asideBg}
				alt="aside bg"
				class="absolute -top-12 left-48 w-[16rem] skew-x-12 opacity-30"
			/>
			<div class="border-l-custom-blue z-10 ml-auto h-full border-l-8"></div>
			<div class="border-l-custom-light-blue z-10 h-full border-l-8"></div>
		</div>
		<div
			class="my-12 flex h-[calc(100vh-10rem)] flex-col gap-y-6 overflow-y-scroll pr-8"
			style="scrollbar-color: #FDB424 #F0F0F0; scrollbar-width:auto ;"
		>
			{#each getAllIITNames() as iit}
				<button
					class="{activeIIT == iit
						? 'outline-custom-dark-yellow'
						: 'outline-custom-gray'} hover:bg-custom-light-blue/10 my-1 w-fit self-center px-10 py-6 outline-2 transition-colors hover:cursor-pointer xl:ml-4 2xl:mx-6"
					onclick={() => {
						activeIIT = iit;
					}}
					data-umami-event="Team selection"
					data-umami-event-team={activeIIT}
				>
					<img
						src={getIITImgSrc(iit)}
						class="skew-x-12 xl:w-16 2xl:w-24"
						alt={'IIT ' + iit + ' logo'}
					/>
				</button>
			{/each}
		</div>
	</aside>

	{#if activeIIT == undefined}
		<main class="flex h-fit grow items-center justify-center">
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
		<main class="hidden lg:flex h-[calc(100vh-20rem)] grow  flex-row w-[100rem] ">
			<div class="flex flex-col w-[20rem] xl:w-[60rem] 2xl:w-full p-[3rem] ">
				<div class="flex flex-col lg:flex-row gap-[2rem]  xl:h-[8rem] 2xl:h-[10rem] items-center justify-between  w-full p-[2rem]">
					<div class="flex gap-[2rem] items-center">
						<img 
						src={getIITImgSrc(activeIIT)}
						class=" h-[4rem] xl:h-[3rem] 2xl:h-[6rem]"
						alt="logo"/>
						<div class="flex flex-col">
							<span class="xl:text-2xl 2xl:text-4xl">IIT {activeIIT}</span>
							<span class="xl:text-xl text-2xl">Ranked 1st in Leaderboard</span>
						</div>
					</div>
					<div class={`3xl:gap-x-5 flex flex-row flex-wrap gap-x-3 xl:w-[20rem] 2xl:w-[30rem] *:rounded-sm *:p-0.5 lg:*:p-1 xl:gap-x-4 2xl:*:p-2 **:[img]:size-10 xl:**:[img]:size-[2rem] 2xl:**:[img]:size-12`}>
						{#each sports as sport}
						<Button
							onclick={() => {
								// window.open('https://www.linkedin.com/company/inter-iit-sports-meet-2025/', '_blank');
								activeSport = sport
							}}
							class={`border-1 border-black ${activeSport == sport ? 'bg-custom-blue' : 'bg-custom-white'}`}
						>
							<img src={getSportImageSrc(sport)} class="" alt="sport" />
						</Button>
						{/each}
				</div>	
				</div>	
				<div class="ml-[2rem] mt-[1rem] w-[96%] "> </div>

				{#if activeSport}
					<div class="mb-3 mt-8 border-t-3 ml-4 border-t-[#D9D9D9] h-0 w-[98%] "></div>

				<div class = "flex flex-row  items-center justify-between xl:mt-[1rem] 2xl:mt-[2.5rem] xl:h-[10rem] ">
				
			<!-- <h2>Team has not been decided yet.</h2> -->
			 
					<div class = "flex flex-row gap-[2rem] items-center  w-[60rem]">
						<img
						class="xl:h-[4rem] 2xl:h-[6rem]"
						alt="sport logo"
						src={getSportImageSrc(activeSport)}
						/>
						<div>
							<span class = "text-3xl uppercase">{activeSport}</span>
							<span class="text-2xl text-custom-blue">   -  Team Players</span>
						</div>
					</div>
				
					<div class = "">
						<ToggleTabs.Root class="ml-auto h-fit ">
							<ToggleTabs.Item
								onclick={() => {
									// sportType = 'Male';
									activeGender = 'MEN'
								}}
								class="!px-5 !py-2"><div class = "flex flex-row justify-center items-center gap-2">MEN <img src={men} alt="Male logo"/></div></ToggleTabs.Item
							>
							<ToggleTabs.Item
								onclick={() => {
									// sportType = 'Female';
									activeGender = 'WOMEN'
								}}
								class="!px-5 !py-2"><div class = "flex flex-row items-center gap-2">WOMEN <img src={women} alt="Female logo"/></div></ToggleTabs.Item
							>
						</ToggleTabs.Root>
					</div>
				</div>
				<div class = "flex flex-none flex-row  flex-wrap overflow-y-auto gap-[4rem] p-[1rem] xl:mt-[1rem] 2xl:mt-[2rem] lg:h-[15rem] xl:h-[23rem] [@media(min-height:900px)]:h-[32rem] 2xl:h-[35rem]">
					{#each playerData as player}
						<div class=" flex flex-col   p-2 my-1  h-auto xl:w-[22rem] 2xl:w-[25rem]">
							<img alt="profile" class = "h-[20rem] " src={PUBLIC_API_URL + '/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}/>
   							<span class = "mt-[1rem] xl:text-xl 2xl:text-3xl "> {player.firstName} {player.lastName} </span>	
   							 <span class="mt-[1rem] xl:text-xxl text-xl">{player.extra}</span> 
  						</div>
						
					{/each}
				</div>
				{/if}
			</div>
			
		</main>
	{/if}
</div>
{#if isMobile}
<div class="xl:hidden">
	<div class="flex  ">
		<MobileHeaderFrame>		
			<!-- {#if browser} -->
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
			<!-- {/if} -->
		</MobileHeaderFrame>
		
	</div>
	{#if activeIIT}
		<div class="flex flex-col items-center ">
			<!-- <SelectSportMobile bind:activeSport /> -->
				<img 
					src={getIITImgSrc(activeIIT)}
					class=" mx-auto my-4 h-24"
					alt={'IIT ' + activeIIT + ' logo'}
				/>
				<h2>IIT {activeIIT}</h2>
				<span class="text-xl text-custom-orange">Current Rank in Leaderboard - 1</span>
				<div class={`mt-10 flex flex-row flex-wrap justify-center gap-x-5 *:rounded-sm *:p-2  **:[img]:size-9 `}>
					{#each sports as sport}
						<Button
							onclick={() => {
								// window.open('https://www.linkedin.com/company/inter-iit-sports-meet-2025/', '_blank');
								activeSport = sport
							}}
							class={` border-1 border-black ${activeSport == sport ? 'bg-custom-blue' : 'bg-custom-white'}`}
						>
							<img src={getSportImageSrc(sport)} class="" alt="sport" />
						</Button>
					{/each}
				</div>	
				{#if activeSport}
					<div class="mb-3 mt-10 border-t-3 border-t-[#D9D9D9] h-0 w-[92%] "></div>
					<div class="flex flex-row justify-between items-center w-[92%] ">
						<div class="flex flex-row gap-4 mt-4 items-center ">
							<img
								class="h-10"
								alt="sport logo"
								src={getSportImageSrc(activeSport)}
							/>
							<div class="flex flex-col items-center">
								<span class = "text-xl uppercase font-semibold">{activeSport}</span>
								<span class="text-l text-custom-blue"> Team Players</span>
							</div>
							
						</div>
						<div>
							<ToggleTabs.Root class="ml-auto h-fit ">
							<ToggleTabs.Item
								onclick={() => {
									// sportType = 'Male';
									activeGender = 'MEN'
								}}
								class="!px-5 !py-2"><img src={men} alt="Male logo"/></ToggleTabs.Item
							>
							<ToggleTabs.Item
								onclick={() => {
									// sportType = 'Female';
									activeGender = 'WOMEN'
								}}
								class="!px-5 !py-2"><img src = {women} alt="Female logo"/></ToggleTabs.Item
							>
						</ToggleTabs.Root>
						</div>
						
					</div>
					<div class = "mt-10 flex flex-none flex-row  flex-wrap overflow-y-auto gap-[4rem] p-[1rem] xl:mt-[1rem] 2xl:mt-[2rem] lg:h-[15rem] xl:h-[23rem] [@media(min-height:900px)]:h-[32rem] 2xl:h-[35rem]">
							{#each playerData as player}
								<div class=" flex flex-col   p-2 my-1  h-auto w-[9.5rem]">
									<img alt="profile" class = "h-[9rem] " src={PUBLIC_API_URL + '/profile-pic/' + (player.profilePic ?? 'tmp') + '.webp'}/>
									<span class = "mt-[0.2rem] text-xl "> {player.firstName} {player.lastName} </span>	
									<span class="mt-[0.3rem] text-base">{player.extra}</span> 
								</div>
							{/each}
					</div>
				{/if}
		</div>
		
	{/if}
</div>
{/if}