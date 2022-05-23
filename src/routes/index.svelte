<script lang="ts">
	import { page } from '$app/stores';

	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import FAQs from '$lib/components/FAQs.svelte';
	import JobCard from '$lib/components/JobCard.svelte';
	import type { JobBoard as IJobBoard } from '$lib/db/schema';

	// TODO
	// Failed to login banner
	// Profile creation banner

	export let jobs: IJobBoard = [];

	const closeBanner = () => {
		const { search } = window.location;
		let params = new URLSearchParams(search);
		params.delete('banner');
		window.location.search = params.toString();
	};
</script>

<main class="relative">
	<!-- Sign Up Banner  -->
	{#if $page.url.searchParams.get('banner')}
		<div class="relative bg-accent">
			<div class="mx-auto max-w-7xl py-3 px-3 sm:px-6 lg:px-8">
				<div class="pr-16 sm:px-16 sm:text-center">
					<p class="font-medium text-white">
						<span class="mb-2 block md:mb-0 md:inline md:text-base"> Welcome to RFFR! </span>
						<span class="block text-sm md:inline md:text-base">
							Check your inbox for a confirmation email. If you don't see an email, check your spam
							folder.
						</span>
					</p>
				</div>
				<div
					class="absolute inset-y-0 right-0 flex items-start pt-1 pr-1 sm:items-start sm:pt-1 sm:pr-2"
				>
					<button
						on:click={closeBanner}
						type="button"
						class="flex rounded-md p-2 hover:bg-primary focus:outline-none focus:ring-2 focus:ring-white"
					>
						<span class="sr-only">Dismiss</span>
						<!-- Heroicon name: outline/x -->
						<svg
							class="h-6 w-6 text-white"
							xmlns="http://www.w3.org/2000/svg"
							fill="none"
							viewBox="0 0 24 24"
							stroke-width="2"
							stroke="currentColor"
							aria-hidden="true"
						>
							<path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
						</svg>
					</button>
				</div>
			</div>
		</div>
	{/if}

	<Header />
	<div id="main" class="hero min-h-screen ">
		<div class="hero-content text-center">
			<!--  Negative margin to shift the content slightly above center -->
			<div class="-mt-20  max-w-3xl sm:-mt-48">
				<h1 class="mb-8 text-4xl font-bold sm:mb-12 sm:text-5xl">
					<span class="text-primary">Refer friends</span> to awesome jobs and
					<span class="text-primary">get paid.</span>
				</h1>
				<p class="my-8 text-lg sm:text-xl">
					RFFR is a candidate-powered recruiting platform. We provide tools and incentives to
					candidates to help you hire amazing people.
				</p>
				<a class="btn btn-outline btn-secondary btn-wide m-2" href="#product">Learn More</a>
				<a class="btn btn-primary btn-wide m-2" href="https://sharedrecruiting.co">Sign Up</a>
			</div>
		</div>
	</div>
	<div id="product" class="mx-8 flex min-h-screen flex-col items-center">
		<h2 class="mt-20 mb-12 max-w-3xl text-center text-4xl font-bold text-secondary sm:text-5xl">
			How RFFR Works
		</h2>
		<div class="flex max-w-xl flex-col space-y-8 md:space-y-12">
			<div class="flex flex-row items-center space-x-4 md:space-x-6 md:space-y-0">
				<div
					class="mask mask-circle bg-primary p-4 text-center text-xl font-bold text-primary-content"
				>
					1
				</div>
				<div class="flex flex-col">
					<div class="text-xl font-semibold">Reward</div>
					<div class="text-lg">Companies place a reward on an open role</div>
				</div>
			</div>
			<div class="flex flex-row items-center space-x-4 md:space-x-6 md:space-y-0">
				<div
					class="mask mask-circle bg-primary p-4 text-center text-xl font-bold text-primary-content"
				>
					2
				</div>
				<div class="flex flex-col">
					<div class="text-xl font-semibold">Publicize</div>
					<div class="text-lg">Companies publicize the reward in existing recruitng channels</div>
				</div>
			</div>
			<div class="flex flex-row items-center space-x-4 md:space-x-6 md:space-y-0">
				<div
					class="mask mask-circle bg-primary p-4 text-center text-xl font-bold text-primary-content"
				>
					3
				</div>
				<div class="flex flex-col">
					<div class="text-xl font-semibold">Refer</div>
					<div class="text-lg">
						Anyone can discover and refer people in their network who are a great fit
					</div>
				</div>
			</div>
			<div class="flex flex-row items-center space-x-4 md:space-x-6 md:space-y-0">
				<div
					class="mask mask-circle bg-primary p-4 text-center text-xl font-bold text-primary-content"
				>
					4
				</div>
				<div class="flex flex-col">
					<div class="text-xl font-semibold">Hire</div>
					<div class="text-lg">
						Companies hire amazing people, friends get awesome jobs, referrers get paid
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="features" class="flex min-h-screen flex-col items-center">
		<h2 class="my-20 max-w-3xl text-center text-4xl font-bold text-accent sm:text-5xl">
			Supercharge Your Recruiting
		</h2>
		<div class="flex w-2/3 flex-wrap justify-between">
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
					/>
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">Stop Wasting Time</p>
				<p>
					99% of outbound recruiting is wasted on happily employed candidates, but someone in the
					candidates’ network isn’t. RFFR helps them help you.
				</p>
			</div>
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path stroke-linecap="round" stroke-linejoin="round" d="M13 10V3L4 14h7v7l9-11h-7z" />
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">
					Maximize the Value of Existing Recruiting Tools
				</p>
				<p>
					RFFR integrates directly with your ATS and pairs perfectly with sourcing software like
					Gem, Dover, and RecruitBot
				</p>
			</div>
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z"
					/>
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">Exponentially Expand Your Network</p>
				<p>Talented people know talented people. RFFR lets you tap into their networks</p>
			</div>
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z"
					/>
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">Quality Matters</p>
				<p>
					Hire the best talent. RFFR provides controls and incentives to keep the referral bar high
				</p>
			</div>
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z"
					/>
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">Amplify Your Outreach</p>
				<p>
					Don’t settle for a single contingency recruiter. On RFFR, everyone is a recruiter, giving
					you access to an ever-growing network of recruiters
				</p>
			</div>
			<div class="mb-12 flex max-w-xs flex-col space-y-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					class="h-12 w-12 text-secondary-focus"
					fill="none"
					viewBox="0 0 24 24"
					stroke="currentColor"
					stroke-width="1"
				>
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"
					/>
				</svg>
				<p class="text-xl font-semibold text-secondary-focus">Own Relationships</p>
				<p>
					RFFR allows you to build relationships with candidates who aren’t ready for a new role,
					keeping you top of mind once they are
				</p>
			</div>
		</div>
	</div>
	<div id="companies" class="flex min-h-screen flex-col items-center text-center">
		<h2 class="my-20 max-w-3xl text-center text-4xl font-bold text-primary sm:text-5xl">
			Join the RFFR Network
		</h2>
		<p class="w-full text-center text-lg font-light uppercase">
			The fastest growing companies supercharge their growth with RFFR
		</p>
		<div class="my-8">
			<div class="slider">
				<div class="slide-track my-8 ">
					{#each [...jobs, ...jobs, ...jobs] as job}
						<div class="slide">
							<JobCard {job} />
						</div>
					{/each}
				</div>
			</div>
			<a class="btn btn-primary btn-wide my-8" href="https://sharedrecruiting.co">Sign Up</a>
		</div>
	</div>
	<div id="faqs">
		<FAQs />
	</div>
</main>
<Footer />

<style>
	@-webkit-keyframes scroll {
		0% {
			-webkit-transform: translateX(0);
			transform: translateX(0);
		}
		100% {
			-webkit-transform: translateX(calc(-250px * 6));
			transform: translateX(calc(-250px * 6));
		}
	}
	@keyframes scroll {
		0% {
			-webkit-transform: translateX(0);
			transform: translateX(0);
		}
		100% {
			-webkit-transform: translateX(calc(-250px * 6));
			transform: translateX(calc(-250px * 6));
		}
	}
	.slider {
		margin: auto;
		overflow: hidden;
		position: relative;
	}
	.slider::before,
	.slider::after {
		background: linear-gradient(to right, white 0%, rgba(255, 255, 255, 0) 100%);
		content: '';
		/* height: 100px; */
		position: absolute;
		/* width: 200px; */
		z-index: 2;
	}
	.slider::after {
		right: 0;
		top: 0;
		-webkit-transform: rotateZ(180deg);
		transform: rotateZ(180deg);
	}
	.slider::before {
		left: 0;
		top: 0;
	}
	.slider .slide-track {
		-webkit-animation: scroll 40s linear infinite;
		animation: scroll 40s linear infinite;
		display: flex;
		gap: 24px;
		/* show at most 6 jobs */
		max-width: calc(250px * 6);
	}

	@media screen and (max-width: 600px) {
		.slider .slide-track {
			max-width: 350px;
		}
	}

	@media screen and (min-width: 600px) and (max-width: 768px) {
		.slider .slide-track {
			max-width: 500px;
		}
	}

	@media screen and (min-width: 768px) and (max-width: 900px) {
		.slider .slide-track {
			max-width: 600px;
		}
	}
	@media screen and (min-width: 768px) and (max-width: 900px) {
		.slider .slide-track {
			max-width: 760px;
		}
	}

	@media screen and (min-width: 900px) and (max-width: 1200px) {
		.slider .slide-track {
			max-width: 900px;
		}
	}
</style>
