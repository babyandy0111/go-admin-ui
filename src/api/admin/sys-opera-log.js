import request from '@/utils/request'

// 清空操作log
export function cleanOperlog() {
  return request({
    url: '/api/v1/operlog/clean',
    method: 'delete'
  })
}

// 查询SysOperlog列表
export function listSysOperlog(query) {
  return request({
    url: '/api/v1/sys-opera-log',
    method: 'get',
    params: query
  })
}

// 刪除SysOperlog
export function delSysOperlog(data) {
  return request({
    url: '/api/v1/sys-opera-log',
    method: 'delete',
    data: data
  })
}

