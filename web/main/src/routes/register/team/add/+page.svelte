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
	import { afterNavigate, beforeNavigate, goto } from '$app/navigation';
	import Loading from '$lib/ui/components/Loading.svelte';
	import { onMount } from 'svelte';

	const sportId = page.url.searchParams.get('sport');
	let profilePic = $state(false);
	let isEditRegister = page.url.searchParams.has('edit');
	let { data, form } = $props();
	if (data.playerData && data.playerData?.sports == null) {
		data.playerData!.sports = [];
	}

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
	onMount(() => {
		if (isEditRegister) {
			if (parseInt(sportId!) > 0) {
				data.playerData!.sports = data.playerData!.sports.filter(
					(val) => val.secondary || val.reserve
				);
			}
			for (let i = 0; i < (data.playerData?.sports.length ?? 0); i++) {
				secondarySports.push(i);
				athleticSubSportArr[i] = data.playerData!.sports[i].sportId.toString();
			}
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
	console.log(data);
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
				goto('/register/team' + page.url.search);
			});
		};
	}}
	class="grid grid-cols-3 gap-10 *:mt-auto 2xl:gap-12"
	method="post"
	enctype="multipart/form-data"
>
	<div class="title-text text-custom-orange col-span-3 mb-3">Personal Details</div>
	<input hidden name="institute" value={data.me?.institute} />
	<input hidden name="staff" value={globals.staff} />
	{#if isEditRegister}
		<input hidden name="user_id" value={page.url.searchParams.get('edit')} />
	{/if}
	{#if sportId && parseInt(sportId) > -10}
		<input
			hidden
			name="gender"
			value={isEditRegister
				? data.playerData?.gender
				: isSportFemale(parseInt(sportId))
					? 'Female'
					: 'Male'}
		/>
	{/if}
	<CustomInput required value={isEditRegister ? data.playerData?.firstName : null} name="first_name"
		>FIRST NAME *</CustomInput
	>
	<CustomInput value={isEditRegister ? data.playerData?.middleName : null} name="middle_name"
		>MIDDLE NAME</CustomInput
	>
	<CustomImagePicker
		profilePic={isEditRegister ? (data.playerData?.profilePic ?? undefined) : undefined}
		bind:filled={profilePic}
		class="row-span-2">UPLOAD PHOTO *</CustomImagePicker
	>
	<CustomInput value={isEditRegister ? data.playerData?.lastName : null} name="last_name"
		>LAST NAME</CustomInput
	>
	{#if parseInt(sportId!) <= -10}
		<CustomSelect
			value={isEditRegister ? data.playerData?.gender : 'Male'}
			items={[
				{ value: 'Male', label: 'Male' },
				{ value: 'Female', label: 'Female' },
				{ value: 'Others', label: 'Others' }
			]}
			type="single"
			required
			name="gender">Gender*</CustomSelect
		>
	{/if}
	<CustomInput
		name="contact_no"
		value={isEditRegister ? data.playerData?.contactNo : null}
		required
		minlength={10}
		maxlength={10}>CONTACT NO. (WHATSAPP PREFERRED) *</CustomInput
	>
	<CustomInput
		type="email"
		value={isEditRegister ? data.playerData?.email : null}
		name="email"
		required>EMAIL ID *</CustomInput
	>
	{#if parseInt(sportId!) > -10}
		<CustomInput name="jersey" value={isEditRegister ? data.playerData?.jersey : null}
			>JERSEY NO.</CustomInput
		>
	{/if}
	{#if parseInt(sportId!) <= -10}
		<CustomInput
			name="designation"
			value={isEditRegister ? data.playerData?.designation : null}
			required>DESIGNATION*</CustomInput
		>
	{/if}
	<CustomInput
		required
		minlength={10}
		maxlength={10}
		value={isEditRegister ? data.playerData?.emergencyContactNo : null}
		name="emergency_contact_no">EMERGENCY CONTACT NO. *</CustomInput
	>
	<CustomSelect
		value={isEditRegister ? data.playerData?.bloodGroup : 'Unknown'}
		items={[
			{ value: 'Unknown', label: 'Unknown' },
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
	<CustomSelect
		value={isEditRegister ? data.playerData?.foodPreference : 'Veg'}
		items={[
			{ value: 'Non Veg', label: 'Non Vegetarian' },
			{ value: 'Veg', label: 'Vegetarian' }
		]}
		type="single"
		required
		name="food_preference">FOOD PREFERENCE*</CustomSelect
	>
	<CustomInput value={isEditRegister ? data.playerData?.remark : null} name="remark"
		>REMARK</CustomInput
	>
	<div class="title-text text-custom-orange col-span-3 mb-3">Dates</div>
	<CustomInput
		type="date"
		value={isEditRegister ? data.playerData?.checkInDate : null}
		name="check_in_date">CHECK IN DATE</CustomInput
	>
	<CustomInput
		type="date"
		name="check_out_date"
		value={isEditRegister ? data.playerData?.checkOutDate : null}>CHECK OUT DATE</CustomInput
	>
	{#if parseInt(sportId!) > -10}
		{#if parseInt(sportId!) > 0}
			<div class="title-text text-custom-orange col-span-3">Sport</div>
			<CustomInput value={getSportFromSportId(parseInt(sportId!))} disabled
				>REGISTERED SPORT</CustomInput
			>
			<input type="hidden" value={parseInt(sportId!)} name="sport_1" />
			<CustomInput
				name="extra_1"
				value={isEditRegister
					? data.playerData?.sports.filter(
							(val) =>
								val.sportId == parseInt(sportId!) && val.secondary == false && val.reserve == false
						)[0].extra
					: null}>POSITION IN SPORT</CustomInput
			>
		{/if}
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
			{#if false}
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
									if (isEditRegister && athleticSubSportArr.includes(val.sportId.toString())) {
										return {
											value: val.sportId.toString(),
											label: val.name + (val.type == 9 ? ' ( Mixed )' : '')
										};
									}
								})
								.filter((val) => val != undefined)}>SPORT</CustomSelect
				>
			{/if}

			<CustomSelect
				required
				type="single"
				name="sport_{parseInt(sportId!) > 0 ? idx + 2 : idx + 1}"
				bind:value={athleticSubSportArr[idx]}
				items={getRegisterableSports(globals.staff, data.sports ?? [])
					.filter(
						(item) =>
							item.id > 0 &&
							(item.type == (isSportFemale(parseInt(sportId!)) ? 2 : 1) || item.type == 3) &&
							item.id != parseInt(sportId!) &&
							(parseInt(sportId!) > 0 || idx >= 1)
					)
					.map((item) => {
						return { value: item.id.toString(), label: item.name };
					})
					.concat(
						data
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
								if (isEditRegister && athleticSubSportArr.includes(val.sportId.toString())) {
									return {
										value: val.sportId.toString(),
										label: val.name + (val.type == 9 ? ' ( Mixed )' : '')
									};
								}
							})
							.filter((val) => val != undefined)
					)}>{parseInt(sportId!) <= 0 && idx == 0 ? 'PRIMARY ' : ''}SPORT</CustomSelect
			>
			<!-- asdfasdfasfasdf asdfa sdf -->

			{#if athleticSubSportArr[idx]}
				{#if getSportFromSportId(parseInt(athleticSubSportArr[idx]!))}
					<CustomInput
						required
						value={isEditRegister ? data.playerData?.sports[idx].extra : null}
						name="extra_{idx + (parseInt(sportId!) > 0 ? 2 : 1)}">POSITION IN SPORT *</CustomInput
					>
				{:else}
					<label class="button-text mt-auto mb-3 flex h-fit items-center gap-x-4 leading-0">
						{#if (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.count ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 ? 4 : 2) || (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.reservedCount ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 && !globals.staff ? 2 : 1)}
							<input
								type="hidden"
								name={'reserve_' + (idx + (parseInt(sportId!) > 0 ? 2 : 1))}
								value={isEditRegister
									? (data.playerData?.sports.at(idx)?.reserve ?? false)
										? 'on'
										: ''
									: (data.athleticSubSport?.find(
												(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
										  )?.count ?? 0) >=
										  ((data.athleticSubSport.find(
												(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
										  )?.type ?? 0) >= 7
												? 4
												: 2)
										? 'on'
										: ''}
							/>
						{/if}
						<input
							type="checkbox"
							name={'reserve_' + (idx + (parseInt(sportId!) > 0 ? 2 : 1))}
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
							checked={isEditRegister
								? data.playerData?.sports.find(
										(val) => val.sportId.toString() == athleticSubSportArr[idx]
									)?.reserve
								: (data.athleticSubSport?.find(
										(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
									)?.count ?? 0) >=
									((data.athleticSubSport?.find(
										(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
									)?.type ?? 0) >= 7
										? 4
										: 2)}
						/>
						<div class="button-text -mb-1">Reserve</div>
					</label>
				{/if}
			{:else}
				<div></div>
			{/if}

			<!-- asdfasdfasfasdf asdfa sdf -->

			{#if parseInt(sportId!) > 0 && false}
				{#if athleticSubSportArr[idx]}
					{#if getSportFromSportId(parseInt(athleticSubSportArr[idx]!))}
						<CustomInput
							required
							value={isEditRegister ? data.playerData?.sports[idx].extra : null}
							name="extra_{idx + 2}">POSITION IN SPORT *</CustomInput
						>
					{:else}{/if}
				{:else}
					<div></div>
				{/if}
			{:else if false}
				<label class="button-text mt-auto mb-3 flex h-fit items-center gap-x-4 leading-0">
					{#if (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.count ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 ? 4 : 2) || (data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.reservedCount ?? 0) >= ((data.athleticSubSport?.find((val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0'))?.type ?? 0) >= 7 && !globals.staff ? 2 : 1)}
						<input
							type="hidden"
							name={'reserve_' + (idx + 1)}
							value={isEditRegister
								? (data.playerData?.sports[idx].reserve ?? false)
									? 'on'
									: ''
								: (data.athleticSubSport?.find(
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
						checked={isEditRegister
							? data.playerData?.sports.find(
									(val) => val.sportId.toString() == athleticSubSportArr[idx]
								)?.reserve
							: (data.athleticSubSport?.find(
									(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
								)?.count ?? 0) >=
								((data.athleticSubSport?.find(
									(val) => val.sportId == parseInt(athleticSubSportArr[idx] ?? '0')
								)?.type ?? 0) >= 7
									? 4
									: 2)}
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
	{:else}
		<input hidden name="sport_1" value={sportId} />
	{/if}
	<Button type="submit" class="bg-custom-orange col-span-3 mx-auto mt-6 w-fit px-24 py-2 text-white"
		>SAVE</Button
	>
</form>
