import request from '@/utils/request';

export function getAirList(params) {
  return request({
    url: '/jipiao/list',
    method: 'get',
    params,
  });
}

export function getDictionaryList(params) {
  return request({
    url: '/dictionary/page',
    method: 'get',
    params,
  });
}
