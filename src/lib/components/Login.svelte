<script lang="ts">
	import { goto } from '$app/navigation';

	import { signInWithEmail, signInWithGoogle } from '$lib/supabase';
	import { isValidEmail } from '$lib/email';

	let email: string;

	// naively duplicate variables for  different logins
	let loadingEmailLogin = false;
	let loadingGoogleLogin = false;

	let emailError: string | null = null;
	let googleError: string | null = null;

	const handleEmailLogin = async () => {
		try {
			loadingEmailLogin = true;

			// basic email validation
			emailError = null;
			email = email?.trim();

			if (!email) {
				emailError = 'Email is required';
				return;
			}

			if (!isValidEmail(email)) {
				emailError = 'Email is invalid';
				return;
			}

			const { error } = await signInWithEmail(email);

			if (error) throw error;

			// on success, redirect to the homepage with banner message
			goto('/?banner=true');
		} catch (error) {
			console.error(error);
			emailError =
				'Something went wrong. Please try again. If this error persists, please reach out to team@rffr.xyz';
		} finally {
			loadingEmailLogin = false;
		}
	};

	const handleGoogleLogin = async () => {
		try {
			loadingGoogleLogin = true;
			googleError = null;

			const { error } = await signInWithGoogle();

			if (error) throw error;
		} catch (error) {
			console.error(error);
			googleError =
				'Something went wrong. Please try again. If this error persists, please reach out to team@rffr.xyz';
		} finally {
			loadingGoogleLogin = false;
		}
	};
</script>

<div class="flex flex-col space-y-4">
	<div class="flex w-full flex-row">
		<div class="form-control flex-1">
			<label class="label" for="email">
				<span class="label-text">Sign in with email</span>
			</label>
			<label class="input-group">
				<input
					id="email"
					bind:value={email}
					class="input input-bordered flex-1"
					type="email"
					placeholder="jane.doe@gmail.com"
					required
					class:input-error={emailError}
				/>
				<button
					disabled={loadingEmailLogin}
					class="btn btn-primary"
					class:loading={loadingEmailLogin}
					on:click={handleEmailLogin}
				>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-6 w-6"
						fill="none"
						viewBox="0 0 24 24"
						stroke="currentColor"
						stroke-width="2"
					>
						<path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3" />
					</svg>
				</button>
			</label>
			{#if emailError}
				<label class="label" for="email">
					<span class="label-text text-xs text-error">{emailError}</span>
				</label>
			{/if}
		</div>
	</div>
	<div class="divider-accent divider w-full">OR</div>
	<button
		disabled={loadingGoogleLogin}
		class="card-shadow btn btn-ghost btn-wide self-center border-2 border-black hover:border-2"
		class:loading={loadingGoogleLogin}
		on:click={handleGoogleLogin}
	>
		<svg
			xmlns="http://www.w3.org/2000/svg"
			xmlns:xlink="http://www.w3.org/1999/xlink"
			class="mr-2 h-6 w-6"
			viewBox="0 0 48 48"
		>
			<defs>
				<path
					id="a"
					d="M44.5 20H24v8.5h11.8C34.7 33.9 30.1 37 24 37c-7.2 0-13-5.8-13-13s5.8-13 13-13c3.1 0 5.9 1.1 8.1 2.9l6.4-6.4C34.6 4.1 29.6 2 24 2 11.8 2 2 11.8 2 24s9.8 22 22 22c11 0 21-8 21-22 0-1.3-.2-2.7-.5-4z"
				/>
			</defs>
			<clipPath id="b">
				<use xlink:href="#a" overflow="visible" />
			</clipPath>
			<path clip-path="url(#b)" fill="#FBBC05" d="M0 37V11l17 13z" />
			<path clip-path="url(#b)" fill="#EA4335" d="M0 11l17 13 7-6.1L48 14V0H0z" />
			<path clip-path="url(#b)" fill="#34A853" d="M0 37l30-23 7.9 1L48 0v48H0z" />
			<path clip-path="url(#b)" fill="#4285F4" d="M48 48L17 24l-4-3 35-10z" />
		</svg>
		Sign in with Google
	</button>
	{#if googleError}
		<div class="text-center text-xs text-error">{googleError}</div>
	{/if}
</div>

<style lang="postcss">
	.card-shadow {
		box-shadow: hsl(var(--bc) / var(--tw-text-opacity)) 2px 2px 0px 0px;
	}
	.card-shadow:hover,
	.card-shadow:focus {
		box-shadow: hsl(var(--bc) / var(--tw-text-opacity)) 4px 4px 0px 0px;
	}
</style>
