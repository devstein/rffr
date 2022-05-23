<script lang="ts">
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';

	import '../app.css';
	import { user, profile } from '$lib/store';
	import supabase from '$lib/supabase';

	const NO_ROWS_FOUND = 406;
	// TODO: Clean up

	const checkForProfile = async (id: string) => {
		try {
			const user = supabase.auth.user();

			if (!user) return;

			let { data } = await supabase
				.from('profile')
				.select(`first_name, last_name`)
				.eq('user_id', id)
				.single();

			if (!data) {
				goto('/login');
				return;
			}

			profile.set({
				firstName: data.first_name,
				lastName: data.last_name
			});
		} catch (error) {
			console.log(error);
			goto('/login');
		}
	};

	user.set(supabase.auth.user());

	supabase.auth.onAuthStateChange(async (_, session) => {
		if (!(session && session.user)) {
			user.set(null);
			profile.set(null);
			return;
		}

		// TODO: If user is logged in, get profile and attach
		user.set(session.user);

		const { id, email } = session.user;
		// identify user
		if (window.heap) {
			window.heap.identify(email);
		}

		await checkForProfile(id);
	});

	onMount(async () => {
		if (!$user) return;

		const { id } = $user;

		await checkForProfile(id);
	});
</script>

<slot />
