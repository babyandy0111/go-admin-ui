import request from '@/utils/request'

// 查询生成表資料
export function listTable(query) {
  return request({
    url: '/api/v1/sys/tables/page',
    method: 'get',
    params: query
  })
}
// 查询db資料库列表
export function listDbTable(query) {
  return request({
    url: '/api/v1/db/tables/page',
    method: 'get',
    params: query
  })
}

// 查询表详细訊息
export function getGenTable(tableId) {
  return request({
    url: '/api/v1/sys/tables/info/' + tableId,
    method: 'get'
  })
}

export function getGenTableInfo(tablename) {
  return request({
    url: '/api/v1/sys/tables?tableName=' + tablename,
    method: 'get'
  })
}

// 修改代碼生成訊息
export function updateGenTable(data) {
  return request({
    url: '/api/v1/sys/tables/info',
    method: 'put',
    data: data
  })
}

// 導入表
export function importTable(data) {
  return request({
    url: '/api/v1/sys/tables/info',
    method: 'post',
    params: data
  })
}
// 預覽生成代碼
export function previewTable(tableId) {
  return request({
    url: '/api/v1/gen/preview/' + tableId,
    method: 'get'
  })
}
// 删除表資料
export function delTable(tableId) {
  return request({
    url: '/api/v1/sys/tables/info/' + tableId,
    method: 'delete'
  })
}

// 生成代碼到项目
export function toProjectTable(tableId) {
  return request({
    url: '/api/v1/gen/toproject/' + tableId,
    method: 'get'
  })
}

// 生成接口資料到遷移脚本
export function apiToFile(tableId) {
  return request({
    url: '/api/v1/gen/apitofile/' + tableId,
    method: 'get'
  })
}

export function toProjectTableCheckRole(tableId, ischeckrole) {
  return request({
    url: '/api/v1/gen/toproject/' + tableId + '?ischeckrole=' + ischeckrole,
    method: 'get'
  })
}

// 生成選單到資料库
export function toDBTable(tableId) {
  return request({
    url: '/api/v1/gen/todb/' + tableId,
    method: 'get'
  })
}

export function getTableTree() {
  return request({
    url: '/api/v1/gen/tabletree',
    method: 'get'
  })
}
