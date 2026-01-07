<template>
  <div class="p-20">
    <common-title button title="新闻信息">
      <el-button type="primary" @click="editVisible = true">新增</el-button>
    </common-title>

    <CustomSearch
      class="m-b-15"
      :searchConfig="newsSearchConfig"
      @updateQueryData="updateQueryData"
    >
    </CustomSearch>

    <CustomTable
      :tableConfig="newsTableConfig"
      :tableData="tableData"
      :total="total"
      @updateQueryData="updateQueryData"
      @handleEdit="handleEdit"
      @handleDelete="onDelete"
    >
      <template #newsContent="{ row }">
        <el-button text type="primary" @click="handleEdit(row)">详情</el-button>
      </template>
      <template #newsPhoto="{ row }">
        <el-image
          style="width: 100px; height: 100px; border-radius: 6px"
          :src="imageUrl(row.newsPhoto)"
          fit="fill"
          lazy
        />
      </template>
    </CustomTable>

    <common-drawer
      :title="title"
      v-model="editVisible"
      :rules="rules"
      :uploadUrl="uploadUrl"
      :formConfig="newsEditFormConfig"
      :initialData="formData"
      @submitForm="submitForm"
      @close="onCloseForm"
    ></common-drawer>
  </div>
</template>

<script setup>
import CustomTable from "@/components/CustomTable/index.vue";
import CustomSearch from "@/components/CustomSearch/index.vue";
import { ref } from "vue";
import { ElMessage } from "element-plus";
import {
  newsTableConfig,
  newsSearchConfig,
  newsEditFormConfig,
} from "./tableConfig";
import {
  getNewsPage,
  getNewsType,
  getNewsById,
  deleteNews,
  updateNews,
  saveNews,
} from "@/api/news";
import { messageBox } from "@/utils/tools";

const uploadUrl =
  import.meta.env.VITE_APP_BASE_IP +
  import.meta.env.VITE_APP_BASE_URL +
  "/" +
  "file/upload";

const rules = {
  newsName: [{ required: true, message: "请输入新闻标题", trigger: "blur" }],
  newsTypes: [{ required: true, message: "请选择航班类型", trigger: "blur" }],
  // newsPhoto: [{ required: true, message: "请上传航班封面", trigger: "blur" }],
  // newsContent: [{ required: true, message: "请输入航班内容", trigger: "blur" }],
};

const total = ref(0);
const tableData = ref([]);
const editVisible = ref(false);

const queryParams = ref({
  page: 1,
  limit: 10,
  sort: "id",
  newsDelete: 1,
  newsName: "",
  newsTypes: "",
});

const formData = ref({
  newsName: "",
  newsTypes: "",
  newsPhoto: [],
  newsContent: "",
});

const title = computed(() => {
  return formData.value.id ? "编辑" : "新增";
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

// 更新查询参数，如果bool为true则调后台接口
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

// 编辑
const handleEdit = async (row) => {
  const { data } = await getNewsById(row.id);
  data.newsPhoto =
    data.newsPhoto !== ""
      ? data.newsPhoto
          .split(",")
          .map(
            (item) =>
              import.meta.env.VITE_APP_BASE_IP +
              import.meta.env.VITE_APP_BASE_URL +
              "/" +
              item
          )
      : [];
  formData.value = data;
  editVisible.value = true;
};

// 确定
const submitForm = async (data) => {
  const url =
    import.meta.env.VITE_APP_BASE_IP + import.meta.env.VITE_APP_BASE_URL + "/";
  if (data.id) {
    const params = {
      ...data,
      newsPhoto: data.newsPhoto
        .map((item) => {
          if (item.includes("upload/")) {
            return item.replace(url, "");
          } else {
            return "upload/" + item;
          }
        })
        .join(",") || "",
    };
    await updateNews(params);
    ElMessage.success("修改成功");
  } else {
    const params = {
      ...data,
      newsPhoto: data.newsPhoto.map((item) => "upload/" + item).join(","),
    };
    await saveNews(params);
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
    message: `确定删除${row.newsName}吗？`,
  });
  if (!res) return;
  await deleteNews([row.id]);
  ElMessage.success("删除成功");
  initData();
};

const initData = async () => {
  const { data } = await getNewsPage(queryParams.value);
  total.value = data.total;
  tableData.value = data.list;
};

const initSearchData = async () => {
  const { data: NewsType } = await getNewsType({
    dicCode: "news_types",
    dicName: "新闻类型",
    page: 1,
    limit: 9999,
  });
  newsSearchConfig.value.forEach((element) => {
    if (element.id === "newsTypes") {
      element.options = NewsType.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });
  newsEditFormConfig.value.forEach((element) => {
    if (element.id === "newsTypes") {
      element.options = NewsType.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });
};

initSearchData();
initData();
</script>

<style scoped></style>
