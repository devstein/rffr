import { createClient } from '@supabase/supabase-js';

// Create a single supabase client for interacting with your database
const client = createClient(
	import.meta.env.VITE_SUPABASE_URL,
	import.meta.env.VITE_SUPABASE_ANON_KEY
);

export const signInWithEmail = async (email: string) =>
	await client.auth.signIn({
		email
	});

export const signInWithGoogle = async () =>
	await client.auth.signIn({
		provider: 'google'
	});

export const logout = async () => await client.auth.signOut();

export default client;
