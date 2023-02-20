<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
          <el-form-item label="職位代碼" prop="postCode">
            <el-input
              v-model="queryParams.postCode"
              placeholder="請輸入職位代碼"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="職位名稱" prop="postName">
            <el-input
              v-model="queryParams.postName"
              placeholder="請輸入職位名稱"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="狀態" prop="status">
            <el-select v-model="queryParams.status" placeholder="職位狀態" clearable size="small">
              <el-option
                v-for="dict in statusOptions"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">查詢</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysPost:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysPost:edit']"
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleUpdate"
            >修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysPost:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >删除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysPost:export']"
              type="warning"
              icon="el-icon-download"
              size="mini"
              @click="handleExport"
            >匯出</el-button>
          </el-col>
        </el-row>

        <el-table v-loading="loading" :data="postList" border @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column label="職位編號" width="80" align="center" prop="postId" />
          <el-table-column label="職位代碼" align="center" prop="postCode" />
          <el-table-column label="職位名稱" align="center" prop="postName" />
          <el-table-column label="職位排序" align="center" prop="sort" />
          <el-table-column label="狀態" align="center" prop="status" :formatter="statusFormat">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.status === 1 ? 'danger' : 'success'"
                disable-transitions
              >{{ statusFormat(scope.row) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="創建時間" align="center" prop="createdAt" width="180">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysPost:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改</el-button>
              <el-button
                v-permisaction="['admin:sysPost:remove']"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
              >删除</el-button>
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

        <!-- 新增或修改職位对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" :close-on-click-modal="false">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="職位名稱" prop="postName">
              <el-input v-model="form.postName" placeholder="請輸入職位名稱" />
            </el-form-item>
            <el-form-item label="職位代碼" prop="postCode">
              <el-input v-model="form.postCode" placeholder="請輸入編碼名稱" />
            </el-form-item>
            <el-form-item label="職位顺序" prop="sort">
              <el-input-number v-model="form.sort" controls-position="right" :min="0" />
            </el-form-item>
            <el-form-item label="職位狀態" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio
                  v-for="dict in statusOptions"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="備註" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="請輸入内容" />
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="submitForm">確 定</el-button>
            <el-button @click="cancel">取 消</el-button>
          </div>
        </el-dialog>
      </el-card>
    </template>
  </BasicLayout>
</template>

<script>
import { listPost, getPost, delPost, addPost, updatePost } from '@/api/admin/sys-post'
import { formatJson } from '@/utils'

export default {
  name: 'SysPostManage',
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
      // 職位表格資料
      postList: [],
      // 弹出层标题
      title: '',
      // 是否顯示弹出层
      open: false,
      // 狀態資料字典
      statusOptions: [],
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        postCode: undefined,
        postName: undefined,
        status: undefined
      },
      // 表單参数
      form: {},
      // 表單校验
      rules: {
        postName: [
          { required: true, message: '職位名稱不能為空', trigger: 'blur' }
        ],
        postCode: [
          { required: true, message: '職位代碼不能為空', trigger: 'blur' }
        ],
        sort: [
          { required: true, message: '職位顺序不能為空', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    this.getList()
    this.getDicts('sys_normal_disable').then(response => {
      this.statusOptions = response.data
    })
  },
  methods: {
    /** 查询職位列表 */
    getList() {
      this.loading = true
      listPost(this.queryParams).then(response => {
        this.postList = response.data.list
        this.total = response.data.count
        this.loading = false
      })
    },
    // 職位狀態字典翻译
    statusFormat(row) {
      return this.selectDictLabel(this.statusOptions, row.status)
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        postId: undefined,
        postCode: undefined,
        postName: undefined,
        sort: 0,
        status: '1',
        remark: undefined
      }
      this.resetForm('form')
    },
    /** 查詢按钮操作 */
    handleQuery() {
      this.queryParams.pageIndex = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    // 多選框選中資料
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.postId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增職位'
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()

      const postId = row.postId || this.ids
      getPost(postId).then(response => {
        this.form = response.data
        this.form.status = String(this.form.status)
        this.open = true
        this.title = '修改職位'
      })
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          this.form.status = parseInt(this.form.status)
          if (this.form.postId !== undefined) {
            updatePost(this.form, this.form.postId).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addPost(this.form).then(response => {
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
    /** 删除按钮操作 */
    handleDelete(row) {
      // const postIds = row.postId || this.ids
      const Ids = (row.postId && [row.postId]) || this.ids
      this.$confirm('是否確認删除職位編號為"' + Ids + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delPost({ 'ids': Ids })
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
    /** 匯出按钮操作 */
    handleExport() {
      // const queryParams = this.queryParams
      this.$confirm('是否確認匯出所有職位資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.downloadLoading = true
        import('@/vendor/Export2Excel').then(excel => {
          const tHeader = ['職位編號', '職位代碼', '職位名稱', '排序', '創建時間']
          const filterVal = ['postId', 'postCode', 'postName', 'sort', 'createdAt']
          const list = this.postList
          const data = formatJson(filterVal, list)
          excel.export_json_to_excel({
            header: tHeader,
            data,
            filename: '職位管理',
            autoWidth: true, // Optional
            bookType: 'xlsx' // Optional
          })
          this.downloadLoading = false
        })
      }).catch(function() {})
    }
  }
}
</script>
