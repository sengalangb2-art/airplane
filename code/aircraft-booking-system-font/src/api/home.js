import request from '@/utils/request';

export function getNewsList(params) {
  return request({
    url: '/news/list',
    method: 'get',
    params
  });
}

export function getFlightInformation(params) {
  return request({
    url: '/jipiao/gexingtuijian',
    method: 'get',
    params
  });
}

export function getNewsDetailById(id) {
  return request({
    url: `/news/detail/${id}`,
    method: 'get',
    params: {
      t: new Date().getTime()
    }
  });
}

export function getDictionaryNewsPage(params) {
  return request({
    url: `/dictionary/page`,
    method: 'get',
    params
  });
}


