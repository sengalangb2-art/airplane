<template>
  <div>
    <div class="flex align-center justify-between m-b-25 search">
      <el-form
        ref="form"
        class="flex"
        inline
        :mode="formData">
        <el-form-item
          label="航班名称:"
          class="m-r-30">
          <el-input
            v-model="formData.jipiaoName"
            placeholder="请输入航班名称"
            clearable></el-input>
        </el-form-item>
        <el-form-item
          label="出发地点:"
          class="m-r-30">
          <el-input
            v-model="formData.jipiaoChufadi"
            placeholder="请输入出发地点"
            clearable></el-input>
        </el-form-item>
        <el-form-item
          label="目的地点:"
          class="m-r-30">
          <el-input
            v-model="formData.jipiaoMudidi"
            placeholder="请输入目的地点"
            clearable></el-input>
        </el-form-item>
        <el-form-item
          label="航班类型:"
          class="m-r-30">
          <el-select
            v-model="formData.jipiaoTypes"
            style="width: 200px"
            clearable
            placeholder="请选择航班类型">
            <el-option
              v-for="item in dictionary"
              :key="item.id"
              :label="item.indexName"
              :value="item.codeIndex"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item
          label="航班状态:"
          class="m-r-30">
          <el-select
            v-model="formData.hangbanTypes"
            clearable
            style="width: 200px"
            placeholder="请选择航班状态">
            <el-option
              v-for="item in nums"
              :key="item.id"
              :label="item.indexName"
              :value="item.codeIndex"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div class="flex align-center">
        <el-button
          type="primary"
          plain
          @click="onSearch"
          >搜索</el-button
        >
        <el-button
          type="danger"
          plain
          @click="onReset"
          >重置</el-button
        >
      </div>
    </div>

    <Air :list="recruitData" />

    <div class="more">
      <span @click="onGetMore">{{ formatMore }}</span>
    </div>
  </div>
</template>

<script setup>
  import dayjs from 'dayjs';
  import router from '@/router';
  import { getAirList, getDictionaryList } from '@/api/company';
  import Air from '../home/components/air.vue';

  const dictionary = ref([]);
  const nums = ref([]);

  const form = ref(null);
  const formData = ref({
    jipiaoTypes: '',
    hangbanTypes: '',
    jipiaoName: '',
    jipiaoChufadi: '',
    jipiaoMudidi: '',
  });
  const pageSize = ref(10);
  const totalCount = ref(0);
  const recruitData = ref([]);

  const formatMore = computed(() => {
    return pageSize.value < totalCount.value ? '加载更多' : '没有更多了~';
  });

  async function initData() {
    const params = {
      page: 1,
      limit: pageSize.value,
      sort: 'id',
      order: 'desc',
      jipiaoDelete: 1,
      shangxiaTypes: 1,
      jipiaoName: formData.value.jipiaoName,
      jipiaoPhoto: '',
      jipiaoTypes: formData.value.jipiaoTypes,
      jipiaoChufadi: formData.value.jipiaoChufadi,
      jipiaoMudidi: formData.value.jipiaoMudidi,
      hangbanTypes: formData.value.hangbanTypes,
      jipiaoContent: '',
      t: new Date().getTime(),
    };
    const { data: dictionaryRes } = await getDictionaryList({
      page: 1,
      limit: 999,
      order: 'desc',
      sort: '',
      dicCode: 'jipiao_types',
      t: new Date().getTime(),
    });
    dictionary.value = dictionaryRes.list;
    const { data: hangbanTypes } = await getDictionaryList({
      page: 1,
      limit: 999,
      order: 'desc',
      sort: '',
      dicCode: 'hangban_types',
      t: new Date().getTime(),
    });
    nums.value = hangbanTypes.list;

    const { data } = await getAirList(params);
    recruitData.value = data.list;
    totalCount.value = data.total;
  }

  function onGetDel(id) {
    router.push({
      name: 'Position',
      query: {
        id,
      },
    });
  }

  function onSearch() {
    initData();
  }

  function onReset() {
    formData.value = {
      jipiaoTypes: '',
      hangbanTypes: '',
      jipiaoName: '',
      jipiaoChufadi: '',
      jipiaoMudidi: '',
    };
    initData();
  }

  function onGetMore() {
    if (pageSize.value >= totalCount.value) return;
    pageSize.value += 10;
    initData();
  }

  initData();
</script>

<style lang="scss" scoped>
  .search {
    padding: 20px 4vw 0;
  }

  .more {
    text-align: center;
    margin-top: 10px;
    font-size: 16px;
    color: #848484;
    margin-bottom: 20px;

    span {
      position: relative;
      cursor: pointer;

      &::before {
        content: '';
        position: absolute;
        top: 50%;
        left: -120%;
        transform: translateY(-50%);
        width: 100%;
        height: 2px;
        background-color: #848484;
        opacity: 0.2;
      }

      &::after {
        content: '';
        position: absolute;
        top: 50%;
        right: -120%;
        transform: translateY(-50%);
        width: 100%;
        height: 2px;
        background-color: #848484;
        opacity: 0.2;
      }
    }
  }
</style>
