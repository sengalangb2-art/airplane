import request from '@/utils/request';

export function getAirCollection(params) {
  return request({
    url: '/jipiaoCollection/list',
    method: 'get',
    params,
  });
}

export function deleteAirCollection(ids) {
  return request({
    url: '/jipiaoCollection/delete',
    method: 'post',
    data: ids,
  });
}

export function getAirOrder(params) {
  return request({
    url: '/jipiaoOrder/list',
    method: 'get',
    params,
  });
}

export function getAirOrderType(params) {
  return request({
    url: '/dictionary/page',
    method: 'get',
    params,
  });
}

// 取票
export function getAirOrderReceiving(params) {
  return request({
    url: '/jipiaoOrder/receiving',
    method: 'get',
    params,
  });
}

// 退票
export function getAirOrderRefund(params) {
  return request({
    url: '/jipiaoOrder/refund',
    method: 'get',
    params,
  });
}

// 更新用户信息
export function updateUser(data) {
  return request({  
    url: '/yonghu/update',
    method: 'post',
    data,
  });
}
