<template>
  <div>
    <div class="p-l-20 p-r-20">
      <common-title title="欢迎使用航空公司管理系统~"></common-title>
    </div>
    <div class="p-20 content">
      <el-row>
        <el-col :span="8">
          <div class="flex align-center">
            <el-icon><User /></el-icon>
            <span>账号：</span>
            <span>{{ adminInfo.username }}</span>
          </div>
        </el-col>
        <el-col :span="8">
          <div class="flex align-center">
            <el-icon><GoldMedal /></el-icon>
            <span>角色：</span>
            <el-tag type="primary">{{ adminInfo.role }}</el-tag>
          </div>
        </el-col>
        <el-col :span="8">
          <div class="flex align-center">
            <el-icon><Lock /></el-icon>
            <span>密码：</span>
            <span>{{ adminInfo.password }}</span>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { session } from "@/api/home";

const adminInfo = ref({});

async function initData() {
  const { data } = await session();
  console.log(data, 99999);
  adminInfo.value = data;
}

initData();
</script>

<style lang="scss" scoped>
.content {
  font-size: 16px;
  color: #111d34;
}
</style>
