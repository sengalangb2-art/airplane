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
      <el-alert
          v-if="changeOrderId"
          title="您当前处于改签模式"
          type="warning"
          description="请选择新的座位并点击订票，系统将自动计算差价并从余额中多退少补。"
          show-icon
          close-text="取消改签"
          @close="cancelChangeMode"
          class="m-b-20"
      />

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
            <span>到达时间：</span>
            <span>{{ positions.jipiaoArrivalTime }}</span>
          </div>
          <div class="row">
            <span>机型：</span>
            <span>{{ positions.jipiaoValue }}</span>
          </div>

          <div class="row">
            <span>经济舱售价：</span>
            <span style="color: #fe574a; font-weight: bold;">{{ positions.jipiaoNewMoney }} 元</span>
          </div>
          <div class="row" v-if="positions.jipiaoFirstMoney">
            <span>头等舱售价：</span>
            <span style="color: #e6a23c; font-weight: bold;">{{ positions.jipiaoFirstMoney }} 元</span>
            <el-tag type="warning" size="small" class="m-l-10">前 {{ positions.jipiaoFirstNum }} 座</el-tag>
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
            >{{ changeOrderId ? '确认改签' : '立即订票' }}</el-button
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
        <span class="m-l-20" style="font-size: 12px; color: #666;">
          <span style="color: #e6a23c;">●</span> 头等舱
          <span class="m-l-10" style="color: #333;">●</span> 经济舱
        </span>
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
              height="30px"
              :style="item <= (positions.jipiaoFirstNum || 0) ? 'color: #e6a23c;' : ''" />

          <div
              class="m-t-5"
              :class="{
              active: selectSeat.includes(item),
              'is-first-class': item <= (positions.jipiaoFirstNum || 0) && !selectSeat.includes(item)
            }">
            {{ item }}号
          </div>
        </div>
      </div>
    </div>

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

    <el-dialog
        v-model="paymentChoiceVisible"
        title="请选择支付方式"
        width="400px"
        center>

      <div class="flex flex-column align-center">
        <el-radio-group v-model="payType" class="flex flex-column" style="align-items: flex-start;">
          <el-radio label="balance" size="large" border style="margin-bottom: 15px; width: 200px;">
            余额支付 (直接扣款)
          </el-radio>
          <el-radio label="alipay" size="large" border style="margin-left: 0; width: 200px;">
            支付宝支付
          </el-radio>
        </el-radio-group>
      </div>

      <template #footer>
        <span class="dialog-footer">
          <el-button @click="paymentChoiceVisible = false">暂不支付</el-button>
          <el-button type="primary" @click="confirmPayment">
            确认支付
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ElMessageBox, ElMessage, ElIcon, ElLoading } from 'element-plus';
import { Loading } from '@element-plus/icons-vue';
import { deleteAirCollection, changeTicket } from '@/api/center'; // 引入 changeTicket
import {
  getAirDetail,
  getCollection,
  postCollection,
  postAirOrder,
  alipayOrder,
  getOrderPayStatus,
  updateOrderPayStatus,
  simulatePayOrder
} from '@/api/position';
import { useRoute, useRouter } from 'vue-router';
import { useUserStore } from '@/stores/user';
import dayjs from 'dayjs';

const url = import.meta.env.VITE_APP_BASE_IP;

const route = useRoute();
const router = useRouter();
const userStore = useUserStore();

// 新增：改签状态
const changeOrderId = ref(sessionStorage.getItem('changeOrderId'));

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
const paymentChoiceVisible = ref(false);
const payType = ref('balance');
const createdOrderId = ref(null);
const payDialogVisible = ref(false);
const payContent = ref('');
const currentOrderId = ref(null);
const payStatusTimer = ref(null);

const form = reactive({
  resume: '',
});

async function initData() {
  const { data } = await getAirDetail(route.query.id);
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

// 新增：取消改签模式
function cancelChangeMode() {
  sessionStorage.removeItem('changeOrderId');
  changeOrderId.value = null;
  ElMessage.info('已退出改签模式');
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

async function confirmPayment() {
  paymentChoiceVisible.value = false;
  if (!createdOrderId.value) return;

  if (payType.value === 'balance') {
    try {
      await simulatePayOrder(createdOrderId.value);
      ElMessage.success('余额支付成功！');
      setTimeout(() => {
        router.replace({ path: '/' });
      }, 1500);
    } catch (error) {
      ElMessage.error(error.msg || '余额支付失败，请尝试其他方式');
    }

  } else if (payType.value === 'alipay') {
    startAlipay(createdOrderId.value);
  }
}

function closePayDialog() {
  payDialogVisible.value = false;
  payContent.value = '';
  if (payStatusTimer.value) {
    clearInterval(payStatusTimer.value);
    payStatusTimer.value = null;
  }
}

async function checkPayStatus() {
  if (!currentOrderId.value) return;
  try {
    const { data } = await getOrderPayStatus(currentOrderId.value);
    if (data && data.isPay === '已支付') {
      if (payStatusTimer.value) {
        clearInterval(payStatusTimer.value);
        payStatusTimer.value = null;
      }
      payDialogVisible.value = false;
      ElMessage.success('支付成功，订单已完成');
      router.replace({ path: '/' });
    }
  } catch (error) {
    console.error('检查支付状态出错:', error);
  }
}

async function startAlipay(orderId) {
  try {
    payContent.value = '';
    payDialogVisible.value = true;
    currentOrderId.value = orderId;

    const { data } = await alipayOrder(orderId);
    if (data) {
      payContent.value = data;
      await nextTick();
      const alipayForm = document.forms['alipaysubmit'];
      if (alipayForm) {
        alipayForm.submit();
      } else {
        const container = document.querySelector('.pay-iframe-container');
        const fallbackForm = container?.querySelector('form');
        if (fallbackForm) fallbackForm.submit();
      }
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

const calculateTotalPrice = () => {
  let total = 0;
  const firstNum = positions.value.jipiaoFirstNum || 0;
  const firstPrice = positions.value.jipiaoFirstMoney || positions.value.jipiaoNewMoney;
  const ecoPrice = positions.value.jipiaoNewMoney;

  selectSeat.value.forEach(seat => {
    if(seat <= firstNum) total += firstPrice;
    else total += ecoPrice;
  });
  return total.toFixed(2);
}

// 修改：预订/改签逻辑
function onAddOrder() {
  if (selectSeat.value.length === 0) {
    ElMessage.error('请选择座位');
    return;
  }

  const totalMoney = calculateTotalPrice();

  // 1. 改签逻辑分支
  if (changeOrderId.value) {
    ElMessageBox.confirm(
        `您当前正在改签，选择了 ${selectSeat.value.length} 个座位，新航班票价总计 ${totalMoney} 元。\n系统将自动计算与原订单的差价并进行多退少补（直接操作余额），是否确认？`,
        '改签确认',
        {
          confirmButtonText: '确认改签',
          cancelButtonText: '取消',
          type: 'warning',
        }
    ).then(async () => {
      try {
        const res = await changeTicket({
          id: changeOrderId.value, // 原订单ID
          newJipiaoId: positions.value.id, // 新航班ID
          newBuyZuoweiNumber: selectSeat.value.join(','), // 新座位
          newBuyZuoweiTime: dayjs().format('YYYY-MM-DD') // 预订日期
        });

        // 成功处理
        ElMessage.success('改签成功！');
        sessionStorage.removeItem('changeOrderId'); // 清除改签状态
        router.push('/center'); // 返回个人中心

      } catch (error) {
        console.error('改签失败:', error);
        // 错误提示由 request拦截器 或 catch 块处理
        // ElMessage.error(error.msg || '改签失败');
      }
    }).catch(() => {
      // 取消操作
    });
    return; // 结束函数，不执行后续的普通购票逻辑
  }

  // 2. 原有的普通购票逻辑
  ElMessageBox.confirm(
      `您选择了 ${selectSeat.value.length} 个座位，总价为 ${totalMoney} 元，是否确定订购该航班吗？`,
      '订票确认',
      {
        confirmButtonText: '确定下单',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    try {
      const res = await postAirOrder({
        jipiaoPhoto: '',
        jipiaoOrderUuidNumber: new Date().getTime(),
        jipiaoId: positions.value.id,
        yonghuId: userStore.userInfo.userId,
        buyZuoweiNumber: selectSeat.value.join(','),
        buyZuoweiTime: dayjs().format('YYYY-MM-DD'),
        jipiaoOrderTruePrice: totalMoney,
        t: new Date().getTime(),
      });

      if (res && res.id) {
        createdOrderId.value = res.id;
        ElMessage.success('订单创建成功，请选择支付方式');
        paymentChoiceVisible.value = true;
      }
    } catch (error) {
      console.error('创建订单失败:', error);
      ElMessage.error('创建订单失败: ' + (error.msg || error.message));
    }
  });
}

function onCancel() {
  dialogFormVisible.value = false;
}
function onConfirm() {
  dialogFormVisible.value = false;
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

  .is-first-class {
    color: #e6a23c;
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