<template>
  <div class="p-20 news">
    <template v-if="newsTypes.length">
      <div class="flex align-center justify-between">
        <div class="new_item">
          <div class="new_item_title flex align-center justify-between">
            <h3>{{ newsTypes[0].indexName }}</h3>
          </div>
          <div class="new_item_content">
            <el-scrollbar height="360px">
              <template v-if="onFilterArr(newsTypes[0].codeIndex).length">
                <div
                  v-for="(item, index) in onFilterArr(newsTypes[0].codeIndex)"
                  :key="index"
                  class="item flex align-center justify-between"
                  @click="onGetNoticeDel(item.id)">
                  <img :src="`${url}/aircraft-booking-api/${item.newsPhoto}`" />
                  <div class="left flex flex-column justify-between">
                    <div class="title">{{ item.newsName }}</div>
                    <div class="flex align-center time">
                      <el-icon><Clock /></el-icon>
                      <span class="m-l-5">时间：</span>
                      <span>{{ item.createTime }}</span>
                    </div>
                  </div>
                </div>
              </template>
              <el-empty v-else description="暂无数据" />
            </el-scrollbar>
          </div>
        </div>
        <div class="new_right">
          <div class="new_item_title flex align-center justify-between">
            <h3>{{ newsTypes[1].indexName }}</h3>
          </div>
          <div class="new_item_content">
            <el-scrollbar height="360px">
              <template v-if="onFilterArr(newsTypes[1].codeIndex).length">
                <div
                  v-for="(item, index) in onFilterArr(newsTypes[1].codeIndex)"
                  :key="index"
                  @click="onGetNoticeDel(item.id)"
                  class="item flex align-center justify-between ellipsis">
                  {{ item.newsName }}
                </div>
              </template>
              <el-empty v-else description="暂无数据" />
            </el-scrollbar>
          </div>
        </div>
      </div>
      <div 
        v-for="(newsType, typeIndex) in newsTypes.slice(2)" 
        :key="'news-type-' + typeIndex"
        class="footer_news">
        <div class="title flex align-center justify-between">
          <h3>{{ newsType.indexName }}</h3>
        </div>
        <el-scrollbar>
          <div class="flex">
            <template v-if="onFilterArr(newsType.codeIndex).length">
              <div
                class="item"
                v-for="(item, index) in onFilterArr(newsType.codeIndex)"
                :key="index"
                @click="onGetNoticeDel(item.id)">
                <img :src="`${url}/aircraft-booking-api/${item.newsPhoto}`" />
                <div class="content">{{ item.newsName }}</div>
              </div>
            </template>
            <el-empty v-else description="暂无数据" class="empty-container" />
          </div>
        </el-scrollbar>
      </div>
    </template>
  </div>
</template>

<script setup>
  import { getDictionaryNewsPage, getNewsList } from '@/api/home';
  import router from '@/router';
  import { ref } from 'vue';
  import { Clock } from '@element-plus/icons-vue';

  const url = import.meta.env.VITE_APP_BASE_IP;
  const newsTypes = ref([]);
  const newsList = ref([]);

  async function initData() {
    const { data } = await getDictionaryNewsPage({
      page: 1,
      limit: 9999,
      sort: '',
      order: '',
      dicCode: 'news_types',
      t: new Date().getTime(),
    });
    // Sort by codeIndex in descending order (highest first)
    newsTypes.value = data.list.sort((a, b) => b.codeIndex - a.codeIndex);

    const { data: newData } = await getNewsList({
      page: 1,
      limit: 9999,
      sort: '',
      order: '',
      t: new Date().getTime(),
    });
    newsList.value = newData.list;
  }

  function onFilterArr(codeIndex) {
    // Filter news items based on the newsTypes value matching the codeIndex
    return newsList.value.filter((item) => Number(item.newsTypes) === Number(codeIndex));
  }

  function onGetNoticeDel(id) {
    router.push({
      name: 'Notice',
      query: {
        id,
      },
    });
  }

  initData();
</script>

<style lang="scss" scoped>
  .news {
    padding: 20px 4vw;
    background-color: #f5f5f5;

    .new_right {
      width: 69%;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 6px;

      .new_item_title {
        padding: 0 0 20px;
        border-bottom: 1px solid #eee;
      }

      .new_item_content {
        padding: 20px 0;

        .item {
          width: 100%;
          padding-bottom: 15px;
          margin-bottom: 15px;
          cursor: pointer;
          border-bottom: 1px dashed #4169e1;

          &:hover {
            opacity: 0.8;
          }

          img {
            width: 45%;
            height: 100%;
          }

          .left {
            width: 55%;
            height: 100%;
            margin-left: 10px;

            .title {
              color: #333;
              letter-spacing: 0.2em;
              line-height: 24px;
            }

            .time {
              color: #666;
              font-size: 12px;
            }
          }
        }
      }
    }

    .new_item {
      width: 30%;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 6px;

      .new_item_title {
        padding: 0 0 20px;
        border-bottom: 1px solid #eee;
      }

      .new_item_content {
        padding: 20px 0;

        .item {
          width: 100%;
          height: 120px;
          padding-bottom: 10px;
          margin-bottom: 30px;
          cursor: pointer;

          &:hover {
            opacity: 0.8;
          }

          img {
            width: 45%;
            height: 100%;
          }

          .left {
            width: 55%;
            height: 100%;
            margin-left: 10px;

            .title {
              color: #333;
              letter-spacing: 0.2em;
              line-height: 24px;
            }

            .time {
              color: #666;
              font-size: 12px;
            }
          }
        }
      }
    }

    .footer_news {
      width: 100%;
      margin-top: 20px;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 6px;

      .title {
        padding: 0 0 20px;
        border-bottom: 1px solid #eee;
      }

      .item {
        width: fit-content;
        background-color: #fff;
        margin-right: 20px;
        margin-top: 20px;

        &:hover {
          opacity: 0.8;
        }

        img {
          width: 220px;
          height: 150px;
        }

        .content {
          width: 220px;
          padding: 20px 10px;
          height: 120px;
          font-size: 14px;
          line-height: 24px;
          color: #333;
          font-weight: 500;
          letter-spacing: 0.2em;
        }
      }

      .empty-container {
        width: 100%;
        margin-top: 20px;
      }
    }
  }
</style>
