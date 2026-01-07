<template>
  <el-upload
    ref="uploadRef"
    v-bind="$attrs"
    v-model:file-list="fileList"
    :action="action"
    :limit="limit"
    :list-type="listType"
    :disabled="uploadDisabled"
    :auto-upload="autoUpload"
    :http-request="uploadApi"
    :on-success="onSuccess"
  >
    <slot name="icon">
      <el-icon><Plus /></el-icon>
    </slot>

    <template #file="{ file }">
      <div>
        <img class="el-upload-list__item-thumbnail" :src="file.url" />
        <span class="el-upload-list__item-actions">
          <span
            class="el-upload-list__item-preview"
            @click="onPictureCardPreview(file)"
          >
            <el-icon><zoom-in /></el-icon>
          </span>
          <span class="el-upload-list__item-delete" @click="onRemove(file)">
            <el-icon><Delete /></el-icon>
          </span>
        </span>
      </div>
    </template>
  </el-upload>

  <el-dialog v-model="dialogVisible">
    <img w-full :src="dialogImageUrl" alt="Preview Image" />
  </el-dialog>
</template>

<script setup>
import { ref, watch } from "vue";
import { upload } from "@/api/upload";
import { Delete, Plus, ZoomIn } from "@element-plus/icons-vue";

const props = defineProps({
  value: {
    type: Array,
    default: () => [],
  },
  limit: {
    type: Number,
    default: 1,
  },
  action: {
    type: String,
    default: "#",
  },
  listType: {
    type: String,
    default: "picture-card",
  },
  autoUpload: {
    type: Boolean,
    default: false,
  },
});

const uploadRef = ref(null);
const fileList = ref([]);
const uploadFile = ref([]);
const dialogImageUrl = ref("");
const dialogVisible = ref(false);

const uploadDisabled = computed(() => {
  return fileList.value.length >= props.limit;
});

const onPictureCardPreview = (file) => {
  dialogImageUrl.value = file.url;
  dialogVisible.value = true;
};

const emits = defineEmits(["update:uploadFile", "change", "success"]);

const uploadApi = async (option) => {
  const { file } = option;
  const response = await upload(file);
  uploadFile.value.push(response.file);
};

const onSuccess = () => {
  emits("change", uploadFile.value);
  emits("success");
};

const onRemove = (file) => {
  fileList.value = fileList.value.filter((item) => item.uid !== file.uid);
  if (uploadFile.value.length && fileList.value.length === 0) {
    uploadFile.value = [];
  }
};

function onUpload() {
  const bool = fileList.value.some((item) => item.status === "ready");
  if (bool) {
    uploadRef.value && uploadRef.value.submit();
  } else {
    emits("success");
  }
}

const onClear = () => {
  uploadRef.value.clearFiles();
};

watch(
  () => props.value,
  (value) => {
    if (value !== null && value.length > 0) {
      fileList.value = value.map((item) => {
        return {
          name: item,
          url: item,
          uid: -1,
        };
      });
    }
  },
  { immediate: true }
);

watch(
  () => fileList.value,
  (value) => {
    if (!value.length) {
      emits("change", []);
    }
  },
  { deep: true }
);

defineExpose({
  onUpload,
  onClear,
});
</script>
