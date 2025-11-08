<script lang="ts">
	import { Select, type WithoutChildren } from 'bits-ui';
	import chevronUpDownSvg from '$lib/assets/icons/chevron-up-down.svg';

	type Props = Select.RootProps & {
		placeholder?: string;
		items: { value: string | undefined; label: string; disabled?: boolean; imgSrc: string }[];
		contentProps?: WithoutChildren<Select.ContentProps>;
		// any other specific component props if needed
	};

	let {
		value = $bindable(undefined),
		children,
		items,
		contentProps,
		placeholder,
		...restProps
	}: Props = $props();

	const selectedLabel = $derived(items.find((item) => item.value === value)?.label);
</script>

<!--
TypeScript Discriminated Unions + destructing (required for "bindable") do not
get along, so we shut typescript up by casting `value` to `never`, however,
from the perspective of the consumer of this component, it will be typed appropriately.
-->
<label class="button-text flex flex-col gap-y-1">
	{@render children?.()}
	<Select.Root bind:value={value as never} {...restProps}>
		<Select.Trigger
			class="text-custom-blue bg-custom-light-gray border-custom-gray focus:ring-custom-orange flex h-[full] border px-5 py-2 text-start text-xl font-normal focus:ring-2 focus:outline-none"
		>
			{selectedLabel ? selectedLabel : placeholder}
			<img src={chevronUpDownSvg} alt="chevron" class="ml-auto" />
		</Select.Trigger>
		<Select.Portal>
			<Select.Content
				{...contentProps}
				class="bg-custom-light-gray shadow-popover data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 mt-2 h-fit max-h-96  w-[var(--bits-select-anchor-width)] min-w-[var(--bits-select-anchor-width)] rounded-sm p-2 px-1 py-3 data-[side=bottom]:translate-y-1 data-[side=left]:-translate-x-1 data-[side=right]:translate-x-1 data-[side=top]:-translate-y-1"
			>
				<Select.ScrollUpButton class="mx-auto transition-all starting:opacity-0"
					>^</Select.ScrollUpButton
				>
				<Select.Viewport class="w-full">
					{#each items as { value, label, disabled, imgSrc } (value)}
						<Select.Item
							{value}
							{label}
							{disabled}
							class="bg-custom-light-gray data-selected:bg-custom-orange/90 flex w-full flex-row items-center gap-[1rem] self-start px-3 py-3 text-lg not-last:mb-2 data-highlighted:brightness-95 data-selected:text-white"
							><img alt="IIT logo" class="w-[2.5rem]" src={imgSrc} />{label}</Select.Item
						>
					{/each}
				</Select.Viewport>
				<Select.ScrollDownButton class="mx-auto transition-all">v</Select.ScrollDownButton>
			</Select.Content>
		</Select.Portal>
	</Select.Root>
</label>
