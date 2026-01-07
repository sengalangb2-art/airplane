import { ref } from "vue";

export const newsTableConfig = [
  {
    prop: "newsName",
    label: "新闻标题",
  },
  {
    prop: "newsValue",
    label: "新闻类型",
  },
  {
    prop: "createTime",
    label: "创建时间",
  },
  {
    prop: "newsPhoto",
    label: "封面",
    slot: true,
    slotName: "newsPhoto",
  },
  {
    prop: "newsContent",
    label: "新闻内容",
    slot: true,
    slotName: "newsContent",
  },
  {
    slot: true,
    label: "操作",
    slotName: "handle",
  },
];

export const newsSearchConfig = ref([
  {
    type: "input",
    title: "新闻标题",
    id: "newsName",
    placeholder: "请输入新闻标题",
  },
  {
    type: "select",
    id: "newsTypes",
    title: "新闻类型",
    placeholder: "请选择新闻类型",
    options: [],
  },
]);

export const newsEditFormConfig = ref([
  {
    type: "input",
    label: "新闻标题",
    id: "newsName",
  },
  {
    type: "select",
    label: "新闻类型",
    id: "newsTypes",
    placeholder: "请选择新闻类型",
    options: [],
  },
  {
    type: "upload",
    label: "新闻封面",
    id: "newsPhoto",
  },
  {
    type: "textarea",
    label: "新闻内容",
    id: "newsContent",
  }
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
