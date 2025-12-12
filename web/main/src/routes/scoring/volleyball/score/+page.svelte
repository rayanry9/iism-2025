<script lang="ts">
//   import { goto } from '$app/navigation'
    // import { $state } from 'svelte-runes'

  import volleyballIcon from '$lib/assets/sport/volleyball.webp'
  import type { IITNames } from '$lib/types/iitNames'
  import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc'
  import PopoverBox  from '$lib/ui/score/Popover.svelte';

  // teams
  let teams: IITNames[] = ['Guwahati', 'Madras']

  // scores
  type TeamState = {
    name: IITNames
    goals: number
    redCard: boolean
    yellowCard: boolean
  }
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
  let teamA = $state<TeamState>({
    name: teams[0],
    goals: 0,
    redCard: false,
    yellowCard: false
    });

    let teamB = $state<TeamState>({
    name: teams[1],
    goals: 0,
    redCard: false,
    yellowCard: false
    });

  // history for undo
  type Snapshot = {
  teamA: TeamState
  teamB: TeamState
  setsA: number
  setsB: number
  timeouts: number
  timeouts2: number
  timerSeconds: number
}

let history: Snapshot[] = []

  let showCardPopup = $state(false)
  let cardType = $state<"red" | "yellow" | null>(null)
    let showEndMatchPopup = $state(false);

  let showKickTakerPopup = $state(false);
let showKickResultPopup = $state(false);

    let selectedKicker = $state<string | null>(null);
    let showGoalPopup = $state(false);
        let goalTeam: 'A' | 'B' | null = $state(null);

        let showTeamMenu = $state(false);
let activeTeam: 'A' | 'B' | null = $state(null);
let setsA = $state(0)
let setsB = $state(0)

let showOutPopup = $state(false);
let showInPopup = $state(false);
let showSetWinnerPopup = $state(false)
let selectedWinner = $state<string | null>(null)


let outgoingPlayer = $state<string | null>(null);
  const props = $props<{
    leftScore?: number
    rightScore?: number
    leftLogo?: string
    rightLogo?: string
    onFinish?: () => void
  }>()

  // defaults
  const leftScore = $state(props.leftScore ?? 0)
  const rightScore = $state(props.rightScore ?? 2)
  const leftLogo = $state(props.leftLogo ?? getIITImgSrc("Guwahati"))
  const rightLogo = $state(props.rightLogo ?? getIITImgSrc("Madras"))
  const onFinish = props.onFinish ?? (() => {})


 function pushHistory() {
  history.push(JSON.parse(JSON.stringify({
    teamA,
    teamB,
    setsA,
    setsB,
    timeouts,
    timeouts2,
    timerSeconds
  })))

  if (history.length > 50) history.shift()
}


  function addGoal(team: 'A' | 'B') {
    pushHistory()
    if (team === 'A') teamA.goals++
    else teamB.goals++
  }

  
   let timeouts = $state(2)
   let timeouts2 = $state(0)

  function inc() {
    timeouts = Math.min(20, timeouts + 1)   // volleyball max 2 per set
  }

  function dec() {
    timeouts = Math.max(0, timeouts - 1)
  }
  function inc2() {
    timeouts2 = Math.min(20, timeouts2 + 1)   // volleyball max 2 per set
  }

  function dec2() {
    timeouts2 = Math.max(0, timeouts2 - 1)
  }

function undo() {
  const prev = history.pop()
  if (!prev) return

  teamA = prev.teamA
  teamB = prev.teamB
  setsA = prev.setsA
  setsB = prev.setsB
  timeouts = prev.timeouts
  timeouts2 = prev.timeouts2
  timerSeconds = prev.timerSeconds
}

  // timer
    let timerRunning = $state(false);
    let timerSeconds = $state(0); // seconds elapsed
    let timerInterval: number | null = null;

    let showPenaltyPopup = $state(false);
    let selectedPenaltyTeam = $state<string | null>(null);


  function formatTime(s: number) {
    const mm = Math.floor(s / 60).toString().padStart(2, '0')
    const ss = (s % 60).toString().padStart(2, '0')
    return `${mm} : ${ss}`
  }

  function toggleTimer() {
    if (timerRunning) {
      // pause
      timerRunning = false
      if (timerInterval) {
        clearInterval(timerInterval)
        timerInterval = null
      }
    } else {
      timerRunning = true
      timerInterval = setInterval(() => {
        timerSeconds += 1
      }, 1000) as unknown as number
    }
  }

  function resetTimer() {
    timerRunning = false
    if (timerInterval) {
      clearInterval(timerInterval)
      timerInterval = null
    }
    timerSeconds = 0
  }

  function addTime() {
    pushHistory()
    timerSeconds += 60
  }

  function endMatch() {
    // example: navigate or show summary
    // goto('/match-summary') // change as needed
  }

  // small helpers for card button styles
  const orange = '#ef4823'
</script>

<!-- container -->
<div class="min-h-screen bg-gray-50 flex justify-center py-6">
  <div class="w-full max-w-md bg-white px-0 pb-8">

    <!-- topbar -->
    <div class="flex items-center justify-between px-4 pt-3">
      <div class="flex items-center gap-3">
        <img src={getIITImgSrc(teams[0])} alt="team a" class="h-6 w-6 object-contain" />
        <span class="text-sm font-medium">IITG</span>
        <span class="text-sm text-[#283891]">VS</span>
        <img src={getIITImgSrc(teams[1])} alt="team b" class="h-6 w-6 object-contain" />
      </div>

      <img src={volleyballIcon} alt="ball" class="h-10 object-contain" />
    </div>

    <div class="w-full h-[1px] bg-gray-500"></div>

    <!-- TEAM CARD (reusable structure used twice) -->
    <div class="px-4 mt-4">
      <!-- Team A -->
      <div class="border border-gray-500  overflow-hidden mb-4">
        <div class="px-3 py-3 flex items-center justify-between">
          <div class="flex items-center gap-2">
            <img src={getIITImgSrc(teamA.name)} class="h-5 w-5" alt="logo" />
            <span class="font-semibold text-gray-700">IIT GUWAHATI</span>
          </div>
                <button
        onclick={() => {
            activeTeam = 'A'
            showTeamMenu = true
        }}
        class="text-gray-600 text-xl"
        >⋮</button>

        </div>

        <div class="grid grid-cols-2 items-center border-t border-b border-gray-500">
          <!-- big score -->
          <div class="p-6 flex items-center justify-center">
            <div class="text-[#ef4823] text-8xl font-bold leading-none">{teamA.goals}</div>
          </div>

          <!-- add goal -->
          <div class="p-6 h-[100%] flex items-center justify-center border-l border-gray-500">
            <button
              onclick={() => {
                goalTeam = 'A';
                showGoalPopup = true;
            }}

              
              class="flex flex-col items-center gap-2"
            >
              <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M2 17.3742L17.2058 17.207M17.2058 17.207L32.748 17.3739M17.2058 17.207L17.3742 2M17.2058 17.207L17.3739 32.748" stroke="black" stroke-width="4" stroke-linecap="round"/>
            </svg>

              <div class="text-sm tracking-wide">ADD POINT</div>
            </button>
          </div>
        </div>

        <div class="flex items-center justify-between p-1">

          <!-- LABEL -->
          <span class="text-[18px] text-black">
            Timeouts remaining for this set -
          </span>

          <!-- BLUE NUMBER -->
           <div class="flex flex-row items-center gap-3">
          <span class="text-[26px] font-semibold text-[#283891]">
            {timeouts}
          </span>

          <!-- BUTTON STACK -->
          <div class="flex flex-col gap-1">
            <!-- UP -->
            <button
              onclick={inc}
              title="up"
              class="w-10 h-7 border border-gray-300 bg-[#F5F5F5] flex items-center justify-center"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                <path d="M3 9L7 5L11 9" stroke="black" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
            </button>

            <!-- DOWN -->
            <button
              onclick={dec}
              title="down"
              class="w-10 h-7 border border-gray-300 bg-[#F5F5F5] border-t-0 flex items-center justify-center"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                <path d="M3 5L7 9L11 5" stroke="black" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
            </button>
          </div>

        </div>
        </div>
      </div>

      <!-- Team B -->
      <div class="border border-gray-500  overflow-hidden mb-4">
        <div class="px-3 py-3 flex items-center justify-between">
          <div class="flex items-center gap-2">
            <img src={getIITImgSrc(teamB.name)} class="h-5 w-5" alt="logo" />
            <span class="font-semibold text-gray-700">IIT MADRAS</span>
          </div>
          <button
            onclick={() => {
                activeTeam = 'B'
                showTeamMenu = true
            }}
            class="text-gray-600 text-xl"
            >⋮</button>

        </div>

        <div class="grid grid-cols-2 items-center border-t border-b border-gray-500">
          <!-- big score -->
          <div class="p-6 flex items-center justify-center">
            <div class="text-[#ef4823] text-8xl font-bold leading-none">{teamB.goals}</div>
          </div>

          <!-- add goal -->
          <div class="p-6  flex items-center justify-center h-[100%] border-l border-gray-500">
            <button
              onclick={() => {
                goalTeam = 'B';
                showGoalPopup = true;
            }}

              class="flex flex-col items-center gap-2"
            >
            <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M2 17.3742L17.2058 17.207M17.2058 17.207L32.748 17.3739M17.2058 17.207L17.3742 2M17.2058 17.207L17.3739 32.748" stroke="black" stroke-width="4" stroke-linecap="round"/>
            </svg>
            <div class="text-sm tracking-wide">ADD POINT</div>
            </button>
          </div>
        </div>

        <div class="flex items-center justify-between p-1">

          <!-- LABEL -->
          <span class="text-[18px] text-black">
            Timeouts remaining for this set -
          </span>

          <!-- BLUE NUMBER -->
           <div class="flex flex-row items-center gap-3">
          <span class="text-[26px] font-semibold text-[#283891]">
            {timeouts2}
          </span>

          <!-- BUTTON STACK -->
          <div class="flex flex-col gap-1">
            <!-- UP -->
            <button
              onclick={inc2}
              title="up"
              class="w-10 h-7 border border-gray-300 bg-[#F5F5F5] flex items-center justify-center"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                <path d="M3 9L7 5L11 9" stroke="black" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
            </button>

            <!-- DOWN -->
            <button
              onclick={dec2}
              title="down"
              class="w-10 h-7 border border-gray-300 bg-[#F5F5F5] border-t-0 flex items-center justify-center"
            >
              <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
                <path d="M3 5L7 9L11 5" stroke="black" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
            </button>
          </div>

        </div>
        </div>
      </div>

      

      <!-- TIMER ROW -->
       <!-- EXACT SETS WON BLOCK -->


    <div class="px-4 mt-6 ">

   <!-- EXACT SETS WON BLOCK -->
      <div class="w-full border border-gray-300 overflow-hidden flex p-1 gap-1 mt-15">
  
  <!-- LEFT SIDE -->
  <div class="flex-1  border-gray-300">
    
    <!-- HEADER -->
    <div class="bg-[#D7EEF2]  h-[40%] py-1 text-center border-t border-gray-300">
      <span class="text-lg tracking-wide text-[#1c6c74] font-semibold">
        SETS WON
      </span>
    </div>

    <!-- SCORES -->
    <div class="grid grid-cols-2 border border-gray-300">
      
      <!-- LEFT TEAM -->
      <div class="flex flex-row items-center justify-center gap-2 border-r border-gray-300 py-1">
        <img alt ="IIT LOGO" src={leftLogo} class="w-6 h-6 object-contain" />
        <div class="text-gray-400 text-2xl font-semibold">-</div>
        <div class="text-[#1c6c74] text-3xl font-semibold">{setsA}</div>
      </div>

      <!-- RIGHT TEAM -->
      <div class="flex flex-row items-center justify-center gap-2 py-1">
        <img src={rightLogo} class="w-6 h-6 object-contain" />
        <div class="text-gray-400 text-2xl font-semibold">-</div>
        <div class="text-[#1c6c74] text-3xl font-semibold">{setsB}</div>
      </div>
    </div>

  </div>

  <!-- FINISH SET BUTTON -->
  <button
    class="w-[30%] bg-[#1c6c74] text-white text-base font-semibold flex items-center justify-center"
    onclick={() => showSetWinnerPopup = true}
  >
    FINISH SET
  </button>

</div>


    <!-- BOTTOM BAR: Add Time | Undo | End Match -->
    <div class="grid grid-cols-2 border-t-0 border border-gray-300 p-2 gap-2">


        <!-- UNDO -->
        <button 
        onclick={undo}
        class="bg-[#F7F3DF]  py-3 text-sm font-medium flex items-center justify-center"
        >
        <svg class="mr-2"width="17" height="15" viewBox="0 0 17 15" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0.146447 3.32833C-0.0488155 3.52359 -0.0488155 3.84018 0.146447 4.03544L3.32843 7.21742C3.52369 7.41268 3.84027 7.41268 4.03553 7.21742C4.2308 7.02216 4.2308 6.70557 4.03553 6.51031L1.20711 3.68188L4.03553 0.853458C4.2308 0.658195 4.2308 0.341613 4.03553 0.146351C3.84027 -0.0489113 3.52369 -0.0489113 3.32843 0.146351L0.146447 3.32833ZM0.5 3.68188V4.18188H10.7845V3.68188V3.18188H0.5V3.68188ZM10.7845 14.0227V13.5227H8.88982V14.0227V14.5227H10.7845V14.0227ZM15.955 8.85229H15.455C15.455 11.4317 13.3639 13.5227 10.7845 13.5227V14.0227V14.5227C13.9162 14.5227 16.455 11.984 16.455 8.85229H15.955ZM10.7845 3.68188V4.18188C13.3639 4.18188 15.455 6.2729 15.455 8.85229H15.955H16.455C16.455 5.72061 13.9162 3.18188 10.7845 3.18188V3.68188Z" fill="black"/>
        </svg>

         Undo
        </button>

        <!-- END MATCH -->
        <button 
        onclick={() => showEndMatchPopup = true}
        class="bg-[#ef4823] text-white py-3 text-sm font-semibold"
      >
        END MATCH
      </button>


    </div>

    </div>


    </div>
  </div>
  {#if showCardPopup}
<div class="fixed inset-0 z-50 bg-black/30 backdrop-blur-sm flex items-center justify-center">

    <PopoverBox
      title={cardType === "red" ? "Red Card to" : "Yellow Card to"}
      color={cardType === "red" ? "#ef4823" : "#f3b45a"}
      buttons={players.map(p => p.name)}
      onSelect={(playerName:string) => {
        
        // handle assignment
        if (cardType === "red") {
          console.log("RED CARD to", playerName)
          // YOUR LOGIC HERE
        } else {
          console.log("YELLOW CARD to", playerName)
        }

        showCardPopup = false
      }}
      onClose={() => showCardPopup = false}
    />
</div>
{/if}
{#if showPenaltyPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <div class="bg-white w-[350px] border border-gray-300 shadow-lg rounded-md overflow-hidden">

    <!-- HEADER -->
    <div class="flex justify-between items-center px-3 py-2 border-b border-gray-300">
      <span class="font-semibold text-gray-800 text-lg">Penalty Awarded To</span>
      <button 
        onclick={() => showPenaltyPopup = false}
        class="text-gray-700 text-xl font-bold"
      >×</button>
    </div>

    <!-- TEAM SELECT GRID -->
    <div class="grid grid-cols-2 p-3 gap-x-3">

      <!-- TEAM A BOX -->
      <button
        onclick={() => {
            selectedPenaltyTeam = teamA.name; // keep your highlight
            showPenaltyPopup = false;         // close popup
            showKickTakerPopup = true;        // open popup 1
        }}
        class="relative flex flex-col items-center justify-center gap-2 p-4 border rounded-md transition-all"
        class:border-orange-500={selectedPenaltyTeam === teamA.name}
        class:border-gray-300={selectedPenaltyTeam !== teamA.name}
      >
        <!-- ORANGE TICK -->
        {#if selectedPenaltyTeam === teamA.name}
          <div class="absolute top-2 right-2 w-6 h-6 bg-orange-500 rounded-full flex items-center justify-center text-white text-sm">
            <svg width="10" height="8" viewBox="0 0 10 8" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M1 3.63882L3.26466 5.90346C3.45992 6.09872 3.77651 6.09872 3.97177 5.90346L8.87522 1" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>
          </div>
        {/if}

        <img src={getIITImgSrc(teamA.name)} class="h-12 w-12 object-contain" />
        <span class="text-sm font-semibold">IIT {teamA.name.toUpperCase()}</span>
      </button>

      <!-- TEAM B BOX -->
      <button
        onclick={() => {
            selectedPenaltyTeam = teamB.name;
            showPenaltyPopup = false;
            showKickTakerPopup = true;
        }}

        class="relative flex flex-col items-center justify-center gap-2 p-4 border rounded-md transition-all"
        class:border-orange-500={selectedPenaltyTeam === teamB.name}
        class:border-gray-300={selectedPenaltyTeam !== teamB.name}
      >
        <!-- ORANGE TICK -->
        {#if selectedPenaltyTeam === teamB.name}
          <div class="absolute top-2 right-2 w-6 h-6 bg-orange-500 rounded-full flex items-center justify-center text-white text-sm">
            <svg width="10" height="8" viewBox="0 0 10 8" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M1 3.63882L3.26466 5.90346C3.45992 6.09872 3.77651 6.09872 3.97177 5.90346L8.87522 1" stroke="white" stroke-width="2" stroke-linecap="round"/>
            </svg>

          </div>
        {/if}

        <img src={getIITImgSrc(teamB.name)} class="h-12 w-12 object-contain" />
        <span class="text-sm font-semibold">IIT {teamB.name.toUpperCase()}</span>
      </button>

    </div>

  </div>
</div>
{/if}
{#if showKickTakerPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

    <PopoverBox
        title="Who is doing the kick?"
        buttons={players.map(p => p.name)}
        onSelect={(name: string) => {
            selectedKicker = name;
            showKickTakerPopup = false;
            showKickResultPopup = true; // open popup 2
        }}
        onClose={() => showKickTakerPopup = false}
    />

</div>
{/if}
{#if showKickResultPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

    <PopoverBox
        title="Did they get point?"
        buttons={["Yes (Goal)", "No (Miss)"]}
        onSelect={(result: string) => {
            
            console.log("Penalty by:", selectedPenaltyTeam);
            console.log("Kicker:", selectedKicker);
            console.log("Result:", result);

            // YOUR LOGIC HERE:
            // if result === "Yes (Goal)" -> addGoal to that team

            if (result.startsWith("Yes")) {
                if (selectedPenaltyTeam === teamA.name) teamA.goals++;
                else teamB.goals++;
            }

            showKickResultPopup = false;
        }}
        onClose={() => showKickResultPopup = false}
    />

</div>
{/if}
{#if showGoalPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">
  
  <div class="bg-white w-[330px] border border-gray-300 rounded-md shadow-lg overflow-hidden">

    <!-- HEADER -->
    <div class="flex justify-between items-center px-4 py-3 border-b border-[#ef4823] ">
      <span class="text-lg font-semibold text-[#ef4823]">Point Scored By</span>
      <button 
        onclick={() => showGoalPopup = false} 
        class="text-gray-600 text-xl font-bold">×</button>
    </div>

    <!-- UNKNOWN / OWN GOAL BUTTON -->
    <div class="p-3 flex flex-col gap-2">
      <button
        onclick={() => {
          if (goalTeam) addGoal(goalTeam);  // ← updates Team A or B
          console.log("Goal: Unknown / Own Goal");
          showGoalPopup = false;
        }}
        class="w-full py-3 bg-[#F8F8F8] border border-gray-300 text-gray-700 font-medium"
      >
        Other
      </button>
      <button
        onclick={() => {
          if (goalTeam) addGoal(goalTeam);  // ← updates Team A or B
          console.log("Goal: Unknown / Own Goal");
          showGoalPopup = false;
        }}
        class="w-full py-3 bg-[#F8F8F8] border border-gray-300 text-gray-700 font-medium"
      >
        Penalty (red card)
      </button>
    </div>

    <!-- DIVIDER -->
    <div class="text-center text-gray-500 text-sm pb-2">
      Or Select Player
    </div>

    <!-- PLAYER GRID -->
    <div class="grid grid-cols-2 gap-2 p-3 max-h-[260px] overflow-y-auto">

      {#each players as p}
        <button
          onclick={() => {
            if (goalTeam) addGoal(goalTeam);  // ← also updates correct team
            console.log("Goal Scored By:", p.name);
            showGoalPopup = false;
          }}
          class="py-3 bg-[#F3F3F3] border border-gray-300 text-gray-800 text-sm font-medium"
        >
          {p.name}
        </button>
      {/each}

    </div>

  </div>

</div>
{/if}
{#if showTeamMenu}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <PopoverBox
    title={activeTeam === 'A' ? "IIT GUWAHATI" : "IIT MADRAS"}
    buttons={["Add Substitute", "Change Goalkeeper"]}
    color="black"
    onSelect={(choice: string) => {
      showTeamMenu = false;

      if (choice === "Add Substitute") {
        showOutPopup = true;     // open next popup
      }

      if (choice === "Change Goalkeeper") {
        console.log("GK Change for", activeTeam);
        showOutPopup = true;
      }
    }}
    onClose={() => showTeamMenu = false}
  />

</div>
{/if}
{#if showOutPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <PopoverBox
    title="Who is going Out?"
    buttons={players.map(p => p.name)}
    color="black"
    onSelect={(name: string) => {
      outgoingPlayer = name;
      showOutPopup = false;
      showInPopup = true;    // open next popup
    }}
    onClose={() => showOutPopup = false}
  />

</div>
{/if}
{#if showInPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <PopoverBox
    title="Who is Coming In?"
    buttons={players.map(p => p.name)}
    color="black"
    onSelect={(incoming: string) => {

      console.log("Substitution for team:", activeTeam);
      console.log("OUT:", outgoingPlayer);
      console.log("IN:", incoming);

      // TODO: update your roster logic here

      showInPopup = false;
    }}
    onClose={() => showInPopup = false}
  />

</div>
{/if}
{#if showEndMatchPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <div class="bg-white w-[90%] border border-gray-300 shadow-lg rounded-md overflow-hidden">

    <!-- HEADER -->
    <div class="px-3 py-2 flex justify-between items-center">
      <span class="text-lg font-semibold text-[#ef4823]">End the Match ?</span>
      
    </div>

    <!-- ORANGE BAR -->
    <div class="w-full h-[1.5px] bg-[#ef4823] mb-3"></div>

    <!-- BUTTON ROW -->
    <div class="grid grid-cols-2 gap-2 px-3 pb-3">

      <!-- GO BACK -->
      <button
        onclick={() => showEndMatchPopup = false}
        class="py-3 bg-[#F0F0F0] text-gray-700 font-medium border border-gray-300"
      >
        Go back
      </button>

      <!-- YES -->
      <button
        onclick={() => {
          console.log("END MATCH CONFIRMED");
          showEndMatchPopup = false;
          // TODO: navigate or finish match
        }}
        class="py-3 bg-[#ef4823] text-white font-medium"
      >
        Yes
      </button>

    </div>

  </div>

</div>
{/if}
{#if showSetWinnerPopup}
<div class="fixed inset-0 bg-black/30 backdrop-blur-sm flex items-center justify-center z-50">

  <div class="bg-white w-[90%] max-w-md border border-gray-300 rounded-md shadow-lg overflow-hidden">

    <!-- HEADER -->
    <div class="p-4 flex justify-between items-center">
      <span class="text-xl font-semibold text-[#1c6c74]">Who won the set ?</span>

      <button
        onclick={() => showSetWinnerPopup = false}
        class="text-[#1c6c74] text-3xl font-bold"
      >
        ×
      </button>
    </div>

    <!-- TOP TEAL LINE -->
    <div class="w-full h-[3px] bg-[#1c6c74]"></div>

    <!-- OPTIONS GRID -->
    <div class="grid grid-cols-2 gap-3 p-4">

      <!-- TEAM A -->
      <button
          onclick={() => {
            pushHistory();
            selectedWinner = teamA.name
            setsA += 1          // ← UPDATE SET COUNT
            showSetWinnerPopup = false
          }}
        class="relative border rounded-md flex flex-col items-center justify-center p-4 cursor-pointer transition"
        class:border-[#ef4823]={selectedWinner === teamA.name}
        class:border-gray-300={selectedWinner !== teamA.name}
      >
        <!-- ORANGE CHECKMARK -->
        {#if selectedWinner === teamA.name}
        <div class="absolute top-2 right-2 w-4 h-4 bg-[#ef4823] rounded-full flex items-center justify-center">
          <svg width="14" height="12" viewBox="0 0 14 12" fill="none">
            <path d="M2 6L5.5 9.5L12 2" stroke="white" stroke-width="2" stroke-linecap="round"/>
          </svg>
        </div>
        {/if}

        <img alt="IIT LOGO" src={getIITImgSrc(teamA.name)} class="h-16 object-contain mb-2" />
        <span class="text-lg font-semibold text-gray-800">IIT {teamA.name.toUpperCase()}</span>
      </button>

      <!-- TEAM B -->
      <button
        onclick={() => {
          pushHistory();
          selectedWinner = teamB.name
          setsB += 1          // ← UPDATE SET COUNT
          showSetWinnerPopup = false
        }}
        class="relative border rounded-md flex flex-col items-center justify-center p-4 cursor-pointer transition"
        class:border-[#ef4823]={selectedWinner === teamB.name}
        class:border-gray-300={selectedWinner !== teamB.name}
      >
        {#if selectedWinner === teamB.name}
        <div class="absolute top-2 right-2 w-4 h-4 bg-[#ef4823] rounded-full flex items-center justify-center">
          <svg width="14" height="12" viewBox="0 0 14 12" fill="none">
            <path d="M2 6L5.5 9.5L12 2" stroke="white" stroke-width="2" stroke-linecap="round"/>
          </svg>
        </div>
        {/if}

        <img alt="IIT LOGO" src={getIITImgSrc(teamB.name)} class="h-16 object-contain mb-2" />
        <span class="text-lg font-semibold text-gray-800">IIT {teamB.name.toUpperCase()}</span>
      </button>

    </div>

  </div>

</div>
{/if}


</div>

<!-- <style>
  /* small tweaks to match screenshot */
  .font-extrabold { font-weight: 800; }
  /* scrollbar thin for the player lists if used elsewhere */
  .scrollbar-thin::-webkit-scrollbar { height: 6px; width: 6px; }
  .scrollbar-thin::-webkit-scrollbar-thumb { background-color: rgba(0,0,0,0.08); border-radius: 999px; }
</style> -->
