 <script>
    // @ts-nocheck
	// Import JSON directly from /stories/index.json
	// Path is relative to *project root*, not this file
	import storiesData from '../../../../static/stories/index.json';
    
	let scrollContainer;
    
	// Create final stories array with full image paths
	let stories = storiesData.map(s => ({
		...s,
		image: `/stories/images/${s.image}` // Construct image path
	}));

	function scrollLeft() {
        if (!scrollContainer) return;

        scrollContainer.scrollBy({
            left: -(scrollContainer.offsetWidth * 0.9),
            behavior: "smooth"
        });
    }

    function scrollRight() {
        if (!scrollContainer) return;

        scrollContainer.scrollBy({
            left: scrollContainer.offsetWidth * 0.9,
            behavior: "smooth"
        });
    }
</script>

<section class="w-full py-16 flex flex-col items-center">
	<h2 class="text-center mb-2">TOP STORIES</h2>

	<p class="text-center text-black mb-12">
		See What is Happening Through top stories and Updates
	</p>

	<!-- Horizontal Scroll -->
	<div
		bind:this={scrollContainer}
		class="flex gap-10 w-11/12 xl:w-10/12 overflow-x-auto snap-x snap-mandatory px-2 pb-4 scroll-smooth"
		style="scrollbar-width: none;"
	>
		<style>
			div::-webkit-scrollbar {
				display: none;
			}
		</style>

		{#each stories as story}
        <div class="story-card min-w-[300px] md:min-w-[380px] snap-start flex-shrink-0 flex flex-col rounded-xl border-[2px] border-[#D9D9D9] overflow-hidden bg-white">
            <img src={story.image} alt={story.title} class="w-full aspect-[4/3] h-[250px] object-cover" />

            <div class="px-6 py-4 flex justify-between items-center">
                <p class="title-text">{story.title}</p>

                <a 
                    href={story.link}
                    class="button-text px-7 py-2 rounded-full
                        bg-[#D2EDF2] text-[#0A4C62]
                        border border-[#0A4C62]
                        hover:bg-custom-blue hover:border-custom-blue hover:text-white
                        transition"
                >
                    VIEW
                </a>
            </div>
        </div>
    {/each}

	</div>

	<!-- Navigation Buttons -->
	<div class="mt-12 flex items-center gap-6">

		<!-- VIEW ALL -->
		<a href="/stories" class="inline-block">
			<div 
				class="-skew-x-6 cursor-pointer
					   rounded-[8px] border border-[#0A4C62]
					   bg-[#D2EDF2] text-[#0A4C62]
					   px-8 py-3
					   hover:bg-custom-blue hover:text-white hover:border-custom-blue transition"
			>
				<span class="skew-x-6 button-text flex items-center gap-2">
					VIEW ALL <span class="inline-block text-lg">↗</span>
				</span>
			</div>
		</a>

		<!-- LEFT -->
		<button on:click={scrollLeft} class="inline-block">
			<div 
				class="-skew-x-6 cursor-pointer
					   rounded-[8px] border border-[#D3D3D3]
					   bg-white text-black
					   px-4 py-3"
			>
				<span class="skew-x-6 text-xl">←</span>
			</div>
		</button>

		<!-- RIGHT -->
		<button on:click={scrollRight} class="inline-block">
			<div 
				class="-skew-x-6 cursor-pointer
					   rounded-[8px] border border-[#D3D3D3]
					   bg-white text-black
					   px-4 py-3"
			>
				<span class="skew-x-6 text-xl">→</span>
			</div>
		</button>

	</div>
</section>
