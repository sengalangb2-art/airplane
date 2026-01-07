import request from "@/utils/request";

// 用户列表
export function getUserPage(params) {
  return request({
    url: `/yonghu/page`,
    method: "get",
    params,
  });
}

// 用户详情
export function getUserById(id) {
  return request({
    url: `/yonghu/info/${id}`,
    method: "get",
  });
}

// 新增用户
export function saveUser(data) {
  return request({
    url: `/yonghu/save`,
    method: "post",
    data,
  });
}

// 修改用户
export function updateUser(data) {
  return request({
    url: `/yonghu/update`,
    method: "post",
    data,
  });
}

// 删除用户
export function deleteUser(ids) {
  return request({
    url: `/yonghu/delete`,
    method: "post",
    data: ids,
  });
}

// 重置密码
export function resetPassword(id) {
  return request({
    url: `/yonghu/resetPassword`,
    method: "get",
    params: {
      id,
    },
  });
}

// 性别列表
export function getSex() {
  return request({
    url: `/dictionary/page`,
    method: "get",
    params: {
      dicCode: "sex_types",
      page: 1,
      limit: 9999,
    },
  });
}
