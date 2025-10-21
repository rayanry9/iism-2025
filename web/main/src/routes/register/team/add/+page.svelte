<script lang="ts">
	import { enhance } from '$app/forms';
	import { page } from '$app/state';
	import CustomInput from '$lib/ui/common/CustomInput.svelte';
	import CustomSelect from '$lib/ui/common/CustomSelect.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import CustomImagePicker from '$lib/ui/register/CustomImagePicker.svelte';
	import {
		getRegisterableSports,
		getSportFromSportId,
		getSportIdOfSport,
		isSportFemale
	} from '$lib/utility/sport.js';
	import plusIcon from '$lib/assets/icons/circle-plus.svg';
	import minusIcon from '$lib/assets/icons/circle-minus.svg';
	import { globals } from '$lib/state.svelte.js';
	import StartToastifyInstance from 'toastify-js';
	import { afterNavigate, beforeNavigate } from '$app/navigation';
	import Loading from '$lib/ui/components/Loading.svelte';

	const sportId = page.url.searchParams.get('sport');
	let profilePic = $state(false);
	let { data, form } = $props();

	$effect(() => {
		if (form != undefined) {
			StartToastifyInstance({
				text: form.success ? 'Successfully added' : 'Failed to add',
				position: 'right',
				gravity: 'bottom',
				duration: 2000,
				style: {
					background: form.success
						? 'linear-gradient(135deg, #4ADE80, #16a34a)'
						: 'linear-gradient(90deg, #FF1744, #D50000)'
				},
				close: true
			}).showToast();
		}
	});

	let secondarySports = $state<Array<number>>([]);
	let athleticSubSportArr = $state<Array<string | undefined>>(new Array<string>(10));

	let secondaryCount = $derived.by(() => {
		return (
			athleticSubSportArr.filter((val) => val == '').length +
			(data.athleticSubSport
				?.filter((val) => athleticSubSportArr.find((i) => i == val.sportId.toString()))
				.filter((item) => item.type < 7).length ?? 0)
		);
	});

	beforeNavigate(() => {
		globals.loading = true;
	});
	afterNavigate(() => {
		globals.loading = false;
	});
</script>

<Loading loading={globals.loading} />

{#if sportId != null}
	<h2 class="mt-4 mb-16">TEAM MEMBER DETAILS</h2>
{:else}
	<h2>Invalid</h2>
{/if}

<form
	use:enhance={({ cancel }) => {
		if (!profilePic) {
			cancel();
		}
		globals.loading = true;
		return async ({ update }) => {
			update({ reset: true, invalidateAll: true }).then(() => {
				secondaryCount = 0;
				athleticSubSportArr = new Array<string | undefined>(10);
				secondarySports = [];
				globals.loading = false;
			});
		};
	}}
	class="grid grid-cols-3 gap-12"
	method="post"
	enctype="multipart/form-data"
>
	<div class="title-text text-custom-orange col-span-3 mb-3">Personal Details</div>
	<input hidden name="institute" value={data.me?.institute} />
	{#if sportId}
		<input hidden name="gender" value={isSportFemale(parseInt(sportId)) ? 'Female' : 'Male'} />
	{/if}
	<CustomInput required name="first_name">FIRST NAME *</CustomInput>
	<CustomInput name="middle_name">MIDDLE NAME</CustomInput>
	<CustomImagePicker bind:filled={profilePic} class="row-span-2">UPLOAD PHOTO *</CustomImagePicker>
	<CustomInput name="last_name">LAST NAME</CustomInput>
	<CustomInput name="phone" required minlength={10} maxlength={10}
		>CONTACT NO. (WHATSAPP PREFERRED) *</CustomInput
	>
	<CustomInput type="email" name="email" required>EMAIL ID *</CustomInput>
	<CustomInput required minlength={10} maxlength={10} name="emergency_phone"
		>EMERGENCY CONTACT NO. *</CustomInput
	>
	<CustomSelect
		value={'A+'}
		items={[
			{ value: 'A+', label: 'A+' },
			{ value: 'A-', label: 'A-' },
			{ value: 'B+', label: 'B+' },
			{ value: 'B-', label: 'B-' },
			{ value: 'AB+', label: 'AB+' },
			{ value: 'AB-', label: 'AB-' },
			{ value: 'O+', label: 'O+' },
			{ value: 'O-', label: 'O-' },
			{ value: 'Others', label: 'Others' }
		]}
		type="single"
		required
		name="blood_group">BLOOD GROUP *</CustomSelect
	>
	<!-- <CustomInput required name="blood_group">BLOOD GROUP *</CustomInput> -->
	<CustomSelect
		value={'Veg'}
		items={[
			{ value: 'Non Veg', label: 'Non Vegetarian' },
			{ value: 'Veg', label: 'Vegetarian' }
		]}
		type="single"
		required
		name="blood_group">FOOD PREFERENCE*</CustomSelect
	>
	<div></div>
	<div class="title-text text-custom-orange col-span-3 mb-3">Dates</div>
	<CustomInput required type="date" name="check_in_date">CHECKOUT IN DATE *</CustomInput>
	<CustomInput required type="date" name="check_out_date">CHECKOUT OUT DATE *</CustomInput>
	{#if parseInt(sportId!) > 0}
		<div class="title-text text-custom-orange col-span-3">Sport</div>
		<CustomInput value={getSportFromSportId(parseInt(sportId!))} disabled
			>REGISTERED SPORT</CustomInput
		>
		<input type="hidden" value={parseInt(sportId!)} name="sport_1" />
		<CustomInput required name="extra_1">POSITION IN SPORT *</CustomInput>
	{/if}
	{#if sportId != getSportIdOfSport('Volleyball', 2, false).toString()}
		<div class="title-text text-custom-orange col-span-3 flex gap-x-4">
			{#if parseInt(sportId!) <= 0}
				Sports
			{:else}
				Secondary Sports ( if any )
			{/if}
			{#if secondaryCount < 3}
				<button
					type="button"
					class=""
					onclick={() => {
						secondarySports.push(
							secondarySports.reduce((prev, curr) => (prev < curr ? curr : prev) + 1, 0)
						);
					}}><img src={plusIcon} alt="Add" class="hover:scale-105" /></button
				>
			{/if}
		</div>
		{#each secondarySports as id, idx (id)}
			<CustomSelect
				required
				type="single"
				name="sport_{parseInt(sportId!) > 0 ? idx + 2 : idx + 1}"
				bind:value={athleticSubSportArr[idx]}
				items={parseInt(sportId!) > 0
					? getRegisterableSports(globals.staff, data.sports ?? [])
							.filter((item) => item.id > 0 && item.type == 1 && item.id != parseInt(sportId!))
							.map((item) => {
								return { value: item.id.toString(), label: item.name };
							})
					: data
							.athleticSubSport!.map((val) => {
								if (
									!(
										val.count >= (val.type >= 7 ? 4 : 2) &&
										val.reservedCount >= (val.type >= 7 && !globals.staff ? 2 : 1)
									)
								) {
									return {
										value: val.sportId.toString(),
										label: val.name + (val.type == 9 ? ' ( Mixed )' : '')
									};
								}
							})
							.filter((val) => val != undefined)}>SPORT</CustomSelect
			>
			{#if parseInt(sportId!) > 0}
				<CustomInput required name="extra_{idx + 2}">POSITION IN SPORT *</CustomInput>
			{:else}
				<label class="button-text mt-auto mb-3 flex h-fit items-center gap-x-4 leading-0">
					{#if (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.count ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 ? 4 : 2) || (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.reservedCount ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 && !globals.staff ? 2 : 1)}
						<input
							type="hidden"
							name={'reserve_' + (idx + 1)}
							value={(data.athleticSubSport?.find(
								(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
							)?.count ?? 0) >= 2
								? 'on'
								: ''}
						/>
					{/if}
					<input
						type="checkbox"
						name={'reserve_' + (idx + 1)}
						class="size-6 -skew-x-12 disabled:cursor-not-allowed"
						disabled={(data.athleticSubSport?.find(
							(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
						)?.count ?? 0) >=
							((data.athleticSubSport?.find(
								(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
							)?.type ?? 0) >= 7
								? 4
								: 2) ||
							(data.athleticSubSport?.find(
								(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
							)?.reservedCount ?? 0) >=
								((data.athleticSubSport?.find(
									(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
								)?.type ?? 0) >= 7 && !globals.staff
									? 2
									: 1)}
						checked={(data.athleticSubSport?.find(
							(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
						)?.count ?? 0) >= 2}
					/>
					<div class="button-text -mb-1">Reserve</div>
				</label>
			{/if}
			<button
				type="button"
				class="flex h-full w-fit flex-col items-start justify-items-start"
				onclick={() => {
					secondarySports = secondarySports.filter((val) => val != id);
					athleticSubSportArr.splice(idx, 1);
					athleticSubSportArr.push(undefined);
				}}><img src={minusIcon} alt="Remove" class=" mt-auto mb-3 h-fit hover:scale-105" /></button
			>
		{/each}
	{/if}
	<Button type="submit" class="bg-custom-orange col-span-3 mx-auto mt-6 w-fit px-24 py-2 text-white"
		>SAVE</Button
	>
</form>
