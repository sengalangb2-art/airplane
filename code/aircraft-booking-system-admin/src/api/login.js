import request from "@/utils/request";

export function login(params) {
  return request({
    url: "/users/login",
    method: "post",
    params,
  });
}

export function session() {
  return request({
    url: "/users/session",
    method: "get"
  });
}
