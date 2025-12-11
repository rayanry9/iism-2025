<script lang="ts">
//   import { goto } from '$app/navigation'
  import footballIcon from '$lib/assets/sport/football.webp'
  import type { IITNames } from '$lib/types/iitNames'
  import { getIITImgSrc } from '$lib/utility/iitLogoImgSrc'

  // teams
  let teams: IITNames[] = ['Guwahati', 'Madras']

  // scores
  type TeamState = {
    name: IITNames
    goals: number
    redCard: boolean
    yellowCard: boolean
  }

  let teamA: TeamState = { name: teams[0], goals: 0, redCard: false, yellowCard: false }
  let teamB: TeamState = { name: teams[1], goals: 0, redCard: false, yellowCard: false }

  // history for undo
  let history: [TeamState, TeamState][] = []


  function pushHistory() {
    history.push(JSON.parse(JSON.stringify([teamA, teamB])))
    if (history.length > 50) history.shift()
  }

  function addGoal(team: 'A' | 'B') {
    pushHistory()
    if (team === 'A') teamA.goals++
    else teamB.goals++
  }

  function toggleRed(team: 'A' | 'B') {
    pushHistory()
    if (team === 'A') teamA.redCard = !teamA.redCard
    else teamB.redCard = !teamB.redCard
  }

  function toggleYellow(team: 'A' | 'B') {
    pushHistory()
    if (team === 'A') teamA.yellowCard = !teamA.yellowCard
    else teamB.yellowCard = !teamB.yellowCard
  }

  function undo() {
    const prev = history.pop()
    if (!prev) return
    // prev was snapshot of [teamA, teamB]
    const [prevA, prevB] = prev
    teamA = JSON.parse(JSON.stringify(prevA))
    teamB = JSON.parse(JSON.stringify(prevB))
  }

  // timer
  let timerRunning = false
  let timerSeconds = 0 // seconds elapsed
  let timerInterval: number | null = null

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

      <img src={footballIcon} alt="ball" class="h-10 object-contain" />
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
          <div class="text-gray-600">⋮</div>
        </div>

        <div class="grid grid-cols-2 items-center border-t border-b border-gray-500">
          <!-- big score -->
          <div class="p-6 flex items-center justify-center">
            <div class="text-[#ef4823] text-8xl font-bold leading-none">{teamA.goals}</div>
          </div>

          <!-- add goal -->
          <div class="p-6 h-[100%] flex items-center justify-center border-l border-gray-500">
            <button
              onclick={() => addGoal('A')}
              class="flex flex-col items-center gap-2"
            >
              <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M2 17.3742L17.2058 17.207M17.2058 17.207L32.748 17.3739M17.2058 17.207L17.3742 2M17.2058 17.207L17.3739 32.748" stroke="black" stroke-width="4" stroke-linecap="round"/>
            </svg>

              <div class="text-sm tracking-wide">ADD GOAL</div>
            </button>
          </div>
        </div>

        <div class="px-4 py-4 flex gap-3">
          <button
            onclick={() => toggleRed('A')}
            class="flex-1 border  py-2 font-semibold text-sm"
            style="border-color: #ef4823; color: #ef4823; background: white;"
          >
            RED CARD
          </button>

          <button
            onclick={() => toggleYellow('A')}
            class="flex-1 border  py-2 font-semibold text-sm"
            style="border-color: #f3b45a; color: #f3b45a; background: white;"
          >
            YELLOW CARD
          </button>
        </div>
      </div>

      <!-- Team B -->
      <div class="border border-gray-500  overflow-hidden mb-4">
        <div class="px-3 py-3 flex items-center justify-between">
          <div class="flex items-center gap-2">
            <img src={getIITImgSrc(teamB.name)} class="h-5 w-5" alt="logo" />
            <span class="font-semibold text-gray-700">IIT MADRAS</span>
          </div>
          <div class="text-gray-600">⋮</div>
        </div>

        <div class="grid grid-cols-2 items-center border-t border-b border-gray-500">
          <!-- big score -->
          <div class="p-6 flex items-center justify-center">
            <div class="text-[#ef4823] text-8xl font-bold leading-none">{teamB.goals}</div>
          </div>

          <!-- add goal -->
          <div class="p-6  flex items-center justify-center h-[100%] border-l border-gray-500">
            <button
              onclick={() => addGoal('B')}
              class="flex flex-col items-center gap-2"
            >
            <svg width="35" height="35" viewBox="0 0 35 35" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M2 17.3742L17.2058 17.207M17.2058 17.207L32.748 17.3739M17.2058 17.207L17.3742 2M17.2058 17.207L17.3739 32.748" stroke="black" stroke-width="4" stroke-linecap="round"/>
            </svg>
            <div class="text-sm tracking-wide">ADD GOAL</div>
            </button>
          </div>
        </div>

        <div class="px-4 py-4 flex gap-3">
          <button
            onclick={() => toggleRed('B')}
            class="flex-1 border  py-2 font-semibold text-sm"
            style="border-color: #ef4823; color: #ef4823; background: white;"
          >
            RED CARD
          </button>

          <button
            onclick={() => toggleYellow('B')}
            class="flex-1 border  py-2 font-semibold text-sm"
            style="border-color: #f3b45a; color: #f3b45a; background: white;"
          >
            YELLOW CARD
          </button>
        </div>
      </div>

      <!-- RECORD PENALTY -->
      <div class="px-4">
        <button class="w-full bg-[#F0F0F0] text-gray-700 py-3  font-semibold">
          RECORD PENALTY
        </button>
      </div>

      <!-- TIMER ROW -->
    <div class="px-4 mt-6 ">

    <!-- TOP BAR: Reset | Timer | Play -->
    <div class="grid grid-cols-[80px_1fr_80px] border border-gray-500 bg-white">

        <!-- RESET -->
        <div class="p-2">
            <button 
        onclick={resetTimer}
        class="flex flex-col items-center justify-center border border-gray-500 py-3 bg-[#F0F0F0] w-[73.25px] h-[73.25px]"
        >
        <svg width="17" height="20" viewBox="0 0 17 20" fill="none">
<path d="M8.0472 3.32833C7.85194 3.52359 7.85194 3.84017 8.0472 4.03544L11.2292 7.21742C11.4244 7.41268 11.741 7.41268 11.9363 7.21742C12.1316 7.02216 12.1316 6.70557 11.9363 6.51031L9.10786 3.68188L11.9363 0.853456C12.1316 0.658193 12.1316 0.341611 11.9363 0.146348C11.741 -0.0489125 11.4244 -0.0489125 11.2292 0.146348L8.0472 3.32833ZM13.6948 5.71793L14.0299 5.34678L13.6948 5.71793ZM16.2603 10.7767L15.7629 10.8277L16.2603 10.7767ZM14.7749 16.2508L15.1783 16.5462L15.1783 16.5462L14.7749 16.2508ZM10.0043 19.319L9.9028 18.8294L10.0043 19.319ZM4.40717 18.3998L4.15443 18.8312L4.15443 18.8312L4.40717 18.3998ZM0.86837 13.967L0.391682 14.1179L0.86837 13.967ZM1.2118 8.30531L0.756851 8.0979L0.756851 8.0979L1.2118 8.30531ZM5.45919 4.79159C5.71259 4.68183 5.82903 4.38744 5.71927 4.13404C5.60951 3.88065 5.31512 3.76421 5.06173 3.87397L5.26046 4.33278L5.45919 4.79159ZM8.40076 3.68188L8.40076 4.18188C10.2329 4.18188 11.9998 4.86144 13.3598 6.08908L13.6948 5.71793L14.0299 5.34678C12.4861 3.95327 10.4804 3.18188 8.40076 3.18188L8.40076 3.68188ZM13.6948 5.71793L13.3598 6.08908C14.7197 7.31671 15.576 9.00514 15.7629 10.8277L16.2603 10.7767L16.7577 10.7257C16.5455 8.65687 15.5736 6.74029 14.0299 5.34678L13.6948 5.71793ZM16.2603 10.7767L15.7629 10.8277C15.9498 12.6502 15.454 14.4773 14.3715 15.9554L14.7749 16.2508L15.1783 16.5462C16.4071 14.8684 16.9698 12.7945 16.7577 10.7257L16.2603 10.7767ZM14.7749 16.2508L14.3715 15.9554C13.289 17.4335 11.6968 18.4575 9.9028 18.8294L10.0043 19.319L10.1058 19.8086C12.1421 19.3865 13.9496 18.2241 15.1783 16.5462L14.7749 16.2508ZM10.0043 19.319L9.9028 18.8294C8.10884 19.2012 6.24071 18.8944 4.6599 17.9683L4.40717 18.3998L4.15443 18.8312C5.94885 19.8824 8.06939 20.2306 10.1058 19.8086L10.0043 19.319ZM4.40717 18.3998L4.6599 17.9683C3.07909 17.0423 1.89796 15.5628 1.34506 13.8161L0.86837 13.967L0.391682 14.1179C1.01929 16.1006 2.36002 17.78 4.15443 18.8312L4.40717 18.3998ZM0.86837 13.967L1.34506 13.8161C0.792155 12.0694 0.906781 10.1797 1.66676 8.51271L1.2118 8.30531L0.756851 8.0979C-0.105814 9.99019 -0.235929 12.1352 0.391682 14.1179L0.86837 13.967ZM1.2118 8.30531L1.66676 8.51271C2.42673 6.84568 3.77803 5.51979 5.45919 4.79159L5.26046 4.33278L5.06173 3.87397C3.15341 4.70056 1.61952 6.20561 0.756851 8.0979L1.2118 8.30531Z" fill="black"/>
</svg>

        <span class="text-xs text-gray-700 mt-1">Reset</span>
        </button>
        </div>

        <!-- TIMER DISPLAY -->
        <div class="flex items-center justify-center text-3xl font-bold tracking-wide">
        {formatTime(timerSeconds)}
        </div>

        <!-- PLAY / PAUSE -->
        <div class="flex items-center justify-center ">
            <button 
                onclick={toggleTimer}
                class="bg-[#1f57a0] flex items-center justify-center w-[73.25px] h-[73.25px]"
                >
                {#if timerRunning}
                    <svg class="w-8 h-8 text-white" fill="white" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-width="1" d="M6 6h4v12H6zM14 6h4v12h-4z"/>
                    </svg>
                {:else}
                    <svg class="w-8 h-8 text-white" fill="white" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-width="1" d="M5 3v18l15-9-15-9z"/>
                    </svg>
                {/if}
            </button>
        </div>

    </div>

    <!-- BOTTOM BAR: Add Time | Undo | End Match -->
    <div class="grid grid-cols-3 border-t-0 border border-gray-500 p-2 gap-2">

        <!-- ADD TIME -->
        <button 
        onclick={addTime}
        class="bg-[#DDF2FA] border border-gray-400 py-3 text-sm font-medium flex items-center justify-center"
        >
        <svg class="mr-2"width="13" height="13" viewBox="0 0 13 13" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0.5 6.36054L6.29634 6.29682M6.29634 6.29682L12.2209 6.36041M6.29634 6.29682L6.36054 0.5M6.29634 6.29682L6.36041 12.2209" stroke="black" stroke-linecap="round"/>
        </svg>

         Add time
        </button>

        <!-- UNDO -->
        <button 
        onclick={undo}
        class="bg-[#F7F3DF] border border-gray-400 py-3 text-sm font-medium flex items-center justify-center"
        >
        <svg class="mr-2"width="17" height="15" viewBox="0 0 17 15" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M0.146447 3.32833C-0.0488155 3.52359 -0.0488155 3.84018 0.146447 4.03544L3.32843 7.21742C3.52369 7.41268 3.84027 7.41268 4.03553 7.21742C4.2308 7.02216 4.2308 6.70557 4.03553 6.51031L1.20711 3.68188L4.03553 0.853458C4.2308 0.658195 4.2308 0.341613 4.03553 0.146351C3.84027 -0.0489113 3.52369 -0.0489113 3.32843 0.146351L0.146447 3.32833ZM0.5 3.68188V4.18188H10.7845V3.68188V3.18188H0.5V3.68188ZM10.7845 14.0227V13.5227H8.88982V14.0227V14.5227H10.7845V14.0227ZM15.955 8.85229H15.455C15.455 11.4317 13.3639 13.5227 10.7845 13.5227V14.0227V14.5227C13.9162 14.5227 16.455 11.984 16.455 8.85229H15.955ZM10.7845 3.68188V4.18188C13.3639 4.18188 15.455 6.2729 15.455 8.85229H15.955H16.455C16.455 5.72061 13.9162 3.18188 10.7845 3.18188V3.68188Z" fill="black"/>
        </svg>

         Undo
        </button>

        <!-- END MATCH -->
        <button 
        onclick={endMatch}
        class="bg-[#ef4823] text-white py-3 text-sm font-semibold"
        >
        END MATCH
        </button>

    </div>

    </div>


    </div>
  </div>
</div>

<!-- <style>
  /* small tweaks to match screenshot */
  .font-extrabold { font-weight: 800; }
  /* scrollbar thin for the player lists if used elsewhere */
  .scrollbar-thin::-webkit-scrollbar { height: 6px; width: 6px; }
  .scrollbar-thin::-webkit-scrollbar-thumb { background-color: rgba(0,0,0,0.08); border-radius: 999px; }
</style> -->
