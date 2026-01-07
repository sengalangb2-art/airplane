<template>
  <svg
    aria-hidden="true"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    :style="{ width, height }"
  >
    <use :xlink:href="symbolId" :fill="color" />
  </svg>
</template>

<script setup>
import { computed } from "vue";

const props = defineProps({
  prefix: {
    type: String,
    default: "icon",
  },
  name: {
    type: String,
    required: true,
  },
  color: {
    type: String,
    default: "#333",
  },
  width: {
    type: String,
    default: "2em",
  },
  height: {
    type: String,
    default: "2em",
  },
});

const symbolId = computed(() => `#${props.prefix}-${props.name}`);
</script>

<style scope>
.svg-icon {
  width: 2em;
  height: 2em;
  fill: currentColor;
  vertical-align: middle;
}
</style>
