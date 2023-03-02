import request from '@/utils/request'

// 查詢CompanyType列表
export function listCompanyType(query) {
  return request({
    url: '/api/v1/company-type',
    method: 'get',
    params: query
  })
}

// 查詢CompanyType詳細
export function getCompanyType(id) {
  return request({
    url: '/api/v1/company-type/' + id,
    method: 'get'
  })
}

// 新增CompanyType
export function addCompanyType(data) {
  return request({
    url: '/api/v1/company-type',
    method: 'post',
    data: data
  })
}

// 更新CompanyType
export function updateCompanyType(data) {
  return request({
    url: '/api/v1/company-type/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除CompanyType
export function delCompanyType(data) {
  return request({
    url: '/api/v1/company-type',
    method: 'delete',
    data: data
  })
}

