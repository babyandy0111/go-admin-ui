<template>
  <el-form ref="form" :model="user" :rules="rules" label-width="80px">
    <el-form-item label="旧密碼" prop="oldPassword">
      <el-input v-model="user.oldPassword" placeholder="請輸入旧密碼" type="password" />
    </el-form-item>
    <el-form-item label="新密碼" prop="newPassword">
      <el-input v-model="user.newPassword" placeholder="請輸入新密碼" type="password" />
    </el-form-item>
    <el-form-item label="確認密碼" prop="confirmPassword">
      <el-input v-model="user.confirmPassword" placeholder="請確認密碼" type="password" />
    </el-form-item>
    <el-form-item>
      <el-button type="primary" size="mini" @click="submit">保存</el-button>
      <el-button type="danger" size="mini" @click="close">關閉</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { updateUserPwd } from '@/api/admin/sys-user'

export default {
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.user.newPassword !== value) {
        callback(new Error('两次输入的密碼不一致'))
      } else {
        callback()
      }
    }
    return {
      test: '1test',
      user: {
        oldPassword: undefined,
        newPassword: undefined,
        confirmPassword: undefined
      },
      // 表單校验
      rules: {
        oldPassword: [
          { required: true, message: '旧密碼不能為空', trigger: 'blur' }
        ],
        newPassword: [
          { required: true, message: '新密碼不能為空', trigger: 'blur' },
          { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, message: '確認密碼不能為空', trigger: 'blur' },
          { required: true, validator: equalToPassword, trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    submit() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          updateUserPwd(this.user.oldPassword, this.user.newPassword).then(
            response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
              } else {
                this.msgError(response.msg)
              }
            }
          )
        }
      })
    },
    close() {
      this.$store.dispatch('tagsView/delView', this.$route)
      this.$router.push({ path: '/index' })
    }
  }
}
</script>
