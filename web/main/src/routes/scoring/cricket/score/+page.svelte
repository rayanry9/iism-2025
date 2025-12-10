<script lang="ts">
	// ---------------------------
	// STATE (RUNES)
	// ---------------------------
	import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc';
    import cricketIcon from '$lib/assets/sport/cricket.webp' 
	import type { IITNames } from '$lib/types/iitNames';
    import PopoverBox from '$lib/ui/score/Popover.svelte'

    let teams:IITNames[] = ["Madras", "Guwahati"]

	let score = $state({ runs: 71, wickets: 2 });
	let overs = $state({ over: 8, ball: 1 });

	let striker = $state({ name: "Rohit Sharma", runs: 34, balls: 24 });
	let nonStriker = $state({ name: "Harbhajan Singh", runs: 12, balls: 12 });

	let bowler = $state({ name: "J. Bumrah", runs: 23, wickets: 1 });

	let thisOver: string[] = $state([]);

	let history: any[] = $state([]);
    let showWicketPopup = $state(false)
    let showFielderPopup = $state(false)
    let dismissalType = $state<string | null>(null)
    let fielders = [
        "J. Bumrah",
        "Harbhajan Singh",
        "Suresh Yadav",
        "Vikas Reddy"
    ]


	function saveState() {
	history.push({
		score: { ...score },
		overs: { ...overs },
		striker: { ...striker },
		nonStriker: { ...nonStriker },
		bowler: { ...bowler },
		thisOver: [...thisOver]
	});
}


	function rotateStrike() {
		[striker, nonStriker] = [nonStriker, striker];
	}

	function addBallLabel(label: string) {
		thisOver.push(label);
		if (thisOver.length === 6) thisOver = [];
	}

	function incrementBall() {
		overs.ball++;
		if (overs.ball === 6) {
			overs.over++;
			overs.ball = 0;
			rotateStrike();
		}
	}

	function scoreRuns(r: number) {
		saveState();
		score.runs += r;
		striker.runs += r;
		striker.balls++;
		addBallLabel(String(r));
		incrementBall();
	}

	function wide() {
		saveState();
		score.runs += 1;
		addBallLabel("WD");
	}

	function noBall() {
		saveState();
		score.runs += 1;
		addBallLabel("NB");
	}

	function bye(r: number) {
		saveState();
		score.runs += r;
		striker.balls++;
		addBallLabel("B");
		incrementBall();
		if (r % 2 === 1) rotateStrike();
	}

	function legBye(r: number) {
		saveState();
		score.runs += r;
		striker.balls++;
		addBallLabel("LB");
		incrementBall();
		if (r % 2 === 1) rotateStrike();
	}

	function wicket() {
		saveState();
		score.wickets++;
		striker.balls++;
		addBallLabel("W");
		incrementBall();
		striker = { name: "New Player", runs: 0, balls: 0 };
	}

	function undo() {
		if (!history.length) return;

		let prev = history.pop();
		score = prev.score;
		overs = prev.overs;
		striker = prev.striker;
		nonStriker = prev.nonStriker;
		bowler = prev.bowler;
		thisOver = prev.thisOver;
	}
</script>

<!-- PAGE -->
<div class="w-full min-h-screen bg-white flex flex-col p-4">

	<!-- TOP BAR -->
	<div class="flex justify-between items-center text-sm text-gray-700">
		<div class="flex items-center gap-2">
            <img alt="logo" src={getIITImgSrc(teams[1])} class="h-5 w-5 object-contain" />
			<span>IITG</span>
			<span class="text-[#283891]"> VS</span>
            <img alt="logo" src={getIITImgSrc(teams[0])} class="h-5 w-5 object-contain" />
			<span>IITM</span>
		</div>
            <img alt="cricket logo" src={cricketIcon} class="ml-auto h-10 object-contain" />
		
	</div>
        <div class="w-screen h-[1.5px] bg-gray-300 -mx-4 mb-3"></div>

	<!-- SCORE PANEL -->
    <div class=" overflow-hidden border border-[#e5e5e5] bg-white">

        <!-- Top row (logo + team + menu) -->
        <div class="flex justify-between items-center px-4 py-3 border-b border-[#e5e5e5]">
            <div class="flex items-center gap-2">
            	<img alt="logo" src={getIITImgSrc(teams[0])} class="h-5 w-5 object-contain" />
                <span class="text-md font-semibold tracking-tight">
                    IIT MADRAS <span class="text-gray-500 font-normal">[Batting]</span>
                </span>
            </div>
            <div class="text-gray-700 text-xl leading-none">⋮</div>
        </div>

        <!-- SCORE + OVERS row -->
        <div class="flex justify-between">
            <!-- LEFT SCORE -->
            <div class="flex-1 px-4 py-5 border-[#e5e5e5]">
                <div class="text-[#EF4823] text-5xl font-bold leading-none ">
                    {score.runs}/{score.wickets}
                </div>
            </div>

            <!-- RIGHT OVERS (full-height box) -->
            <div class="w-28 flex flex-col  border-l justify-center items-center p-5">
                <div class="text-xl  font-semibold leading-none">
                    {overs.over}.{overs.ball}
                </div>
                <div class="text-md  tracking-wide mt-1">
                    OVERS
                </div>
            </div>
        </div>
    </div>
<!-- STRIKER / NON-STRIKER BOX -->
<div class="mt-4 bg-white border border-gray-200 rounded-lg overflow-hidden">

    <!-- Striker -->
    <div class="px-4 py-3 bg-[#e9f7ff] flex justify-between items-center border-b border-gray-200 relative">
        <div>
            <div class="text-sm text-blue-600 font-semibold">Striker</div>
            <div class="font-bold text-gray-900">{striker.name}</div>
        </div>

        <div class="font-semibold text-gray-700">
            {striker.runs}/{striker.balls}
        </div>

        <!-- SWITCH BUTTON → moved to the RIGHT -->
        <button
            onclick={rotateStrike}
            class="absolute right-20 top-2/2 -translate-y-1/2
                   w-8 h-8 rounded-full border border-[#3aa2b3] bg-white
                   flex items-center justify-center text-[#3aa2b3]"
        >
            ↑↓
        </button>
    </div>

    <!-- Non Striker -->
    <div class="px-4 py-3 flex justify-between items-center">
        <div>
            <div class="text-sm text-gray-500">Non Striker</div>
            <div class="font-semibold text-gray-900">{nonStriker.name}</div>
        </div>

        <div class="font-semibold text-gray-700">
            {nonStriker.runs}/{nonStriker.balls}
        </div>
    </div>
</div>



<!-- 🟤 BOWLER BOX -->
<div class="mt-4 bg-white border border-gray-200 rounded-lg p-4">
    <div class="text-sm text-gray-500">Bowler</div>
    <div class="flex justify-between items-center mt-1">
        <div class="font-semibold text-gray-900">{bowler.name}</div>

        <div class="font-semibold text-gray-700">
            {bowler.wickets}/{bowler.runs} ({overs.over}.{overs.ball})
        </div>
    </div>

    <!-- Ball history -->
    <div class="flex gap-2 mt-3 flex-wrap">
        {#each thisOver as b}
            <div class="w-6 h-6 px-2 py-1 text-sm rounded-full border flex items-center justify-center
                {b === 'W' ? 'bg-red-100 text-red-600 border-red-300' : ''}
                {b === 'WD' ? 'bg-blue-100 text-blue-700 border-blue-300' : ''}
                {b === 'NB' ? 'bg-yellow-100 text-yellow-700 border-yellow-300' : ''}
                {Number(b) >= 0 ? 'bg-gray-100 text-gray-700 border-gray-300' : ''}">
                {b}
            </div>
        {/each}
    </div>
</div>


<!-- BOTTOM BUTTON PANEL -->
<div class="mt-4 select-none">

    <div class="flex gap-2">

        <!-- LEFT COLUMN (GRAY) -->
        <div class="flex flex-col w-24">

            <!-- WD -->
            <button onclick={wide}
                class="h-20 bg-[#f3f3f3] border border-gray-300 flex flex-col items-center justify-center">
                <span class="text-xl text-gray-700 font-medium">WD</span>
            </button>

            <!-- NB -->
            <button onclick={noBall}
                class="h-20 bg-[#f3f3f3] border border-gray-300 flex flex-col items-center justify-center">
                <span class="text-xl text-gray-700 font-medium">NB</span>
            </button>

            <!-- BYE -->
            <button onclick={() => bye(1)}
                class="h-10 bg-[#f3f3f3] border border-gray-300 flex items-center justify-center text-gray-700 font-medium">
                BYE
            </button>

            <!-- LEG BYE -->
            <button onclick={() => legBye(1)}
                class="h-10 bg-[#f3f3f3] border border-gray-300 flex items-center justify-center text-gray-700 font-medium">
                LEG BYE
            </button>
        </div>

        <!-- RIGHT GRID -->
        <div class="grid grid-cols-2  flex-1">

            <button onclick={() => scoreRuns(0)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold">
                0
            </button>

            <button onclick={() => scoreRuns(1)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold">
                1
            </button>

            <button onclick={() => scoreRuns(3)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold">
                3
            </button>

            <button onclick={() => scoreRuns(2)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold">
                2
            </button>

            <button onclick={() => scoreRuns(4)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold text-teal-600">
                4
            </button>

            <button onclick={() => scoreRuns(6)}
                class="h-20 border border-gray-300 flex items-center justify-center text-xl font-semibold text-blue-600">
                6
            </button>

            

        </div>
		
    </div>
	<div class="flex flex-row mt-2 gap-1 w-full">
		<button onclick={undo}
                class="w-30 col-span-1  h-20 bg-[#f4eed7] border border-gray-300 flex flex-col items-center justify-center text-gray-700">
                <span class="text-2xl">↶</span>
                <span class="text-sm -mt-1">Undo</span>
            </button>

            <!-- WICKET -->
            <button onclick={() => showWicketPopup = true}
                class="flex-1 col-span-1 h-20 bg-[#ef4823] text-white border border-gray-300 flex items-center justify-center text-xl font-semibold">
                WICKET
            </button>
	</div>
</div>

{#if showWicketPopup}
    <div class="fixed inset-0 bg-black/30 backdrop-blur-[5px] flex items-center justify-center z-50">
        <PopoverBox
            title="Confirm wicket"
            buttons={["Bowled", "Caught", "LBW", "Run Out", "Stumped", "Hit Wicket"]}
            onSelect={(type: string) => {
                // If caught / stumped / run out → open second popup
                if (type === "Caught" || type === "Stumped" || type === "Run Out") {
                    dismissalType = type
                    showWicketPopup = false
                    showFielderPopup = true
                    return
                }

                // Otherwise it's a normal bowled / lbw / hit wicket
                showWicketPopup = false
                wicket()
            }}
            onClose={() => showWicketPopup = false}
        />
    </div>
{/if}
{#if showFielderPopup}
    <div class="fixed inset-0 bg-black/30 backdrop-blur-[5px] flex items-center justify-center z-50">
        <PopoverBox
            title={`${dismissalType} by ?`}
            buttons={fielders}
            onSelect={(fielder:string) => {
                console.log("Out:", dismissalType, "by", fielder)
                showFielderPopup = false
                wicket()
            }}
            onClose={() => showFielderPopup = false}
        />
    </div>
{/if}


</div>
