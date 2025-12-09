<script lang="ts">
    import { goto } from '$app/navigation'
	import type { IITNames } from '$lib/types/iitNames';
    import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
    import cricketIcon from '$lib/assets/sport/cricket.webp'


    let teams:IITNames[] = ["Madras", "Guwahati"]
    let selected: string | null = null

    function selectTeam(t: string) {
        selected = t
    }

    function next() {
        if (!selected) return
        goto('/scoring/cricket/score') // replace with real route
    }
</script>

<div class="min-h-screen flex flex-col items-center px-6 pb-12">

    <!-- NAV — moved up, no justify-center influence -->
    <div class="w-full max-w-md mt-6 mb-10">
        <div class="flex items-center gap-3 text-gray-700">
            <span class="text-xl cursor-pointer">‹</span>

            <div class="flex items-center gap-2 text-sm">
                <img alt="logo" src={getIITImgSrc(teams[0])} class="h-5 w-5 object-contain" />
                <span>IITG</span>
                <span class="font-semibold">VS</span>
                <img alt="logo" src={getIITImgSrc(teams[1])} class="h-5 w-5 object-contain" />
                <span>IITM</span>
            </div>

            <img alt="cricket logo" src={cricketIcon} class="ml-auto h-10 object-contain" />
        </div>
        <div class="w-screen h-[1.5px] bg-gray-300 -mx-6"></div>

    </div>

    <!-- MAIN SECTION — manually centered -->
    <div class="flex flex-col items-center justify-center flex-grow">
        <!-- TITLE -->
        <h2 class="text-xl font-semibold text-center mb-8">Who is Batting first ?</h2>

        <!-- TEAM BOXES -->
        <div class="grid grid-cols-2 gap-8 max-w-md mb-12">
            {#each teams as t}
                <button
                    class={`relative w-40 h-40 border  flex flex-col items-center justify-center
                        px-4 py-4 gap-4 transition-all
                        ${selected === t ? "border-orange-500 bg-orange-50" : "border-gray-300 bg-white"}`}
                    on:click={() => selectTeam(t)}
                >
                    <img alt="team logo" src={getIITImgSrc(t)} class="h-14 w-14 object-contain" />
                    <span class="font-semibold text-sm text-center">IIT {t.toUpperCase()}</span>

                    {#if selected === t}
                        <div class="absolute top-2 right-2 h-6 w-6 rounded-full bg-orange-500 flex items-center justify-center">
                            <svg
                                class="h-4 w-4 text-white"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke="currentColor"
                                stroke-width="3"
                            >
                                <path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7" />
                            </svg>
                        </div>
                    {/if}
                </button>
            {/each}
        </div>

        <!-- NEXT BUTTON -->
        <button
            on:click={next}
            disabled={!selected}
            class="bg-orange-500 text-white font-semibold px-10 py-3 
                flex items-center justify-center gap-2 transform -skew-x-12  
                disabled:opacity-40 disabled:cursor-not-allowed"
        >
            <div class="flex items-center gap-2 transform skew-x-12">
                <span class="text-sm">NEXT</span>
                <span class="text-lg leading-none">›</span>
            </div>
        </button>
    </div>

</div>

