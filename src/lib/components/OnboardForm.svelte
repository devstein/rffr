<script lang="ts">
	import { goto } from '$app/navigation';

	import supabase from '$lib/supabase';
	import { profile } from '$lib/store';

	export let userID: string;
	export let email: string;

	let loading = false;
	let firstName: string = '';
	let lastName: string = '';
	// TODO: Can we use sign in with LinkedIn?
	let linkedinURL: string = '';
	let hearAboutUs: string = '';
	let whyJoin: string = '';
	let otherReason: string = '';
	let agreeToTerms = false;

	const otherOption = 'Other';
	const whyJoinOptions = [
		'I want to refer people',
		'I want to list a job',
		'I want to refer people and list a job',
		otherOption
	];

	let errors: Record<string, string> = {};
	$: hasError = (field: string): boolean => Boolean(errors[field]);

	const onSelect = ({ target }: FormEventHandler<HTMLSelectElement>) => {
		if (!target) return;
		const { value } = target;
		whyJoin = value;
		// reset other
		otherReason = '';
	};

	const updateProfile = async () => {
		try {
			loading = true;
			let validationError = false;

			if (!agreeToTerms) {
				errors.agreeToTerms = 'You must agree to the terms of service to join RFFR.';
				validationError = true;
			} else {
				errors.agreeToTerms = '';
			}

			// validation
			if (!firstName?.trim()) {
				errors.firstName = 'Field is required.';
				validationError = true;
			} else {
				errors.firstName = '';
				firstName = firstName.trim();
			}

			if (!lastName?.trim()) {
				errors.lastName = 'Field is required.';
				validationError = true;
			} else {
				errors.lastName = '';
				lastName = lastName.trim();
			}

			if (!linkedinURL?.trim()) {
				errors.linkedinURL = 'Field is required.';
				validationError = true;
			} else if (!linkedinURL.includes('linkedin.')) {
				errors.linkedinURL = `LinkedIn profile URL appears malformed. It doesn't include linkedin.com`;
				validationError = true;
			} else {
				errors.linkedinURL = '';
				linkedinURL = linkedinURL.trim();
			}

			if (!hearAboutUs?.trim()) {
				errors.hearAboutUs = 'Field is required.';
				validationError = true;
			} else {
				errors.hearAboutUs = '';
				hearAboutUs = hearAboutUs.trim();
			}

			if (!whyJoin?.trim()) {
				errors.whyJoin = 'Field is required.';
				validationError = true;
			} else {
				errors.whyJoin = '';
				whyJoin = whyJoin.trim();
			}

			if (whyJoin === otherOption && !otherReason?.trim()) {
				errors.otherReason = 'Field is required.';
				validationError = true;
			} else {
				errors.otherReason = '';
				otherReason = otherReason?.trim();
			}

			// do not proceed if there are errors
			if (validationError) return;

			// keep as an array
			const survey = [
				{
					question: 'How did you hear about RFFR?',
					answer: hearAboutUs
				},
				{
					question: 'Why do you want to join RFFR?',
					answer: otherReason || whyJoin
				}
			];

			const updates = {
				user_id: userID,
				first_name: firstName,
				last_name: lastName,
				linkedin_url: linkedinURL,
				survey_response: survey,
				agree_to_terms: agreeToTerms
			};

			let { error } = await supabase.from('profile').upsert(updates, {
				returning: 'minimal' // Don't return the value after inserting
			});

			if (error) throw error;

			profile.set({
				firstName,
				lastName
			});

			goto('/');
		} catch (error) {
			alert(error.message);
		} finally {
			loading = false;
		}
	};
</script>

<h2 class="mb-8 text-2xl">Setup your profile!</h2>
<form
	class="form flex w-full flex-col items-start space-y-4"
	on:submit|preventDefault={updateProfile}
>
	<div class="w-full">
		<label class="label" for="email">
			<span class="label-text">Email<span class="text-error">*</span></span>
		</label>
		<input class="input w-full" required id="email" type="text" value={email} disabled />
	</div>
	<div class="flew-wrap flex w-full flex-row space-x-2">
		<div class="flex-1">
			<label class="label" for="firstName">
				<span class="label-text">First Name<span class="text-error">*</span></span>
			</label>
			<input
				class="input input-bordered w-full focus:input-secondary"
				id="firstName"
				type="text"
				placeholder="Jane"
				bind:value={firstName}
				required
				class:input-error={hasError('firstName')}
			/>
			{#if hasError('firstName')}
				<label class="label" for="firstName">
					<span class="label-text text-xs text-error">{errors.firstName}</span></label
				>
			{/if}
		</div>
		<div class="flex-1">
			<label class="label" for="lastName">
				<span class="label-text">Last Name<span class="text-error">*</span></span>
			</label>
			<input
				class="input input-bordered w-full focus:input-secondary"
				required
				id="lastName"
				type="text"
				placeholder="Doe"
				bind:value={lastName}
				class:input-error={hasError('lastName')}
			/>
			{#if hasError('lastName')}
				<label class="label" for="lastName">
					<span class="label-text text-xs text-error">{errors.lastName}</span></label
				>
			{/if}
		</div>
	</div>
	<div class="w-full">
		<label class="label" for="linkedinURL">
			<span class="label-text">LinkedIn Profile URL<span class="text-error">*</span></span>
		</label>
		<input
			class="input input-bordered w-full focus:input-secondary"
			required
			id="linkedinURL"
			type="text"
			placeholder="https://www.linkedin.com/in/devin-stein-087148107"
			bind:value={linkedinURL}
			class:input-error={hasError('linkedinURL')}
		/>
		{#if hasError('linkedinURL')}
			<label class="label" for="linkedinURL">
				<span class="label-text text-xs text-error">{errors.linkedinURL}</span></label
			>
		{/if}
	</div>

	<div class="w-full">
		<label class="label" for="hearAboutUs">
			<span class="label-text">How did you hear about RFFR?<span class="text-error">*</span></span>
		</label>
		<textarea
			class="textarea textarea-bordered w-full focus:textarea-secondary"
			required
			id="hearAboutUs"
			type="text"
			bind:value={hearAboutUs}
			placeholder="LinkedIn"
			class:textarea-error={hasError('hearAboutUs')}
		/>
		{#if hasError('hearAboutUs')}
			<label class="label" for="hearAboutUs">
				<span class="label-text text-xs text-error">{errors.hearAboutUs}</span></label
			>
		{/if}
	</div>

	<div class="form-control w-full">
		<label class="label" for="whyJoin">
			<span class="label-text">Why do you want to join RFFR?<span class="text-error">*</span></span>
		</label>
		<select
			id="whyJoin"
			class="select select-bordered focus:select-secondary"
			on:change={onSelect}
			required
			class:select-error={hasError('whyJoin')}
		>
			<option disabled selected>Select one option</option>
			{#each whyJoinOptions as option}
				<option>{option}</option>
			{/each}
		</select>
		{#if hasError('whyJoin')}
			<label class="label" for="whyJoin">
				<span class="label-text text-xs text-error">{errors.whyJoin}</span></label
			>
		{/if}
	</div>

	{#if whyJoin.includes(otherOption)}
		<div class="w-full">
			<label class="label" for="otherReason">
				<span class="label-text">Please Specify Reason<span class="text-error">*</span></span>
			</label>
			<textarea
				class="textarea textarea-bordered w-full focus:textarea-secondary"
				required
				id="otherReason"
				type="text"
				bind:value={otherReason}
				class:textarea-error={hasError('otherReason')}
			/>
		</div>
		{#if hasError('otherReason')}
			<label class="label" for="otherReason">
				<span class="label-text text-xs text-error">{errors.otherReason}</span></label
			>
		{/if}
	{/if}

	<div>
		<label class="label cursor-pointer justify-start">
			<input
				type="checkbox"
				bind:checked={agreeToTerms}
				id="agreeToTerms"
				class="checkbox checkbox-secondary checkbox-sm mr-2"
				class:checkbox-error={hasError('agreeToTerms')}
			/>
			<span class="label-text"
				>I agree to RFFR's <a target="_blank" href="/terms-of-service" class="link"
					>terms of service</a
				>
				and <a target="_blank" href="/privacy" class="link">privacy policy</a><span
					class="text-error">*</span
				></span
			>
		</label>
		{#if hasError('agreeToTerms')}
			<div>
				<span class="text-xs text-error">{errors.agreeToTerms}</span>
			</div>
		{/if}
	</div>

	<div class="flex w-full flex-row justify-center">
		<input
			type="submit"
			class="btn btn-secondary btn-wide"
			value={loading ? 'Setting up your profile...' : 'Join RFFR'}
			disabled={loading}
		/>
	</div>
</form>
