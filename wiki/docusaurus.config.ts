import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Waste Of Space Wiki',
  tagline: 'RIP Arvid',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://regexman1.github.io',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/Pilot.lua-Luau-LSP/',
  trailingSlash: false,

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'regexman1', // Usually your GitHub org/user name.
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
  themes: [
      [
	      "@easyops-cn/docusaurus-search-local",
	      ({
		      hashed: true,
	      })
      ]
  ],
  presets: [
    [
      'classic',
      {
        docs: {
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
	  sidebarId: 'classesSidebar',
	  position: 'left',
	  label: 'Classes'
	},
        {
          type: 'docSidebar',
          sidebarId: 'documentationSidebar',
          position: 'left',
          label: 'Documentation',
        },
        {
          href: 'https://github.com/regexman1/Pilot.lua-Luau-LSP',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Documentation',
              to: '/docs/Globals',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/regexman1/Pilot.lua-Luau-LSP',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Pilot.lua Luau LSP Typechecking, Inc. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
	themeConfig: {
		colorMode: {
		  defaultMode: 'dark',
		  respectPrefersColorScheme: true,
		},
	  },
  } satisfies Preset.ThemeConfig,
};

export default config;
