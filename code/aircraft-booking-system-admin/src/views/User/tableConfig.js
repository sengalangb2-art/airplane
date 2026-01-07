import { ref } from "vue";

export const userTableConfig = [
  {
    prop: "username",
    label: "账号",
  },
  {
    prop: "yonghuName",
    label: "姓名",
  },
  {
    prop: "yonghuPhoto",
    label: "头像",
    slot: true,
    slotName: "yonghuPhoto",
  },
  {
    prop: "sexValue",
    label: "性别",
  },
  {
    prop: "yonghuIdNumber",
    label: "身份证号",
  },
  {
    prop: "yonghuPhone",
    label: "手机号",
  },
  {
    prop: "newMoney",
    label: "余额",
    formatter: (row) => {
      return row + "元";
    },
  },
  {
    prop: "password",
    label: "重置密码",
    slot: true,
    slotName: "password",
  },
  {
    slot: true,
    label: "操作",
    slotName: "handle",
  },
];

export const userSearchConfig = ref([
  {
    type: "input",
    title: "账号",
    id: "username",
    placeholder: "请输入账号查询",
  },
  {
    type: "input",
    title: "姓名",
    id: "yonghuName",
    placeholder: "请输入姓名查询",
  },
  {
    type: "select",
    id: "sexTypes",
    title: "性别",
    placeholder: "请选择性别",
    options: [],
  },
]);

export const userEditFormConfig = ref([
  {
    type: "input",
    label: "账号",
    id: "username",
  },
  {
    type: "input",
    label: "密码",
    id: "password",
    inputType: "password",
  },
  {
    type: "input",
    label: "姓名",
    id: "yonghuName",
  },
  {
    type: "select",
    label: "性别",
    id: "sexTypes",
    placeholder: "请选择性别",
    options: [],
  },
  {
    type: "upload",
    label: "头像",
    id: "yonghuPhoto",
  },
  {
    type: "input",
    label: "身份证号",
    id: "yonghuIdNumber",
  },
  {
    type: "input",
    label: "手机号",
    id: "yonghuPhone",
  },
  {
    type: "input",
    label: "余额",
    id: "newMoney",
    inputType: "number",
  },
]);

export const typeTableConfig = [
  {
    prop: "indexName",
    label: "新闻类型",
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
    label: "新闻类型KeyCode：",
    id: "codeIndex",
  },
  {
    type: "input",
    label: "新闻类型名称：",
    id: "indexName",
  },
  {
    type: "input",
    label: "备注：",
    id: "beizhu",
  },
]);
