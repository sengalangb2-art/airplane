<template>
  <div class="common-table">
    <template v-if="tableData.length">
      <el-table :data="tableData" v-bind="$attrs" :border="border">
        <el-table-column
          v-if="showIndex"
          type="index"
          label="序号"
          width="56"
        />
        <el-table-column type="expand" v-if="expand">
          <template #default="scope">
            <slot name="expand" :row="scope.row" />
          </template>
        </el-table-column>
        <el-table-column
          v-for="(item, index) in columns"
          :key="index"
          :prop="item.prop"
          :label="item.label"
          :width="item.width"
          :align="item.align"
          :fixed="item.fixed"
          show-overflow-tooltip
        >
          <template #default="scope">
            <span v-if="!item.custom">{{ scope.row[item.prop] }}</span>
            <slot v-else :name="'column-' + item.prop" :row="scope.row" />
          </template>
        </el-table-column>
      </el-table>
    </template>
    <Empty v-else />
  </div>
</template>

<script setup>
const props = defineProps({
  data: {
    type: Array,
    default: () => [],
  },
  showIndex: {
    type: Boolean,
    default: false,
  },
  columns: {
    type: Array,
    default: () => [],
  },
  border: {
    type: Boolean,
    default: false,
  },
  expand: {
    type: Boolean,
    default: false,
  },
});

const tableData = computed(() => props.data);
</script>

<style scoped lang="scss">
.common-table {
  ::v-deep(.el-table--border .el-table__cell) {
    border-right: none;
  }

  ::v-deep(.el-table) {
    border-radius: 5px;

    th {
      border-right: 0;

      &:not(:last-child):after {
        content: "";
        position: absolute;
        right: 1px;
        height: 20px;
        width: 1px;
        top: 50%;
        transform: translateY(-50%);
        background: rgb(165, 154, 162);
        opacity: 0;
        transition: all 0.3s ease-out;
      }
    }

    .el-table__cell {
      font-size: 15px;
      font-weight: 500;
      z-index: 0;
    }

    .el-table__header:hover {
      th {
        &::after {
          opacity: 1;
          transition: all 0.3s ease-out;
        }
      }
    }
  }
}
</style>
