<script lang="ts">
	import type { JobBoard } from '$lib/db/schema';

	import JobCard from '$lib/components/JobCard.svelte';

	export let jobs: JobBoard;
</script>

<ul
	class="flex flex-col content-center items-center justify-start break-words bg-base-100 text-base-content md:flex-row md:flex-wrap"
>
	{#each [...jobs, ...jobs, ...jobs] as job}
		<li class="my-8 w-full md:mr-8 md:w-fit">
			<JobCard {job} />
		</li>
	{/each}
</ul>
