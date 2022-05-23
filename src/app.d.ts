/// <reference types="@sveltejs/kit" />

// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare namespace App {
	// interface Locals {}
	// interface Platform {}
	// interface Session {}
	// interface Stuff {}
}

interface Heap {
	identify: (string) => void;
	addUserProperties: (properties: Record<string, string | number>) => void;
	track: (name: string, properties?: Record<string, string>) => void;
}

export declare global {
	interface Window {
		heap: Heap;
	}
}
