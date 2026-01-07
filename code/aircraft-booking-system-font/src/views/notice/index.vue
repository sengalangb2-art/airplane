<template>
  <div>
    <div class="left-container m-r-20 flex flex-column justify-between">
      <div>
        <head class="flex align-center justify-between">
          <div class="titile flex align-center">
            <el-icon><Promotion /></el-icon>
            <span class="m-l-10">{{ positions.newsName }}</span>
          </div>
          <el-button
            type="warning"
            plain
            @click="$router.go(-1)"
            >返回上一页</el-button
          >
        </head>
        <div class="content">
          <div class="title">{{ positions.newsName }}</div>
          <div class="flex align-center justify-center time">
            <div class="flex align-center">
              <span>时间：</span>
              <span>{{ positions.createTime }}</span>
            </div>
            <div class="m-l-10">|</div>
            <div class="flex align-center">
              <span>类型：</span>
              <span>{{ positions.newsValue }}</span>
            </div>
          </div>
          <img :src="`${url}/aircraft-booking-api/${positions.newsPhoto}`" />
          <div class="detail" v-html="positions.newsContent"></div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
  import { getNewsDetailById } from '@/api/home';
  import { useRoute } from 'vue-router';

  const url = import.meta.env.VITE_APP_BASE_IP;

  const route = useRoute();

  const positions = ref({
    id: 12,
    newsName: '新闻标题12',
    newsTypes: 2,
    newsPhoto: 'upload/news12.jpg',
    insertTime: '2023-04-03 14:38:39',
    newsContent: '新闻详情12',
    createTime: '2023-04-03 14:38:39',
    newsValue: '新闻类型2',
  });

  async function initData() {
    const { data } = await getNewsDetailById(route.query.id);
    positions.value = data;
  }

  initData();
</script>

<style lang="scss" scoped>
  .left-container {
    flex: 1;
    height: calc(100vh - 105px);
    background-color: #ffffff;
    border-radius: 6px;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.05);

    head {
      padding: 25px 20px 20px;
      border-bottom: 1px solid #e6e6e6;
    }

    .titile {
      color: #111d34;
      font-size: 20px;
      font-weight: 500;
    }

    .content {
      padding: 20px;
      font-size: 14px;
      text-align: center;
      line-height: 2;
      color: #333;
      font-weight: 500;
      text-indent: 2em;

      .title {
        font-size: 32px;
      }

      .time {
        font-size: 16px;
        color: #666;
      }

      .detail {
        margin-top: 20px;
        color: #111d34;
        font-size: 20px;
        font-weight: 500;
      }

      img {
        width: 45%;
        border-radius: 6px;
        box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.05);
        height: auto;
        margin-top: 20px;
      }
    }
  }
</style>
