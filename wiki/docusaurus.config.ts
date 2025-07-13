import { themes as prismThemes } from "prism-react-renderer";
import type { Config } from "@docusaurus/types";
import type * as Preset from "@docusaurus/preset-classic";

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

if (process.env.NODE_ENV !== 'production') {
	require('dotenv').config();
}

const config: Config = {
	title: "Waste of Space Wiki",
	tagline:
		"All information on this wiki is sourced from practical testing and developer messages. I have never had access to information no one else can get.",
	favicon: "image/favicon.ico",

	// Set the production url of your site here
	url: "https://arvidsilverlock.github.io",
	// Set the /<baseUrl>/ pathname under which your site is served
	// For GitHub pages deployment, it is often '/<projectName>/'
	baseUrl: "/Pilot.lua-Luau-LSP/",
	trailingSlash: false,

	// GitHub pages deployment config.
	// If you aren't using GitHub pages, you don't need these.
	organizationName: "ArvidSilverlock", // Usually your GitHub org/user name.
	projectName: "Pilot.lua-Luau-LSP", // Usually your repo name.

	onBrokenLinks: "throw",
	onBrokenMarkdownLinks: "warn",

	// Even if you don't use internationalization, you can use this field to set
	// useful metadata like html lang. For example, if your site is Chinese, you
	// may want to replace "en" with "zh-Hans".
	i18n: {
		defaultLocale: "en",
		locales: ["en"],
	},

	presets: [
		[
			"classic",
			{
				docs: {
					path: "docs",
					routeBasePath: "/",
					sidebarPath: "./sidebars.ts",
				},
				theme: {
					customCss: "./src/css/custom.css",
				},
				gtag: {
					trackingID: process.env.GTAG_TRACKING_ID,
					anonymizeIP: true,
				},
			} satisfies Preset.Options,
		],
	],

	themeConfig: {
		image: "image/social-card.png",
		metadata: [
			{
				name: "keywords",
				content:
					"waste of space, wos, wos microcontroller, roblox, pilot.lua, pilot.luau",
			},
		],
		navbar: {
			title: "Waste of Space Wiki",
			logo: {
				alt: "WoS Wiki Logo",
				src: "image/logo.png",
			},
			items: [
				{
					type: "docSidebar",
					sidebarId: "objectsSidebar",
					position: "left",
					label: "Objects",
				},
				{
					type: "docSidebar",
					sidebarId: "typesSidebar",
					position: "left",
					label: "Types",
				},
				{
					type: "docSidebar",
					sidebarId: "moduleSidebar",
					position: "left",
					label: "Modules",
				},
				{
					type: "docSidebar",
					sidebarId: "helpSidebar",
					position: "left",
					label: "Help",
				},
				{
					position: "right",
					label: "Raw Documentation",
					to: "raw-documentation",
				},
				{
					position: "right",
					label: "Contributing",
					to: "contributing",
				},
				{
					href: "https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP",
					label: "GitHub",
					position: "right",
				},
			],
		},
		footer: {
			style: "dark",
			links: [
				{
					title: "Documentation",
					items: [
						{
							label: "Documentation",
							to: "/objects/PilotObject",
						},
					],
				},
				{
					title: "More",
					items: [
						{
							label: "GitHub",
							href: "https://github.com/ArvidSilverlock/Pilot.lua-Luau-LSP",
						},
					],
				},
			],
			copyright: `Copyright © ${new Date().getFullYear()} ArvidSilverlock. Built with Docusaurus.`,
		},
		algolia: {
			appId: process.env.ALGOLIA_APP_ID,
			apiKey: process.env.ALGOLIA_SEARCH_API_KEY,
			indexName: process.env.ALGOLIA_INDEX_NAME,
			contextualSearch: true,
		},
		prism: {
			theme: prismThemes.github,
			darkTheme: prismThemes.dracula,
			additionalLanguages: ["lua"],
			magicComments: [
				{
					className: "code-block-error-line",
					line: "This will error",
				},
			],
		},
	} satisfies Preset.ThemeConfig,
};

export default config;
