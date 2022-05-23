module.exports = {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	theme: {
		extend: {
			fontFamily: {
				sans: ['Miriam Libre', 'sans-serif']
			}
		}
	},
	daisyui: {
		themes: [
			// 'light',
			// 'dark',
			// 'cupcake',
			// 'bumblebee',
			// 'emerald',
			// 'corporate',
			// 'synthwave',
			// 'retro',
			// 'cyberpunk',
			// 'valentine',
			// 'halloween',
			// 'garden',
			// 'forest',
			// 'aqua',
			// 'lofi',
			// 'pastel',
			// 'fantasy',
			// 'wireframe',
			// 'black',
			// 'luxury',
			// 'dracula',
			// 'cmyk',
			// 'autumn',
			// 'business',
			// 'acid',
			// 'lemonade',
			// 'night',
			// 'coffee',
			// 'winter',
			{
				custom: {
					primary: '#56b881',
					'primary-content': '#fff',
					secondary: '#006994',
					accent: '#f77f00',
					// accent: '#e9a820',
					// accent: '#ff3503',
					neutral: '#fff',
					// 'base-100': '#e4f3e9',
					'base-100': '#fff',
					info: '#6b39d5',
					success: '#84cc16',
					warning: '#e9a820',
					error: '#da2c38'
				}
			}
		]
	},
	plugins: [require('daisyui'), require('@tailwindcss/typography')]
};
