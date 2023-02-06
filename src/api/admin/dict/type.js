import request from '@/utils/request'

// 查询字典類型列表
export function listType(query) {
  return request({
    url: '/api/v1/dict/type',
    method: 'get',
    params: query
  })
}

// 查询字典類型详细
export function getType(dictId) {
  return request({
    url: '/api/v1/dict/type/' + dictId,
    method: 'get'
  })
}

// 新增字典類型
export function addType(data) {
  return request({
    url: '/api/v1/dict/type',
    method: 'post',
    data: data
  })
}

// 修改字典類型
export function updateType(data) {
  return request({
    url: '/api/v1/dict/type/' + data.id,
    method: 'put',
    data: data
  })
}

// 删除字典類型
export function delType(dictId) {
  return request({
    url: '/api/v1/dict/type',
    method: 'delete',
    data: dictId
  })
}

// 匯出字典類型
export function exportType(query) {
  return request({
    url: '/api/v1/dict/type/export',
    method: 'get',
    params: query
  })
}

// 獲取字典選擇框列表
export function optionselect() {
  return request({
    url: '/api/v1/dict/type-option-select',
    method: 'get'
  })
}
