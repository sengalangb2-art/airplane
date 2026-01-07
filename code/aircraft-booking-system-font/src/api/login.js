import request from "@/utils/request";

export function login(params) {
  return request({
    url: "/yonghu/login",
    method: "get",
    params: {
      ...params,
      role: "yonghu",
      t: new Date().getTime(),
    },
  });
}

export function session() {
  return request({
    url: "/yonghu/session",
    method: "get",
    params: {
      t: new Date().getTime(),
    },
  });
}

export function register(data) {
  return request({
    url: "/yonghu/register",
    method: "post",
    data,
  });
}
