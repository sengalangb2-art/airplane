<template>
  <div style="border: 1px solid #ccc">
    <Toolbar
      style="border-bottom: 1px solid #ccc"
      :editor="editorRef"
      :mode="mode"
    />
    <Editor
      style="height: 500px; overflow-y: hidden"
      v-model="valueHtml"
      :defaultConfig="editorConfig"
      :mode="mode"
      @onCreated="handleCreated"
    />
  </div>
</template>

<script setup>
import "@wangeditor/editor/dist/css/style.css"; // 引入 css
import { onBeforeUnmount, ref, shallowRef, watch, watchEffect } from "vue";
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";
// import { Boot, IModuleConf, SlateElement } from "@wangeditor/editor";
import { ElMessage } from "element-plus";

const baseUrl =
  import.meta.env.VITE_APP_BASE_IP + import.meta.env.VITE_APP_BASE_URL + "/";
const lineUrl = baseUrl + "upload";

let insertImgsList = [];

const props = defineProps({
  modalValue: {
    type: String,
    default: "",
  },
});

const emits = defineEmits(["update:modalValue", "deleteImg", 'change']);

// 编辑器实例，必须用 shallowRef
const editorRef = shallowRef();

// 内容 HTML
const valueHtml = ref("");

watchEffect(() => {
  valueHtml.value = props.modalValue;
});

watch(valueHtml, (val) => {
  emits("update:modalValue", val);
  emits('change', val)
});

const editorConfig = {
  placeholder: "请输入内容...",
  MENU_CONF: {
    uploadImage: {
      maxFileSize: 100 * 1024 * 1024, // 1M
      server: baseUrl + "file/upload",
      fieldName: "file",
      // 自定义插入图片
      customInsert(res, insertFn) {
        if (res.code !== 0) {
          ElMessage.error("上传失败");
          return;
        }
        const url = lineUrl + res.file;
        insertFn(url);
      },
    },
    uploadVideo: {
      fieldName: "file",
      maxFileSize: 500 * 1024 * 1024, // 5M
      maxNumberOfFiles: 3,
      allowedFileTypes: ["video/*"],
      server: baseUrl + "file/upload",
      timeout: 15 * 1000, // 15 秒
      customInsert(res, insertFn) {
        if (res.code !== 0) {
          ElMessage.error("上传失败");
          return;
        }
        const url = lineUrl + res.file;
        insertFn(url);
      },
    },
    insertImage: {
      onInsertedImage(imageNode) {
        if (imageNode == null) return;
        const { src } = imageNode;
        insertImgsList.push(src);
      },
    },
  },
};

const handleCreated = (editor) => {
  editorRef.value = editor; // 记录 editor 实例，重要！
};

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
  const editor = editorRef.value;
  if (editor == null) return;
  editor.destroy();
});

const getUploadImgs = () => {
  const editor = editorRef.value;
  const imgs = editor.getElemsByType("image").map((i) => i.src);
  const result = insertImgsList.filter((item) => !imgs.includes(item));
  const deleteImg = result.map((i) => i.replace(lineUrl, ""));
  if (!deleteImg.length) return;
  emits("deleteImg", deleteImg);
};

defineExpose({
  getUploadImgs,
});

const mode = "default"; // 或 'simple'
</script>
