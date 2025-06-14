import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
	title: 'Waste of Space Wiki',
	tagline: 'All information on this wiki is sourced from practical testing and developer messages. I have never had access to information no one else can get.',
	favicon: 'img/favicon.ico',

	// Set the production url of your site here
	url: 'https://arvidsilverlock.github.io',
	// Set the /<baseUrl>/ pathname under which your site is served
	// For GitHub pages deployment, it is often '/<projectName>/'
	baseUrl: '/Pilot.lua-Luau-LSP/',
	trailingSlash: false,

	// GitHub pages deployment config.
	// If you aren't using GitHub pages, you don't need these.
	organizationName: 'ArvidSilverlock', // Usually your GitHub org/user name.
	projectName: 'Pilot.lua-Luau-LSP', // Usually your repo name.

	onBrokenLinks: 'throw',
	onBrokenMarkdownLinks: 'warn',

	// Even if you don't use internationalization, you can use this field to set
	// useful metadata like html lang. For example, if your site is Chinese, you
	// may want to replace "en" with "zh-Hans".
	i18n: {
		defaultLocale: 'en',
		locales: ['en'],
	},

	plugins: [
		[
			require.resolve("@easyops-cn/docusaurus-search-local"),
			{
				docsRouteBasePath: "/",
				hashed: true,
				indexDocs: true,
				indexBlog: false,
			},
		],
	],

	presets: [
		[
			'classic',
			{
				docs: {
					path: "docs",
					routeBasePath: "/",
					sidebarPath: './sidebars.ts',
				},
				theme: {
					customCss: './src/css/custom.css',
				},
			} satisfies Preset.Options,
		],
	],

	themeConfig: {
		image: 'img/social-card.png',
		navbar: {
			title: 'Waste of Space Wiki',
			logo: {
				alt: 'WoS Wiki Logo',
				src: 'img/logo.png',
			},
			items: [
				{
					type: 'docSidebar',
					sidebarId: 'objectsSidebar',
					position: 'left',
					label: 'Objects',
				},
				{
					type: 'docSidebar',
					sidebarId: 'typesSidebar',
					position: 'left',
					label: 'Types',
				},
				{
					type: 'docSidebar',
					sidebarId: 'helpSidebar',
					position: 'left',
					label: 'Help',
				},
				{
					position: 'left',
					label: 'Raw Documentation',
					to: 'raw-documentation',
				},
				{
					href: 'https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP',
					label: 'GitHub',
					position: 'right',
				},
			],
		},
		footer: {
			style: 'dark',
			links: [
				{
					title: 'Documentation',
					items: [
						{
							label: 'Documentation',
							to: '/objects/PilotObject',
						},
					],
				},
				{
					title: 'More',
					items: [
						{
							label: 'GitHub',
							href: 'https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP',
						},
					],
				},
			],
			copyright: `Copyright © ${new Date().getFullYear()} ArvidSilverlock. Built with Docusaurus.`,
		},
		prism: {
			theme: prismThemes.github,
			darkTheme: prismThemes.dracula,
			additionalLanguages: ['lua'],
			magicComments: [
				{
					className: 'code-block-error-line',
					line: 'This will error',
				},
			]
		},
	} satisfies Preset.ThemeConfig,
};

export default config;
