<template>
  <el-form
    ref="formRef"
    :label-position="labelPosition"
    label-width="auto"
    :model="formData"
    :style="style"
    :rules="rules"
  >
    <el-form-item
      v-for="(item, index) in formConfig"
      :key="index"
      :prop="item.id"
      :label="item.label"
      :label-position="item.itemLabelPosition"
    >
      <span v-if="item.type === 'text'">{{ data?.[item.id] || "-" }}</span>
      <MyInput
        v-if="item.type == 'input'"
        :value="data?.[item.id]"
        :type="item.inputType"
        @change="(e) => changeValue(e, item.id)"
      ></MyInput>

      <MySelect
        v-if="item.type == 'select'"
        :value="data?.[item.id]"
        :placeholder="item.placeholder"
        :options="item.options"
        :label-key="item.label"
        :value-key="item.value"
        @change="(e) => changeValue(e, item.id)"
      ></MySelect>

      <common-upload
        ref="commonUploadRef"
        v-if="item.type == 'upload'"
        :value="data?.[item.id]"
        :file-list="data?.[item.id]"
        :action="uploadUrl"
        @success="onUploadSuccess"
        @change="(e) => changeValue(e, item.id)"
      ></common-upload>

      <common-date-picker
        v-if="item.type == 'date'"
        :value="data?.[item.id]"
        :type="item.dateType"
        :placeholder="item.placeholder"
        @change="(e) => changeValue(e, item.id)"
      />

      <rich-edit
        v-if="item.type == 'textarea'"
        :modalValue="data?.[item.id]"
        @change="(e) => changeValue(e, item.id)"
      ></rich-edit>
    </el-form-item>

    <div class="flex align-center justify-end">
      <el-button type="primary" @click="submitForm">
        {{ submitBtn }}
      </el-button>
      <el-button @click="cancelForm">{{ cancelBtn }}</el-button>
    </div>
  </el-form>
</template>

<script setup>
import { reactive, ref } from "vue";
import MyInput from "../MyInput/index.vue";
import MySelect from "../MySelect/index.vue";
import CommonUpload from "../CommonUpload.vue";
import CommonDatePicker from "../CommonDatePicker.vue";
import RichEdit from "../RichEdit/index.vue";

const prop = defineProps({
  labelPosition: {
    Type: String,
    default: "left",
  },
  style: {
    Type: Object,
    default: () => {
      return {};
    },
  },
  data: {
    Type: Object,
    default: () => {},
  },
  formConfig: {
    Type: Array,
    required: true,
  },
  uploadUrl: {
    Type: String,
    default: "#",
  },
  rules: {
    Type: Object,
    default: () => {},
  },
  submitBtn: {
    Type: String,
    default: "确定",
  },
  cancelBtn: {
    Type: String,
    default: "取消",
  },
});

const formRef = ref(null);
const commonUploadRef = ref(null);
const formData = reactive(prop.data || {});

const changeValue = (value, id) => {
  formData[id] = value;
};

const emit = defineEmits(["submitForm", "cancelForm"]);

// 确定
const submitForm = async () => {
  if (formRef.value) {
    formRef.value.validate(async (valid) => {
      if (!valid) return;
      if (prop.uploadUrl !== "#") {
        if (commonUploadRef.value.length > 0) {
          commonUploadRef.value.forEach((element) => {
            element.onUpload();
          });
        } else {
          commonUploadRef.value.onUpload();
        }
      } else {
        emit("submitForm", formData);
      }
    });
  }
};

const onUploadSuccess = () => {
  emit("submitForm", formData);
};

// 取消
const cancelForm = () => {
  emit("cancelForm");
};
</script>
