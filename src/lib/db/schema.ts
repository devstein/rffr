export type JobBoardPost = {
	job_id: string;
	title: string;
	reward: number;
	company_name: string;
	job_description_url: string;
	locations: string[];
	created_at: string;
	updated_at: string;
};

export type JobBoard = JobBoardPost[];
