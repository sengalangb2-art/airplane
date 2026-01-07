<template>
  <div class="flex justify-between align-center common-title">
    <div class="flex align-center">
      <svg-icon name="title-icon" class="svg-color"/>
      <span class="title m-l-5">{{ title }}</span>
    </div>
    <div>
      <slot v-if="button" />
      <template v-else>
        <el-icon color="#CED4E0"><MoreFilled /></el-icon>
      </template>
    </div>
  </div>
</template>

<script setup>

defineProps({
  title: {
    type: String,
    default: '标题'
  },
  button: {
    type: Boolean,
    default: false
  }
})
</script>

<style lang="scss" scoped>
.common-title {
  padding: 20px 0;

  .title {
    font-weight: 500;
    font-size: 18px;
    color: #111d34;
  }

  .svg-color {
    color: var(--el-color-primary);
  }
}
</style>
