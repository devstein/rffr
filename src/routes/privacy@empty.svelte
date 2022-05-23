<script lang="ts">
	import { marked } from 'marked';

	import Header from '$lib/components/Header.svelte';
	import Footer from '$lib/components/Footer.svelte';

	import privacy from '$lib/legal/privacy.md?raw';
</script>

<Header />
<div class="flex h-screen w-full flex-col items-center overflow-scroll">
	<h1 class="my-4 text-center text-4xl sm:my-12 sm:text-5xl">Privacy Policy</h1>

	<article class="prose pt-8">
		{@html marked(privacy)}
	</article>
</div>
<Footer />
