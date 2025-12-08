import { readFile } from 'fs/promises';
import type { PageServerLoad } from './$types';
import type { TopStory } from '$lib/types/topStories';

export const load: PageServerLoad = async () => {
	return {
		topStories: JSON.parse((await readFile('../main/top_stories.json')).toString()) as TopStory[]
	};
};
