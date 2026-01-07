import request from "@/utils/request";

// 获取新闻列表
export function getNewsPage(params) {
  return request({
    url: `/news/page`,
    method: "get",
    params,
  });
}

// 获取新闻类型列表
export function getNewsType(params) {
  return request({
    url: `/dictionary/page`,
    method: "get",
    params,
  });
}

// 获取新闻最大的codeIndex
export function getNewsMaxCodeIndex(data) {
  return request({
    url: `/dictionary/maxCodeIndex`,
    method: "post",
    data,
  });
}

// 新闻详情
export function getNewsById(id) {
  return request({
    url: `/news/info/${id}`,
    method: "get",
  });
}

// 新闻类型详情
export function getNewsTypeById(id) {
  return request({
    url: `/dictionary/info/${id}`,
    method: "get",
  });
}

// 新增新闻
export function saveNews(data) {
  return request({
    url: `/news/save`,
    method: "post",
    data,
  });
}

// 新增新闻类型
export function saveNewsType(data) {
  return request({
    url: `/dictionary/save`,
    method: "post",
    data,
  });
}

// 修改新闻
export function updateNews(data) {
  return request({
    url: `/news/update`,
    method: "post",
    data,
  });
}

// 修改新闻类型
export function updateNewsType(data) {
  return request({
    url: `/dictionary/update`,
    method: "post",
    data,
  });
}

// 删除新闻类型
export function deleteNews(ids) {
  return request({
    url: `/news/delete`,
    method: "post",
    data: ids,
  });
  
}
// 删除新闻类型
export function deleteNewsType(ids) {
  return request({
    url: `/dictionary/delete`,
    method: "post",
    data: ids,
  });
}

