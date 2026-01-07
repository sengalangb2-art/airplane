import { ref } from "vue";
import { defineStore } from "pinia";

export const useCommonStore = defineStore("common", () => {
  const loading = ref(false);

  const showLoading = () => {
    loading.value = true;    
  };

  const closeLoading = () => {
    loading.value = false;
  };

  return { loading, showLoading, closeLoading };
});
