<script lang="ts">
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

	import supabase from '$lib/supabase';
	import { user } from '$lib/store';

	import Login from '$lib/components/Login.svelte';
	import OnboardForm from '$lib/components/OnboardForm.svelte';

	let loading = true;
	const NO_ROWS_FOUND = 406;

	// TODO: Can we do this server-side?
	// on load,
	// if user is not authenticated, show them a login page
	// if user is authenticated, but doesn't have a profile show onboarding form
	// if user already has a profile, redirect to home page

	const getProfile = async () => {
		try {
			loading = true;
			const user = supabase.auth.user();

			if (!user) return;

			let { data, error, status } = await supabase
				.from('profile')
				.select(`first_name, last_name`)
				.eq('user_id', user.id)
				.single();

			if (error && status !== NO_ROWS_FOUND) throw error;

			return data;
		} catch (error) {
			alert(error.message);
		} finally {
			loading = false;
		}
	};

	onMount(async () => {
		const profile = await getProfile();

		// Do we need to do an empty check?
		if (!profile) return;

		// if profile, go home
		goto('/');
	});
</script>

<div class="flex h-full w-full flex-col items-center justify-center bg-primary">
	<div class="mx-8 rounded border bg-primary-content px-8 py-12 sm:mx-auto md:w-1/2 lg:w-2/5">
		{#if !loading}
			{#if !$user}
				<h3 class="my-4 text-2xl font-bold">Login to RFFR</h3>
				<Login />
			{/if}
			{#if $user && $user.email}
				<OnboardForm userID={$user.id} email={$user.email} />
			{/if}
		{/if}
	</div>
</div>
