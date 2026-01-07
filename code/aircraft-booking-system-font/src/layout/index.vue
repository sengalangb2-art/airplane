<template>
  <div>
    <Header />
    <Menu />
    <div class="content" v-loading="loading">
        <router-view></router-view>
    </div>
  </div>
</template>

<script setup>
import Header from "./components/Header.vue";
import Menu from "./components/menu.vue";
import { useCommonStore } from "@/stores/common";

const commonStore = useCommonStore();

const loading = computed(() => commonStore.loading);
</script>

<style lang="scss" scoped>
.content {
  margin-top: 125px;
}
</style>
