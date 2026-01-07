import { fileURLToPath, URL } from "node:url";
import path from "path";
import { defineConfig, loadEnv } from 'vite';
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";
import { createSvgIconsPlugin } from "vite-plugin-svg-icons";

const env = loadEnv(process.env.NODE_ENV, process.cwd());

// https://vite.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    vueDevTools(),
    createSvgIconsPlugin({
      iconDirs: [path.resolve(process.cwd(), "src/assets/svg")],
      symbolId: "icon-[dir]-[name]",
    }),
    Components({
      dirs: ["src/components"],
      extensions: ["vue"],
      deep: true,
      dts: "./typings/components.d.ts",
    }),
    AutoImport({
      imports: [
        "vue",
        "vue-router",
        {
          "pinia/dist/pinia": ["storeToRefs"],
        },
      ],
      //配置后会自动扫描目录下的文件
      dirs: ["src/hooks/**", "src/utils/**", "src/store/**"],
      eslintrc: {
        enabled: true, // Default `false`
        filepath: "./eslintrc/.eslintrc-auto-import.json", // Default `./.eslintrc-auto-import.json`
        globalsPropValue: true, // Default `true`, (true | false | 'readonly' | 'readable' | 'writable' | 'writeable')
      },
      dts: "./typings/auto-imports.d.ts",
    }),
  ],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  server: {
    port: 3000,
    proxy: {
      '/aircraft-booking-api': {
        target: env.VITE_APP_BASE_IP,
        changeOrigin: true,
        // rewrite: (path) => path.replace(/^\/api/, '')
      },
    },
  },
});
