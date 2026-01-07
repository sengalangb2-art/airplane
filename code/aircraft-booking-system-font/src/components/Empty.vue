<template>
  <el-empty
    v-show="isEmpty"
    class="empty"
    v-bind="$attrs"
    :style="{ height: height || '100%' }"
    :image="emptyImg"
    :image-size="180"
  >
    <template #description>
      <p class="description">{{ text }}</p>
    </template>
  </el-empty>
</template>

<script setup>
import empty from '@/assets/images/empty.png'

const props = defineProps({
  isEmpty: {
    type: Boolean,
    default: true
  },
  height: String,
  text: { type: String, default: '暂无数据' },
  img: { type: String, default: '' }
})

const emptyImg = computed(() => {
  if (props.img) {
    return require(`@/assets/images/${props.img}.png`)
  } else {
    return empty
  }
})
</script>
<style lang="scss" scoped>
:deep(.el-empty__image) {
  width: 90px !important;
  height: 48px;
}
:deep(.el-empty__description) {
  margin-top: 12px;
}
</style>
