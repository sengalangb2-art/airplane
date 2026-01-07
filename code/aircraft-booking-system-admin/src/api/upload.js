import request from "@/utils/request";

export function upload(file) {
  const data = new FormData();
  data.append("file", file);
  return request({
    url: `/file/upload`,
    headers: {
      "Content-Type": "multipart/form-data",
    },
    method: "post",
    data,
  });
}
