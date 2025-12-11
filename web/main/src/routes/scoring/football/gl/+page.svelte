<script lang="ts">
	import { goto } from '$app/navigation';
    import footballIcon from '$lib/assets/sport/football.webp'
	import type { IITNames } from '$lib/types/iitNames';
    import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
    import PopoverBox from '$lib/ui/score/Popover.svelte'

	let teams :IITNames[] = ["Guwahati", "Madras"]
	let selectedTeam = teams[0]



	let players = [
		{ js: 67, name: "Virat Kohli", id: 1 },
		{ js: 13, name: "Rohit Sharma", id: 2 },
		{ js: 83, name: "Virat Kohli", id: 3 },
		{ js: 39, name: "Virat Kohli", id: 4 },
		{ js: 67, name: "Virat Kohli", id: 5 },
		{ js: 67, name: "Virat Kohli", id: 6 },
		{ js: 67, name: "Virat Kohli", id: 7 },
		{ js: 67, name: "Virat Kohli", id: 8 },
		{ js: 67, name: "Virat Kohli", id: 9 },
		{ js: 67, name: "Virat Kohli", id: 10 }
	]
    let gkGuwahati = $state(players[0])
    let gkMadras = $state(players[1])
    let showGKPopup = $state(false)
   let currentGKTeam = $state<string | null>(null)


	let selectedPlayers: number[] = []

    function togglePlayer(id: number) {
        if (selectedPlayers.includes(id)) {
            selectedPlayers = selectedPlayers.filter(x => x !== id)
        } else {
            selectedPlayers = [...selectedPlayers, id]
        }
    }

    function next() {
        if (selectedTeam === teams[0]) {
            // Move to Team 2
            selectedTeam = teams[1];
        } else {
            // next → dummy redirect
            console.log("Redirecting to match page...");
            goto('/scoring/football/gl') // dummy route
        }
    }

</script>

<div class="max-w-md mx-auto bg-white l  pb-8 ">
    <div class="w-full">
	<div class="flex items-center justify-between px-4 pt-3 ">
		<h1 class="text-base font-semibold pb-2">Lineups</h1>

		<!-- Replace with your real image -->
		<img 
			src={footballIcon} 
			alt="stumps" 
			class="h-10 w-auto object-contain"
		/>
	</div>

	<!-- Grey bar -->
	<div class="w-full h-[1px] bg-gray-300 m-0 p-0"></div>
</div>
	<h2 class="text-xl font-semibold mt-2 p-4">Confirm GoalKeepers</h2>
	<p class="text-sm text-gray-600 -mt-2 px-4">
		Confirm GoalKeepers for both teams
	</p>
    <!-- TEAM 1 -->
<!-- TEAM 1 -->
<div class="mt-10 relative">

	<!-- TEAM HEADER -->
	<div class="flex items-center gap-2 px-4 mb-2">
		<img alt="IIT LOGO" src={getIITImgSrc("Guwahati")} class="h-5 w-5" />
		<span class="font-semibold text-gray-700">IIT GUWAHATI</span>
	</div>

	<!-- GK ROW -->
	<div class="flex items-center mx-4">
		<div class="w-16 h-12 border border-gray-300 flex items-center justify-center text-gray-800 font-semibold">
			{gkGuwahati.js}
		</div>

		<div class="flex-1 h-12 border border-gray-300 flex items-center px-3 text-gray-800">
			{gkGuwahati.name}
		</div>

		<button
			onclick={() => {
				currentGKTeam = "Guwahati"
				showGKPopup = true
			}}
			class="ml-2 px-4 py-2 border border-[#ef4823] text-[#ef4823] font-semibold"
		>
			CHANGE
		</button>
	</div>

	<!-- POPUP (ABSOLUTE OVERLAY, DOES NOT SHIFT LAYOUT) -->
	{#if showGKPopup && currentGKTeam === "Guwahati"}
	<div class="absolute left-3 right-0 top-8 z-50 
	            border border-red-400  bg-white  overflow-hidden">

		<!-- TITLE ROW -->
		<div class="flex justify-between items-center px-3 py-2 bg-white">
			<h2 class="text-[#ef4823] font-semibold text-lg">Choose Goalkeeper</h2>
			<button onclick={() => showGKPopup = false}
					class="text-[#ef4823] text-xl font-bold leading-none">×</button>
		</div>

		<!-- ORANGE DIVIDER -->
		<div class="w-full h-[2px] bg-[#ef4823]"></div>

		<!-- SCROLLABLE GRID -->
		<div class="max-h-[330px] overflow-y-auto p-3 grid grid-cols-2 gap-3 bg-white">
			{#each players as p}
				<button
					onclick={() => {
						gkGuwahati = p
						showGKPopup = false
					}}
					class="w-full py-3 bg-[#eeeeee] text-gray-700 rounded-md shadow-sm text-md"
				>
					{p.name}
				</button>
			{/each}
		</div>
	</div>
	{/if}

</div>

<!-- TEAM 2 -->
<div class="mt-5 relative">
	<div class="flex items-center gap-2 px-4 mb-2">
		<img alt="IIT LOGO" src={getIITImgSrc("Madras")} class="h-5 w-5" />
		<span class="font-semibold text-gray-700">IIT MADRAS</span>
	</div>

	<div class="flex items-center  mx-4">
		<div class="w-16 h-12 border border-gray-300  flex items-center justify-center text-gray-800 font-semibold">
			{gkMadras.js}
		</div>

		<div class="flex-1 h-12 border border-gray-300  flex items-center px-3 text-gray-800">
			{gkMadras.name}
		</div>

		<button onclick={() => {
            currentGKTeam = "Madras"
            showGKPopup = true
        }} class="ml-2 px-4 py-2 border border-[#ef4823] text-[#ef4823]  font-semibold">
			CHANGE
		</button>
        
	</div>
    {#if showGKPopup && currentGKTeam === "Madras"}
	<div class="absolute left-3 right-0 top-8.5 z-50 
	            border border-red-400  bg-white  overflow-hidden">

		<!-- TITLE ROW -->
		<div class="flex justify-between items-center px-3 py-2 bg-white">
			<h2 class="text-[#ef4823] font-semibold text-lg">Choose Goalkeeper</h2>
			<button onclick={() => showGKPopup = false}
					class="text-[#ef4823] text-xl font-bold leading-none">×</button>
		</div>

		<!-- ORANGE DIVIDER -->
		<div class="w-full h-[2px] bg-[#ef4823]"></div>

		<!-- SCROLLABLE GRID -->
		<div class="max-h-[330px] overflow-y-auto p-3 grid grid-cols-2 gap-3 bg-white">
			{#each players as p}
				<button
					onclick={() => {
						gkMadras = p
						showGKPopup = false
					}}
					class="w-full py-3 bg-[#eeeeee] text-gray-700 rounded-md shadow-sm text-md"
				>
					{p.name}
				</button>
			{/each}
		</div>
	</div>
	{/if}
</div>

<!-- START MATCH BUTTON -->
<div class="flex justify-center mt-100">
	<button
		onclick={next}
		class="bg-[#ef4823] text-white px-8 py-3  -skew-x-8 font-semibold tracking-wide shadow-md"
	>
		START MATCH →
	</button>
</div>




 </div>   