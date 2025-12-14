<script lang="ts">
	import type { IITNames } from '$lib/types/iitNames';
	import { getIITImgSrc, getIITShortCode } from '$lib/utility/iitLogoImgSrc';
	import { getSportFromSportId, isSportFemale, isSportMixed } from '$lib/utility/sport';
	import { getSportImageSrc } from '$lib/utility/sportImgSrc';
	import menSvg from '$lib/assets/icons/men.svg';
	import womenSvg from '$lib/assets/icons/female.svg';
	import type { Snippet } from 'svelte';
	import pinImg from '$lib/assets/icons/pin.svg';

	let {
		sportId,
		startTime,
		subCTA,
		matchData,
		team1,
		team2,
		pool,
		liveStreamLink,
		isSportAthletic = false,
		athleticSportName,
		participants
	}: {
		sportId: number;
		startTime: string;
		subCTA: Snippet;
		matchData: GetPoolMatchDataById;
		team1: IITNames;
		team2: IITNames;
		pool: string;
		liveStreamLink: string | null;
		isSportAthletic?: boolean;
		athleticSportName?: string;
		participants?: IITNames[];
	} = $props();
</script>

<div class="border-custom-gray flex w-full border max-xl:flex-col">
	<div class="border-b-custom-gray flex w-full grow border-b">
		<div class="title-text relative z-20 flex w-1/2 flex-col items-center overflow-clip">
			<div
				class="bg-custom-light-blue absolute z-1 h-full w-full"
				style="clip-path: polygon(0% 0%, 80% 0%, 95% 100%, 0% 100%);"
			></div>
			<div
				class="bg-custom-blue absolute z-2 h-full w-full"
				style="clip-path: polygon(0% 0%, 91% 0%, 86% 100%, 0% 100%);"
			></div>
			<div
				class="bg-custom-dark-blue absolute z-3 h-full w-full"
				style="clip-path: polygon(0% 0%, 100% 0%, 80% 100%, 0% 100%);"
			></div>
			<div class="z-20 my-4 flex gap-x-2 text-center text-white">
				{getSportFromSportId(sportId)?.toUpperCase()}
				<div class="flex">
					<img src={isSportFemale(sportId) ? womenSvg : menSvg} alt="gender" />
					{#if isSportMixed(sportId)}
						<img src={womenSvg} alt="gender" />
					{/if}
				</div>
			</div>
			<img
				src={getSportImageSrc(getSportFromSportId(sportId) ?? 'Athletics')}
				alt="sport"
				class="absolute -bottom-2/5 z-20 h-full max-xl:-ml-[40%] xl:-ml-[60%] 2xl:-ml-[50%]"
			/>
		</div>
		<div class="flex w-1/2 flex-col items-center justify-center gap-y-2 py-4">
			<div class="flex flex-col items-center">
				<p class="text-custom-orange">Started At</p>
				<h2>{startTime}</h2>
			</div>

			{@render subCTA()}
			<a href={liveStreamLink} target="_blank" class="hidden xl:block">
				<button
					class="{liveStreamLink
						? 'bg-custom-orange'
						: 'bg-custom-gray'} flex w-fit items-center gap-x-3 rounded-full px-6 py-1.5 text-white"
				>
					<svg
						width="14"
						height="16"
						viewBox="0 0 14 16"
						fill="none"
						xmlns="http://www.w3.org/2000/svg"
					>
						<path
							d="M0 14.314V1.00167C0 0.233265 0.830617 -0.248033 1.49728 0.134081L13.068 6.7661C13.737 7.1496 13.7385 8.11411 13.0707 8.49971L1.5 15.18C0.833333 15.5649 0 15.0838 0 14.314Z"
							fill="white"
						/>
					</svg>
					{#if liveStreamLink}
						WATCH
					{:else}
						N/A
					{/if}
				</button>
			</a>
		</div>
	</div>
	<div class="hidden"></div>
	<div class="relative grid shrink-0 grid-cols-[1fr_auto_1fr] px-3 py-5 max-xl:w-full xl:w-1/2">
		{#if !isSportAthletic}
			<div class="flex flex-col items-center justify-center gap-y-1 xl:gap-y-2">
				<img src={getIITImgSrc(team1)} alt={team1} class="size-16 xl:size-20 2xl:size-24" />
				<div class="button-text block text-center">
					IIT{getIITShortCode(team1).toUpperCase()}
				</div>
			</div>
			{#if getSportFromSportId(sportId) == 'Cricket'}
				<div class="flex items-center gap-x-1">
					<div class="flex flex-col items-center">
						<div class="text-custom-orange title-text">
							{matchData.team1Score}-{matchData.team1Wickets}
						</div>
						<div class="flex flex-col">
							Over {Math.floor(
								matchData.team1Balls / 6
							)}{#if matchData.team1Balls % 6 != 0}.{matchData.team1Balls % 6}{/if}
						</div>
					</div>

					<div class="bg-custom-gray mx-3 h-12 w-px -skew-x-12"></div>

					<div class="flex flex-col items-center">
						<div class="text-custom-orange title-text">
							{matchData.team2Score}-{matchData.team2Wickets}
						</div>
						<div class="flex flex-col">
							Over {Math.floor(
								matchData.team2Balls / 6
							)}{#if matchData.team2Balls % 6 != 0}.{matchData.team2Balls % 6}{/if}
						</div>
					</div>
				</div>
			{:else if getSportFromSportId(sportId) == 'Volleyball'}
				<div class="text-custom-orange my-4 grid grid-cols-[1fr_auto_1fr] gap-x-3">
					{#each [0, 1, 2, 3, 4] as idx}
						<p class="">{matchData.team1Score[idx] ?? 0}</p>
						<p class="">:</p>
						<p class="">{matchData.team2Score[idx] ?? 0}</p>
					{/each}
				</div>
			{:else}
				<h1 class="text-custom-dark-yellow my-auto px-1">
					{matchData?.team1Score[0] ?? 0} : {matchData?.team2Score[0] ?? 0}
				</h1>
			{/if}
			<div class="flex flex-col items-center justify-center gap-y-1 xl:gap-y-2">
				<img src={getIITImgSrc(team2)} alt={team2} class="size-16 xl:size-20 2xl:size-24" />
				<div class="button-text block text-center">
					IIT{getIITShortCode(team2).toUpperCase()}
				</div>
			</div>
			<div
				class="border-t-custom-gray absolute right-0 left-0 mx-auto w-fit border-t py-2 max-xl:top-0 xl:bottom-0"
			>
				<div class="h-full w-1/3"></div>
				{pool}
				<div class="h-full w-1/3"></div>
			</div>
		{:else}
			<div class="flex w-full flex-col items-center px-8 py-6">
				<div class="button-text text-custom-blue">{athleticSportName}</div>
				<div class="flex flex-wrap gap-3">
					{#each participants as parti (parti)}
						<img src={getIITImgSrc(parti)} alt={parti} class="size-4" />
					{/each}
				</div>
			</div>
		{/if}
		<a href={liveStreamLink} target="_blank" class="xl:hidden">
			<button
				class="absolute {liveStreamLink
					? 'bg-custom-orange'
					: 'bg-custom-gray'} right-0 bottom-0 left-0 mx-auto flex w-fit translate-y-1/2 items-center gap-x-3 rounded-full px-4 py-3 text-white"
			>
				<svg
					width="14"
					height="16"
					viewBox="0 0 14 16"
					fill="none"
					xmlns="http://www.w3.org/2000/svg"
				>
					<path
						d="M0 14.314V1.00167C0 0.233265 0.830617 -0.248033 1.49728 0.134081L13.068 6.7661C13.737 7.1496 13.7385 8.11411 13.0707 8.49971L1.5 15.18C0.833333 15.5649 0 15.0838 0 14.314Z"
						fill="white"
					/>
				</svg>
				{#if liveStreamLink}
					WATCH
				{:else}
					N/A
				{/if}
			</button>
		</a>
	</div>
</div>
