<script lang="ts">
	import 'cropperjs';
	import { innerWidth } from 'svelte/reactivity/window';
	let { children, class: className, filled = $bindable() } = $props();

	let dialog = $state<HTMLDialogElement>();
	let input = $state<HTMLInputElement>();
	let files = $state<FileList>();
	let croppedSelection = $state();
	$effect(() => {
		filled = !(files == undefined || files.length == 0);
	});
	console.log(innerWidth.current);
</script>

<label class="button-text flex flex-col gap-y-1 {className}">
	<div class="button-text">
		{@render children()}
	</div>
	<input
		hidden
		bind:this={input}
		bind:files
		onchange={() => {
			if (files![0].size > 10 * 1024 * 1024) {
				files = undefined;
			} else {
				dialog?.showModal();
			}
		}}
		type="file"
		accept="image/png, image/jpeg"
		class="bg-custom-light-gray"
		name="profile_pic"
	/>
	<div
		class="border-custom-gray flex w-full items-center justify-center border-2 border-dashed {files ==
			undefined || files.length == 0
			? 'flex-col py-12'
			: 'p-6'}"
	>
		{#if input == undefined || files == undefined || files.length == 0}
			<div class="mx-auto flex w-min flex-col items-center justify-center gap-y-2">
				<div class="text-center opacity-90">JPEG, PNG formats, up to 10 MB</div>
				<button
					type="button"
					class="button-text bg-custom-orange px-6 py-2 text-nowrap whitespace-nowrap text-white"
					onclick={() => {
						input?.click();
					}}>Choose a file</button
				>
			</div>
		{:else}
			<img
				src={URL.createObjectURL(files[0])}
				alt="preview"
				class="aspect-square h-40 object-cover"
			/>
			<button
				class="button-text bg-custom-orange ml-6 px-6 py-2 text-nowrap whitespace-nowrap text-white"
				onclick={() => {
					input?.click();
				}}>Change</button
			>
		{/if}
	</div>
</label>
<dialog bind:this={dialog} class="mx-auto my-auto rounded-md p-6">
	<section class="flex flex-col">
		<div class="title-text mb-4 w-fit">Crop Image</div>
		<div class="size-[30rem] 2xl:size-[40rem]">
			<cropper-canvas background class="h-full">
				<cropper-image
					src={files != undefined ? URL.createObjectURL(files[0]) : ''}
					alt="Picture"
					scalable
					translatable
				></cropper-image>
				<cropper-shade></cropper-shade>
				<cropper-handle action="move" plain></cropper-handle>
				<cropper-selection
					bind:this={croppedSelection}
					x={(innerWidth.current ?? 0) > 1536 ? '120' : '40'}
					y={(innerWidth.current ?? 0) > 1536 ? '120' : '40'}
					outlined
					width="400"
					height="400"
					aspect-ratio="1"
				>
					<cropper-grid role="grid" covered></cropper-grid>
					<cropper-handle action="move" plain></cropper-handle>
				</cropper-selection>
			</cropper-canvas>
		</div>
		<div class="mt-4 flex flex-row items-center justify-center gap-x-8">
			<button
				type="button"
				class="button-text border-custom-gray border bg-white px-6 py-2 text-nowrap whitespace-nowrap hover:cursor-pointer hover:brightness-95"
				onclick={() => {
					input!.value = '';
					files = undefined;
					dialog?.close();
				}}>Cancel</button
			>
			<button
				type="button"
				class="button-text bg-custom-orange px-6 py-2 text-nowrap whitespace-nowrap text-white hover:cursor-pointer hover:brightness-95"
				onclick={async () => {
					const canvas = (await (croppedSelection as any).$toCanvas()) as HTMLCanvasElement;
					const blob: Blob = await new Promise((resolve) => {
						canvas.toBlob((b) => resolve(b!), 'image/png', 100);
					});
					const file = new File([blob], 'cropped_' + files![0].name, {
						type: 'image/png'
					});
					const dt = new DataTransfer();
					dt.items.add(file);
					input!.files = dt.files;
					files = dt.files;

					input!.dispatchEvent(new Event('change', { bubbles: true }));
					dialog?.close();
				}}>Confirm</button
			>
		</div>
	</section>
</dialog>
