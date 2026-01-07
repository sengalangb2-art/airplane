<template>
  <div class="login-container flex">
    <div class="login-right flex flex-col">
      <div class="login">
        <div class="fz-20 text-center text-bold m-b-15">欢迎登录航空公司信息管理平台</div>
        <div class="text-center m-b-30">WELCOME</div>
        <el-form :model="form" :rules="rules" ref="ruleForm">
          <el-form-item class="login-input flex" prop="username">
            <el-icon class="flex1"><User /></el-icon>
            <el-input
              class="login-input-right"
              v-model="form.username"
              placeholder="请输入账号"
            />
          </el-form-item>
          <el-form-item class="login-input flex" prop="password">
            <el-icon class="flex1"><Lock /></el-icon>
            <el-input
              class="login-input-right"
              v-model="form.password"
              placeholder="请输入密码"
            />
          </el-form-item>
          <el-form-item>
            <el-button class="login-btn" type="primary" @click="onSubmit()"
              >立即登录</el-button
            >
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import router from "@/router";
import { ref, reactive } from "vue";
import { getDynamicRoutes } from "@/utils/getData.js";
import { getAuthRouters } from "@/router/authRouter.js";
import { useAuthRouterStore } from "@/stores/authRouter.js";
import { login, session } from "@/api/login.js";
import { useUserStore } from "@/stores/user";

const authRouterStore = useAuthRouterStore();
const { SET_TOKEN, SET_USER_INFO } = useUserStore();

const ruleForm = ref(null);
const form = reactive({
  username: "admin",
  password: "admin",
});

const rules = {
  username: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
};

const onSubmit = () => {
  ruleForm.value.validate(async (valid) => {
    if (valid) {
      // 其他登录逻辑
      const data = await login(form);
      SET_TOKEN(data.token);
      const res = await session();
      // 成功后将token存到session
      sessionStorage.token = data.token;
      SET_USER_INFO(res.data);

      // 获取动态路由
      let dynamicRoutes = await getDynamicRoutes();
      // 动态添加路由
      let newRoutes = getAuthRouters(dynamicRoutes);
      authRouterStore.addRouterList(newRoutes);
      newRoutes.forEach((val) => {
        router.addRoute(val);
      });
      router.push("/dashboard");
    }
  });
};
</script>

<style scoped>
.login-container {
  position: relative;
  width: 100vw;
  height: 100vh;
  background: url("../../assets/images/login.png") no-repeat;
  background-size: cover;
}
.login-left {
  width: 58%;
  height: 100%;
}
.login-right {
  position: absolute;
  left: 0;
  top: 0;
  width: 30%;
  height: 100%;
  background-color: #fff;
  margin: auto;
  /* border-radius: 10px; */
  box-shadow: #b3d2fb 1px 1px 15px 1px;
  padding: 40px 50px;
}

.login {
  margin: auto 0;
}

.login-input {
  height: 50px;
  border: 1px solid #b3d2fb;
  border-radius: 5px;
  background: rgba(231, 241, 253, 0.4);
}
.login-input-right {
  width: 80%;
  height: 60%;
  border-left: 1px solid #ccc;
}
.login-remember {
  font-size: 12px;
}
.login-btn {
  width: 100%;
  height: 40px;
}
</style>
<style>
.login-input-right .el-input__wrapper {
  border: none !important;
  box-shadow: none !important;
  background: transparent;
}
.login-remember .el-checkbox__label {
  font-size: 12px;
  color: #aaa;
}
</style>
