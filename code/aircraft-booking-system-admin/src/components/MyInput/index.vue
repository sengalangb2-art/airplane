<template>
  <el-input
    v-bind="$attrs"
    :style="style"
    v-model="localValue"
    :placeholder="placeholder"
    :type="type"
    clearable
  ></el-input>
</template>

<script setup>
import { ref } from "vue";
const prop = defineProps({
  style: {
    Type: Object,
    default: () => {},
  },
  value: {
    Type: String,
    default: "",
  },
  placeholder: {
    Type: String,
    default: "",
  },
  type: {
    Type: String,
    default: "text",
  },
});

const localValue = ref(prop.value);
</script>

<style scoped></style>
