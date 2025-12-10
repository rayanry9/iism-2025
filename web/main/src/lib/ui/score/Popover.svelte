<script lang="ts">
  // PROPS in runes mode
  let { 
    title = "Confirm wicket",
    buttons = [],
    onSelect = (label: string) => {},
    onClose = () => {}
  } = $props()
</script>

<!-- OUTER WRAPPER -->
<div class="border border-red-400 rounded-md bg-white shadow-lg w-[90%]  relative">

  <!-- HEADER -->
  <div class="flex justify-between items-center p-3">
    <h2 class="text-red-500 font-semibold text-lg">{title}</h2>

    <!-- CLOSE BUTTON -->
    <button
      onclick={() => onClose()}
      class="text-red-500 text-2xl font-bold leading-none"
    >
      ×
    </button>
  </div>
  <div class="w-[100%] h-[1.5px] bg-[#ef4823] mb-3 "></div>

  <!-- BUTTON GRID -->
  <div class="grid grid-cols-2 gap-3 p-3">
    {#each buttons as b}
      <button
        onclick={() => onSelect(b)}
        class="w-full py-3 bg-[#eeeeee] rounded-md text-gray-700 text-md shadow-sm"
      >
        {b}
      </button>
    {/each}
  </div>

</div>
