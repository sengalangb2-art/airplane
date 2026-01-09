import request from '@/utils/request';

export function getAirDetail(id) {
  return request({
    url: `/jipiao/detail/${id}`,
    method: 'get',
  });
}

export function getCollection(params) {
  return request({
    url: `/jipiaoCollection/list`,
    method: 'get',
    params,
  });
}

export function postCollection(data) {
  return request({
    url: `/jipiaoCollection/add`,
    method: 'post',
    data,
  });
}

export function postAirOrder(data) {
  return request({
    url: `/jipiaoOrder/add`,
    method: 'post',
    data,
  });
}

// 调用支付宝支付接口
export function alipayOrder(id) {
  return request({
    url: `/jipiaoOrder/alipay/${id}`,
    method: 'get',
  });
}

// 查询订单支付状态
export function getOrderPayStatus(id) {
  return request({
    url: `/jipiaoOrder/payStatus/${id}`,
    method: 'get'
  });
}

// 更新订单支付状态
export function updateOrderPayStatus(data) {
  return request({
    url: `/jipiaoOrder/updatePayStatus`,
    method: 'post',
    params: data
  });
  }
// 模拟支付接口
export function simulatePayOrder(id) {
  return request({
    url: `/jipiaoOrder/pay`,
    method: 'post',
    data: id,
    headers: {
      'Content-Type': 'application/json'
    }
  });
}