# Website

This website is built using [Docusaurus](https://docusaurus.io/), a modern static website generator.

You'll need to run `lune run pilot-generate -- --wikionly` as to generate the files in the `/wiki/docs/objects` & `/wiki/docs/types` directories.

### Installation

```
$ yarn
```

### Local Development

```
$ yarn start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

### Finishing Up

```
$ yarn build
```

This command generates static content into the `build` directory, it will provide warnings about dead links, so it's good to finish your work by running this (just in case!).
