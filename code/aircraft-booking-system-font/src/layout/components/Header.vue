<template>
  <div
    class="header flex justify-between align-center"
    :style="{ height: height + 'px' }">
    <div class="flex align-center">
      <div class="m-r-120 flex align-center">
        <svg-icon
          name="logo"
          width="40px"
          height="40px" />
        <span class="m-l-10 logo">航班出行订票系统</span>
      </div>
    </div>
    <div class="flex align-center">
      <el-dropdown trigger="click">
        <div class="flex align-center">
          <el-avatar :src="currentAvatarUrl" @error="handleAvatarError" />
          <span class="m-l-10 name">{{ userName }}</span>
        </div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="onGoCenter">个人中心</el-dropdown-item>
            <el-dropdown-item @click="onLoginOut">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
  import { ElMessageBox } from 'element-plus';
  import { useUserStore } from '@/stores/user';
  import router from '@/router';
  import { session } from '@/api/login';

  const url = import.meta.env.VITE_APP_BASE_IP;

  const { LOGOUT, userInfo } = useUserStore();

  defineProps({
    height: {
      type: Number,
      default: 65,
    },
  });

  const user = ref({});
  const userName = computed(() => userInfo?.username || '欢迎您~请先登录');
  
  const defaultAvatarUrl = 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png';
  const currentAvatarUrl = ref('');

  const avatarUrl = computed(() => {
    return user.value.yonghuPhoto
      ? url + '/aircraft-booking-api/' + user.value.yonghuPhoto
      : defaultAvatarUrl;
  });
  
  const handleAvatarError = () => {
    // 当头像加载失败时，直接设置为默认头像
    currentAvatarUrl.value = defaultAvatarUrl;
    return true;
  };

  async function initData() {
    const { data } = await session();
    user.value = data;
    // 初始化头像URL
    currentAvatarUrl.value = avatarUrl.value;
  }

  const onGoCenter = () => {
    router.push({ path: '/center' });
  };

  const onLoginOut = () => {
    ElMessageBox.confirm('确定退出登录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
      draggable: true,
    }).then(() => {
      LOGOUT();
    });
  };

  onMounted(() => {
    nextTick(() => {
      initData();
    });
  });
</script>

<style lang="scss" scoped>
  .header {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 999;
    width: 100%;
    padding: 10px 4vw;
    background-color: #4169e1;
    color: #fff;
    font-size: 24px;

    .logo {
      cursor: pointer;
      color: #fff;
      font-size: 22px;
      font-weight: 600;
      font-family: 'Times New Roman', Times, serif;
    }

    .name {
      color: #fff;
      font-size: 16px;
    }
  }
</style>
