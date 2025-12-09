<script lang="ts">
	// ---------------------------
	// STATE (RUNES)
	// ---------------------------
	let score = $state({ runs: 71, wickets: 2 });
	let overs = $state({ over: 8, ball: 1 });

	let striker = $state({ name: "Rohit Sharma", runs: 34, balls: 24 });
	let nonStriker = $state({ name: "Harbhajan Singh", runs: 12, balls: 12 });

	let bowler = $state({ name: "J. Bumrah", runs: 23, wickets: 1 });

	let thisOver: string[] = $state([]);

	let history: any[] = $state([]);

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
	<div class="flex justify-between items-center text-sm text-gray-700 mb-4">
		<div class="flex items-center gap-2">
			<div class="w-5 h-5 rounded-full bg-gray-300"></div>
			<span>IITG</span>
			<span class="text-blue-500 font-bold">VS</span>
			<span>IITM</span>
		</div>
		<div class="w-6 h-6 bg-gray-300 rounded"></div>
	</div>

	<!-- SCORE PANEL -->
    <div class=" overflow-hidden border border-[#e5e5e5] bg-white">

        <!-- Top row (logo + team + menu) -->
        <div class="flex justify-between items-center px-4 py-3 border-b border-[#e5e5e5]">
            <div class="flex items-center gap-2">
                <div class="w-7 h-7 rounded-full bg-[#d9d9d9]"></div>
                <span class="text-xl font-semibold tracking-tight">
                    IIT MADRAS <span class="text-gray-500 font-normal">[Batting]</span>
                </span>
            </div>
            <div class="text-gray-700 text-xl leading-none">⋮</div>
        </div>

        <!-- SCORE + OVERS row -->
        <div class="flex justify-between">
            <!-- LEFT SCORE -->
            <div class="flex-1 px-4 py-5 border-[#e5e5e5]">
                <div class="text-orange-300 text-5xl font-bold leading-none ">
                    {score.runs}/{score.wickets}
                </div>
            </div>

            <!-- RIGHT OVERS (full-height box) -->
            <div class="w-28 flex flex-col  border-l justify-center items-center p-5">
                <div class="text-xl font-semibold leading-none">
                    {overs.over}.{overs.ball}
                </div>
                <div class="text-[11px] text-gray-600 tracking-wide mt-1">
                    OVERS
                </div>
            </div>
        </div>
    </div>
    <!-- SCORE PANEL ... unchanged above -->

<!-- 🔵 STRIKER / NON-STRIKER BOXES -->
<div class="mt-4 bg-white border border-gray-200 rounded-lg overflow-hidden">

    <!-- Striker -->
    <div class="px-4 py-3 bg-[#e9f7ff] flex justify-between items-center border-b border-gray-200">
        <div>
            <div class="text-sm text-blue-600 font-semibold">Striker</div>
            <div class="font-bold text-gray-900">{striker.name}</div>
        </div>

        <div class="font-semibold text-gray-700">
            {striker.runs}/{striker.balls}
        </div>
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
            <div class="px-2 py-1 text-sm rounded-full border 
                {b === 'W' ? 'bg-red-100 text-red-600 border-red-300' : ''}
                {b === 'WD' ? 'bg-blue-100 text-blue-700 border-blue-300' : ''}
                {b === 'NB' ? 'bg-yellow-100 text-yellow-700 border-yellow-300' : ''}
                {Number(b) >= 0 ? 'bg-gray-100 text-gray-700 border-gray-300' : ''}">
                {b}
            </div>
        {/each}
    </div>
</div>


	<!-- RUN BUTTON GRID -->
	<div class="grid grid-cols-3 gap-2 mt-4 text-center select-none">

		<!-- wides -->
		<button class="border rounded-lg p-4" onclick={wide}>WD<br><span class="text-xl font-semibold">0</span></button>
		<button class="border rounded-lg p-4" onclick={() => scoreRuns(1)}>1</button>
		<button class="border rounded-lg p-4" onclick={() => scoreRuns(2)}>2</button>

		<button class="border rounded-lg p-4" onclick={noBall}>NB<br><span class="text-xl font-semibold">+</span></button>
		<button class="border rounded-lg p-4" onclick={() => scoreRuns(3)}>3</button>
		<button class="border rounded-lg p-4" onclick={() => scoreRuns(4)}>4</button>

		<button class="border rounded-lg p-4" onclick={() => bye(4)}>BYE<br>4</button>
		<button class="border rounded-lg p-4" onclick={() => legBye(6)}>LB<br>6</button>
		<button class="border rounded-lg p-4" onclick={() => scoreRuns(6)}>6</button>
	</div>

	<!-- FOOTER BUTTONS -->
	<div class="flex gap-4 mt-4">
		<button class="flex-1 bg-[#efe2c8] text-black py-3 rounded-lg" onclick={undo}>
			Undo
		</button>
		<button class="flex-1 bg-[#ff5630] text-white py-3 rounded-lg font-semibold" onclick={wicket}>
			WICKET
		</button>
	</div>

</div>
