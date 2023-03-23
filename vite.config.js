import path from 'node:path';

import autoprefixer from 'autoprefixer';
import { defineConfig } from 'vite';

import pages from './pages.config';

const pagesInput = {};

pages.forEach((page) => {
  pagesInput[page.name] = path.resolve(__dirname, page.path);
});

export default defineConfig(() => {
  return {
    root: path.resolve(__dirname, 'src'),
    base: './',
    server: {
      // not used rn, but may be needed in the future
      port: 8080,
      host: '0.0.0.0',
      watch: {
        usePolling: true,
      },
    },
    resolve: {
      alias: [
        {
          find: 'root',
          replacement: path.resolve(__dirname, 'src'),
        },
      ],
      extensions: ['.css', '.scss', '.mjs', '.js', '.ts', '.jsx', '.tsx', '.json', '.vue'],
    },
    build: {
      outDir: path.resolve(__dirname, 'dist'),
      rollupOptions: {
        input: {
          ...pagesInput,
        },
        output: {
          assetFileNames: (assetInfo) => {
            const info = assetInfo.name.split('.');
            let extType = info[info.length - 1];
            if (/png|jpe?g|svg|gif|tiff|bmp|ico/i.test(extType)) {
              extType = 'img';
            } else if (/woff|woff2/.test(extType)) {
              extType = "fonts";
            } else if(/\.(css)$/i.test(extType)) {
              extType = "css";
            }
            return `assets/${extType}/[name][extname]`;
          },
          chunkFileNames: 'assets/js/[name].js',
          entryFileNames: 'assets/js/[name].js',
        },
      },
    },
    css: {
      postcss: {
        plugins: [autoprefixer({})],
      },
    },
  };
});
