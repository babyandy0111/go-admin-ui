<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-row :gutter="20">
          <!--部門資料-->
          <el-col :span="4" :xs="24">
            <div class="head-container">
              <el-input
                v-model="deptName"
                placeholder="請輸入部門名稱"
                clearable
                size="small"
                prefix-icon="el-icon-search"
                style="margin-bottom: 20px"
              />
            </div>
            <div class="head-container">
              <el-tree
                ref="tree"
                :data="deptOptions"
                :props="defaultProps"
                :expand-on-click-node="false"
                :filter-node-method="filterNode"
                default-expand-all
                @node-click="handleNodeClick"
              />
            </div>
          </el-col>
          <!--用户資料-->
          <el-col :span="20" :xs="24">
            <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
              <el-form-item label="帳號" prop="username">
                <el-input
                  v-model="queryParams.username"
                  placeholder="請輸入帳號"
                  clearable
                  size="small"
                  style="width: 160px"
                  @keyup.enter.native="handleQuery"
                />
              </el-form-item>
              <el-form-item label="手機號碼" prop="phone">
                <el-input
                  v-model="queryParams.phone"
                  placeholder="請輸入手機號碼"
                  clearable
                  size="small"
                  style="width: 160px"
                  @keyup.enter.native="handleQuery"
                />
              </el-form-item>
              <el-form-item label="狀態" prop="status">
                <el-select
                  v-model="queryParams.status"
                  placeholder="狀態"
                  clearable
                  size="small"
                  style="width: 160px"
                >
                  <el-option
                    v-for="dict in statusOptions"
                    :key="dict.value"
                    :label="dict.label"
                    :value="dict.value"
                  />
                </el-select>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜尋</el-button>
                <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
              </el-form-item>
            </el-form>

            <el-row :gutter="10" class="mb8">
              <el-col :span="1.5">
                <el-button
                  v-permisaction="['admin:sysUser:add']"
                  type="primary"
                  icon="el-icon-plus"
                  size="mini"
                  @click="handleAdd"
                >新增</el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button
                  v-permisaction="['admin:sysUser:edit']"
                  type="success"
                  icon="el-icon-edit"
                  size="mini"
                  :disabled="single"
                  @click="handleUpdate"
                >修改</el-button>
              </el-col>
              <el-col :span="1.5">
                <el-button
                  v-permisaction="['admin:sysUser:remove']"
                  type="danger"
                  icon="el-icon-delete"
                  size="mini"
                  :disabled="multiple"
                  @click="handleDelete"
                >刪除</el-button>
              </el-col>
            </el-row>

            <el-table
              v-loading="loading"
              :data="userList"
              border
              @selection-change="handleSelectionChange"
              @sort-change="handleSortChang"
            >
              <el-table-column type="selection" width="45" align="center" />
              <el-table-column label="編號" width="75" prop="userId" sortable="custom" />
              <el-table-column label="登入帳號" width="105" prop="username" sortable="custom" :show-overflow-tooltip="true" />
              <el-table-column label="暱稱" prop="nickName" :show-overflow-tooltip="true" />
              <el-table-column label="部門" prop="dept.deptName" :show-overflow-tooltip="true" />
              <el-table-column label="手機" prop="phone" width="108" />
              <el-table-column label="狀態" width="80" sortable="custom">
                <template slot-scope="scope">
                  <el-switch
                    v-model="scope.row.status"
                    active-value="2"
                    inactive-value="1"
                    @change="handleStatusChange(scope.row)"
                  />
                </template>
              </el-table-column>
              <el-table-column
                label="建立時間"
                prop="createdAt"
                sortable="custom"
                width="155"
              >
                <template slot-scope="scope">
                  <span>{{ parseTime(scope.row.createdAt) }}</span>
                </template>
              </el-table-column>
              <el-table-column
                label="操作"
                width="160"

                fix="right"
                class-name="small-padding fixed-width"
              >
                <template slot-scope="scope">
                  <el-button
                    v-permisaction="['admin:sysUser:edit']"
                    size="mini"
                    type="text"
                    icon="el-icon-edit"
                    @click="handleUpdate(scope.row)"
                  >修改</el-button>
                  <el-button
                    v-if="scope.row.userId !== 1"
                    v-permisaction="['admin:sysUser:remove']"
                    size="mini"
                    type="text"
                    icon="el-icon-delete"
                    @click="handleDelete(scope.row)"
                  >刪除</el-button>
                  <el-button
                    v-permisaction="['admin:sysUser:resetPassword']"
                    size="mini"
                    type="text"
                    icon="el-icon-key"
                    @click="handleResetPwd(scope.row)"
                  >重置</el-button>
                </template>
              </el-table-column>
            </el-table>

            <pagination
              v-show="total>0"
              :total="total"
              :page.sync="queryParams.pageIndex"
              :limit.sync="queryParams.pageSize"
              @pagination="getList"
            />
          </el-col>
        </el-row>
      </el-card>
      <!-- 新增或修改参数設定对话框 -->
      <el-dialog :title="title" :visible.sync="open" width="600px" :close-on-click-modal="false">
        <el-form ref="form" :model="form" :rules="rules" label-width="80px">
          <el-row>
            <el-col :span="12">
              <el-form-item label="暱稱" prop="nickName">
                <el-input v-model="form.nickName" placeholder="請輸入暱稱" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="隸屬部門" prop="deptId">
                <treeselect
                  v-model="form.deptId"
                  :options="deptOptions"
                  placeholder="請選擇隸屬部門"
                />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="手機號碼" prop="phone">
                <el-input v-model="form.phone" placeholder="請輸入手機號碼" maxlength="11" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="E-mail" prop="email">
                <el-input v-model="form.email" placeholder="請輸入E-mail" maxlength="50" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="帳號" prop="username">
                <el-input v-model="form.username" placeholder="請輸入帳號" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item v-if="form.userId == undefined" label="密碼" prop="password">
                <el-input v-model="form.password" placeholder="請輸入密碼" type="password" />
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="性别">
                <el-select v-model="form.sex" placeholder="請選擇">
                  <el-option
                    v-for="dict in sexOptions"
                    :key="dict.value"
                    :label="dict.label"
                    :value="dict.value"
                  />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="狀態">
                <el-radio-group v-model="form.status">
                  <el-radio
                    v-for="dict in statusOptions"
                    :key="dict.value"
                    :label="dict.value"
                  >{{ dict.label }}</el-radio>
                </el-radio-group>
              </el-form-item>
            </el-col>

            <el-col :span="12">
              <el-form-item label="職位">
                <el-select v-model="form.postId" placeholder="請選擇" @change="$forceUpdate()">
                  <el-option
                    v-for="item in postOptions"
                    :key="item.postId"
                    :label="item.postName"
                    :value="item.postId"
                    :disabled="item.status == 1"
                  />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="12">
              <el-form-item label="角色">
                <el-select v-model="form.roleId" placeholder="請選擇" @change="$forceUpdate()">
                  <el-option
                    v-for="item in roleOptions"
                    :key="item.roleId"
                    :label="item.roleName"
                    :value="item.roleId"
                    :disabled="item.status == 1"
                  />
                </el-select>
              </el-form-item>
            </el-col>
            <el-col :span="24">
              <el-form-item label="備註">
                <el-input v-model="form.remark" type="textarea" placeholder="請輸入内容" />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitForm">確 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </el-dialog>
      <!-- 用户導入对话框 -->
      <el-dialog :title="upload.title" :visible.sync="upload.open" width="400px" :close-on-click-modal="false">
        <el-upload
          ref="upload"
          :limit="1"
          accept=".xlsx, .xls"
          :headers="upload.headers"
          :action="upload.url + '?updateSupport=' + upload.updateSupport"
          :disabled="upload.isUploading"
          :on-progress="handleFileUploadProgress"
          :on-success="handleFileSuccess"
          :auto-upload="false"
          drag
        >
          <i class="el-icon-upload" />
          <div class="el-upload__text">
            將文件拖到此處，或
            <em>點擊上傳</em>
          </div>
          <div slot="tip" class="el-upload__tip">
            <el-checkbox v-model="upload.updateSupport" />是否更新已經存在的user資料
            <el-link type="info" style="font-size:12px" @click="importTemplate">下載模板</el-link>
          </div>
          <div slot="tip" class="el-upload__tip" style="color:red">提示：僅允許匯入“xls”或“xlsx”格式文件！</div>
        </el-upload>
        <div slot="footer" class="dialog-footer">
          <el-button type="primary" @click="submitFileForm">確 定</el-button>
          <el-button @click="upload.open = false">取 消</el-button>
        </div>
      </el-dialog>
    </template>
  </BasicLayout>
</template>

<script>
import { listUser, getUser, delUser, addUser, updateUser, exportUser, resetUserPwd, changeUserStatus, importTemplate } from '@/api/admin/sys-user'
import { getToken } from '@/utils/auth'

import { listPost } from '@/api/admin/sys-post'
import { listRole } from '@/api/admin/sys-role'
import { treeselect } from '@/api/admin/sys-dept'

import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'

export default {
  name: 'SysUserManage',
  components: { Treeselect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 選中数组
      ids: [],
      // 非單个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 用户表格資料
      userList: null,
      // 弹出层標题
      title: '',
      // 部門树選项
      deptOptions: undefined,
      // 是否顯示弹出层
      open: false,
      // 部門名稱
      deptName: undefined,
      // 默認密碼
      initPassword: undefined,
      // 日期範圍
      dateRange: [],
      // 狀態資料字典
      statusOptions: [],
      // 性别狀態字典
      sexOptions: [],
      // 職位選项
      postOptions: [],
      // 角色選项
      roleOptions: [],
      // 表單参数
      form: {},
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      // 用户導入参数
      upload: {
        // 是否顯示弹出层（用户導入）
        open: false,
        // 弹出层標题（用户導入）
        title: '',
        // 是否禁用上傳
        isUploading: false,
        // 是否更新已经存在的用户資料
        updateSupport: 0,
        // 設定上傳的請求头部
        headers: { Authorization: 'Bearer ' + getToken() },
        // 上傳的地址
        url: process.env.VUE_APP_BASE_API + '/system/user/importData'
      },
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        username: undefined,
        phone: undefined,
        status: undefined,
        deptId: undefined
      },
      // 表單校验
      rules: {
        username: [{ required: true, message: '帳號不能為空', trigger: 'blur' }],
        nickName: [{ required: true, message: '暱稱不能為空', trigger: 'blur' }],
        deptId: [{ required: true, message: '隸屬部門不能為空', trigger: 'blur' }],
        password: [{ required: true, message: '密碼不能為空', trigger: 'blur' }],
        email: [
          { required: true, message: 'E-mail地址不能為空', trigger: 'blur' },
          { type: 'email', message: '請輸入正確的E-mail地址', trigger: ['blur', 'change'] }
        ],
        phone: [
          { required: true, message: '手機號碼不能為空', trigger: 'blur' },
          { pattern: /^09[0-9]{8}$/, message: '請輸入正確的手機號碼', trigger: 'blur' }
        ]
      }
    }
  },
  watch: {
    // 根據名稱筛選部門树
    deptName(val) {
      this.$refs.tree.filter(val)
    }
  },
  created() {
    this.getList()
    this.getTreeselect()
    this.getDicts('sys_normal_disable').then(response => {
      this.statusOptions = response.data
    })
    this.getDicts('sys_user_sex').then(response => {
      this.sexOptions = response.data
    })
    this.getConfigKey('sys_user_initPassword').then(response => {
      this.initPassword = response.data.configValue
    })
  },
  methods: {
    /** 查询用户列表 */
    getList() {
      this.loading = true
      listUser(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.userList = response.data.list
        this.total = response.data.count
        this.loading = false
      }
      )
    },
    /** 查询部門下拉树结构 */
    getTreeselect() {
      treeselect().then(response => {
        this.deptOptions = response.data
      })
    },
    // 筛選节點
    filterNode(value, data) {
      if (!value) return true
      return data.label.indexOf(value) !== -1
    },
    // 节點單击事件
    handleNodeClick(data) {
      this.queryParams.deptId = '/' + data.id + '/'
      this.getList()
    },
    /** 转换選單資料结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.id,
        label: node.label,
        children: node.children
      }
    },
    /** 排序回调函数 */
    handleSortChang(column, prop, order) {
      prop = column.prop
      order = column.order
      if (this.order !== '' && this.order !== prop + 'Order') {
        this.queryParams[this.order] = undefined
      }
      if (order === 'descending') {
        this.queryParams[prop + 'Order'] = 'desc'
        this.order = prop + 'Order'
      } else if (order === 'ascending') {
        this.queryParams[prop + 'Order'] = 'asc'
        this.order = prop + 'Order'
      } else {
        this.queryParams[prop + 'Order'] = undefined
      }
      this.getList()
    },
    // 用户狀態修改
    handleStatusChange(row) {
      const text = row.status === '2' ? '啟用' : '停用'
      this.$confirm('確認要"' + text + '""' + row.username + '"用户吗?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return changeUserStatus(row)
      }).then(() => {
        this.msgSuccess(text + '成功')
      }).catch(function() {
        row.status = row.status === '2' ? '1' : '2'
      })
    },
    // 取消按鈕
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        userId: undefined,
        deptId: undefined,
        username: undefined,
        nickName: undefined,
        password: undefined,
        phone: undefined,
        email: undefined,
        sex: undefined,
        status: '2',
        remark: undefined,
        postIds: undefined,
        roleIds: undefined
      }
      this.resetForm('form')
    },
    /** 查詢按鈕操作 */
    handleQuery() {
      this.queryParams.page = 1
      this.getList()
    },
    /** 重置按鈕操作 */
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.queryParams.deptId = ''
      this.handleQuery()
    },
    // 多選框選中資料
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按鈕操作 */
    handleAdd() {
      this.reset()
      this.getTreeselect()

      listPost({ pageSize: 1000 }).then(response => {
        this.postOptions = response.data.list
      })
      listRole({ pageSize: 1000 }).then(response => {
        this.roleOptions = response.data.list
      })
      this.open = true
      this.title = '新增用户'
      this.form.password = this.initPassword
    },
    /** 修改按鈕操作 */
    handleUpdate(row) {
      this.reset()

      const userId = row.userId || this.ids
      getUser(userId).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改用户'
        this.form.password = ''
      })
      listPost({ pageSize: 1000 }).then(response => {
        this.postOptions = response.data.list
      })
      listRole({ pageSize: 1000 }).then(response => {
        this.roleOptions = response.data.list
      })
    },
    /** 重置密碼按鈕操作 */
    handleResetPwd(row) {
      this.$prompt('請輸入"' + row.username + '"的新密碼', '提示', {
        confirmButtonText: '確定',
        cancelButtonText: '取消'
      }).then(({ value }) => {
        resetUserPwd(row.userId, value).then(response => {
          if (response.code === 200) {
            this.msgSuccess(response.msg)
          } else {
            this.msgError(response.msg)
          }
        })
      }).catch(() => {})
    },
    /** 提交按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.userId !== undefined) {
            updateUser(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addUser(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          }
        }
      })
    },
    /** 刪除按鈕操作 */
    handleDelete(row) {
      const Ids = (row.userId && [row.userId]) || this.ids
      this.$confirm('是否確認刪除用户編號為"' + Ids + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delUser({ 'ids': Ids })
      }).then((response) => {
        if (response.code === 200) {
          this.msgSuccess(response.msg)
          this.open = false
          this.getList()
        } else {
          this.msgError(response.msg)
        }
      }).catch(function() {})
    },
    /** 匯出按鈕操作 */
    handleExport() {
      const queryParams = this.queryParams
      this.$confirm('是否確認匯出所有用户資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return exportUser(queryParams)
      }).then(response => {
        this.download(response.msg)
      }).catch(function() {})
    },
    /** 導入按鈕操作 */
    handleImport() {
      this.upload.title = '用户導入'
      this.upload.open = true
    },
    /** 下载模板操作 */
    importTemplate() {
      importTemplate().then(response => {
        this.download(response.msg)
      })
    },
    // 文件上傳中处理
    handleFileUploadProgress(event, file, fileList) {
      this.upload.isUploading = true
    },
    // 文件上傳成功处理
    handleFileSuccess(response, file, fileList) {
      this.upload.open = false
      this.upload.isUploading = false
      this.$refs.upload.clearFiles()
      this.$alert(response.msg, '導入结果', { dangerouslyUseHTMLString: true })
      this.getList()
    },
    // 提交上傳文件
    submitFileForm() {
      this.$refs.upload.submit()
    }
  }
}
</script>
