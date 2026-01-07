<template>
  <div class="p-20">
    <common-title title="航班订单列表"> </common-title>

    <CustomTable
      :tableConfig="orderTableConfig"
      :tableData="tableData"
      :total="total"
      @updateQueryData="updateQueryData"
    >
      <template #yonghuPhoto="{ row }">
        <el-image
          style="width: 100px; height: 100px; border-radius: 6px"
          :src="imageUrl(row.yonghuPhoto)"
          fit="fill"
          lazy
        />
      </template>
      <template #jipiaoOrderValue="{ row }">
        <el-tag
          :type="
            row.jipiaoOrderTypes == 101
              ? 'primary'
              : row.jipiaoOrderTypes == 102
              ? 'danger'
              : row.jipiaoOrderTypes == 103
              ? 'warning'
              : 'success'
          "
          >{{ row.jipiaoOrderValue }}</el-tag
        >
      </template>
      <template #handle="{ row }">
        <div>
          <el-button
            v-if="row.jipiaoOrderTypes == 101"
            type="primary"
            plain
            @click="onPostOrderTicket(row)"
            >出票</el-button
          >
        </div>
      </template>
    </CustomTable>
  </div>
</template>

<script setup>
import CustomTable from "@/components/CustomTable/index.vue";
import { ref } from "vue";
import { ElMessage } from "element-plus";
import { orderTableConfig } from "./tableConfig";
import { getOrderPage, postOrderTicket } from "@/api/flight";
import { messageBox } from "@/utils/tools";

const total = ref(0);
const tableData = ref([]);
const queryParams = ref({
  page: 1,
  limit: 10,
  jipiaoOrderDelete: 1,
  sort: "id",
});

const imageUrl = computed(() => {
  return function (url) {
    return (
      import.meta.env.VITE_APP_BASE_IP +
      import.meta.env.VITE_APP_BASE_URL +
      "/" +
      url
    );
  };
});

const updateQueryData = (params, bool) => {
  const { pageNum, pageSize } = params;
  queryParams.value = {
    ...queryParams.value,
    ...params,
    page: pageNum,
    limit: pageSize,
  };
  initData();
};

const onPostOrderTicket = async (row) => {
  const res = await messageBox({
    title: "提示",
    type: "warning",
    "show-close": false,
    closeOnClickModal: false,
    showCancelButton: true,
    confirmButtonText: "是",
    cancelButtonText: "否",
    message: `确定出票航班：${row.jipiaoName}，订单号为：${row.jipiaoOrderUuidNumber}，乘车人姓名：${row.yonghuName}的机票吗？`,
  });
  if (!res) return;
  await postOrderTicket(row.id);
  ElMessage.success("出票成功");
  initData();
};

const initData = async () => {
  const { data } = await getOrderPage(queryParams.value);
  total.value = data.total;
  tableData.value = data.list;
};

initData();
</script>

<style scoped></style>
