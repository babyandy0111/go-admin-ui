import request from '@/utils/request'

// 查詢Quote列表
export function listQuote(query) {
  return request({
    url: '/api/v1/quote',
    method: 'get',
    params: query
  })
}

// 查詢Quote詳細
export function getQuote(id) {
  return request({
    url: '/api/v1/quote/' + id,
    method: 'get'
  })
}

// 新增Quote
export function addQuote(data) {
  return request({
    url: '/api/v1/quote',
    method: 'post',
    data: data
  })
}

// 更新Quote
export function updateQuote(data) {
  return request({
    url: '/api/v1/quote/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除Quote
export function delQuote(data) {
  return request({
    url: '/api/v1/quote',
    method: 'delete',
    data: data
  })
}

