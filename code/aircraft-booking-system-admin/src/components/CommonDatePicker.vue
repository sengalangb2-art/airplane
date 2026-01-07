<template>
  <div>
    <el-date-picker v-bind="$attrs" v-model="dateValue" :type="type" />
  </div>
</template>

<script setup>
import { ref } from "vue";

const props = defineProps({
  value: {
    type: [String, Number, Date],
    default: "",
  },
  type: {
    type: String,
    default: "datetime",
  },
});

const dateValue = ref(props.value);
</script>

<style lang="scss" scoped></style>
