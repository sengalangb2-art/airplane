<template>
  <div class="title flex align-center justify-between m-b-20">
    <div class="flex align-center">
      <el-icon><Memo /></el-icon>
      <span class="m-l-10">机票预定</span>
    </div>
  </div>
  <div class="flex">
    <el-tabs
      tab-position="left"
      v-model="activeName"
      style="height: 200px"
      @tab-change="initGetAirOrder">
      <el-tab-pane
        v-for="item in tabs"
        :key="item.id"
        :label="item.indexName"
        :name="item.codeIndex"></el-tab-pane>
    </el-tabs>
    <div class="content">
      <div class="top flex align-center">
        <div>订单详情</div>
        <div>金额</div>
        <div>状态</div>
        <div>操作</div>
      </div>
      <div class="form">
        <template v-if="tableData.length">
          <div
            class="item"
            v-for="(item, index) in tableData"
            :key="index">
            <div class="header flex align-center">
              <div>订单号: {{ item.jipiaoOrderUuidNumber }}</div>
              <div class="m-l-10">订票时间: {{ item.createTime }}</div>
            </div>
            <div class="body flex align-center">
              <div class="flex align-center">
                <img :src="formatImg(item.jipiaoPhoto)" />
                <div>
                  <div class="m-b-5">航班名称：{{ item.jipiaoName }}</div>
                  <div class="m-b-5">
                    出发地-目的地：{{ item.jipiaoChufadi }} - {{ item.jipiaoMudidi }}
                  </div>
                  <div class="m-b-5">登机时间：{{ item.jipiaoTime }}</div>
                  <div class="m-b-5">座位号：{{ item.buyZuoweiNumber }}</div>
                </div>
              </div>
              <div>{{ item.jipiaoOrderTruePrice }} 元</div>
              <div>
                <el-tag
                  :type="
                    item.jipiaoOrderTypes == 101
                      ? 'primary'
                      : item.jipiaoOrderTypes == 102
                      ? 'danger'
                      : item.jipiaoOrderTypes == 103
                      ? 'warning'
                      : 'success'
                  "
                  >{{ item.jipiaoOrderValue }}</el-tag
                >
              </div>
              <div>
                <el-button
                  type="danger"
                  v-if="activeName == '101'"
                  plain
                  @click="onCancelTicket(item)"
                  >退票</el-button
                >
                <el-button
                  type="primary"
                  v-if="activeName == '103'"
                  plain
                  @click="onGetTicket(item)"
                  >取票</el-button
                >
              </div>
            </div>
          </div>
        </template>
        <Empty v-else />
      </div>
    </div>
  </div>
</template>

<script setup>
  import {
    getAirOrderType,
    getAirOrder,
    getAirOrderReceiving,
    getAirOrderRefund,
  } from '@/api/center';
  import { messageBox } from '@/utils/tools';
  import { ElMessage } from 'element-plus';

  const activeName = ref(null);
  const tabs = ref([]);
  const tableData = ref([]);

  const formatImg = computed(() => {
    return function (url) {
      return import.meta.env.VITE_APP_BASE_IP + '/aircraft-booking-api/' + url;
    };
  });

  const initData = async () => {
    const { data } = await getAirOrderType({
      page: 1,
      limit: 9999,
      sort: '',
      order: '',
      dicCode: 'jipiao_order_types',
      t: new Date().getTime(),
    });
    tabs.value = data.list.reverse();
    if (tabs.value.length) {
      activeName.value = tabs.value[0].codeIndex;
    }
    initGetAirOrder();
  };

  async function initGetAirOrder() {
    const { data } = await getAirOrder({
      page: 1,
      limit: 9999,
      sort: 'id',
      order: 'desc',
      jipiaoOrderUuidNumber: '',
      jipiaoOrderTypes: activeName.value,
      buyZuoweiNumber: '',
      t: new Date().getTime(),
    });
    tableData.value = data.list;
  }

  async function onGetTicket(item) {
    const res = await messageBox({
      title: '提示',
      type: 'warning',
      'show-close': false,
      closeOnClickModal: false,
      showCancelButton: true,
      confirmButtonText: '是',
      cancelButtonText: '否',
      message: `确定要取票航班：${item.jipiaoName}，订单号为：${item.jipiaoOrderUuidNumber}，乘车人姓名：${item.yonghuName}的机票吗？`,
    });
    if (!res) return;
    await getAirOrderReceiving({
      id: item.id,
      t: new Date().getTime(),
    });
    ElMessage.success('取票成功');
    initData();
  }

  async function onCancelTicket(item) {
    const res = await messageBox({
      title: '提示',
      type: 'warning',
      'show-close': false,
      closeOnClickModal: false,
      showCancelButton: true,
      confirmButtonText: '是',
      cancelButtonText: '否',
      message: `确定要退掉航班：${item.jipiaoName}，订单号为：${item.jipiaoOrderUuidNumber}，乘车人姓名：${item.yonghuName}的机票吗？`,
    });
    if (!res) return;
    await getAirOrderRefund({
      id: item.id,
      t: new Date().getTime(),
    });
    ElMessage.success('退票成功');
    initData();
  }

  onActivated(() => {
    initData();
  });
</script>

<style scoped lang="scss">
  .title {
    font-size: 18px;
    font-weight: 500;
    color: #4169e1;
    padding-bottom: 12px;
    border-bottom: 1px solid #eee;
  }

  .content {
    flex: 1;

    .top {
      width: 100%;
      background-color: #f5f5f5;
      padding: 10px 20px;
      border-radius: 5px;
      margin-bottom: 15px;

      & > div {
        flex: 1;

        &:first-child {
          flex: 4;
        }
      }
    }

    .form {
      width: 100%;

      .item {
        width: 100%;
        border-bottom: 1px solid #eee;
        margin-bottom: 15px;

        .header {
          color: #111d34;
          font-size: 12px;
          font-weight: 500;
          background-color: #f5f5f5;
          padding: 15px 20px;
          border-radius: 5px;
        }

        .body {
          padding: 10px 20px;
          background-color: #fff;

          & > div {
            flex: 1;

            &:first-child {
              flex: 4;

              img {
                width: 85x;
                height: 75px;
                border-radius: 5px;
              }

              & > div {
                margin-left: 10px;
                height: 100%;
                color: #111d34;
                font-size: 14px;
                font-weight: 500;
              }
            }
          }
        }
      }
    }
  }
</style>
