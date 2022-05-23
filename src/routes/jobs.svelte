<script lang="ts">
	import Header from '$lib/components/Header.svelte';
	/* import JobBoard from '$lib/components/JobBoard.svelte'; */
	import type { JobBoard as IJobBoard } from '$lib/db/schema';

	// mailgun w/ Supabase auth?

	export let jobs: IJobBoard;
	/* <h1 class="my-8 max-w-lg text-4xl">Jobs</h1> */
	/* <JobBoard {jobs} /> */
</script>

<Header />
<div
	class="mx-8 my-2 flex h-screen w-full flex-col items-center justify-center space-y-12 text-base-content"
>
	<h1 class="text-6xl">Coming Soon!</h1>
</div>
