import request from '@/utils/request'

// 查詢Currency列表
export function listCurrency(query) {
  return request({
    url: '/api/v1/currency',
    method: 'get',
    params: query
  })
}

// 查詢Currency詳細
export function getCurrency(id) {
  return request({
    url: '/api/v1/currency/' + id,
    method: 'get'
  })
}

// 新增Currency
export function addCurrency(data) {
  return request({
    url: '/api/v1/currency',
    method: 'post',
    data: data
  })
}

// 更新Currency
export function updateCurrency(data) {
  return request({
    url: '/api/v1/currency/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除Currency
export function delCurrency(data) {
  return request({
    url: '/api/v1/currency',
    method: 'delete',
    data: data
  })
}

