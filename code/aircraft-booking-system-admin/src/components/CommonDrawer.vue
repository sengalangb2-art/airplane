<template>
  <el-drawer
    v-bind="$attrs"
    :title="title"
    :size="width"
    :direction="direction"
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
  </el-drawer>
</template>

<script setup>
import CustomForm from "@/components/CustomForm/index.vue";

const prop = defineProps({
  title: {
    Type: String,
    default: "编辑",
  },
  width: {
    default: "50%",
  },
  direction: {
    Type: String,
    default: "rtl",
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
