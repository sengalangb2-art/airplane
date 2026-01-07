<template>
  <div class="center">
    <el-tabs
      v-model="componentActive"
      class="p-t-10 p-b-10">
      <el-tab-pane
        label="个人中心"
        :name="1"></el-tab-pane>
      <el-tab-pane
        label="机票预定"
        :name="2"></el-tab-pane>
      <el-tab-pane
        label="航班收藏"
        :name="3"></el-tab-pane>
    </el-tabs>
    <div class="center-right">
      <keep-alive>
        <component :is="currentComponent" />
      </keep-alive>
    </div>
  </div>
</template>

<script setup>
  const componentsMap = {
    1: defineAsyncComponent(() => import('./components/information.vue')),
    2: defineAsyncComponent(() => import('./components/resume.vue')),
    3: defineAsyncComponent(() => import('./components/delivery.vue')),
  };

  const componentActive = ref(1);

  const currentComponent = computed(() => {
    return componentsMap[componentActive.value];
  });
</script>

<style lang="scss" scoped>
  .center {
    padding: 0 4vw;
  }

  .center-right {
    background-color: #fff;
    border-radius: 6px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  }
</style>
