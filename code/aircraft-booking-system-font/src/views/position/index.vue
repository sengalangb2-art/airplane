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
        v-model="payDialogVisible"
        title="支付宝支付"
        width="800px"
        :before-close="closePayDialog">
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
import { deleteAirCollection } from '@/api/center';
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
const paymentChoiceVisible = ref(false); // 控制选择支付方式弹窗的显示
const payType = ref('balance'); // 默认选择余额支付 'balance' 或 'alipay'
const createdOrderId = ref(null); // 存储当前创建的订单ID
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
// 4. 新增：确认支付方式并执行支付
async function confirmPayment() {
  // 关闭选择弹窗
  paymentChoiceVisible.value = false;

  if (!createdOrderId.value) return;

  if (payType.value === 'balance') {
    // --- 分支 A：余额支付 ---
    try {
      await simulatePayOrder(createdOrderId.value);
      ElMessage.success('余额支付成功！');
      // 支付成功后跳转回首页
      setTimeout(() => {
        router.replace({ path: '/' });
      }, 1500);
    } catch (error) {
      // 如果余额不足或失败
      ElMessage.error(error.msg || '余额支付失败，请尝试其他方式');
      // 失败后可以重新打开选择框，或者让用户去订单中心支付
    }

  } else if (payType.value === 'alipay') {
    // --- 分支 B：支付宝支付 ---
    // 调用原有的 startAlipay 逻辑
    startAlipay(createdOrderId.value);
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

async function startAlipay(orderId) {
  try {
    payContent.value = '';
    payDialogVisible.value = true;
    currentOrderId.value = orderId;

    const { data } = await alipayOrder(orderId);
    if (data) {
      payContent.value = data;

      // 等待 DOM 更新（也就是等待 v-html 把表单渲染出来）
      await nextTick();

      // 找到支付宝返回的表单（支付宝默认表单 name 为 alipaysubmit）
      const alipayForm = document.forms['alipaysubmit'];
      if (alipayForm) {
        // 手动提交表单，这会让浏览器跳转到支付宝页面
        alipayForm.submit();
      } else {
        // 如果找不到 name，尝试在容器里找第一个 form
        const container = document.querySelector('.pay-iframe-container');
        const fallbackForm = container?.querySelector('form');
        if (fallbackForm) fallbackForm.submit();
      }
      // ------------------ 修改结束 ------------------

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

// 新增函数：计算选中座位的总价
const calculateTotalPrice = () => {
  let total = 0;
  const firstNum = positions.value.jipiaoFirstNum || 0;
  // 如果没有设置头等舱价格，则默认使用经济舱价格
  const firstPrice = positions.value.jipiaoFirstMoney || positions.value.jipiaoNewMoney;
  const ecoPrice = positions.value.jipiaoNewMoney;

  selectSeat.value.forEach(seat => {
    if(seat <= firstNum) total += firstPrice;
    else total += ecoPrice;
  });
  return total.toFixed(2); // 保留两位小数
}

function onAddOrder() {
  if (selectSeat.value.includes(undefined)) {
    // 简单的防错检查
  }
  if (selectSeat.value.length === 0) {
    ElMessage.error('请选择座位');
    return;
  }

  const totalMoney = calculateTotalPrice();

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
      // 1. 请求后端创建订单
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

      // 2. 订单创建成功，保存订单ID
      if (res && res.id) {
        createdOrderId.value = res.id;
        ElMessage.success('订单创建成功，请选择支付方式');

        // 3. 打开支付方式选择弹窗
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

  // 新增样式：头等舱文字高亮
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