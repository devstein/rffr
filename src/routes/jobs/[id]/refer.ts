import type { RequestHandler } from '@sveltejs/kit';

import supabase from '$lib/supabase';

export const get: RequestHandler = async ({ params }) => {
	const { id } = params;
	const { data: job } = await supabase.from('job_board').select('*').eq('job_id', id).single();

	return {
		body: {
			job
		}
	};
};
