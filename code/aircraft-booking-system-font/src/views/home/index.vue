<template>
  <div class="home">
    <div class="flex align-center justify-between m-b-20">
      <div class="swiper">
        <el-carousel
          :height="`${height}px`"
          autoplay>
          <el-carousel-item>
            <img src="@/assets/images/swiper/1.png" />
          </el-carousel-item>
          <el-carousel-item>
            <img src="@/assets/images/swiper/2.png" />
          </el-carousel-item>
        </el-carousel>
        <div class="news">
          <div
            class="notice"
            :style="{ height: `${height}px` }">
            <div class="notice-header flex align-center justify-between">
              <div class="flex align-center notice-title">
                <SvgIcon
                  name="air"
                  width="28px"
                  height="28px" />
                <span class="m-l-10">民航新闻资讯</span>
              </div>
            </div>
            <el-scrollbar>
              <div
                class="ellipsis item"
                v-for="item in homeState.noticeData"
                :key="item.id"
                @click="onGetNoticeDel(item.id)">
                {{ item.newsName }}
              </div>
            </el-scrollbar>
          </div>
        </div>
      </div>
    </div>

    <div class="titles flex align-center justify-center">
      <div>航班最新动态</div>
    </div>

    <air :list="homeState.recruitData" />
  </div>
</template>

<script setup>
  import air from './components/air.vue';
  import { getFlightInformation, getNewsList } from '@/api/home';
  import router from '@/router';

  const height = 580;

  const homeState = reactive({
    noticeData: [],
    recruitData: [],
  });

  async function initData() {
    const { data: newsData } = await getNewsList({
      page: 1,
      limit: 9999,
      newsTypes: '',
      order: 'desc',
      t: new Date().getTime(),
    });
    homeState.noticeData = newsData.list;

    const { data: flightData } = await getFlightInformation({
      page: 1,
      limit: 10,
      shangxiaTypes: 1,
      jipiaoDelete: 1,
      jipiaoTypes: '',
      order: 'desc',
      t: new Date().getTime(),
    });
    console.log(flightData, 999999);
    homeState.recruitData = flightData.list;
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
  .home {
    .swiper {
      position: relative;
      width: 100%;

      .carousel-item {
        color: #475669;
        opacity: 0.75;
        margin: 0;
        text-align: center;
      }

      .el-carousel__item img {
        color: #475669;
        display: flex;
        align-items: center;
        margin: 0;
        text-align: center;
        height: 100%;
        width: 100%;
        object-fit: cover;
      }

      .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
      }

      .el-carousel__item:nth-child(2n + 1) {
        background-color: #d3dce6;
      }

      .news {
        position: absolute;
        bottom: 0;
        left: 0;
        min-width: 400px;
        width: 26%;
        height: 100%;
        background-color: rgba(255, 255, 255, 0.92);
        box-shadow: 4px 0 2px 0 rgba(0, 0, 0, 0.1);

        .notice {
          width: 100%;
          overflow: hidden;
          padding: 20px 15px 15px 4vw;

          .notice-header {
            padding-bottom: 10px;
            margin-bottom: 20px;
            border-bottom: 1px solid #e6e9f0;

            .notice-title {
              font-size: 17px;
              font-weight: 600;
              color: #4169e1;

              & > img {
                width: 25px;
                height: 25px;
              }

              & > span {
                font-family: 'Courier New', Courier, monospace;
              }
            }

            .more {
              font-size: 11px;
              color: #27292d;
              cursor: pointer;

              & :hover {
                opacity: 0.75;
              }
            }
          }

          .item {
            width: 100%;
            padding-top: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #6f86cc;
            cursor: pointer;

            &:last-child {
              border-bottom: none;
              margin-bottom: 40px;
            }

            &:first-child {
              padding-top: 0;
            }

            &:hover {
              color: #111d34;
              opacity: 0.75;
            }
          }

          .notice-content {
            width: 100%;
            padding: 20px 0;
          }
        }
      }
    }

    .titles {
      position: relative;
      z-index: 1;
      font-size: 32px;
      font-weight: 800;
      text-align: center;
      margin: 25px 0 20px;
      color: #4169e1;
      font-family: 'Times New Roman', Times, serif;

      &:after {
        content: 'Latest updates on flights';
        position: absolute;
        top: 90%;
        left: 50%;
        z-index: -1;
        opacity: 0.3;
        font-size: 26px;
        text-transform: uppercase;
        transform: translate(-50%, -20%);
      }
    }

    .position {
      width: 100%;
      justify-content: space-between;

      .card {
        width: 32.5%;
        border-radius: 8px;
        padding: 20px;
        color: #111d34;
        background-color: #fff;
        margin-bottom: 20px;

        .title {
          font-size: 26px;
          font-weight: 500;
        }

        .money {
          font-size: 20px;
          color: #fe574a;
          font-weight: 500;
        }

        .del {
          color: #848484;
        }

        .footer {
          img {
            width: 22px;
            height: 22px;
            margin-right: 5px;
          }
        }

        &:hover {
          cursor: pointer;
          box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
        }

        &:active {
          box-shadow: 0 0 0 0 rgba(0, 0, 0, 0.1);
        }
      }
    }
  }
</style>
