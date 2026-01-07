import request from "@/utils/request";

export function session() {
  return request({
    url: "/users/session",
    method: "get"
  });
}