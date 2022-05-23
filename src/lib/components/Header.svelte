<script lang="ts">
	import { logout } from '$lib/supabase';
	import { profile } from '$lib/store';
</script>

<div class="sticky top-0 z-50">
	<div
		class="flex flex-row flex-nowrap items-center justify-between space-x-4 bg-base-100 px-4  py-4 text-lg sm:text-xl"
	>
		<a href="/" class="text-xl font-black text-primary sm:text-2xl md:min-w-[150px]">RFFR</a>
		<div class="hidden md:flex md:space-x-4">
			<a href="/#product" class="text-base font-medium text-gray-500 hover:text-gray-900">Product</a
			>
			<a href="/#features" class="text-base font-medium text-gray-500 hover:text-gray-900"
				>Features</a
			>
			<a href="/#companies" class="text-base font-medium text-gray-500 hover:text-gray-900"
				>Companies</a
			>
			<a href="#faqs" class="text-base font-medium text-gray-500 hover:text-gray-900">FAQs</a>
		</div>
		<div class="flex items-center justify-end space-x-4 md:min-w-[150px]">
			{#if !$profile}
				<a class="hover:text-primary" href="https://sharedrecruiting.co">Login</a>
				<a
					class="rounded-lg bg-primary px-4 py-2 text-primary-content hover:bg-primary-focus"
					href="https://sharedrecruiting.co">Join</a
				>
			{:else}
				<a class="hover:text-primary" href="/jobs" sveltekit:prefetch>Jobs</a>
				<button class="btn btn-ghost btn-square btn-sm" on:click={logout}>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-5 w-5"
						viewBox="0 0 20 20"
						fill="currentColor"
					>
						<path
							fill-rule="evenodd"
							d="M3 3a1 1 0 00-1 1v12a1 1 0 102 0V4a1 1 0 00-1-1zm10.293 9.293a1 1 0 001.414 1.414l3-3a1 1 0 000-1.414l-3-3a1 1 0 10-1.414 1.414L14.586 9H7a1 1 0 100 2h7.586l-1.293 1.293z"
							clip-rule="evenodd"
						/>
					</svg>
				</button>
			{/if}
		</div>
	</div>
	<div class="bg-accent">
		<div class="mx-auto flex max-w-7xl items-center justify-center py-3 px-3 sm:px-6 lg:px-8">
			<svg
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 24 24"
				stroke-width="1.5"
				stroke="currentColor"
				class="h-8 w-8 text-white"
			>
				<path
					stroke-linecap="round"
					stroke-linejoin="round"
					d="M15.59 14.37a6 6 0 01-5.84 7.38v-4.8m5.84-2.58a14.98 14.98 0 006.16-12.12A14.98 14.98 0 009.631 8.41m5.96 5.96a14.926 14.926 0 01-5.841 2.58m-.119-8.54a6 6 0 00-7.381 5.84h4.8m2.581-5.84a14.927 14.927 0 00-2.58 5.84m2.699 2.7c-.103.021-.207.041-.311.06a15.09 15.09 0 01-2.448-2.448 14.9 14.9 0 01.06-.312m-2.24 2.39a4.493 4.493 0 00-1.757 4.306 4.493 4.493 0 004.306-1.758M16.5 9a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"
				/>
			</svg>
			<div class="px-4 sm:text-center">
				<p class="font-medium text-white">
					<span class="mb-2 block md:mb-0 md:inline md:text-base">
						RFFR is now part of the Shared Recruiting Co. Learn more at <a
							href="https://sharedrecruiting.co"
							class="underline">sharedrecruiting.co</a
						>!
					</span>
				</p>
			</div>
		</div>
	</div>
</div>
