<template>
  <el-form ref="form" :model="user" :rules="rules" label-width="80px">
    <el-form-item label="暱稱" prop="nickName">
      <el-input v-model="user.nickName" />
    </el-form-item>
    <el-form-item label="手機號碼" prop="phone">
      <el-input v-model="user.phone" maxlength="11" />
    </el-form-item>
    <el-form-item label="E-mail" prop="email">
      <el-input v-model="user.email" maxlength="50" />
    </el-form-item>
    <el-form-item label="性别">
      <el-radio-group v-model="user.sex">
        <el-radio label="0">男</el-radio>
        <el-radio label="1">女</el-radio>
      </el-radio-group>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" size="mini" @click="submit">保存</el-button>
      <el-button type="danger" size="mini" @click="close">关闭</el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import { updateUser } from '@/api/admin/sys-user'

export default {
  props: {
    // eslint-disable-next-line vue/require-default-prop
    user: { type: Object }
  },
  data() {
    return {
      // 表單校验
      rules: {
        nickName: [
          { required: true, message: '暱稱不能為空', trigger: 'blur' }
        ],
        email: [
          { required: true, message: 'E-mail地址不能為空', trigger: 'blur' },
          {
            type: 'email',
            message: "'請輸入正確的E-mail地址",
            trigger: ['blur', 'change']
          }
        ],
        phone: [
          { required: true, message: '手機號碼不能為空', trigger: 'blur' },
          {
            pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
            message: '請輸入正確的手機號碼',
            trigger: 'blur'
          }
        ]
      }
    }
  },
  methods: {
    submit() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          updateUser(this.user).then(response => {
            if (response.code === 200) {
              this.msgSuccess(response.msg)
            } else {
              this.msgError(response.msg)
            }
          })
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
