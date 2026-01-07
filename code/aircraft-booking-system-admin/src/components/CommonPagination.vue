<template>
  <el-pagination
    v-model:currentPage="pageNum"
    v-model:page-size="pageSize"
    :class="{ hiddenPage: hidden, myPage: true }"
    v-bind="$attrs"
    :page-sizes="pageSizes"
    :pager-count="pagerCount"
    background
    layout="total, prev, pager, next, sizes, jumper"
    :total="total"
    @size-change="onChange"
    @current-change="onChange"
  />
</template>

<script setup>
const props = defineProps({
  page: Number,
  limit: Number,
  total: Number,
  pagerCount: Number,
  pageSizes: {
    type: Array,
    default: () => [10, 20, 30, 50, 100, 500],
  },
});
const emits = defineEmits(["pagechange", "update:page", "update:limit"]);

const pageNum = computed({
  get: () => props.page,
  set: (val) => {
    emits("update:page", val);
  },
});

const pageSize = computed({
  get: () => props.limit,
  set: (val) => {
    emits("update:limit", val);
  },
});

const hidden = computed(() => props.total === 0);

const onChange = () => {
  emits("pagechange");
};
</script>

<style lang="scss" scoped>
$font-szie: 15px;

.myPage {
  margin-top: 20px;
}

.hiddenPage {
  display: none;
}

.el-pagination {
  --el-pagination-button-bg-color: #fff;
  --el-disabled-bg-color: #fff;
  padding: 0;

  :deep(.el-pagination__total) {
    margin-right: 14px !important;
    color: #8e99ad;
    font-size: $font-szie !important;
  }

  :deep(.el-pager) {
    li {
      border-radius: 4px;
      color: #000000;
      font-size: $font-szie !important;
    }

    .el-icon svg {
      color: #8e99ad;
    }
  }

  :deep(.el-select) {
    .el-input {
      font-size: $font-szie !important;

      .el-input__wrapper {
        padding: 3px;
        box-sizing: border-box;
      }
    }

    .el-input__suffix-inner > :first-child {
      margin-left: 4px;
    }
  }

  :deep(.el-pagination__editor) {
    min-width: 48px;
  }

  :v-deep(.el-pagination__editor) .el-input {
    width: 48px !important;
  }

  :deep(.el-pagination__sizes) {
    margin: 0 0 0 12px !important;
  }

  :deep(.el-pagination__jump) {
    margin-left: 12px;
    color: #8e99ad;
    font-size: $font-szie !important;
  }

  // :deep(.btn-prev) {
  //   // @include bg('/sel-suffix.png');
  //   transform: rotateZ(90deg);

  //   .el-icon {
  //     width: 20px;
  //     height: 20px;

  //     svg {
  //       display: none !important;
  //     }
  //   }
  // }

  // :deep(.btn-next) {
  //   // @include bg('/sel-suffix.png');
  //   transform: rotateZ(-90deg);

  //   .el-icon {
  //     width: 20px;
  //     height: 20px;

  //     svg {
  //       display: none !important;
  //     }
  //   }
  // }

  // :deep(.el-select__icon) {
  //   width: 20px !important;
  //   height: 20px !important;
  //   // @include bg('/sel-suffix.png');

  //   svg {
  //     display: none;
  //   }
  // }
}
</style>
