<template>
  <div class="p-20">
    <common-title button title="新闻类型">
      <el-button type="primary" @click="editVisible = true">新增</el-button>
    </common-title>

    <CustomTable
      :tableConfig="typeTableConfig"
      :tableData="tableData"
      :total="total"
      @updateQueryData="updateQueryData"
      @handleEdit="handleEdit"
      @handleDelete="onDelete"
    >
    </CustomTable>

    <EditDialog
      :title="title"
      v-model="editVisible"
      :rules="rules"
      :formConfig="typeEditFormConfig"
      :initialData="formData"
      @submitForm="submitForm"
      @close="onCloseForm"
    ></EditDialog>
  </div>
</template>

<script setup>
import CustomTable from "@/components/CustomTable/index.vue";
import EditDialog from "@/components/CustomEditDialog/index.vue";
import { ref } from "vue";
import { ElMessage } from "element-plus";
import { typeTableConfig, typeEditFormConfig } from "./tableConfig";
import {
  getNewsType,
  getNewsTypeById,
  deleteNewsType,
  updateNewsType,
  saveNewsType,
  getNewsMaxCodeIndex,
} from "@/api/news";
import { messageBox } from "@/utils/tools";

const total = ref(0);
const tableData = ref([]);

const queryParams = ref({
  page: 1,
  limit: 10,
  sort: "id",
  dicCode: "news_types",
  dicName: "新闻类型",
});

const title = computed(() => {
  return formData.value.id ? "编辑" : "新增";
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

const editVisible = ref(false);

const rules = {
  indexName: [
    { required: true, message: "请输入新闻类型名称", trigger: "blur" },
  ],
};

const formData = ref({});

// 编辑
const handleEdit = async (row) => {
  const { data } = await getNewsTypeById(row.id);
  formData.value = data;
  editVisible.value = true;
};

// 确定
const submitForm = async (data) => {
  if (data.id) {
    const params = {
      ...data,
    };
    await updateNewsType(params);
    ElMessage.success("修改成功");
  } else {
    const params = {
      ...data,
      superId: "",
      dicCode: "news_types",
      dicName: "新闻类型",
    };
    await saveNewsType(params);
    ElMessage.success("新增成功");
  }
  editVisible.value = false;
  formData.value = {};
  initData();
};

const onCloseForm = () => {
  editVisible.value = false;
  formData.value = {};
};

// 删除
const onDelete = async (row) => {
  const res = await messageBox({
    title: "提示",
    type: "warning",
    "show-close": false,
    closeOnClickModal: false,
    showCancelButton: true,
    confirmButtonText: "是",
    cancelButtonText: "否",
    message: `确定删除${row.indexName}吗？`,
  });
  if (!res) return;
  await deleteNewsType([row.id]);
  ElMessage.success("删除成功");
  initData();
};

const initData = async () => {
  const { data } = await getNewsType(queryParams.value);
  total.value = data.total;
  tableData.value = data.list;
};

const initSearchData = async () => {
  const { maxCodeIndex } = await getNewsMaxCodeIndex({
    dicCode: "news_types",
  });
  formData.value.codeIndex = maxCodeIndex || 1;
};

initSearchData();
initData();
</script>

<style scoped></style>
