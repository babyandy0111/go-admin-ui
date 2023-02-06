import request from '@/utils/request'

// 查询服務器详细
export function getServer() {
  return request({
    url: '/api/v1/server-monitor',
    method: 'get'
  })
}
