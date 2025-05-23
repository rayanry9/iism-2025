import tailwindcss from '@tailwindcss/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	server: {
		allowedHosts: [
			"iism2025.sports.iith.ac.in"
		]
	},
	plugins: [tailwindcss(), sveltekit()]
});
