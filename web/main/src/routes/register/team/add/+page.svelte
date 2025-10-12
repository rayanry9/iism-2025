<script lang="ts">
	import { enhance } from '$app/forms';
	import { page } from '$app/state';
	import CustomInput from '$lib/ui/common/CustomInput.svelte';
	import Button from '$lib/ui/components/Button.svelte';
	import CustomImagePicker from '$lib/ui/register/CustomImagePicker.svelte';
	import { isSportFemale } from '$lib/utility/sport.js';

	const sportId = page.url.searchParams.get('sport');
	let profilePic = $state(false);
	let { data } = $props();
</script>

{#if sportId != null}
	<h2 class="mt-4 mb-16">TEAM MEMBER DETAILS</h2>
{:else}
	<h2>Invalid</h2>
{/if}

<form
	onsubmit={(ev) => {
		if (!profilePic) {
			ev.preventDefault();
			alert('Profile pic not submitted');
		}
		ev.currentTarget.submit();
	}}
	class="grid grid-cols-3 gap-12"
	method="post"
	enctype="multipart/form-data"
	use:enhance
>
	<div class="title-text text-custom-orange col-span-3 mb-3">Personal Details</div>
	<input hidden name="institute" value={data.me?.institute} />
	{#if sportId}
		<input hidden name="gender" value={isSportFemale(parseInt(sportId)) ? 'Female' : 'Male'} />
		<input hidden name="sport_id_1" value={sportId} />
	{/if}
	<CustomInput required name="first_name">FIRST NAME *</CustomInput>
	<CustomInput name="middle_name">MIDDLE NAME</CustomInput>
	<CustomImagePicker bind:filled={profilePic} class="row-span-2">UPLOAD PHOTO *</CustomImagePicker>
	<CustomInput name="last_name">LAST NAME</CustomInput>
	<CustomInput name="phone" required minlength={10} maxlength={10}
		>CONTACT NO. (WHATSAPP PREFERRED) *</CustomInput
	>
	<CustomInput type="email" name="email" required>EMAIL ID *</CustomInput>
	<CustomInput required name="blood_group">BLOOD GROUP *</CustomInput>
	<CustomInput required minlength={10} maxlength={10} name="emergency_phone"
		>EMERGENCY CONTACT NO. *</CustomInput
	>
	<CustomInput required name="food_preference">FOOD PREFERENCE *</CustomInput>
	<div></div>
	<div class="title-text text-custom-orange col-span-3 mb-3">Dates</div>
	<CustomInput required type="date" name="check_in_date">CHECKOUT IN DATE *</CustomInput>
	<CustomInput required type="date" name="check_out_date">CHECKOUT OUT DATE *</CustomInput>
	<div class="title-text text-custom-orange col-span-3">Sport</div>
	<CustomInput required name="extra">POSITION IN SPORT *</CustomInput>

	<div></div>
	<Button type="submit" class="bg-custom-orange col-span-3 mx-auto mt-6 w-fit px-24 py-2 text-white"
		>SAVE</Button
	>
</form>
