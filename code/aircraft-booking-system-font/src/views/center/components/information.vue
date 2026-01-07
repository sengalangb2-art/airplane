<template>
  <div>
    <div class="title flex align-center p-20">
      <el-icon><User /></el-icon>
      <span class="m-l-10">个人资料</span>
    </div>
    <div class="content flex justify-between p-20">
      <el-form
        ref="formRef"
        :model="form"
        class="form"
        :rules="rules">
        <el-form-item
          label="账号:"
          prop="username">
          <el-input
            disabled
            v-model="form.username"
            placeholder="请输入账号"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>
        <el-form-item
          label="密码:"
          prop="password">
          <el-input
            type="password"
            show-password
            v-model="form.password"
            placeholder="请输入密码"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>
        <el-form-item
          label="用户名:"
          prop="yonghuName">
          <el-input
            v-model="form.yonghuName"
            placeholder="请输入用户名"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>
        <el-form-item
          label="性别:"
          prop="sexTypes">
          <el-select
            v-model="form.sexTypes"
            placeholder="请选择性别">
            <el-option
              :key="1"
              :label="'男'"
              :value="1"></el-option>
            <el-option
              :key="2"
              :label="'女'"
              :value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="身份证号:"
          prop="yonghuIdNumber">
          <el-input
            v-model="form.yonghuIdNumber"
            placeholder="请输入身份证号"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>
        <el-form-item
          label="手机号:"
          prop="yonghuPhone">
          <el-input
            v-model="form.yonghuPhone"
            placeholder="请输入手机号"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>
        <el-form-item
          label="余额:"
          prop="newMoney">
          <el-input
            type="number"
            disabled
            v-model="form.newMoney"
            placeholder="请输入余额"
            :style="{
              width: width,
            }"></el-input>
        </el-form-item>

        <el-form-item>
          <el-button
            type="primary"
            plain
            @click="onUpdate"
            >更新信息</el-button
          >
          <el-button
            type="success"
            plain
            @click="openRechargeDialog"
            >充值</el-button
          >
          <el-button
            type="danger"
            plain
            @click="onLoginOut"
            >退出登录</el-button
          >
        </el-form-item>
      </el-form>
      <div class="avatar">
        <el-avatar
          :size="90"
          :src="currentAvatarUrl"
          @error="handleAvatarError"></el-avatar>
      </div>
    </div>

    <!-- 充值弹窗 -->
    <el-dialog
      v-model="rechargeDialogVisible"
      title="充值"
      width="30%">
      <el-form :model="rechargeForm" :rules="rechargeRules" ref="rechargeFormRef">
        <el-form-item label="当前余额:" prop="currentMoney">
          <el-input v-model="rechargeForm.currentMoney" disabled></el-input>
        </el-form-item>
        <el-form-item label="充值金额:" prop="rechargeMoney">
          <el-input v-model="rechargeForm.rechargeMoney" type="number" placeholder="请输入充值金额"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="rechargeDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="onAddMoney">确认</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
  import { useUserStore } from '@/stores/user';
  import { session } from '@/api/login';
  import { updateUser } from '@/api/center';
  import { ElMessageBox, ElMessage } from 'element-plus';

  const width = '500px';
  const url = import.meta.env.VITE_APP_BASE_IP;

  const { LOGOUT } = useUserStore();

  const rules = {
    yonghuName: [
      { required: true, message: '请输入用户名', trigger: 'blur' },
      { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' },
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' },
      { min: 6, max: 16, message: '长度在 6 到 16 个字符', trigger: 'blur' },
    ],
    sexTypes: [{ required: true, message: '请输入性别', trigger: 'blur' }],
    yonghuPhone: [
      { required: true, message: '请输入手机号', trigger: 'blur' },
      {
        pattern: /^1[34578]\d{9}$/,
        message: '请输入正确的手机号',
        trigger: 'blur',
      },
    ],
    yonghuIdNumber: [
      { required: true, message: '请输入身份证号', trigger: 'blur' },
      {
        pattern: /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
        message: '请输入正确的身份证号',
        trigger: 'blur',
      },
    ],
    newMoney: [
      { required: true, message: '请输入余额', trigger: 'blur' },
      {
        pattern: /^[1-9]\d*(\.\d{1,2})?$/,
        message: '请输入正确的余额',
        trigger: 'blur',
      },
    ],
  };

  const rechargeRules = {
    rechargeMoney: [
      { required: true, message: '请输入充值金额', trigger: 'blur' },
      {
        pattern: /^[1-9]\d*(\.\d{1,2})?$/,
        message: '请输入正确的金额',
        trigger: 'blur',
      },
    ],
  };

  const formRef = ref(null);
  const form = ref({});
  const rechargeDialogVisible = ref(false);
  const rechargeFormRef = ref(null);
  const rechargeForm = ref({
    currentMoney: '',
    rechargeMoney: '',
  });

  const defaultAvatarUrl = 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png';
  const currentAvatarUrl = ref('');

  const avatarUrl = computed(() => {
    return form.value.yonghuPhoto
      ? url + '/aircraft-booking-api/' + form.value.yonghuPhoto
      : defaultAvatarUrl;
  });

  const handleAvatarError = () => {
    // 当头像加载失败时，直接设置为默认头像
    currentAvatarUrl.value = defaultAvatarUrl;
    return true;
  };

  async function initData() {
    const { data } = await session();
    form.value = data;
    // 初始化头像URL
    currentAvatarUrl.value = avatarUrl.value;
  }

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

  function openRechargeDialog() {
    rechargeForm.value.currentMoney = form.value.newMoney;
    rechargeForm.value.rechargeMoney = '';
    rechargeDialogVisible.value = true;
  }

  function onAddMoney() {
    rechargeFormRef.value.validate(async (valid) => {
      if (valid) {
        const totalMoney = parseFloat(rechargeForm.value.currentMoney) + parseFloat(rechargeForm.value.rechargeMoney);
        
        await updateUser({
          ...form.value,
          newMoney: totalMoney.toFixed(2),
          t: new Date().getTime(),
        });
        
        ElMessage.success('充值成功');
        rechargeDialogVisible.value = false;
        initData();
      }
    });
  }

  function onUpdate() {
    formRef.value.validate(async (valid) => {
      if (valid) {
        await updateUser({
          ...form.value,
          t: new Date().getTime(),
        });
        ElMessage.success('更新成功');
        initData();
      }
    });
  }

  initData();
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
    min-height: 79vh;

    .form {
      ::v-deep(.el-input__wrapper) {
        border: none;
        box-shadow: none;
        border-radius: 0px;

        .is-focus {
          box-shadow: none;
        }

        &:hover {
          border: none;
        }
      }
    }
  }
</style>
