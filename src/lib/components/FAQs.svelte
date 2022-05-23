<script lang="ts">
	import { slide } from 'svelte/transition';

	const faqs = [
		{
			question: 'How do I get started referring people in my network?',
			answer: 'Sign up for an account and start recruiting!'
		},
		{
			question: 'How much does RFFR cost?',
			answer:
				"It's free to join and post to RFFR! We only charge for value we deliver, meaning you only pay when you make a hire."
		},
		{
			question: 'How do I get paid?',
			answer:
				"We use Stripe for processing payments. You'll get paid directly by company once the referred candidate is hired."
		},
		{
			question: 'How can I post a reward?',
			answer:
				"Right now, we are in a closed-beta. If you'd like to post a reward, indicate it on your profile when you sign up and we'll reach out! You can also reach out to us directly."
		},
		{
			question: 'What if a company has already reached out to a candidate I’ve referred?',
			answer:
				"You will not receive a referral reward if the candidate was already in the company's recruiting pipeline."
		},
		{
			question: 'Can I use RFFR for internal employee referrals?',
			answer: 'Absolutely! RFFR is free to use for internal referrals.'
		},
		{
			question: 'Can I refer myself?',
			answer:
				'No, you cannot refer yourself. If you have a good reason we should change this, reach out and let us know!'
		},
		{
			question: 'More Questions?',
			answer:
				"Reach out to us at <a class='link' href='mailto:team@rffr.xyz'>team@rffr.xyz</a>! We'd love to chat."
		}
	];

	let opened: Record<string, boolean> = {};

	const toggleVisibility = (key: string) => {
		opened[key] = !opened[key];
	};
</script>

<div class="mx-auto max-w-7xl py-12 px-4 sm:py-16 sm:px-6 lg:px-8">
	<div class="mx-auto max-w-3xl divide-y-2 divide-gray-200">
		<div>
			<h2 class="mt-8 mb-4 text-center text-3xl font-extrabold text-gray-900 sm:text-4xl">
				Frequently Asked Questions
			</h2>
			<p class="text-center text-sm text-gray-500">
				For any additional questions, please reach out to us at <a
					class="link"
					href="mailto:team@rffr.xyz">team@rffr.xyz</a
				>. We'd love to chat!
			</p>
		</div>
		<dl class="mt-6 space-y-6 divide-y divide-gray-200">
			{#each faqs as faq}
				<div class="pt-6">
					<dt class="text-lg">
						<!-- Expand/collapse question button -->
						<button
							type="button"
							class="flex w-full items-start justify-between text-left text-gray-400"
							aria-controls={`faq-${faq.question}`}
							aria-expanded={opened[faq.question]}
							on:click={(e) => {
								e.preventDefault();
								toggleVisibility(faq.question);
							}}
						>
							<span class="font-medium text-gray-900">
								{faq.question}
							</span>
							<span class="ml-6 flex h-7 items-center">
								<!--
                  Expand/collapse icon, toggle classes based on question open state.

                  Heroicon name: outline/chevron-down

                  Open: "-rotate-180", Closed: "rotate-0"
                -->
								<svg
									class="h-6 w-6 transform"
									class:-rotate-180={opened[faq.question]}
									class:rotate-0={!opened[faq.question]}
									xmlns="http://www.w3.org/2000/svg"
									fill="none"
									viewBox="0 0 24 24"
									stroke-width="2"
									stroke="currentColor"
									aria-hidden="true"
								>
									<path stroke-linecap="round" stroke-linejoin="round" d="M19 9l-7 7-7-7" />
								</svg>
							</span>
						</button>
					</dt>
					{#if opened[faq.question]}
						<dd class="mt-2 pr-12" id={`faq-${faq.question}`} transition:slide>
							<p class="text-base text-gray-500">
								{@html faq.answer}
							</p>
						</dd>
					{/if}
				</div>
			{/each}
		</dl>
	</div>
</div>
