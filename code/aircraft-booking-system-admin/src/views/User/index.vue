<template>
  <div class="p-20">
    <common-title button title="用户信息">
      <el-button type="primary" @click="editVisible = true">新增</el-button>
    </common-title>

    <CustomSearch
      class="m-b-15"
      :searchConfig="userSearchConfig"
      @updateQueryData="updateQueryData"
    >
    </CustomSearch>

    <CustomTable
      :tableConfig="userTableConfig"
      :tableData="tableData"
      :total="total"
      @updateQueryData="updateQueryData"
      @handleEdit="handleEdit"
      @handleDelete="onDelete"
    >
      <template #yonghuPhoto="{ row }">
        <el-image
          style="width: 100px; height: 100px; border-radius: 6px"
          :src="imageUrl(row.yonghuPhoto)"
          fit="fill"
          lazy
        />
      </template>
      <template #password="{ row }">
        <el-button text type="danger" @click="onResetPassword(row)"
          >重置密码</el-button
        >
      </template>
    </CustomTable>

    <EditDialog
      :title="title"
      v-model="editVisible"
      :rules="rules"
      :uploadUrl="uploadUrl"
      :formConfig="userEditFormConfig"
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
import { ref } from "vue";
import { ElMessage } from "element-plus";
import {
  userTableConfig,
  userSearchConfig,
  userEditFormConfig,
} from "./tableConfig";
import {
  getUserPage,
  getUserById,
  deleteUser,
  updateUser,
  saveUser,
  getSex,
  resetPassword,
} from "@/api/user";
import { messageBox } from "@/utils/tools";

const uploadUrl =
  import.meta.env.VITE_APP_BASE_IP +
  import.meta.env.VITE_APP_BASE_URL +
  "/" +
  "file/upload";

const rules = {
  username: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
  yonghuName: [{ required: true, message: "请输入姓名", trigger: "blur" }],
  sexTypes: [{ required: true, message: "请选择性别", trigger: "blur" }],
  yonghuIdNumber: [
    { required: true, message: "请输入身份证号", trigger: "blur" },
    {
      pattern:
        /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/,
      message: "请输入正确的身份证号",
      trigger: "blur",
    },
  ],
  yonghuPhone: [
    { required: true, message: "请输入手机号", trigger: "blur" },
    {
      pattern: /^1[3-9]\d{9}$/,
      message: "请输入正确的手机号",
      trigger: "blur",
    },
  ],
  newMoney: [{ required: true, message: "请输入余额", trigger: "blur" }],
  // yonghuPhoto: [
  //   { required: true, message: "请上传头像", trigger: "blur" },
  //   { type: "array", message: "请上传头像", trigger: "blur" },
  // ],
};

const formData = ref({});

const total = ref(0);
const tableData = ref([]);
const editVisible = ref(false);

const queryParams = ref({
  page: 1,
  limit: 10,
  sort: "id",
  yonghuDelete: 1,
  username: "",
  yonghuName: "",
  sexTypes: "",
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

const onResetPassword = async (row) => {
  const res = await messageBox({
    title: "提示",
    type: "warning",
    "show-close": false,
    closeOnClickModal: false,
    showCancelButton: true,
    confirmButtonText: "是",
    cancelButtonText: "否",
    message: `确定恢复${row.yonghuName}的初始密吗？`,
  });
  if (!res) return;
  await resetPassword(row.id);
  ElMessage.success("密码已重置为初始密码");
  initData();
};

// 编辑
const handleEdit = async (row) => {
  const { data } = await getUserById(row.id);
  data.yonghuPhoto = data.yonghuPhoto
    .split(",")
    .map(
      (item) =>
        import.meta.env.VITE_APP_BASE_IP +
        import.meta.env.VITE_APP_BASE_URL +
        "/" +
        item
    );
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
      yonghuPhoto: data.yonghuPhoto
        .map((item) => {
          if (item.includes("upload/")) {
            return item.replace(url, "");
          } else {
            return "upload/" + item;
          }
        })
        .join(","),
    };
    await updateUser(params);
    ElMessage.success("修改成功");
  } else {
    const params = {
      ...data,
      yonghuPhoto: data.yonghuPhoto.map((item) => "upload/" + item).join(","),
    };
    await saveUser(params);
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
    message: `确定删除${row.yonghuName}吗？`,
  });
  if (!res) return;
  await deleteUser([row.id]);
  ElMessage.success("删除成功");
  initData();
};

const initData = async () => {
  const { data } = await getUserPage(queryParams.value);
  total.value = data.total;
  tableData.value = data.list;
};

const initSearchData = async () => {
  const { data: userType } = await getSex();
  console.log(userType, 656666);

  userSearchConfig.value.forEach((element) => {
    if (element.id === "sexTypes") {
      element.options = userType.list.map((item) => {
        return {
          label: item.indexName,
          value: item.codeIndex,
        };
      });
    }
  });
  userEditFormConfig.value.forEach((element) => {
    if (element.id === "sexTypes") {
      element.options = userType.list.map((item) => {
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
