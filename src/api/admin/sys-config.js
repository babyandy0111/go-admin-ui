import request from '@/utils/request'

// 查询参数列表
export function listConfig(query) {
  return request({
    url: '/api/v1/config',
    method: 'get',
    params: query
  })
}

// 查询参数詳细
export function getConfig(configId) {
  return request({
    url: '/api/v1/config/' + configId,
    method: 'get'
  })
}

// 根據参数鍵值查询参数值
export function getConfigKey(configKey) {
  return request({
    url: '/api/v1/configKey/' + configKey,
    method: 'get'
  })
}

// 新增参数設定
export function addConfig(data) {
  return request({
    url: '/api/v1/config',
    method: 'post',
    data: data
  })
}

// 修改参数設定
export function updateConfig(data) {
  return request({
    url: '/api/v1/config/' + data.id,
    method: 'put',
    data: data
  })
}

// 刪除参数設定
export function delConfig(data) {
  return request({
    url: '/api/v1/config',
    method: 'delete',
    data: data
  })
}

export function getSetConfig(query) {
  return request({
    url: '/api/v1/set-config',
    method: 'get'
  })
}

export function updateSetConfig(data) {
  return request({
    url: '/api/v1/set-config',
    method: 'put',
    data: data
  })
}
