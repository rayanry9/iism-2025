<script lang="ts">
	import { enhance } from '$app/forms';
	import { afterNavigate, beforeNavigate, goto } from '$app/navigation';
	import { globals } from '$lib/state.svelte.js';
	import Button from '$lib/ui/components/Button.svelte';
	import Input from '$lib/ui/components/Input.svelte';
	import Loading from '$lib/ui/components/Loading.svelte';
	import StartToastifyInstance from 'toastify-js';

	let { data, form } = $props();
	if (data.me && data.me.staff != globals.staff) {
		globals.staff = data.me.staff;
		goto('/register');
	}

	$effect(() => {
		if (form != undefined) {
			StartToastifyInstance({
				text: form?.text,
				position: 'right',
				gravity: 'bottom',
				duration: 2000,
				className: 'toast-error',
				style: {
					background: 'linear-gradient(90deg, #FF1744, #D50000)'
				},
				close: true
			}).showToast();
		}
	});

	beforeNavigate(() => {
		globals.loading = true;
	});
	afterNavigate(() => {
		globals.loading = false;
	});
</script>

<Loading loading={globals.loading} />

<main class="mx-auto my-32 flex w-fit flex-col items-center gap-y-12">
	<div class="flex flex-col items-center gap-y-4">
		<h2>LOGIN</h2>
		<p class="px-4">Login with your Contingent Leader credentials</p>
	</div>
	<form use:enhance method="post" class="flex w-full flex-col gap-y-12">
		<Input
			id="email"
			placeholder="Enter here"
			required={true}
			type="text"
			label="PROVIDED Login ID"
			name="email"
		/>
		<Input
			id="password"
			required={true}
			placeholder="Enter here"
			type="password"
			label="PASSWORD"
			name="password"
		/>

		<Button type="submit" class="bg-custom-orange w-fit self-center px-20 py-2 text-white"
			>NEXT</Button
		>
	</form>
</main>
