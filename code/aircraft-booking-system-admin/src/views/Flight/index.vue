<template>
  <div class="p-20">
    <common-title button title="航班信息">
      <el-button type="primary" @click="editVisible = true">新增</el-button>
    </common-title>

    <CustomSearch
      class="m-b-15"
      :searchConfig="flightSearchConfig"
      @updateQueryData="updateQueryData"
    >
      <el-button
        type="danger"
        plain
        icon="RefreshRight"
        class="m-l-10"
        @click="onReset"
      >重置</el-button
      >
    </CustomSearch>

    <CustomTable
      :tableConfig="flightTableConfig"
      :tableData="tableData"
      :total="total"
      @updateQueryData="updateQueryData"
      @handleEdit="handleEdit"
      @handleDelete="onDelete"
    >
      <template #hangbanValue="{ row }">
        <el-tag :type="row.hangbanTypes == 1 ? 'success' : 'danger'">{{
            row.hangbanValue
          }}</el-tag>
      </template>
    </CustomTable>

    <EditDialog
      :title="title"
      v-model="editVisible"
      :rules="rules"
      :uploadUrl="uploadUrl"
      :formConfig="flightEditFormConfig"
      :initialData="formData"
      @submitForm="submitForm"
      @close="onCloseForm"
    ></EditDialog>
  </div>
</template>

<script setup>
import CustomTable from "@/components/CustomTable/index.vue";
import CustomSearch from "@/components/CustomSearch/index.vue";
import EditDialog from "@/components/CustomEditDialog/index.vue";
import { ref, computed } from "vue"; // 补全 computed 引用
import { ElMessage } from "element-plus";
import dayjs from "dayjs"; // 【修改】独立导入 dayjs，防止 element-plus 导出异常
import {
  flightTableConfig,
  flightSearchConfig,
  flightEditFormConfig,
} from "./tableConfig";
import {
  getFlightPage,
  getFlightType,
  getFlightById,
  deleteFlight,
  updateFlight,
  saveFlight,
} from "@/api/flight";
import { messageBox } from "@/utils/tools";

const total = ref(0);
const tableData = ref([]);

const queryParams = ref({
  page: 1,
  limit: 10,
  sort: "id",
  jipiaoDelete: 1,
  jipiaoName: "",
  jipiaoTypes: "",
  jipiaoChufadi: "",
  jipiaoMudidi: "",
  hangbanTypes: "",
});

const title = computed(() => {
  return formData.value.id ? "编辑" : "新增";
});

const uploadUrl =
  import.meta.env.VITE_APP_BASE_IP +
  import.meta.env.VITE_APP_BASE_URL +
  "/" +
  "file/upload";

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

const editVisible = ref(false);

const rules = {
  jipiaoName: [{ required: true, message: "请输入航班名称", trigger: "blur" }],
  jipiaoTypes: [{ required: true, message: "请选择航班类型", trigger: "blur" }],
  jipiaoTime: [{ required: true, message: "请选择出发时间", trigger: "blur" }],
  jipiaoChufadi: [{ required: true, message: "请输入出发地", trigger: "blur" }],
  jipiaoMudidi: [{ required: true, message: "请输入目的地", trigger: "blur" }],
  jipiaoNewMoney: [{ required: true, message: "请输入经济舱价格", trigger: "blur" }],
  // 新增校验
  jipiaoFirstMoney: [{ required: true, message: "请输入头等舱价格", trigger: "blur" }],
  jipiaoFirstNum: [{ required: true, message: "请输入头等舱座位数", trigger: "blur" }],

  zuoweiNumber: [
    { required: true, message: "请输入总座位数量", trigger: "blur" },
  ],
  hangbanTypes: [
    { required: true, message: "请选择航班状态", trigger: "blur" },
  ],
  shangxiaTypes: [
    { required: true, message: "请选择上架状态", trigger: "blur" },
  ],
};

const formData = ref({});

const onReset = () => {
  queryParams.value = {
    page: 1,
    limit: 10,
    sort: "id",
    jipiaoDelete: 1,
    jipiaoName: "",
    jipiaoTypes: "",
    jipiaoChufadi: "",
    jipiaoMudidi: "",
    hangbanTypes: "",
  };
  initData();
};

// 编辑
const handleEdit = async (row) => {
  const { data } = await getFlightById(row.id);
  // 处理图片回显
  if (data.jipiaoPhoto) {
    data.jipiaoPhoto = data.jipiaoPhoto
      .split(",")
      .map(
        (item) =>
          import.meta.env.VITE_APP_BASE_IP +
          import.meta.env.VITE_APP_BASE_URL +
          "/" +
          item
      );
  } else {
    data.jipiaoPhoto = []; // 防止为 null 报错
  }
  formData.value = data;
  editVisible.value = true;
};

// 确定 【核心修改部分】
const submitForm = async (data) => {
  const url =
    import.meta.env.VITE_APP_BASE_IP + import.meta.env.VITE_APP_BASE_URL + "/";

  // 1. 统一处理时间格式化，防止 400 错误
  // 注意：如果 jipiaoTime 本身就是字符串且格式正确，dayjs(str).format 会保持原样，所以这样写是安全的
  const formattedTime = dayjs(data.jipiaoTime).format("YYYY-MM-DD HH:mm:ss");

  // 【修复点】：增加到达时间格式化，如果有值则格式化，没值传 null
  const formattedArrivalTime = data.jipiaoArrivalTime
    ? dayjs(data.jipiaoArrivalTime).format("YYYY-MM-DD HH:mm:ss")
    : null;

  if (data.id) {
    // === 修改逻辑 ===
    const params = {
      ...data,
      jipiaoTime: formattedTime,
      jipiaoArrivalTime: formattedArrivalTime, // 传入格式化后的到达时间
      jipiaoPhoto:
        data.jipiaoPhoto && data.jipiaoPhoto.length > 0
          ? data.jipiaoPhoto
            .map((item) => {
              if (item.includes("upload/")) {
                return item.replace(url, "");
              } else {
                return "upload/" + item;
              }
            })
            .join(",")
          : "",
    };
    await updateFlight(params);
    ElMessage.success("修改成功");
  } else {
    // === 新增逻辑 ===
    const params = {
      ...data,
      jipiaoTime: formattedTime,
      jipiaoArrivalTime: formattedArrivalTime, // 传入格式化后的到达时间
      jipiaoPhoto:
        data.jipiaoPhoto && data.jipiaoPhoto.length > 0
          ? data.jipiaoPhoto.map((item) => "upload/" + item).join(",")
          : "",
    };
    await saveFlight(params);
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
    message: `确定删除${row.jipiaoName}吗？`,
  });
  if (!res) return;
  await deleteFlight([row.id]);
  ElMessage.success("删除成功");
  initData();
};

const initData = async () => {
  const { data } = await getFlightPage(queryParams.value);
  total.value = data.total;
  tableData.value = data.list;
};

const initSearchData = async () => {
  // 1. 获取航班类型字典
  const { data: flightType } = await getFlightType({
    dicCode: "jipiao_types",
    page: 1,
    limit: 9999,
  });

  // 映射到搜索配置
  flightSearchConfig.value.forEach((element) => {
    if (element.id === "jipiaoTypes") {
      element.options = flightType.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });

  // 映射到表单配置
  flightEditFormConfig.value.forEach((element) => {
    if (element.id === "jipiaoTypes") {
      element.options = flightType.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });

  // 2. 获取航班状态字典
  const { data: flightStatus } = await getFlightType({
    dicCode: "hangban_types",
    page: 1,
    limit: 9999,
  });

  flightSearchConfig.value.forEach((element) => {
    if (element.id === "hangbanTypes") {
      element.options = flightStatus.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });

  flightEditFormConfig.value.forEach((element) => {
    if (element.id === "hangbanTypes") {
      element.options = flightStatus.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });

  // 3. 获取上下架字典
  const { data } = await getFlightType({
    dicCode: "shangxia_types",
    page: 1,
    limit: 9999,
  });
  flightEditFormConfig.value.forEach((element) => {
    if (element.id === "shangxiaTypes") {
      element.options = data.list.map((item) => {
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
