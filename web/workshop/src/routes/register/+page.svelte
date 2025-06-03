<script lang="ts">
	import { enhance } from '$app/forms';
	import type { PageProps } from './$types';
	let dialog = $state();
	let { form }: PageProps = $props();
</script>

<svelte:head>
	<title>IISM 2025 Registration</title>
	<meta
		name="description"
		content="5-day Sports Workshop Registration Page. Registration form for the workshop being conducted for Inter IIT Sports Meet by IIT Hyderabad."
	/>
</svelte:head>

<dialog
	closedby="any"
	bind:this={dialog}
	class="bg-background text-foreground mx-auto mt-auto h-[70vh] w-screen max-w-none grow p-12 sm:my-auto sm:h-fit sm:w-[75vw] sm:p-16"
>
	<div class="flex flex-col">
		<div class="flex flex-row items-center">
			<h2 class="text-[2rem] font-medium sm:text-[2.5rem]">Terms and Conditions</h2>
			<button
				onclick={() => {
					(dialog as HTMLDialogElement).close();
				}}
				class="ml-auto flex size-12 -skew-x-[15deg] cursor-pointer flex-col bg-[#016064] sm:size-16"
			>
				<img
					src="icons/cross.svg"
					class="mx-auto my-auto skew-x-[15deg] items-center"
					alt="cross"
				/>
			</button>
		</div>
		<hr class="my-6 sm:my-12" />
		{#snippet Card(header: string, points: string[])}
			<div class="flex flex-col">
				<h4 class="text-xl font-semibold sm:text-2xl">{header}</h4>
				<ul class="mt-2.5 list-disc pl-4 sm:pl-6 sm:text-lg">
					{#each points as point (point)}
						<li>{point}</li>
					{/each}
				</ul>
			</div>
		{/snippet}
		<div class="grid grid-cols-1 gap-x-4 gap-y-8 sm:grid-cols-2">
			{@render Card('ACCOMODATION & MEALS', [
				'Hostel stay and meals are included in the fee',
				'No refunds for skipped meals or early exits from campus',
				'Participants must follow hostel guidelines and maintain decorum'
			])}
			{@render Card('CODE OF CONDUCT', [
				'Unethical behavior, harassment, or rule violations will result in expulsion from the camp',
				'No refunds will be issued in such cases',
				'Respect for peers, staff, and campus property is mandatory'
			])}
			{@render Card('DAMAGE & PENALTY', [
				'Participants are liable for any damage to campus property',
				'Monetary penalties will be applied for any damage',
				'Repeated or serious offenses may lead to suspension from the camp without refund'
			])}
			{@render Card('WEATHER & SCHEDULE FLEXIBILITY', [
				'In case of rain or other disruptions, outdoor sports will be shifted to indoor venues or alternative activities arranged',
				'The schedule may be adjusted for safety or logistical reasons'
			])}
			{@render Card('SAFETY & LIABILITY', [
				'Basic medical assistance will be available on-site',
				'Organizers are not responsible for injuries during the camp',
				'All participants are expected to follow staff and coach instructions'
			])}
			{@render Card('GENERAL TERMS', [
				'Organizers reserve the right to alter the schedule, sports lineup, and policies as necessary',
				'The camp fee is non-refundable except in rare medical emergencies with valid proof'
			])}
		</div>
	</div>
</dialog>

<main class="body-spacing pt-16 pb-16 sm:pt-24 sm:pb-32">
	{#if form == null}
		<section>
			<h1 class="text-[2rem] font-medium sm:text-[3.5rem]">Register</h1>
			<p class="sm:text-xl">
				Workshop is pen to school and college students around Hyderabad. Limited seats<br
				/>available. Fill the form below to confirm your spot!
			</p>

			<form
				method="POST"
				use:enhance
				class="mt-12 grid grid-cols-1 gap-x-20 gap-y-6 *:flex *:flex-col sm:grid-cols-2 sm:gap-y-20 lg:grid-cols-3 xl:gap-16 2xl:gap-20"
			>
				<h1 class=" text-xl font-medium sm:col-span-2 sm:-mb-10 sm:text-[2rem] lg:col-span-3">
					About You
				</h1>

				<label>
					<p class="label-text">Full Name<span class="text-red-500">*</span></p>
					<input class="input" name="name" placeholder="Enter Here" type="text" required />
				</label>

				<label>
					<p class="label-text">
						Contact No. (Whatsapp Preferred)<span class="text-red-500">*</span>
					</p>
					<input class="input" name="phone" placeholder="Enter Here" required type="text" />
				</label>

				<label>
					<p class="label-text">Email ID<span class="text-red-500">*</span></p>
					<input class="input" name="email" placeholder="Enter Here" type="email" required />
				</label>

				<label>
					<p class="label-text">Gender<span class="text-red-500">*</span></p>
					<select class="input select" name="gender" required>
						<option selected={true} value="Male" class="option">Male</option>
						<option class="option">Female</option>
						<option class="option">Others</option>
						<option class="option">Prefer Not to Say</option>
					</select>
				</label>

				<label>
					<p class="label-text">Age (10-28)<span class="text-red-500">*</span></p>
					<input
						class="input"
						name="age"
						placeholder="Enter Here"
						type="number"
						min={10}
						max={28}
						required
					/>
				</label>

				<label>
					<p class="label-text">Date of Birth<span class="text-red-500">*</span></p>
					<input class="input" name="dob" placeholder="Enter Here" type="date" required />
				</label>

				<label class="">
					<p class="label-text">Address<span class="text-red-500">*</span></p>
					<input class="input" name="address" placeholder="Enter Here" type="text" />
				</label>

				<label class="">
					<p class="label-text">Pincode<span class="text-red-500">*</span></p>
					<input class="input" name="pincode" placeholder="Enter Here" type="number" />
				</label>

				<label>
					<p class="label-text">
						School / College / Institute Name<span class="text-red-500">*</span>
					</p>
					<input class="input" name="institute" placeholder="Enter Here" type="text" required />
				</label>

				<label>
					<p class="label-text">Current Class / Year of Study<span class="text-red-500">*</span></p>
					<input class="input" name="class" placeholder="Enter Here" type="text" required />
				</label>

				<label>
					<p class="label-text">Blood Group<span class="text-red-500">*</span></p>
					<select class="input select" name="blood" required>
						<option value="A+" selected={true} class="option">A+</option>
						<option class="option">A-</option>
						<option class="option">B+</option>
						<option class="option">B-</option>
						<option class="option">AB+</option>
						<option class="option">AB-</option>
						<option class="option">O+</option>
						<option class="option">O-</option>
					</select>
				</label>

				<label>
					<p class="label-text">
						Medical Conditions or Allergies (If Any)<span class="text-red-500">*</span>
					</p>
					<input class="input" name="medical" placeholder="Enter Here" type="text" />
				</label>

				<label>
					<p class="label-text">
						Will you stay in the campus hostel?<span class="text-red-500">*</span>
					</p>
					<select class="input select" name="hostel" required>
						<option selected={true} value="Yes" class="option">Yes</option>
						<option class="option">No</option>
					</select>
				</label>

				<label>
					<p class="label-text">Sport You are Interested in<span class="text-red-500">*</span></p>
					<select class="input select" name="sport" required>
						<option selected={true} value="Football" class="option">Football</option>
						<option class="option">Basketball</option>
						<option class="option">Badminton</option>
						<option class="option">Hockey</option>
					</select>
				</label>

				<label>
					<p class="label-text">Previous Sports Experience</p>
					<input type="text" class="input" name="experience" placeholder="Enter Here" />
				</label>

				<h1
					class="mb-6 text-2xl font-medium sm:col-span-2 sm:text-[2rem] lg:col-span-3 lg:mt-8 lg:mb-0"
				>
					Gaurdian Details (Required for under 18)
				</h1>

				<label class="-mt-8">
					<p class="label-text">Gaurdian Full Name</p>
					<input class="input" placeholder="Enter Here" name="gaurdian_name" type="text" required />
				</label>

				<label class="sm:-mt-8 lg:col-span-2 lg:grid lg:grid-cols-subgrid">
					<p class="label-text sm:col-span-2">Gaurdian Contact No. (WhatsApp Preferred)</p>
					<input
						class="input sm:col-span-1"
						placeholder="Enter Here"
						name="gaurdian_phone"
						type="text"
						required
					/>
				</label>

				<h1 class="text-2xl font-medium sm:col-span-2 sm:text-[2rem] lg:col-span-3">Payment</h1>
				<div class="-mt-4 sm:col-span-2 sm:text-2xl lg:col-span-3 lg:-mt-16">
					Details will be provided through Email or Whatsapp.
				</div>
				<div class="md:col-span-2">
					<label class="sm:text-2xl">
						<input type="checkbox" class="size-4 hover:cursor-pointer sm:size-5" required />
						<span class="hover:cursor-pointer">
							I Agree to all Terms and Conditions
							<span
								onclick={(ev) => {
									ev.preventDefault();
									ev.stopImmediatePropagation();
									(dialog as HTMLDialogElement).showModal();
								}}
								role="button"
								tabindex={0}
								class="text-primary underline">Read Here</span
							>
						</span>
					</label>
				</div>
				<button
					type="submit"
					class="bg-primary text-background hover:bg-primary/75 w-full py-3 text-xl hover:cursor-pointer sm:py-3.5 sm:text-2xl"
					>SUBMIT</button
				>
			</form>
		</section>
	{:else if form.success}
		<section class="mx-auto w-fit">
			<h1 class=" text-xl font-medium sm:text-[2rem]">
				You have <span class="text-primary">Successfully</span> Registered for the Summer Camp.
			</h1>
		</section>
	{:else}
		<section class="mx-auto w-fit">
			<h1 class=" text-xl font-medium sm:text-[2rem]">
				We encountered issues while registering you for the Camp. Please try again later or email us
				directly.
			</h1>
		</section>
	{/if}
</main>

<style>
	@reference "../../app.css";

	.label-text {
		@apply mb-4 sm:text-2xl;
	}

	.input {
		@apply focus:border-primary mt-auto w-full border-2 border-[#016064] bg-[#D6E8E6] px-5 py-3 text-[#016064] hover:brightness-90 focus:outline-none sm:text-2xl;
	}

	select,
	::picker(select) {
		appearance: base-select;
	}

	select:open::picker-icon {
		rotate: 180deg;
	}

	.option {
		@apply py-2 pl-4 text-sm sm:text-lg;
	}
</style>
