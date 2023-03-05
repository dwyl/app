// let {build} = require("esbuild");
// let files = ["../build/web/flutter.js", "../build/web/main.dart.js", ];

// build({
//     stdin: { contents: files.map(f => `import "${f}"`).join('\n') },
//     outfile: "../build/web/bundle.js",
//     minify: true,
//     bundle: true
// }).catch(() => process.exit(1));

// // build/web/main.dart.js
// // web/build.js

// const esbuild = require('esbuild')

require('esbuild').build({
  entryPoints: ['../build/web/flutter.js','../build/web/main.dart.js'],
  bundle: true,
  minify: true,
  allowOverwrite: true,
  treeShaking: true,
  outdir: '../build/web/'
})