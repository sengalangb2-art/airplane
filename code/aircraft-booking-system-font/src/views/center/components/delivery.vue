<template>
  <div>
    <div class="title flex align-center">
      <el-icon><DataAnalysis /></el-icon>
      <span class="m-l-10">航班收藏</span>
    </div>
    <Air :list="tableData" @cancel="initData" />
  </div>
</template>

<script setup>
import { ref, onActivated } from "vue";
import { getAirCollection } from "@/api/center";
import { useUserStore } from "@/stores/user";
import Air from "../components/air.vue";

const userStore = useUserStore();

const tableData = ref([]);
const totalCount = ref(0);

const initData = async () => {
  const params = {
    page: 1,
    limit: 9999,
    sort: "id",
    order: "desc",
    jipiaoCollectionTypes: 1,
    yonghuId: userStore.userInfo.userId,
    jipiaoName: "",
    jipiaoTypes: "",
    hangbanTypes: "",
    t: new Date().getTime(),
  };
  const { data } = await getAirCollection(params);
  tableData.value = data.list;
  totalCount.value = data.total;
};

onActivated(() => {
  initData();
});
</script>

<style scoped lang="scss">
.title {
  padding: 20px 20px 12px;
  font-size: 18px;
  font-weight: 500;
  color: #4169e1;
  padding-bottom: 12px;
  border-bottom: 1px solid #eee;
}

.content {
  min-height: 79vh;

  .statistics {
    font-size: 14px;
    color: #666;
    margin-bottom: 15px;
    padding: 15px 10px;
    border-radius: 4px;
    border-radius: 6px;

    span {
      font-weight: 600;
      color: #333;
      font-size: 16px;
      margin: 0 10px;
    }
  }
}
</style>
