<script lang="ts">
	import { browser } from '$app/env';
	import { page } from '$app/stores';
	import { marked } from 'marked';

	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';

	import terms from '$lib/legal/terms.md?raw';
	import referrer from '$lib/legal/referrer.md?raw';
	import employer from '$lib/legal/employer.md?raw';

	// on mobile, synchronize option and url hash
	let option: string = $page.url.hash || '#terms';
	$: browser && (window.location.hash = option);

	// harcode for now...
	let article = terms;
	$: article =
		$page.url.hash === '#referrer' ? referrer : $page.url.hash === '#employer' ? employer : terms;
</script>

<Header />
<div class="flex h-screen w-full flex-col items-center overflow-scroll">
	<h1 class="my-4 text-center text-4xl sm:my-12 sm:text-5xl">Terms of Service</h1>

	<div class="tabs hidden sm:block">
		<a
			class:tab-active={$page.url.hash === '#terms' || !$page.url.hash}
			class="tab tab-bordered"
			href="#terms">Terms & Conditions</a
		>
		<a
			class:tab-active={$page.url.hash === '#referrer'}
			class="tab tab-active tab-bordered"
			href="#referrer"
		>
			Referrer Addendum
		</a>
		<a class:tab-active={$page.url.hash === '#employer'} class="tab tab-bordered" href="#employer">
			Employer Addendum
		</a>
	</div>

	<div class="sm:hidden">
		<select class="select select-ghost w-full max-w-xs" bind:value={option}>
			<option value="#terms">Terms & Conditions</option>
			<option value="#referrer"> Referrer Addendum </option>
			<option value="#employer"> Employer Addendum </option>
		</select>
	</div>

	<article class="prose px-1 pt-8">
		{@html marked(article)}
	</article>
</div>
<Footer />
