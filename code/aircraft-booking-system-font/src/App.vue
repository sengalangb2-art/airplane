<template>
  <div>
    <el-scrollbar :height="height">
      <router-view />
    </el-scrollbar>
  </div>
</template>

<script setup>
const height = "100vh";
</script>

<style lang="scss" scoped></style>
