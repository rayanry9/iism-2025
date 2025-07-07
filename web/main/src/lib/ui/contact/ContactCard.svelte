<script lang="ts">
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
		<img class="-mr-2 h-40 xl:-mr-4 xl:h-52 2xl:h-60" src={imgSrc} alt={name} />

		<div class="flex flex-col items-end self-end">
			<div class="title-text ml-6 xl:ml-8 2xl:ml-10">{name}</div>
			<p class="mt-1 mb-3 ml-3 2xl:mt-2 2xl:mb-4">{designation}</p>
			<div
				class="tags-text bg-custom-teal w-full -skew-x-[14deg] px-7 py-4 text-center leading-0 text-white 2xl:px-10 2xl:py-5"
			>
				<div class="skew-x-[14deg]">
					{phone}
				</div>
			</div>
		</div>
	</div>
</div>
