<template>
  <div>
    <div class="left-container m-r-20 flex flex-column justify-between">
      <div class="head flex align-center justify-between">
        <el-button
          type="primary"
          plain
          @click="$router.go(-1)"
          >返回上一页</el-button
        >
        <div class="titile flex align-center">
          <div class="flex align-center m-r-20">
            <svg-icon name="airs" />
            <span class="m-l-10">{{ positions.jipiaoName }}</span>
          </div>
          <el-tooltip
            effect="dark"
            :content="content"
            placement="bottom">
            <svg-icon
              :name="collection.length > 0 ? 'sca' : 'sc'"
              width="35px"
              height="35px"
              @click="onCollection" />
          </el-tooltip>
        </div>
      </div>
    </div>
    <div class="wrapper">
      <div class="top flex justify-between align-center">
        <img :src="`${url}/aircraft-booking-api/${positions.jipiaoPhoto}`" />
        <div class="flex flex-column justify-between">
          <div class="flex align-center justify-between">
            <div class="row">
              <span>航班名称：</span>
              <span>{{ positions.jipiaoName }}</span>
            </div>
            <div class="flex align-center">
              <span>航班状态：</span>
              <el-tag
                :type="positions.hangbanTypes == '1' ? 'success' : 'danger'"
                size="large"
                >{{ positions.hangbanValue }}</el-tag
              >
              <!-- <span>{{ positions.hangbanValue }}</span> -->
            </div>
          </div>
          <div class="row">
            <span>出发地：</span>
            <span>{{ positions.jipiaoChufadi }}</span>
          </div>
          <div class="row">
            <span>目的地：</span>
            <span>{{ positions.jipiaoMudidi }}</span>
          </div>
          <div class="row">
            <span>起飞时间：</span>
            <span>{{ positions.jipiaoTime }}</span>
          </div>
          <div class="row">
            <span>机型：</span>
            <span>{{ positions.jipiaoValue }}</span>
          </div>
          <div class="row">
            <span>售价：</span>
            <span>{{ positions.jipiaoNewMoney }} 元</span>
          </div>
          <div class="flex align-center justify-between">
            <div class="row">
              <span>座位总数：</span>
              <span>{{ positions.zuoweiNumber }} 个</span>
            </div>
            <el-button
              type="primary"
              plain
              :disabled="positions.hangbanTypes != '1'"
              @click="onAddOrder"
              >立即订票</el-button
            >
          </div>
        </div>
      </div>
      <div class="flex align-center m-t-20 m-b-20">
        <svg-icon
          name="titles"
          width="24px"
          height="24px" />
        <span class="m-l-10 subtitle">航班详情</span>
      </div>
      <div
        class="content"
        v-html="positions.jipiaoContent"></div>
      <div class="flex align-center m-t-20 m-b-20">
        <svg-icon
          name="titles"
          width="24px"
          height="24px" />
        <span class="m-l-10 subtitle">座位列表</span>
      </div>
      <div class="flex flex-wrap p-l-20 p-r-20">
        <div
          class="seat flex align-center justify-center flex-column"
          v-for="(item, index) in positions.zuoweiNumber"
          :key="index"
          @click="onselect(item)">
          <svg-icon
            :name="selectSeat.includes(item) ? 'seata' : 'seat'"
            width="30px"
            height="30px" />
          <div
            class="m-t-5"
            :class="{
              active: selectSeat.includes(item),
            }">
            {{ item }}号
          </div>
        </div>
      </div>
    </div>

    <el-dialog
      v-model="dialogFormVisible"
      title="baio"
      width="500">
      <el-form :model="form">
        <el-form-item label="简历">
          <el-select
            v-model="form.resume"
            placeholder="请选择简历">
            <el-option
              v-for="item in resumeList"
              :key="item.id"
              :label="item.name"
              :value="item.id"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="flex align-center justify-end">
          <el-button @click="onCancel">取消</el-button>
          <el-button
            type="primary"
            @click="onConfirm">
            确认
          </el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 支付宝支付弹窗 -->
    <el-dialog
      v-model="payDialogVisible"
      title="支付宝支付"
      width="800px"
      :before-close="closePayDialog">
      <div
        v-if="payContent"
        v-html="payContent"
        class="pay-iframe-container"></div>
      <div
        v-else
        class="pay-loading">
        <el-icon class="is-loading"><Loading /></el-icon>
        <span class="m-l-10">正在加载支付页面...</span>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
  import { ElMessageBox, ElMessage, ElIcon, ElLoading } from 'element-plus';
  import { Loading } from '@element-plus/icons-vue';
  import { deleteAirCollection } from '@/api/center';
  import {
    getAirDetail,
    getCollection,
    postCollection,
    postAirOrder,
    alipayOrder,
    getOrderPayStatus,
    updateOrderPayStatus,
  } from '@/api/position';
  import { useRoute, useRouter } from 'vue-router';
  import { useUserStore } from '@/stores/user';
  import dayjs from 'dayjs';

  const url = import.meta.env.VITE_APP_BASE_IP;

  const route = useRoute();
  const router = useRouter();
  const userStore = useUserStore();

  const selectSeat = ref([]);
  const collection = ref([]);
  const content = computed(() => {
    return collection.value.length > 0 ? '已收藏' : '添加收藏';
  });

  const status = ref(0);
  const dialogFormVisible = ref(false);
  const positions = ref({});
  const resumeList = ref([]);
  const appliedDatas = ref([]);

  // 支付相关状态
  const payDialogVisible = ref(false);
  const payContent = ref('');
  const currentOrderId = ref(null);
  const payStatusTimer = ref(null);

  const form = reactive({
    resume: '',
  });

  async function initData() {
    const { data } = await getAirDetail(route.query.id);
    console.log(data, 5555555);
    positions.value = data;
    initGetCollection();
  }

  async function initGetCollection() {
    const { data } = await getCollection({
      page: 1,
      limit: 999,
      jipiaoId: positions.value.id,
      yonghuId: userStore.userInfo.userId,
      t: new Date().getTime(),
    });
    collection.value = data.list;
  }

  function onselect(id) {
    if (selectSeat.value.includes(id)) {
      selectSeat.value = selectSeat.value.filter((item) => item !== id);
      return;
    }
    selectSeat.value.push(id);
  }

  async function onCollection() {
    if (collection.value.length > 0) {
      ElMessageBox.confirm('确定取消收藏该航班吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        draggable: true,
      }).then(async () => {
        await deleteAirCollection([positions.value.id]);
        ElMessage.success('取消收藏成功');
        initGetCollection();
      });
    } else {
      ElMessageBox.confirm('确定收藏该航班吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        draggable: true,
      }).then(async () => {
        await postCollection({
          yonghuId: userStore.userInfo.userId,
          jipiaoId: positions.value.id,
          jipiaoCollectionTypes: 1,
          t: new Date().getTime(),
        });
        ElMessage.success('收藏成功');
        initGetCollection();
      });
    }
  }

  // 关闭支付弹窗
  function closePayDialog() {
    payDialogVisible.value = false;
    payContent.value = '';
    if (payStatusTimer.value) {
      clearInterval(payStatusTimer.value);
      payStatusTimer.value = null;
    }
  }

  // 检查支付状态
  async function checkPayStatus() {
    if (!currentOrderId.value) return;

    try {
      const { data } = await getOrderPayStatus(currentOrderId.value);
      if (data && data.isPay === '已支付') {
        // 支付成功，清除定时器并关闭支付弹窗
        if (payStatusTimer.value) {
          clearInterval(payStatusTimer.value);
          payStatusTimer.value = null;
        }
        payDialogVisible.value = false;
        ElMessage.success('支付成功，订单已完成');
        router.replace({
          path: '/',
        });
      }
    } catch (error) {
      console.error('检查支付状态出错:', error);
    }
  }

  // 发起支付宝支付
  async function startAlipay(orderId) {
    try {
      payContent.value = '';
      payDialogVisible.value = true;
      currentOrderId.value = orderId;

      const { data } = await alipayOrder(orderId);
      if (data) {
        payContent.value = data;

        // 启动定时器每5秒检查一次支付状态
        payStatusTimer.value = setInterval(checkPayStatus, 5000);
      } else {
        ElMessage.error('获取支付信息失败');
        payDialogVisible.value = false;
      }
    } catch (error) {
      console.error('发起支付宝支付出错:', error);
      ElMessage.error('发起支付失败: ' + error.message);
      payDialogVisible.value = false;
    }
  }

  function onAddOrder() {
    if (selectSeat.value.length === 0) {
      ElMessage.error('请选择座位');
      return;
    }
    ElMessageBox.confirm(
      `总价为${
        positions.value.jipiaoNewMoney * selectSeat.value.length
      }元，是否确定订购该航班吗？`,
      '提示',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        draggable: true,
      }
    ).then(async () => {
      try {
        // 1. 创建订单
        const { data } = await postAirOrder({
          jipiaoPhoto: '',
          jipiaoOrderUuidNumber: new Date().getTime(),
          jipiaoId: positions.value.id,
          yonghuId: userStore.userInfo.userId,
          buyZuoweiNumber: selectSeat.value.join(','),
          buyZuoweiTime: dayjs().format('YYYY-MM-DD'),
          jipiaoOrderTruePrice:
            positions.value.jipiaoNewMoney * selectSeat.value.length,
          t: new Date().getTime(),
        });

        // 2. 获取创建的订单ID，显示加载中提示
        ElMessage.success('订单创建成功');
        
      } catch (error) {
        console.error('创建订单失败:', error);
        ElMessage.error('创建订单失败: ' + error.message);
      }
    });
  }

  initData();
</script>

<style lang="scss" scoped>
  .left-container {
    width: 100%;
    background-color: #ffffff;
    border-radius: 6px;
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.05);

    .head {
      padding: 25px 4vw 20px;
      border-bottom: 1px solid #e6e6e6;
    }

    .titile {
      color: #111d34;
      font-size: 22px;
      font-weight: 500;
    }

    .content {
      padding: 0 20px 20px;
      font-size: 14px;
      line-height: 1.8;
      color: #333;
      text-indent: 2em;
    }

    .footer {
      width: 100%;
      padding: 20px;
      color: #333;
      font-size: 13px;
      border-top: 1px solid #e6e6e6;

      .item {
        flex: 1;
        border-right: 1px solid #e6e6e6;
        padding: 0 20px;
        display: flex;
        align-items: center;

        &:last-child {
          border-right: none;
        }
      }
    }
  }

  .wrapper {
    width: 100%;
    padding: 20px 4vw;
    background-color: #ffffff;

    .top {
      width: 100%;
      height: 400px;

      img {
        width: 40%;
        height: 100%;
        border-radius: 6px;
        object-fit: cover;
      }

      & > div {
        width: 59%;
        padding: 15px 20px;
        height: 100%;
        background-color: #f7f7f7;

        .row {
          & > span {
            color: #333;
            font-size: 15px;
            font-weight: 500;
            margin-right: 10px;

            &:last-child {
              margin-right: 0;
              font-size: 18px;
            }
          }
        }
      }
    }

    .subtitle {
      color: #111d34;
      font-size: 16px;
      font-weight: 500;
    }

    .content {
      padding: 10px 0;
      font-size: 15px;
      line-height: 1.8;
      color: #333;
      text-indent: 2em;
      letter-spacing: 0.2em;
    }

    .seat {
      width: 50px;
      margin-right: 20px;
      margin-bottom: 30px;
      cursor: pointer;
    }

    .active {
      color: #4169e1;
      font-weight: 600;
    }
  }

  .pay-iframe-container {
    width: 100%;
    min-height: 400px;
  }

  .pay-loading {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100px;
    font-size: 16px;
  }
</style>
