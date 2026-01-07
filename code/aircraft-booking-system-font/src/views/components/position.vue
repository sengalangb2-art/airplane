<template>
  <div
    class="card m-r-10"
    v-for="item in list"
    :key="item.id"
    :class="{ 'border': border }"
    @click="onGetDel(item.id)"
  >
    <div class="flex align-center justify-between m-b-25">
      <div class="flex align-center">
        <span class="title m-r-5 ellipsis">{{ item.title }}</span>
        <el-tag type="primary">{{ item.creater.company.industry }}</el-tag>
      </div>
      <div class="flex align-center money">
        <span class="m-r-5">{{ item.salary }}</span>
        <span>元</span>
      </div>
    </div>
    <div class="flex align-center m-b-40">
      <div class="del m-r-20">
        <span>岗位：</span>
        <span>{{ item.job }}</span>
      </div>
      <div class="del">
        <span>人数：</span>
        <span>{{ item.nums }}</span>
      </div>
    </div>
    <div class="flex align-center justify-between footer">
      <div class="flex align-center">
        <img src="@/assets/images/company.png" />
        <span>企业名称：</span>
        <span>{{ item.creater.company.name }}</span>
      </div>
      <div class="flex align-center">
        <img src="@/assets/images/time.png" />
        <span>截至日期：</span>
        <span>{{ formatDate(item.endDate) }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import dayjs from "dayjs";

defineProps({
  list: {
    type: Array,
    default: () => [],
  },
  border: {
    type: Boolean,
    default: false,
  }
});

const formatDate = computed(() => {
  return function (date) {
    return dayjs(date).format("YYYY-MM-DD");
  };
});

const emits = defineEmits(["getDel"]);

const onGetDel = (id) => {
  emits("getDel", id);
};
</script>

<style lang="scss" scoped>
.card {
  width: 32.5%;
  border-radius: 8px;
  padding: 20px;
  color: #111d34;
  background-color: #fff;
  margin-bottom: 20px;

  .border {
    border-radius: 8px;
    border: 1px solid #e5e5e5;
  }

  .title {
    max-width: 200px;
    font-size: 26px;
    font-weight: 500;
  }

  .money {
    font-size: 20px;
    color: #fe574a;
    font-weight: 500;
  }

  .del {
    color: #848484;
  }

  .footer {
    img {
      width: 22px;
      height: 22px;
      margin-right: 5px;
    }
  }

  &:hover {
    cursor: pointer;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  }

  &:active {
    box-shadow: 0 0 0 0 rgba(0, 0, 0, 0.1);
  }
}
</style>
