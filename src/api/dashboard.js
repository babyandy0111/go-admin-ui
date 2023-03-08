import request from '@/utils/request'

export function getSalesByM(query) {
  return request({
    url: '/api/v1/dashboard/GetSalesByM',
    method: 'get',
    params: query
  })
}

export function getSalesTop15(query) {
  return request({
    url: '/api/v1/dashboard/GetSalesTop15',
    method: 'get',
    params: query
  })
}

export function getSalesByMAccount(query) {
  return request({
    url: '/api/v1/dashboard/GetSalesByMAccount',
    method: 'get',
    params: query
  })
}

export function getSalesByProduct(query) {
  return request({
    url: '/api/v1/dashboard/GetSalesByProduct',
    method: 'get',
    params: query
  })
}

// 新增Article
export function addArticle(data) {
  return request({
    url: '/api/v1/article',
    method: 'post',
    data: data
  })
}

// 更新Article
export function updateArticle(data) {
  return request({
    url: '/api/v1/article/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除Article
export function delArticle(data) {
  return request({
    url: '/api/v1/article',
    method: 'delete',
    data: data
  })
}

