
<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="48px">
          <el-form-item label="標题" prop="title">
            <el-input
              v-model="queryParams.title"
              placeholder="請輸入標题"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="地址" prop="path">
            <el-input
              v-model="queryParams.path"
              placeholder="請輸入地址"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="類型" prop="action">
            <el-select
              v-model="queryParams.action"
              placeholder="請選擇類型"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            >
              <el-option value="GET">GET</el-option>
              <el-option value="POST">POST</el-option>
              <el-option value="PUT">PUT</el-option>
              <el-option value="DELETE">DELETE</el-option>
            </el-select>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">查詢</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-table
          v-loading="loading"
          :data="sysapiList"
          border
          @selection-change="handleSelectionChange"
          @sort-change="handleSortChang"
        >
          <el-table-column
            label="標题"
            header-align="center"
            align="left"
            prop="title"
            fixed="left"
            sortable="custom"
            width="260px"
            :show-overflow-tooltip="true"
          >
            <template slot-scope="scope">
              <span v-if="scope.row.type=='SYS' && scope.row.title!=''"><el-tag type="success">{{ '['+scope.row.type +'] '+ scope.row.title }}</el-tag></span>
              <span v-if="scope.row.type!='SYS' && scope.row.title!=''"><el-tag type="">{{ '['+scope.row.type +'] '+scope.row.title }}</el-tag></span>
              <span v-if="scope.row.title==''"><el-tag type="danger">暂無</el-tag></span>

            </template>
          </el-table-column>

          <el-table-column
            label="Request Info"
            header-align="center"
            align="left"
            prop="path"
            sortable="custom"
            :show-overflow-tooltip="true"
          >
            <!-- <template slot-scope="scope">
              <span>{{ "["+scope.row.action +"] "+ scope.row.path }}</span>
            </template> -->
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p><span v-if="scope.row.type=='SYS' && scope.row.title!=''"><el-tag type="success">{{ '['+scope.row.type +'] '+ scope.row.title }}</el-tag></span>
                  <span v-if="scope.row.type!='SYS' && scope.row.title!=''"><el-tag type="">{{ '['+scope.row.type +'] '+scope.row.title }}</el-tag></span>
                  <span v-if="scope.row.title==''"><el-tag type="danger">暂無</el-tag></span>
                </p>
                <p>Handle: {{ scope.row.handle }}</p>
                <p>Method:
                  <el-tag v-if="scope.row.action=='GET'">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='POST'" type="success">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='PUT'" type="warning">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='DELETE'" type="danger">{{ scope.row.action }}</el-tag>
                </p>
                <p>API類型: {{ scope.row.type }}</p>
                <div slot="reference" class="name-wrapper">
                  <el-tag v-if="scope.row.action=='GET'">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='POST'" type="success">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='PUT'" type="warning">{{ scope.row.action }}</el-tag>
                  <el-tag v-if="scope.row.action=='DELETE'" type="danger">{{ scope.row.action }}</el-tag>
                  {{ scope.row.path }}
                </div>
              </el-popover>
            </template>
          </el-table-column>
          <el-table-column
            label="創建時間"
            align="center"
            prop="createdAt"
            width="155px"
            sortable="custom"
          >
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="操作"
            align="center"
            width="80px"
            class-name="small-padding fixed-width"
          >
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysApi:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改
              </el-button>
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

        <!-- 新增或修改对话框 -->
        <el-drawer
          ref="drawer"
          :title="title"
          :before-close="cancel"
          :visible.sync="open"
          direction="rtl"
          custom-class="demo-drawer"
        >
          <div class="demo-drawer__content">
            <el-form ref="form" :model="form" :rules="rules" label-width="80px">

              <el-form-item label="Handle" prop="handle">
                <el-input
                  v-model="form.handle"
                  placeholder="handle"
                />
              </el-form-item>
              <el-form-item label="標题" prop="title">
                <el-input
                  v-model="form.title"
                  placeholder="標题"
                />
              </el-form-item>
              <el-form-item label="類型" prop="type">
                <el-select
                  v-model="form.type"
                  placeholder="請選擇類型"
                  clearable
                  size="small"
                  @keyup.enter.native="handleQuery"
                >
                  <el-option value="SYS">SYS</el-option>
                  <el-option value="BUS">BUS</el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="Method" prop="action">
                <el-select
                  v-model="form.action"
                  placeholder="請選擇方式"
                  clearable
                  size="small"
                  @keyup.enter.native="handleQuery"
                >
                  <el-option value="GET">GET</el-option>
                  <el-option value="POST">POST</el-option>
                  <el-option value="PUT">PUT</el-option>
                  <el-option value="DELETE">DELETE</el-option>
                </el-select>
              </el-form-item>

              <el-form-item label="地址" prop="path">
                <el-input
                  v-model="form.path"
                  :disabled="isEdit"
                  placeholder="地址"
                />
              </el-form-item>

            </el-form>
            <div class="demo-drawer__footer">
              <el-button type="primary" @click="submitForm">確 定</el-button>
              <el-button @click="cancel">取 消</el-button>
            </div>
          </div>

        </el-drawer>

      </el-card>
    </template>
  </BasicLayout>
</template>

<script>
import { addSysApi, delSysApi, getSysApi, listSysApi, updateSysApi } from '@/api/admin/sys-api'

export default {
  name: 'SysApiManage',
  components: {
  },
  data() {
    return {
      dialog: false,
      // 遮罩层
      loading: true,
      // 選中数组
      ids: [],
      // 非單个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 總筆数
      total: 0,
      // 弹出层標题
      title: '',
      // 是否顯示弹出层
      open: false,
      isEdit: false,
      // 類型資料字典
      typeOptions: [],
      sysapiList: [],
      dateRange: [],

      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        name: undefined,
        title: undefined,
        path: undefined,
        action: undefined,
        parentId: undefined

      },
      // 表單参数
      form: {
      },
      // 表單校验
      rules: {
        title: [{ required: true, message: '標题不能為空', trigger: 'blur' }],
        path: [{ required: true, message: '地址不能為空', trigger: 'blur' }],
        action: [{ required: true, message: '類型不能為空', trigger: 'blur' }],
        parentId: [{ required: true, message: '按鈕id不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    handleClose(done) {
      if (this.loading) {
        return
      }
      done()
    },
    /** 查询参数列表 */
    getList() {
      this.loading = true
      listSysApi(this.queryParams).then(response => {
        this.sysapiList = response.data.list
        this.total = response.data.count
        this.loading = false
      }
      )
    },
    // 取消按鈕
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        id: undefined,
        name: undefined,
        title: undefined,
        path: undefined,
        paths: undefined,
        action: undefined,
        parentId: undefined,
        sort: undefined
      }
      this.resetForm('form')
    },
    parentIdFormat(row) {
      return this.selectItemsLabel(this.parentIdOptions, row.parentId)
    },
    // 文件
    /** 查詢按鈕操作 */
    handleQuery() {
      this.queryParams.pageIndex = 1
      this.getList()
    },
    /** 重置按鈕操作 */
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.handleQuery()
    },
    /** 新增按鈕操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增API管理'
      this.isEdit = false
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
    // 多選框選中資料
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 修改按鈕操作 */
    handleUpdate(row) {
      this.reset()
      const id =
                row.id || this.ids
      getSysApi(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改API管理'
        this.isEdit = true
      })
    },
    /** 提交按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateSysApi(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addSysApi(this.form).then(response => {
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
      var Ids = (row.id && [row.id]) || this.ids

      this.$confirm('是否確認刪除編號為"' + Ids + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delSysApi({ 'ids': Ids })
      }).then((response) => {
        if (response.code === 200) {
          this.msgSuccess(response.msg)
          this.open = false
          this.getList()
        } else {
          this.msgError(response.msg)
        }
      }).catch(function() {})
    }
  }
}
</script>
