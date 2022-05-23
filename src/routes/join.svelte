<script lang="ts">
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

	import { user } from '$lib/store';

	import Login from '$lib/components/Login.svelte';

	// TODO: Can we do this server-side?
	// TODO: Do we want to check if the email already exists?

	onMount(async () => {
		// if user exists redirect
		if (!$user) return;

		// if profile, go home
		goto('/');
	});
</script>

<div class="flex h-full w-full flex-col items-center justify-center bg-primary">
	<div class="mx-8 rounded border bg-primary-content px-8 py-12 sm:mx-auto md:w-1/2 lg:w-2/5">
		<h3 class="my-4 text-2xl font-bold">Join the RFFR Network</h3>
		<Login />
	</div>
</div>
