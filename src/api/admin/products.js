import request from '@/utils/request'

// 查询Products列表
export function listProducts(query) {
  return request({
    url: '/api/v1/products',
    method: 'get',
    params: query
  })
}

// 查询Products詳细
export function getProducts(id) {
  return request({
    url: '/api/v1/products/' + id,
    method: 'get'
  })
}

// 新增Products
export function addProducts(data) {
  return request({
    url: '/api/v1/products',
    method: 'post',
    data: data
  })
}

// 修改Products
export function updateProducts(data) {
  return request({
    url: '/api/v1/products/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除Products
export function delProducts(data) {
  return request({
    url: '/api/v1/products',
    method: 'delete',
    data: data
  })
}

