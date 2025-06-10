<script lang="ts">
	import { enhance } from '$app/forms';
	import { base } from '$app/paths';
	import type { Action } from 'svelte/action';
	import type { PageProps } from './$types';
	let dialog = $state();
	let formStage = $state(1);
	let formElem = $state();
	let fileInputElem = $state<HTMLInputElement | null>(null);
	let { form }: PageProps = $props();
	let filename = $state('JPEG, PNG, PDF formats, up to 10 MB');

	const focusAction: Action<HTMLDivElement> = (node) => {
		node.scrollIntoView({ behavior: 'smooth' });
	};
</script>

<svelte:head>
	<title>IITH Sports Workshop 2025 Registration</title>
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
	{#snippet SportItem(
		text: string,
		imgSrc: string,
		details: string[],
		extras: string | null = null
	)}
		<div class="flex flex-row gap-x-4">
			<img src={imgSrc} alt={text} class="size-6" />
			<div class="flex flex-col gap-y-4">
				<h4 class="text-xl font-semibold sm:text-2xl">{text}</h4>
				<ul class="list-disc pl-6 text-lg leading-tight font-medium">
					{#each details as detail}
						<li>{@html detail}</li>
					{/each}
				</ul>
				{#if extras != null}
					<p class="text-lg font-medium text-[#016064]">{extras}</p>
				{/if}
			</div>
		</div>
	{/snippet}
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

			<h4 class="col-span-1 text-xl font-semibold sm:col-span-2 sm:text-2xl">SPORTS & RULES</h4>

			{@render SportItem(
				'FOOTBALL',
				'register/football.webp',
				[
					'Football shoes (must bring your own)',
					'Shin gaurds and 2 pairs of socks',
					'2 pairs of jerseys'
				],
				'Football, cones, and other training equipment will be provided.'
			)}
			{@render SportItem(
				'BASKETBALL',
				'register/basketball.webp',
				[
					'Non-marking 	basketball shoes (mandatory)',
					'2 pairs of jerseys and socks',
					'Bring your own basic kit (water bottle, towel, etc)'
				],
				'Basketballs and training gear will be provided.'
			)}
			{@render SportItem(
				'HOCKEY',
				'register/hockey.webp',
				['Hockey Shoes', 'Hockey stockings (long socks)', '2 pairs of jerseys and stockings'],
				'Sticks, balls, and shin gaurds will be provided.'
			)}
			{@render SportItem('BADMINTON', 'register/badminton.webp', [
				'Non-marking shoes (mandatory)',
				'Bring your own racket',
				'Shuttlecocks: Yonex Mavis 350 only (minimum 5 pieces)<br/>(Other brands/models are not permitted)'
			])}
			{@render SportItem('TABLE TENNIS', 'register/tt.webp', [
				'Bring your own	TT bat',
				'White TT balls (minimum 5 pieces)',
				'Non-marking shoes',
				'2 pairs of jerseys and socks'
			])}
			{@render SportItem('SQUASH', 'register/squash.webp', [
				'Non-marking shoes (mandatory)',
				'Bring your own squash racket',
				'Bring your own squash ball'
			])}
			{@render SportItem(
				'VOLLEYBALL',
				'register/volleyball.webp',
				['Non-marking shoes', '2 pairs of jerseys and socks'],
				'Balls and nets will be provided'
			)}
		</div>
	</div>
</dialog>

<main class="body-spacing pt-16 pb-16 sm:pt-24 sm:pb-32">
	{#if form == null}
		<section>
			{#if formStage != 2}
				<h1 class="text-[2rem] font-medium sm:text-[3.5rem]">Register</h1>
				<p class="sm:text-xl">
					Workshop is open to school and college students around Hyderabad. Limited seats<br
					/>available. Fill the form below to proceed!
					<span
						onclick={(ev) => {
							ev.preventDefault();
							ev.stopImmediatePropagation();
							(dialog as HTMLDialogElement).showModal();
						}}
						role="button"
						tabindex={0}
						class="text-primary underline hover:cursor-pointer">(T&C Applied)</span
					>
				</p>
				<div
					class="my-12 grid grid-cols-2 text-xl font-semibold sm:grid-cols-[25%_75%] sm:text-2xl"
				>
					<p>EARLY BIRD OFFER:</p>
					<p class="mb-5"><span class="text-primary">4998/-</span> (VALID TILL 22 JUNE)</p>

					<p>STANDARD FEE:</p>
					<p>6998/- (POST EARLY BIRD PERIOD)</p>
				</div>
			{:else}
				<h1 class="text-[2rem] font-medium sm:text-[3.5rem]">Payment</h1>
				<p class="sm:text-xl">
					Scan the QR Code and fill the payment details to confirm your spot.
				</p>
			{/if}

			<form
				method="POST"
				use:enhance
				enctype="multipart/form-data"
				bind:this={formElem}
				class="mt-12 grid grid-cols-1 gap-x-20 gap-y-6 *:flex *:flex-col sm:gap-y-20 {formStage == 1
					? 'sm:grid-cols-2 lg:grid-cols-3 '
					: 'lg:grid-cols-2'} xl:gap-14 2xl:gap-20"
			>
				<h1
					class="text-xl {formStage == 1
						? ''
						: '!hidden'} font-medium sm:col-span-2 sm:-mb-10 sm:text-[2rem] lg:col-span-3"
				>
					About You
				</h1>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Full Name<span class="text-red-500">*</span></p>
					<input class="input" name="name" placeholder="Enter Here" type="text" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">
						Contact No. (Whatsapp Preferred)<span class="text-red-500">*</span>
					</p>
					<input class="input" name="phone" placeholder="Enter Here" required type="text" />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Email ID<span class="text-red-500">*</span></p>
					<input class="input" name="email" placeholder="Enter Here" type="email" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Gender<span class="text-red-500">*</span></p>
					<select class="input select" name="gender" required>
						<option selected={true} value="Male" class="option">Male</option>
						<option class="option">Female</option>
						<option class="option">Others</option>
						<option class="option">Prefer Not to Say</option>
					</select>
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Age<span class="text-red-500">*</span></p>
					<input class="input" name="age" placeholder="Enter Here" type="number" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Date of Birth<span class="text-red-500">*</span></p>
					<input class="input" name="dob" placeholder="Enter Here" type="date" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Address<span class="text-red-500">*</span></p>
					<input class="input" name="address" placeholder="Enter Here" type="text" />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Pincode<span class="text-red-500">*</span></p>
					<input class="input" name="pincode" placeholder="Enter Here" type="number" />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">
						School / College / Institute Name<span class="text-red-500">*</span>
					</p>
					<input class="input" name="institute" placeholder="Enter Here" type="text" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Current Class / Year of Study<span class="text-red-500">*</span></p>
					<input class="input" name="class" placeholder="Enter Here" type="text" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
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

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">
						Medical Conditions or Allergies (If Any)<span class="text-red-500">*</span>
					</p>
					<input class="input" name="medical" placeholder="Enter Here" type="text" />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Sport You are Interested in<span class="text-red-500">*</span></p>
					<select class="input select" name="sport" required>
						<option selected={true} value="Football" class="option">Football</option>
						<option class="option">Basketball</option>
						<option class="option">Badminton</option>
						<option class="option">Hockey</option>
						<option class="option">Table Tennis</option>
						<option class="option">Volleyball</option>
						<option class="option">Squash</option>
					</select>
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">Gaurdian Full Name<span class="text-red-500">*</span></p>
					<input class="input" placeholder="Enter Here" name="gaurdian_name" type="text" required />
				</label>

				<label class={formStage == 1 ? '' : '!hidden'}>
					<p class="label-text">
						Gaurdian Contact No. (WhatsApp Preferred)<span class="text-red-500">*</span>
					</p>
					<input
						class="input"
						placeholder="Enter Here"
						name="gaurdian_phone"
						type="text"
						required
					/>
				</label>
				{#if formStage == 1}
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
				{/if}
				{#if formStage == 2}
					<div use:focusAction class="grid grid-cols-1 lg:pr-32">
						<h1 class="text-xl font-medium sm:text-[2rem]">Scan & Pay</h1>
						<p class="mt-4 text-lg">
							Scan the QR code or copy the UPI ID to make the payment using any UPI app.
						</p>

						<div class="mt-8 flex flex-col border border-[#C9C9C9] px-4 py-6">
							<img src="register/qr.png" alt="UPI QR" />
							<p class="mt-4 px-2.5 text-xl font-bold select-none">
								UPI ID: <span class="text-primary select-text">transport67@sbi</span>
							</p>
						</div>

						<div
							class="mt-8 flex flex-row items-center border border-[#C9C9C9] p-6 text-2xl font-semibold"
						>
							<p>EARLY BIRD OFFER</p>
							<p class="text-primary ml-auto text-[40px] font-bold">4998/-</p>
						</div>

						<div class="mt-8 flex flex-col border border-[#C9C9C9] p-6 text-lg font-medium">
							<p>
								Please ensure you pay the exact amount. Incorrect payments may result in
								cancellation without refund.
							</p>
							<p class="mt-6">
								<span class="font-bold">Note:</span> Registration fee is non-refundable once payment
								is confirmed.
							</p>
						</div>
					</div>
					<div class="grid grid-cols-1 gap-y-6 sm:gap-y-16">
						<h1 class="text-xl font-medium sm:text-[2rem]">Enter Payment Details</h1>

						<label>
							<p class="label-text">
								UTR Number<span class="text-red-500">*</span>
							</p>
							<input required class="input" name="utr" placeholder="Enter Here" type="text" />
						</label>

						<label>
							<p class="label-text">
								Account Holder Name (the account you paid from)<span class="text-red-500">*</span>
							</p>
							<input
								class="input"
								name="account_holder_name"
								placeholder="Enter Here"
								type="text"
								required
							/>
						</label>

						<label>
							<p class="label-text">
								Upload Payment Screenshot<span class="text-red-500">*</span>
							</p>
							<input
								bind:this={fileInputElem}
								class="input hidden"
								accept="application/pdf, image/jpeg, image/png"
								onchange={(inp) => {
									filename = (inp.target! as HTMLInputElement)!.files![0].name;
								}}
								name="screenshot"
								placeholder="Enter Here"
								type="file"
								required
							/>
							<div
								class="flex h-fit w-full flex-col items-center gap-y-6 border border-dotted border-[#016064] py-12"
							>
								<p class="text-[#016064]">{filename}</p>
								<button
									type="button"
									onclick={() => {
										(fileInputElem! as HTMLInputElement).click();
									}}
									class="h-fit w-fit border border-[#016064] bg-[#C6D8D6] px-6 py-4 text-xl font-medium text-[#016064] hover:bg-[#D6E8E6]"
								>
									Choose a file
								</button>
							</div>
						</label>

						<button
							type="button"
							class="bg-primary text-background hover:bg-primary/75 w-full py-3 text-xl font-medium hover:cursor-pointer sm:py-3.5 sm:text-2xl"
							onclick={() => {
								if ((formElem as HTMLFormElement).checkValidity()) {
									let ext = (fileInputElem as HTMLInputElement).files![0].name;

									if ((fileInputElem as HTMLInputElement).files![0].size > 5000000) {
										(fileInputElem as HTMLInputElement).setCustomValidity(
											'File needs to less than 5 MB'
										);
										(fileInputElem as HTMLInputElement).reportValidity();
										(formElem as HTMLFormElement).reportValidity();
									} else if (
										!(
											ext.includes('png') ||
											ext.includes('jpeg') ||
											ext.includes('jpg') ||
											ext.includes('pdf')
										)
									) {
										(fileInputElem as HTMLInputElement).setCustomValidity('Invalid File Format');

										(fileInputElem as HTMLInputElement).reportValidity();
										(formElem as HTMLFormElement).reportValidity();
									} else {
										(formElem as HTMLFormElement).submit();
									}
								} else {
									(formElem as HTMLFormElement).reportValidity();
								}
							}}>SUBMIT</button
						>
					</div>
				{:else}
					<div class="col-span-1"></div>
					<div class="col-span-1"></div>
					<button
						type="button"
						onclick={() => {
							if ((formElem as HTMLFormElement).checkValidity()) {
								formStage = 2;
							} else {
								(formElem as HTMLFormElement).reportValidity();
							}
						}}
						class="bg-primary text-background hover:bg-primary/75 ml-auto w-fit px-8 py-3 text-xl font-medium hover:cursor-pointer sm:col-span-2 sm:py-3.5 sm:text-2xl"
						>SUBMIT & PROCEED TO PAYMENT</button
					>
				{/if}
			</form>
		</section>
	{:else if form.success}
		<section class="mx-auto flex w-fit flex-col items-center gap-y-4 py-24">
			<img src="register/success.png" alt="success" class="size-24" />
			<h1 class="text-[3.5rem] font-semibold">Thanks!</h1>
			<p class="text-center text-xl font-medium">
				Your payment details have been submitted successfully.You’ll receive confirmation
				<br />within 24 hours.
			</p>
			<a href={base}>
				<button
					class="border-primary text-primary mt-12 border px-8 py-3 font-semibold hover:cursor-pointer"
					>GO HOME</button
				>
			</a>
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
