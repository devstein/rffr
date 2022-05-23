import type { RequestHandler } from '@sveltejs/kit';

import supabase from '$lib/supabase';
import type { JobBoardPost } from '$lib/db/schema';

const jobs = [
	{
		id: 1,
		title: 'Ex-Founders',
		reward: 7500,
		company_name: 'Supabase',
		job_description_url: 'https://sharedrecruiting.co',
		locations: ['Remote']
	},
	{
		id: 2,
		title: 'Full Stack Engineer',
		reward: 8000,
		company_name: 'Gravity',
		job_description_url: 'https://sharedrecruiting.co',
		locations: ['Bay Area', 'Remote']
	},
	{
		id: 3,
		title: 'Head of Design',
		reward: 12000,
		company_name: 'Viaduct',
		job_description_url: 'https://sharedrecruiting.co',
		locations: ['Bay Area', 'Remote']
	},
	{
		id: 4,
		title: 'Software Engineer',
		reward: 4000,
		company_name: 'Pogo',
		job_description_url: 'https://sharedrecruiting.co',
		locations: ['Brooklyn', 'Remote']
	}
];


export const get: RequestHandler = async () => {

	return {
		body: {
			jobs
		}
	};
};
