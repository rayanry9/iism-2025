<script lang="ts">
	import asideBg from '$lib/assets/team-aside-bg.webp';
	import type { IITNames } from '$lib/types/iitNames';
	import { getAllIITNames, getIITImgSrc } from '$lib/utility/iitLogoImgSrc';

	let { activeIIT = $bindable() }: { activeIIT: IITNames | undefined | '' } = $props();
</script>

<aside class="mr-20 -ml-64 hidden w-fit max-w-fit min-w-fit -skew-x-12 flex-row xl:flex">
	<div class="bg-custom-dark-blue relative mr-4 flex w-[20rem] flex-row overflow-x-clip">
		<img
			src={asideBg}
			alt="aside bg"
			class="absolute -top-12 left-48 w-[16rem] skew-x-12 opacity-30"
		/>
		<div class="border-l-custom-blue z-10 ml-auto h-full border-l-8"></div>
		<div class="border-l-custom-light-blue z-10 h-full border-l-8"></div>
	</div>
	<div
		class="my-12 flex h-[calc(100vh-10rem)] flex-col gap-y-6 overflow-y-scroll pr-8"
		style="scrollbar-color: #FDB424 #F0F0F0; scrollbar-width:auto ;"
	>
		{#each getAllIITNames() as iit}
			<button
				class="{activeIIT == iit
					? 'outline-custom-dark-yellow'
					: 'outline-custom-gray'} hover:bg-custom-light-blue/10 my-1 w-fit self-center px-10 py-6 outline-2 transition-colors hover:cursor-pointer xl:ml-4"
				onclick={() => {
					activeIIT = iit;
				}}
			>
				<img
					src={getIITImgSrc(iit)}
					class="skew-x-12 xl:w-16 2xl:w-20"
					alt={'IIT ' + iit + ' logo'}
				/>
			</button>
		{/each}
	</div>
</aside>
