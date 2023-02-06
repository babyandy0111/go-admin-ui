import request from '@/utils/request'

// 獲取验证码
export function getCodeImg() {
  return request({
    url: '/api/v1/captcha',
    method: 'get'
  })
}

// 查询 此接口不在验证資料權限
export function getSetting() {
  return request({
    url: '/api/v1/app-config',
    method: 'get'
  })
}
