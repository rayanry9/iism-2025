<script lang="ts">
	import { Select, type WithoutChildren } from 'bits-ui';
	import chevronUpDownSvg from '$lib/assets/icons/chevron-up-down.svg';

	type Props = Select.RootProps & {
		placeholder?: string;
		items: { value: string; label: string; disabled?: boolean }[];
		contentProps?: WithoutChildren<Select.ContentProps>;
		// any other specific component props if needed
	};

	let {
		value = $bindable(),
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
			class="bg-custom-light-gray border-custom-gray focus:ring-custom-orange flex h-full border px-5 py-2 text-start font-normal focus:ring-2 focus:outline-none"
		>
			{selectedLabel ? selectedLabel : placeholder}
			<img src={chevronUpDownSvg} alt="chevron" class="ml-auto" />
		</Select.Trigger>
		<Select.Portal>
			<Select.Content
				{...contentProps}
				class="bg-custom-light-gray mt-2 w-[var(--bits-select-anchor-width)] rounded-sm p-2"
			>
				<Select.ScrollUpButton>^</Select.ScrollUpButton>
				<Select.Viewport class="w-full">
					{#each items as { value, label, disabled } (value)}
						<Select.Item
							{value}
							{label}
							{disabled}
							class="bg-custom-light-gray data-selected:bg-custom-orange/90 w-full self-start px-3 py-3 not-last:mb-2 data-highlighted:brightness-95 data-selected:text-white"
							>{label}</Select.Item
						>
					{/each}
				</Select.Viewport>
				<Select.ScrollDownButton>v</Select.ScrollDownButton>
			</Select.Content>
		</Select.Portal>
	</Select.Root>
</label>
