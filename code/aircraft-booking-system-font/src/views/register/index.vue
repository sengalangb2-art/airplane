<template>
  <div class="login flex justify-center align-center">
    <div class="login-container flex align-center justify-center">
      <el-form
          ref="formRef"
          :model="ruleForm"
          :rules="rules"
          label-width="auto"
          class="login-form"
          status-icon
      >
        <el-form-item>
          <div class="logo flex justify-center align-center m-b-25">
            <svg-icon name="logo" width="45px" height="45px" />
            <span>航班出行订票系统</span>
          </div>
        </el-form-item>
        <el-form-item>
          <div class="title">手机号注册</div>
        </el-form-item>

        <el-form-item prop="yonghuPhone">
          <el-input
              v-model="ruleForm.yonghuPhone"
              :prefix-icon="Iphone"
              size="large"
              placeholder="请输入手机号"
          />
        </el-form-item>

        <el-form-item prop="password">
          <el-input
              size="large"
              v-model="ruleForm.password"
              type="password"
              :prefix-icon="Lock"
              show-password
              placeholder="请输入密码"
          />
        </el-form-item>
        <el-form-item>
          <span class="register" @click="$router.push('/login')">已有账号？去登录</span>
        </el-form-item>
        <el-form-item>
          <el-button
              style="width: 100%"
              type="primary"
              size="large"
              @click="submitForm(formRef)"
          >
            注册
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { register } from "@/api/login";
import { useUserStore } from "@/stores/user";
import { Lock, Iphone } from "@element-plus/icons-vue"; // 引入 Iphone 图标
import router from "@/router";
import { ElMessage } from "element-plus";

const { SET_TOKEN, SET_USER_INFO } = useUserStore();

const formRef = ref();

const ruleForm = reactive({
  yonghuPhone: "", // 绑定手机号
  password: "",
});

const rules = reactive({
  yonghuPhone: [
    {
      required: true,
      message: "请填写手机号",
      trigger: "blur",
    },
    {
      pattern: /^1[3-9]\d{9}$/,
      message: "请输入正确的手机号码",
      trigger: "blur"
    },
  ],
  password: [
    {
      required: true,
      message: "请填写密码",
      trigger: "blur",
    },
    { min: 6, max: 10, message: "密码长度应为 6 到 10 位", trigger: "blur" },
  ],
});

const submitForm = async (formEl) => {
  if (!formEl) return;
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      // 构造提交参数
      const params = {
        username: ruleForm.yonghuPhone, // 将手机号作为用户名提交，以便后续登录
        yonghuPhone: ruleForm.yonghuPhone,
        password: ruleForm.password,
        yonghuName: "用户" + ruleForm.yonghuPhone.substring(7) // 默认给一个昵称
      };

      await register(params);
      ElMessage.success("注册成功，请使用手机号登录");
      router.push('/login'); // 注册成功跳转登录
    } else {
      console.log("error submit!", fields);
    }
  });
};
</script>

<style lang="scss" scoped>
.login {
  position: relative;
  width: 100vw;
  height: 100vh;
  // background-color: #fff;
  background-image: url("../../assets/images/swiper/2.png");
  background-size: 100% 100%;
  background-repeat: no-repeat;

  .login-container {
    position: absolute;
    top: 0;
    left: 0;
    width: 32vw;
    height: 100%;
    background-color: #fff;
    box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.15);

    .login-form {
      width: 100%;
      padding: 50px 80px;

      .logo {
        width: 100%;
        color: #111d34;
        font-family: "Times New Roman", Times, serif;
        font-weight: 700;

        span {
          font-size: 36px;
          margin-left: 10px;
        }
      }

      .title {
        position: relative;
        margin: 0 auto;
        text-align: center;
        font-size: 20px;
        font-weight: bold;
        color: #333;

        &:before {
          content: "";
          position: absolute;
          bottom: -10px;
          left: 50%;
          transform: translateX(-50%);
          width: 80px;
          height: 3px;
          background-color: #1e90ff;
        }
      }

      .register {
        font-size: 14px;
        cursor: pointer;
        font-weight: 500;
        color: #1890ff;

        &:hover {
          opacity: 0.8;
        }
      }
    }
  }
}
</style>