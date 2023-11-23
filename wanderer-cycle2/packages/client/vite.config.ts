import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import * as path from "path";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    fs: {
      strict: false,
    },
  },
  build: {
    target: "es2022",
    minify: true,
    sourcemap: true,
  },
  resolve: {
    alias: {
      '@': path.resolve(__dirname, 'src'),
      'shared': path.resolve(__dirname, 'shared'),
      'entities': path.resolve(__dirname, 'entities'),
      'pages': path.resolve(__dirname, 'pages'),
      'widgets': path.resolve(__dirname, 'widgets'),
    },
  },
});
