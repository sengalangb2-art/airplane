import { ElMessageBox } from "element-plus";

export const messageBox = (config) => {
  const { message, title, ...rest } = config;
  return new Promise((resolve) => {
    ElMessageBox.confirm(message, title, {
      ...rest,
    })
      .then(() => {
        resolve(true);
      })
      .catch(() => {
        resolve(false);
      });
  });
};
