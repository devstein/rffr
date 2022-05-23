import { writable } from 'svelte/store';
import type { User } from '@supabase/supabase-js';

export const user = writable<User | null>();

interface Profile {
	firstName: string;
	lastName: string;
}

export const profile = writable<Profile | null>(null);
