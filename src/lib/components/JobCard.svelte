<script lang="ts">
	import type { JobBoardPost } from '$lib/db/schema';

	export let job: JobBoardPost;

	/* Temporarily remove link and cursor-pointer
	/* <a href={`/jobs/${job.job_id}/refer`} sveltekit:prefetch> */
</script>

<div>
	<div
		class="card-shadow flex h-56 w-full w-56 flex-col flex-nowrap items-center space-y-2 rounded border-2 border-base-content bg-white px-4 py-4 text-center transition transition-shadow"
	>
		<h4 class="my-4 text-lg font-bold">{job.company_name}</h4>
		<p class="text-secondary">{job.title}</p>
		<p class="flex flex-row flex-nowrap items-center whitespace-pre-wrap text-sm text-gray-500">
			{#each job.locations as location, index}
				<span>{location}</span>
				{#if index !== job.locations.length - 1}
					<span>{' '}• </span>
				{/if}
			{/each}
		</p>
		<p class="mt-2 flex flex-1 flex-col justify-end font-bold text-primary-focus">
			${job.reward}
		</p>
	</div>
</div>

<style lang="postcss">
	.card-shadow {
		box-shadow: hsl(var(--bc) / var(--tw-text-opacity)) 2px 2px 0px 0px;
	}
	.card-shadow:hover,
	.card-shadow:active,
	.card-shadow:focus-visible,
	.card-shadow:focus {
		box-shadow: hsl(var(--p) / var(--tw-text-opacity)) 5px 5px 0px 0px;
		@apply border-primary;
	}
</style>
