<script lang="ts">
	import { goto } from '$app/navigation';
    import footballIcon from '$lib/assets/sport/football.webp'
	import type { IITNames } from '$lib/types/iitNames';
    import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
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

<div class="max-w-md mx-auto bg-white rounded-2xl  pb-8 shadow-sm">
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
	<h2 class="text-xl font-semibold mt-2 p-4">Confirm Players</h2>
	<p class="text-sm text-gray-600 mb-4 px-4">
		Select playing Team, others will be Substitute
	</p>

	<!-- Team Tabs -->
	<div class="flex gap-6 mb-0 relative px-2">
	{#each teams as t}
		<div class="relative flex flex-col items-center">
			<button
				class={`px-3 py-2 rounded-full border-2 text-sm font-medium cursor-pointer flex items-center gap-2
					${selectedTeam === t
						? "border-orange-500"
						: "border-gray-300 text-gray-700"}`}
				on:click={() => (selectedTeam = t)}
			>
				<img class="h-7 w-auto object-contain" alt="IIT LOGO" src={getIITImgSrc(t)} />
				<span class="capitalize">IIT {t.toUpperCase()}</span>
			</button>

			<!-- ORANGE underline under selected tab -->
			{#if selectedTeam === t}
				<div class="absolute -bottom-[16px] left-0 right-0 h-[3px] bg-orange-500 rounded-full"></div>
			{/if}
		</div>
	{/each}
</div>

<!-- GREY divider bar -->
<div class="w-full h-[1px] bg-gray-300 mt-4 mb-2"></div>

	<!-- Header Row -->
<!-- HEADER + ROWS IN ONE GRID -->
<div class="grid grid-cols-[60px_minmax(0,_1fr)_32px] text-sm gap-y-2 px-4">

  <!-- Header row -->
    <div class="text-white text-xs py-2 px-3 flex items-center" style="background:#7882B9">
        JS NO.
    </div>
    <div class="text-white text-xs py-2 px-3 flex items-center" style="background:#7882B9">
        NAME
    </div>
    <div class="text-white text-xs py-2 px-3" style="background:#7882B9"></div>

  <!-- Player rows -->
  {#each players as p}
    {@const rowBorder = selectedPlayers.includes(p.id)
        ? "border-orange-500 "
        : "border-gray-300 bg-white"}

    <button
        type="button"
        class="contents cursor-pointer"
        on:click={() => togglePlayer(p.id)}
    >
        <!-- JS number cell -->
        <div
            class={`relative px-3 py-3 flex items-center 
                border ${rowBorder} border-r-0`}
        >
            {p.js}

            <!-- vertical bar after JS no -->
            <div
                class={`absolute right-1 top-1/2 -translate-y-1/2 w-px h-11  ${selectedPlayers.includes(p.id) ? "bg-orange-500" : "bg-gray-300"}`}
            ></div>
        </div>

        <!-- Name cell -->
        <div
            class={`px-3 py-3 flex items-center 
                border-y  ${selectedPlayers.includes(p.id) ? "border-orange-500" : "bg-white border-gray-300"}`}
        >
            {p.name}
        </div>

        <!-- Radio cell -->
        <div
            class={`px-1 py-3 grid place-items-center 
                border ${rowBorder} border-l-0`}
        >
            <div class="relative h-5 w-5 flex items-center justify-center">
                <div
                    class={`h-5 w-5 rounded-full border-2 flex items-center justify-center
                        ${selectedPlayers.includes(p.id)
                            ? "bg-orange-500 border-orange-500"
                            : "border-gray-500 bg-white"}`}
                ></div>

                {#if selectedPlayers.includes(p.id)}
                    <svg
                        class="absolute h-3 w-3 text-white"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                        stroke-width="3"
                    >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                    </svg>
                {/if}
            </div>
        </div>
    </button>
{/each}


</div>


	<!-- NEXT button -->
	<button
        on:click={next}
        class="mt-6 mx-auto bg-orange-500 text-white font-semibold px-10 py-2  
            flex items-center gap-2 transform -skew-x-10"
    >
        <!-- Inner wrapper to UN-SKEW the text -->
        <div class="flex items-center gap-2 transform skew-x-6">
            <span class="text-sm whitespace-nowrap">
                {selectedTeam === teams[0] ? "NEXT" : "NEXT"}
            </span>
            <span class="text-lg leading-none">›</span>
        </div>
    </button>
</div>
