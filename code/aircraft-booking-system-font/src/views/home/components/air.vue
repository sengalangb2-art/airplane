<template>
  <div class="flex flex-wrap air">
    <div
      class="flex align-center justify-between air-item"
      v-for="item in list"
      :key="item.id"
       @click="onGoDetail(item.id)"
      >
      <img :src="formatImg(item.jipiaoPhoto)" />
      <div class="left m-l-15 flex-column justify-between flex">
        <div class="m-b-15 flex align-center ellipsis">
          <span> 航班名称：</span>
          <span>{{ item.jipiaoName }}</span>
        </div>
        <div class="m-b-15 flex align-center">
          <span> 航班类型：</span>
          <span>{{ item.jipiaoValue }}</span>
        </div>
        <div class="m-b-15 flex align-center">
          <span> 航班出发地：</span>
          <span>{{ item.jipiaoChufadi }}</span>
        </div>
        <div class="m-b-15 flex align-center">
          <span> 航班目的地：</span>
          <span>{{ item.jipiaoMudidi }}</span>
        </div>
        <div class="flex align-center">
          <span> 航班时间：</span>
          <span>{{ item.jipiaoTime }}</span>
        </div>
      </div>
      <div class="tag">
        <el-tag :type="item.hangbanTypes == '1' ? 'success' : 'danger'">{{
          item.hangbanValue
        }}</el-tag>
      </div>
    </div>
  </div>
</template>

<script setup>
  import router from '@/router';

  defineProps({
    list: {
      type: Array,
      default: () => [],
    },
  });

  const formatImg = computed(() => {
    return function (url) {
      return import.meta.env.VITE_APP_BASE_IP + '/aircraft-booking-api/' + url;
    };
  }); 
  
  function onGoDetail(id) {
    router.push({ path: '/position', query: { id } });
  }
</script>

<style lang="scss" scoped>
  .air {
    padding: 20px 4vw;

    .air-item {
      position: relative;
      width: 32%;
      margin-right: 1%;
      margin-bottom: 20px;
      height: 180px;
      padding: 10px;
      background-color: #fff;
      border-radius: 10px;
      border: 1px solid #4169e1;

      img {
        width: 50%;
        height: 100%;
        border-radius: 6px;
      }

      .left {
        width: 50%;
        height: 100%;
        padding: 5px 0;
        color: #111d34;
        font-size: 14px;
      }

      .tag {
        position: absolute;
        top: 5px;
        right: 5px;
      }

      &:hover {
        cursor: pointer;
        box-shadow: 0px 2px 10px rgba($color: #4169e1, $alpha: 0.2);
      }
    }
  }
</style>
