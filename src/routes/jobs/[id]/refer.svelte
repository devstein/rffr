<script lang="ts">
	import type { JobBoardPost } from '$lib/db/schema';

	import supabase from '$lib/supabase';
	import { user } from '$lib/store';
	import Login from '$lib/components/Login.svelte';

	export let job: JobBoardPost;

	let submitting = false;
	let success = false;

	let email: string;
	let relationship: string;
	let fit: string;

	let errors: Record<string, string> = {};
	$: hasError = (field: string): boolean => Boolean(errors[field]);

	const submit = async () => {
		try {
			submitting = true;
			let validationError = false;

			// validation
			if (!email?.trim()) {
				errors.email = 'Field is required.';
				validationError = true;
			} else if (email.trim() === $user?.email) {
				errors.email = 'You cannot refer yourself.';
				validationError = true;
			} else {
				errors.email = '';
				email = email.trim();
			}

			if (!relationship?.trim()) {
				errors.relationship = 'Field is required.';
				validationError = true;
			} else {
				errors.relationship = '';
				relationship = relationship.trim();
			}

			if (!fit?.trim()) {
				errors.fit = 'Field is required.';
				validationError = true;
			} else {
				errors.fit = '';
				fit = fit.trim();
			}

			// return if there are validation errors
			if (validationError) return;

			// keep as an array
			const survey = [
				{
					question: 'How do you know them?',
					answer: relationship
				},
				{
					question: 'Why are they a good fit for the role?',
					answer: fit
				}
			];

			const referral = {
				candidate_email: email,
				job_id: job.job_id,
				referrer_id: $user?.id as string,
				survey_response: survey
			};

			let { error } = await supabase.from('referral').insert(referral, {
				returning: 'minimal' // Don't return the value after inserting
			});

			if (error) throw error;

			success = true;
		} catch (err) {
			// TODO: Handler error
			console.error(err);
			alert(err);
		} finally {
			submitting = false;
		}
	};

	// TODO: Company Website
	// TODO: Explanatory text
	// TODO: Success state (more explanatory text)
	// TODO: Wrap in form

	// Success! Thee candidate will receive an email letting them know they've been referred!
	// The candidate will receive an email letting them know they have been referred
	// They will choose to accept or reject the referral
	// If they accept, the company will receive an the referral information
</script>

<div class="flex h-full w-full flex-col items-center justify-center bg-primary">
	<div
		class="mx-8 max-w-3xl rounded border bg-primary-content px-8 pb-10 pt-4 sm:mx-auto md:w-1/2 lg:w-2/5"
	>
		{#if !$user}
			<h2 class="my-4 text-3xl md:text-4xl">Login or Sign Up to Submit a Referral</h2>
			<Login />
		{:else if success}
			<h2 class="my-4 text-3xl font-bold text-success md:text-4xl">Success!</h2>
			<p class="my-4 text-lg">What Happens Next</p>
			<ol class="space-y-4">
				<li>
					1. The candidate will receive an email at {email} letting them know you've referred them.
				</li>
				<li>
					2. If the candidate accepts the referral, then they will start the interview process with {job.company_name}
				</li>
				<li>3. If they are hired for the role, the you'll receive ${job.reward}!</li>
			</ol>
			<div class="mt-8">
				<a href="/jobs" class="link">View Other Jobs -></a>
			</div>
		{:else}
			<h2 class="my-8 text-3xl md:text-4xl">Submit a Referral</h2>
			<h4 class="my-4 text-xl">About the Role</h4>
			<div
				class="job-shadow flex flex-col space-y-3 rounded border-2 border-base-content px-4 py-2"
			>
				<div class="my-2 flex flex-row items-center space-x-1 text-lg text-secondary">
					<div>{job.title}</div>
					<a href={job.job_description_url} target="_blank" rel="noopener noreferrer" class="link">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							class="h-4 w-4"
							fill="none"
							viewBox="0 0 24 24"
							stroke="currentColor"
							stroke-width="2"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
							/>
						</svg>
					</a>
				</div>
				<div
					class="flex flex-col flex-nowrap space-x-0 space-y-2 md:flex-row md:items-center md:space-x-4 md:space-y-0"
				>
					<div class="flex flex-row flex-nowrap items-center space-x-1">
						<svg
							xmlns="http://www.w3.org/2000/svg"
							class="h-5 w-5"
							fill="none"
							viewBox="0 0 24 24"
							stroke="currentColor"
							stroke-width="2"
						>
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
							/>
						</svg>
						<div>
							{job.company_name}
						</div>
					</div>
					<div class="flex flex-row flex-nowrap items-center whitespace-pre-wrap text-gray-500">
						<svg
							class="mr-1 h-5 w-5 fill-current"
							viewBox="0 0 24 24"
							fill="none"
							xmlns="http://www.w3.org/2000/svg"
						>
							<path
								fill-rule="evenodd"
								clip-rule="evenodd"
								d="M16.2721 10.2721C16.2721 12.4813 14.4813 14.2721 12.2721 14.2721C10.063 14.2721 8.27214 12.4813 8.27214 10.2721C8.27214 8.063 10.063 6.27214 12.2721 6.27214C14.4813 6.27214 16.2721 8.063 16.2721 10.2721ZM14.2721 10.2721C14.2721 11.3767 13.3767 12.2721 12.2721 12.2721C11.1676 12.2721 10.2721 11.3767 10.2721 10.2721C10.2721 9.16757 11.1676 8.27214 12.2721 8.27214C13.3767 8.27214 14.2721 9.16757 14.2721 10.2721Z"
							/><path
								fill-rule="evenodd"
								clip-rule="evenodd"
								d="M5.79417 16.5183C2.19424 13.0909 2.05438 7.3941 5.48178 3.79418C8.90918 0.194258 14.6059 0.0543983 18.2059 3.48179C21.8058 6.90919 21.9457 12.606 18.5183 16.2059L12.3124 22.7241L5.79417 16.5183ZM17.0698 14.8268L12.243 19.8965L7.17324 15.0698C4.3733 12.404 4.26452 7.9732 6.93028 5.17326C9.59603 2.37332 14.0268 2.26454 16.8268 4.93029C19.6267 7.59604 19.7355 12.0269 17.0698 14.8268Z"
							/>
						</svg>
						{#each job.locations as location, index}
							<span>{location}</span>
							{#if index !== job.locations.length - 1}
								<span>{' '}• </span>
							{/if}
						{/each}
					</div>
				</div>
				<div class="flex flex-row flex-nowrap items-center space-x-1 font-bold text-primary-focus">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-6 w-6"
						fill="none"
						viewBox="0 0 24 24"
						stroke="currentColor"
						stroke-width="2"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"
						/>
					</svg>
					<div>
						${job.reward}
					</div>
				</div>
			</div>
			<!-- Start form -->
			<h4 class="mt-8 text-xl ">About the Candidate</h4>
			<p class="mb-2 text-xs text-slate-400">
				Your responses will be shared with {job.company_name} if the candidate accepts the referral
			</p>
			<div class="flex flex-col space-y-4">
				<div class="w-full">
					<label class="label" for="email">
						<span class="label-text">Email<span class="text-error">*</span></span>
					</label>
					<input
						class="input input-bordered w-full focus:input-primary"
						required
						id="email"
						type="email"
						placeholder="jane.doe@gmail.com"
						bind:value={email}
						class:input-error={hasError('email')}
					/>
					{#if hasError('email')}
						<label class="label" for="email">
							<span class="label-text text-xs text-error">{errors.email}</span></label
						>
					{/if}
				</div>
				<div class="w-full">
					<label class="label" for="relationship">
						<span class="label-text">How do you know them?<span class="text-error">*</span></span>
					</label>
					<textarea
						class="textarea textarea-bordered w-full focus:textarea-primary"
						required
						id="relationship"
						type="text"
						bind:value={relationship}
						placeholder="I worked with Jane Doe at ACME Corp"
						class:textarea-error={hasError('relationship')}
					/>
					{#if hasError('relationship')}
						<label class="label" for="relationship">
							<span class="label-text text-xs text-error">{errors.relationship}</span></label
						>
					{/if}
				</div>
				<div class="w-full">
					<label class="label" for="whyCandidate">
						<span class="label-text"
							>Why are they a good fit for the role?<span class="text-error">*</span></span
						>
					</label>
					<textarea
						class="textarea textarea-bordered w-full focus:textarea-primary"
						required
						id="fit"
						type="text"
						bind:value={fit}
						placeholder="Jane is the best engineer I've ever worked with. She's a great team player and I'd recommend her to anyone looking for a developer."
						class:textarea-error={hasError('fit')}
					/>
					{#if hasError('fit')}
						<label class="label" for="fit">
							<span class="label-text text-xs text-error">{errors.fit}</span></label
						>
					{/if}
				</div>
				<div class="flex w-full flex-row justify-center">
					<input
						type="submit"
						class="btn btn-primary btn-wide"
						class:loading={submitting}
						value={submitting ? 'Submitting...' : 'Submit'}
						on:click={submit}
						disabled={submitting}
					/>
				</div>
			</div>
		{/if}
	</div>
</div>

<style lang="postcss">
	.job-shadow {
		/* Unclear why this isn't working */
		/* box-shadow: hsl(var(--bc) / var(--tw-text-opacity)) 2px 2px 0px 0px; */
		box-shadow: 2px 2px black;
	}
</style>
