<script lang="ts">
	import { onMount, setContext } from 'svelte';

	let { children } = $props();
	let mainDiv: HTMLDivElement;
	let bgDiv: HTMLDivElement;

	let currentIndex = $state(1);
	let prevIndex = 1;

	let startXPos = 0;
	let width = 0;
	let height = 0;

	setContext('updateIndex', (index: number) => {
		if (currentIndex - 1 == index) {
			currentIndex = -1;
		}
		currentIndex = index + 1;
	});

	onMount(() => {
		startXPos = (mainDiv.children[currentIndex] as HTMLButtonElement).getBoundingClientRect().x;
		width = (mainDiv.children[currentIndex] as HTMLButtonElement).clientWidth;
		height = (mainDiv.children[currentIndex] as HTMLButtonElement).clientHeight;

		for (let i = 1; i < mainDiv.children.length; i++) {
			(mainDiv.children[i] as HTMLButtonElement).dataset.index = (i - 1).toString();
		}
	});

	$effect(() => {
		width = (mainDiv.children[currentIndex] as HTMLButtonElement).clientWidth;
		height = (mainDiv.children[currentIndex] as HTMLButtonElement).clientHeight;

		bgDiv.style.width = width + 'px';
		bgDiv.style.height = height + 'px';
		bgDiv.style.left =
			(mainDiv.children[currentIndex] as HTMLButtonElement).getBoundingClientRect().x + 'px';

		(mainDiv.children[prevIndex] as HTMLButtonElement).style.color = 'black';
		(mainDiv.children[currentIndex] as HTMLButtonElement).style.color = 'white';

		prevIndex = currentIndex;
	});
</script>

<div
	bind:this={mainDiv}
	class="border-custom-gray relative flex w-fit flex-row rounded-full border p-1.5"
>
	<div
		bind:this={bgDiv}
		class="bg-custom-blue absolute z-[-1] w-20 rounded-full transition-all duration-200 ease-in-out"
	></div>
	{@render children()}
</div>
