<template>
  <div class="flex p-20 align-start">
    <el-avatar :src="avatar" />
    <div class="m-l-20">
      <div class="m-b-15 author-name">{{ author?.name || name || '匿名' }}</div>
      <span class="time">{{ time }}</span>
    </div>
  </div>
</template>

<script setup>
  import dayjs from 'dayjs';

  const props = defineProps({
    author: {
      type: Object,
      required: true,
      default: () => ({}),
    },
    time: {
      type: String,
      required: true,
      default: '',
    },
    avatar: {
      type: String,
      default: '',
    },
    name: {
      type: String,
      default: '',
    },
  });

  const time = computed(() => {
    return dayjs(props.time).format('YYYY-MM-DD HH:mm:ss');
  });

  const avatar = computed(() => {
    return (
      import.meta.env.VITE_APP_BASE_IP + '/static/' + props.avatar ||
      'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'
    );
  });
</script>

<style lang="scss" scoped>
  .author-name {
    font-size: 15px;
    font-weight: 600;
    color: #111d34;
  }

  .time {
    font-size: 12px;
    color: #666;
  }
</style>
