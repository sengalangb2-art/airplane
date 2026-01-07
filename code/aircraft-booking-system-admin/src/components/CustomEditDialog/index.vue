<template>
  <el-dialog
    :title="title"
    :width="width"
    :center="center"
    destroy-on-close
    @close="onClose"
  >
    <CustomForm
      :formConfig="formConfig"
      :rules="rules"
      :data="initialData"
      v-bind="$attrs"
      @submitForm="submitForm"
      @cancelForm="onClose"
    ></CustomForm>
  </el-dialog>
</template>

<script setup>
import CustomForm from "@/components/CustomForm/index.vue";
import { ref, watch } from "vue";

const prop = defineProps({
  title: {
    Type: String,
    default: "编辑",
  },
  width: {
    Type: Number,
    default: 600,
  },
  center: {
    Type: Boolean,
    default: false,
  },
  rules: {
    Type: Object,
    default: () => {},
  },
  initialData: {
    Type: Object,
    default: () => {},
  },
  formConfig: {
    Type: Array,
    default: () => [],
  },
});

const emit = defineEmits(["submitForm", "close"]);

const submitForm = (data) => {
  emit("submitForm", data);
};
const onClose = () => {
  emit("close");
};
</script>

<style scoped></style>
