import request from '@/utils/request'

// 查询職位列表
export function listPost(query) {
  return request({
    url: '/api/v1/post',
    method: 'get',
    params: query
  })
}

// 查询職位详细
export function getPost(postId) {
  return request({
    url: '/api/v1/post/' + postId,
    method: 'get'
  })
}

// 新增職位
export function addPost(data) {
  return request({
    url: '/api/v1/post',
    method: 'post',
    data: data
  })
}

// 修改職位
export function updatePost(data, id) {
  return request({
    url: '/api/v1/post/' + id,
    method: 'put',
    data: data
  })
}

// 删除職位
export function delPost(postId) {
  return request({
    url: '/api/v1/post',
    method: 'delete',
    data: postId
  })
}

