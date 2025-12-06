<script lang="ts">
	import mailIcon from '$lib/assets/icons/mail.svg';
	let {
		imgSrc,
		name,
		designation,
		phone,
		mail
	}: { imgSrc: string; name: string; designation: string; phone: string; mail: string } = $props();
</script>

<div class="flex flex-col items-center">
	<div class="flex text-nowrap">
		<img class="3xl:h-64 -mr-2 h-40 xl:-mr-4 xl:h-52 2xl:h-60" src={imgSrc} alt={name} />

		<div class="flex flex-col items-end self-end">
			<div class="title-text ml-6 xl:ml-8 2xl:ml-10">{name}</div>
			<p class="mt-1 mb-3 ml-3 2xl:mt-2 2xl:mb-4">{designation}</p>
			<div
				class="tags-text bg-custom-teal w-full -skew-x-[14deg] px-7 py-4 text-center leading-0 text-white 2xl:px-10 2xl:py-5"
			>
				<div class="skew-x-14">
					{phone}
				</div>
			</div>
		</div>
	</div>

	{#if mail != ''}
		<div class="3xl:pr-6 w-full max-2xl:pr-5">
			<div class="border-custom-teal bg-custom-pastel-blue mt-4 w-full -skew-x-[14deg] border">
				<div class=" text-custom-teal flex skew-x-[14deg] items-center">
					<img src={mailIcon} alt="mail icon" class="p-3 max-xl:size-12 xl:p-5" />
					<p>{mail}</p>
				</div>
			</div>
		</div>
	{/if}
</div>
