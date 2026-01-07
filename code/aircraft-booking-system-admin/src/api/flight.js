import request from "@/utils/request";

export function getFlightPage(params) {
  return request({
    url: `/jipiao/page`,
    method: "get",
    params,
  });
}

export function getFlightType(params) {
  return request({
    url: `/dictionary/page`,
    method: "get",
    params,
  });
}

export function getFlightMaxCodeIndex(data) {
  return request({
    url: `/dictionary/maxCodeIndex`,
    method: "post",
    data,
  });
}

// 航班详情
export function getFlightById(id) {
  return request({
    url: `/jipiao/info/${id}`,
    method: "get",
  });
}

// 航班类型详情
export function getFlightTypeById(id) {
  return request({
    url: `/dictionary/info/${id}`,
    method: "get",
  });
}

// 新增航班
export function saveFlight(data) {
  return request({
    url: `/jipiao/save`,
    method: "post",
    data,
  });
}

// 新增航班类型
export function saveFlightType(data) {
  return request({
    url: `/dictionary/save`,
    method: "post",
    data,
  });
}

// 修改航班
export function updateFlight(data) {
  return request({
    url: `/jipiao/update`,
    method: "post",
    data,
  });
}

// 修改航班类型
export function updateFlightType(data) {
  return request({
    url: `/dictionary/update`,
    method: "post",
    data,
  });
}

// 删除航班类型
export function deleteFlight(ids) {
  return request({
    url: `/jipiao/delete`,
    method: "post",
    data: ids,
  });
}

// 删除航班类型
export function deleteFlightType(ids) {
  return request({
    url: `/dictionary/delete`,
    method: "post",
    data: ids,
  });
}

export function cancelFlight(id) {
  return request({
    url: `/jipiao/quxiaohangban`,
    method: "get",
    params: {
      id,
    },
  });
}

// 机票订单
export function getOrderPage(params) {
  return request({
    url: `/jipiaoOrder/page`,
    method: "get",
    params,
  });
}

// 获取全部订单数据用于统计分析
export function getAllOrders(params) {
  return request({
    url: `/jipiaoOrder/page`,
    method: "get",
    params: {
      ...params,
      limit: 999, // 设置较大的限制以获取全部数据
      jipiaoOrderDelete: 1 // 默认获取未删除的数据
    },
  });
}

// 获取全部航班类型数据用于统计分析
export function getAllFlightTypes() {
  return request({
    url: `/dictionary/page`,
    method: "get",
    params: {
      page: 1,
      limit: 999,
      dicCode: 'jipiao_types'
    },
  });
}

// 机票订单出票
export function postOrderTicket(id) {
  return request({
    url: `/jipiaoOrder/deliver`,
    method: "post",
    params: {
      id,
    },
  });
}
