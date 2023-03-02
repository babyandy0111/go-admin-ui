import request from '@/utils/request'

// 查詢Account列表
export function listAccount(query) {
  return request({
    url: '/api/v1/account',
    method: 'get',
    params: query
  })
}

// 查詢Account詳細
export function getAccount(id) {
  return request({
    url: '/api/v1/account/' + id,
    method: 'get'
  })
}

// 新增Account
export function addAccount(data) {
  return request({
    url: '/api/v1/account',
    method: 'post',
    data: data
  })
}

// 更新Account
export function updateAccount(data) {
  return request({
    url: '/api/v1/account/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除Account
export function delAccount(data) {
  return request({
    url: '/api/v1/account',
    method: 'delete',
    data: data
  })
}

