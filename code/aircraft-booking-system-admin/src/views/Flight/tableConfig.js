import { ref } from "vue";

export const flightTableConfig = [
  {
    prop: "jipiaoName",
    label: "航班名称",
  },
  {
    prop: "jipiaoValue",
    label: "航班类型",
  },
  {
    prop: "jipiaoChufadi",
    label: "出发地",
  },
  {
    prop: "jipiaoMudidi",
    label: "目的地",
  },
  {
    prop: "jipiaoTime",
    label: "出发时间",
  },
  {
    prop: "jipiaoArrivalTime",
    label: "到达时间",
  },
  {
    prop: "jipiaoNewMoney",
    label: "经济舱价格",
    formatter: (row) => {
      return row + "元";
    },
  },
  {
    prop: "jipiaoFirstMoney",
    label: "头等舱价格",
    formatter: (row) => {
      return (row || 0) + "元";
    },
  },
  {
    prop: "zuoweiNumber",
    label: "座位数量",
    formatter: (row) => {
      return row + "个";
    },
  },
  {
    prop: "hangbanValue",
    label: "航班状态",
    slot: true,
    slotName: "hangbanValue",
  },
  {
    slot: true,
    label: "操作",
    slotName: "handle",
  },
];

export const flightSearchConfig = ref([
  {
    type: "input",
    title: "航班名称",
    id: "jipiaoName",
    placeholder: "请输入航班名称",
  },
  {
    type: "input",
    title: "出发地",
    id: "jipiaoChufadi",
    placeholder: "请输入出发地查询",
  },
  {
    type: "input",
    title: "目的地",
    id: "jipiaoMudidi",
    placeholder: "请输入目的地查询",
  },
  {
    type: "select",
    id: "jipiaoTypes",
    title: "航班类型",
    placeholder: "请选择航班类型",
    options: [],
  },
  {
    type: "select",
    id: "hangbanTypes",
    title: "航班状态",
    placeholder: "请选择航班状态",
    options: [],
  },
]);

export const flightEditFormConfig = ref([
  {
    type: "input",
    label: "航班名称",
    id: "jipiaoName",
  },
  {
    type: "select",
    label: "航班类型",
    id: "jipiaoTypes",
    placeholder: "请选择航班类型",
    options: [],
  },
  {
    type: "date",
    label: "出发时间",
    id: "jipiaoTime",
  },
  {
    type: "date",
    label: "到达时间",
    id: "jipiaoArrivalTime",
  },
  {
    type: "upload",
    label: "图片",
    id: "jipiaoPhoto",
  },
  {
    type: "input",
    label: "出发地",
    id: "jipiaoChufadi",
  },
  {
    type: "input",
    label: "目的地",
    id: "jipiaoMudidi",
  },
  // === 新增/修改字段 ===
  {
    type: "input",
    label: "经济舱价格",
    id: "jipiaoNewMoney",
    inputType: "number",
  },
  {
    type: "input",
    label: "头等舱价格",
    id: "jipiaoFirstMoney",
    inputType: "number",
  },
  {
    type: "input",
    label: "头等舱座位数(前N个)",
    id: "jipiaoFirstNum",
    inputType: "number",
    placeholder: "例如: 10, 代表1-10号为头等舱",
  },
  // ===================
  {
    type: "input",
    label: "总座位数量",
    id: "zuoweiNumber",
    inputType: "number",
  },
  {
    type: "select",
    label: "航班状态",
    id: "hangbanTypes",
    placeholder: "请选择航班状态",
    options: [],
  },
  {
    type: "select",
    label: "上架状态",
    id: "shangxiaTypes",
    placeholder: "请选择上架状态",
    options: [],
  },
]);

export const typeTableConfig = [
  {
    prop: "indexName",
    label: "航班类型",
  },
  {
    prop: "codeIndex",
    label: "keyCode",
  },
  {
    prop: "createTime",
    label: "创建时间",
  },
  {
    prop: "beizhu",
    label: "备注",
    formatter: (row) => {
      return row || "无";
    },
  },
  {
    slot: true,
    label: "操作",
    slotName: "handle",
  },
];

export const typeEditFormConfig = ref([
  {
    type: "text",
    label: "航班类型KeyCode：",
    id: "codeIndex",
  },
  {
    type: "input",
    label: "航班类型名称：",
    id: "indexName",
  },
  {
    type: "input",
    label: "备注：",
    id: "beizhu",
  },
]);

export const orderTableConfig = [
  {
    prop: "jipiaoName",
    label: "航班名称",
  },
  {
    prop: "jipiaoValue",
    label: "航班类型",
  },
  {
    prop: "jipiaoChufadi",
    label: "出发地",
  },
  {
    prop: "jipiaoMudidi",
    label: "目的地",
  },
  {
    prop: "jipiaoTime",
    label: "登机时间",
  },
  {
    prop: "jipiaoOrderUuidNumber",
    label: "订单号",
  },
  {
    prop: "yonghuName",
    label: "乘客姓名",
  },
  {
    prop: "yonghuIdNumber",
    label: "乘客身份证",
  },
  {
    prop: "yonghuPhone",
    label: "乘客电话",
  },
  {
    prop: "yonghuPhoto",
    label: "乘客照片",
    slot: true,
    slotName: "yonghuPhoto",
  },
  {
    prop: "buyZuoweiNumber",
    label: "座位号",
  },
  {
    prop: "jipiaoOrderTruePrice",
    label: "订单金额",
    formatter: (row) => {
      return row + "元";
    },
  },
  {
    prop: "jipiaoOrderValue",
    label: "订单状态",
    slot: true,
    slotName: "jipiaoOrderValue",
  },
  {
    slot: true,
    label: "操作",
    slotName: "handle",
  },
];
