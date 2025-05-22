<script lang="ts">
	import { enhance } from '$app/forms';
</script>

<main class="px-52 pt-24 pb-32">
	<section>
		<h1 class="text-[3.5rem] font-medium">Register</h1>
		<p class="text-xl">
			Workshop is pen to school and college students around Hyderabad. Limited seats<br />available.
			Fill the form below to confirm your spot!
		</p>

		<form use:enhance class="mt-24 grid grid-cols-3 gap-x-20 gap-y-20">
			<label>
				<p class="label-text">Name</p>
				<input class="input" placeholder="Enter Here" type="text" />
			</label>

			<label>
				<p class="label-text">Contact No.</p>
				<input class="input" placeholder="Enter Here" type="text" />
			</label>

			<label>
				<p class="label-text">Emergency No. (Parents)</p>
				<input class="input" placeholder="Enter Here" type="text" />
			</label>

			<label>
				<p class="label-text">Email ID</p>
				<input class="input" placeholder="Enter Here" type="email" />
			</label>

			<label>
				<p class="label-text">Age</p>
				<input class="input" placeholder="Enter Here" type="number" />
			</label>

			<label>
				<p class="label-text">Gender</p>
				<select class="input select">
					<option class="option">Male</option>
					<option class="option">Female</option>
					<option class="option">Others</option>
					<option class="option">Prefer Not to Say</option>
				</select>
			</label>

			<label>
				<p class="label-text">Blood Group</p>
				<select class="input select">
					<option class="option">A+</option>
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
				<p class="label-text">Sport You are Interested in</p>
				<select class="input select">
					<option class="option">Football</option>
					<option class="option">Basketball</option>
					<option class="option">Badminton</option>
					<option class="option">Hockey</option>
				</select>
			</label>

			<label>
				<p class="label-text">Previous Sports Experience</p>
				<input type="text" class="input" placeholder="Enter Here" />
			</label>

			<label class="col-span-2">
				<p class="label-text">Address (with city & pincode)</p>
				<input class="input" placeholder="Enter Here" type="text" />
			</label>

			<label>
				<p class="label-text">Your Instituition Name</p>
				<input class="input" placeholder="Enter Here" type="text" />
			</label>

			<h1 class="col-span-3 text-[3.5rem] font-medium">Payment</h1>
			<div class="col-span-2"></div>
			<button
				type="submit"
				class="bg-primary text-background hover:bg-primary/75 w-full py-3.5 text-2xl hover:cursor-pointer"
				>SUBMIT</button
			>
		</form>
	</section>
</main>

<style>
	@reference "../../app.css";

	.label-text {
		@apply mb-4 text-2xl;
	}

	.input {
		@apply focus:border-primary w-full border-2 border-[#016064] bg-[#D6E8E6] px-5 py-3 text-2xl text-[#016064] hover:brightness-90 focus:outline-none;
	}

	.select {
	}
	.option {
		@apply py-2 pl-4 text-lg;
	}
</style>
