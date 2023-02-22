<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="48px">
          <el-form-item label="名稱" prop="configName">
            <el-input
              v-model="queryParams.configName"
              placeholder="請輸入参数名稱"
              clearable
              size="small"
              style="width: 160px"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="鍵值" prop="configKey">
            <el-input
              v-model="queryParams.configKey"
              placeholder="請輸入参数鍵值"
              clearable
              size="small"
              style="width: 160px"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="内置" prop="configType">
            <el-select v-model="queryParams.configType" placeholder="系统内置" clearable size="small">
              <el-option
                v-for="dict in typeOptions"
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
              v-permisaction="['admin:sysConfig:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysConfig:edit']"
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleUpdate"
            >修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysConfig:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >刪除</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysConfig:export']"
              type="warning"
              icon="el-icon-download"
              size="mini"
              @click="handleExport"
            >匯出</el-button>
          </el-col>
        </el-row>

        <el-table
          v-loading="loading"
          :data="configList"
          border
          @selection-change="handleSelectionChange"
          @sort-change="handleSortChang"
        >
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column
            label="編碼"
            sortable="custom"
            width="75"
            prop="id"
          />
          <el-table-column
            label="名稱"
            sortable="custom"
            prop="configName"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="鍵值"
            sortable="custom"
            prop="configKey"
          >
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p>键值: {{ scope.row.configValue }}</p>
                <p>UI参数:  <el-tag v-if="scope.row.isFrontend=='2'">否</el-tag>
                  <el-tag v-if="scope.row.isFrontend=='1'" type="success">是</el-tag>
                </p>
                <div slot="reference" class="name-wrapper">
                  {{ scope.row.configKey }}
                </div>
              </el-popover>
            </template>
          </el-table-column>
          <el-table-column
            label="内置"
            sortable="custom"
            prop="configType"
            :formatter="typeFormat"
            width="80"
          />
          <el-table-column
            label="備註"
            prop="remark"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="創建時間"
            sortable="custom"
            prop="createdAt"
            width="160"
          >
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            label="操作"
            class-name="small-padding fixed-width"
            width="120"
          >
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysConfig:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改</el-button>
              <el-button
                v-permisaction="['admin:sysConfig:remove']"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
              >刪除</el-button>
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

        <!-- 新增或修改参数設定对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" :close-on-click-modal="false">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-form-item label="参数名稱" prop="configName">
              <el-input v-model="form.configName" placeholder="請輸入参数名稱" :disabled="isEdit" />
            </el-form-item>
            <el-form-item label="参数鍵值" prop="configKey">
              <el-input v-model="form.configKey" placeholder="請輸入参数鍵值" :disabled="isEdit" />
            </el-form-item>
            <el-form-item label="参数键值" prop="configValue">
              <el-input v-model="form.configValue" placeholder="請輸入参数键值" />
            </el-form-item>
            <el-form-item label="系统内置" prop="configType">
              <el-radio-group v-model="form.configType">
                <el-radio
                  v-for="dict in typeOptions"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="前台顯示" prop="isFrontend">
              <el-select v-model="form.isFrontend" placeholder="是否前台顯示" clearable size="small">
                <el-option label="是" value="1" />
                <el-option label="否" value="2" />
              </el-select>
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
import { listConfig, getConfig, delConfig, addConfig, updateConfig } from '@/api/admin/sys-config'
import { formatJson } from '@/utils'

export default {
  name: 'SysConfigManage',
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
      // 總筆数
      total: 0,
      // 参数表格資料
      configList: [],
      // 排序字段
      order: 'createdAtOrder',
      // 弹出层標题
      title: '',
      isEdit: false,
      // 是否顯示弹出层
      open: false,
      // 類型資料字典
      typeOptions: [],
      // 日期範圍
      dateRange: [],
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        configName: undefined,
        configKey: undefined,
        configType: undefined,
        createdAtOrder: 'desc'
      },
      // 表單参数
      form: {},
      // 表單校验
      rules: {
        configName: [{ required: true, message: '参数名稱不能為空', trigger: 'blur' }],
        configKey: [{ required: true, message: '参数鍵值不能為空', trigger: 'blur' }],
        configValue: [{ required: true, message: '参数键值不能為空', trigger: 'blur' }],
        isFrontend: [{ required: true, message: '是否前台顯示不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
    this.getDicts('sys_yes_no').then(response => {
      this.typeOptions = response.data
    })
  },
  methods: {
    /** 查询参数列表 */
    getList() {
      this.loading = true
      listConfig(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.configList = response.data.list
        this.total = response.data.count
        this.loading = false
      }
      )
    },
    // 参数系统内置字典翻译
    typeFormat(row, column) {
      return this.selectDictLabel(this.typeOptions, row.configType)
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
        configName: undefined,
        configKey: undefined,
        configValue: undefined,
        configType: 'Y',
        isFrontend: '1',
        remark: undefined
      }
      this.resetForm('form')
    },
    /** 查詢按鈕操作 */
    handleQuery() {
      this.queryParams.pageIndex = 1
      this.getList()
    },
    /** 重置按鈕操作 */
    resetQuery() {
      this.dateRange = []
      this.resetForm('queryForm')
      this.queryParams['createdAtOrderOrder'] = 'desc'
      this.handleQuery()
    },
    /** 新增按鈕操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增参数'
      this.isEdit = false
    },
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
      const ID = row.id || this.ids
      getConfig(ID).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改参数'
        this.isEdit = true
      })
    },
    /** 提交按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateConfig(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addConfig(this.form).then(response => {
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
      const Ids = (row.id && [row.id]) || this.ids
      this.$confirm('是否確認刪除参数編號為"' + Ids + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delConfig({ 'ids': Ids })
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
      // const queryParams = this.queryParams
      this.$confirm('是否確認匯出所有参数資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.downloadLoading = true
        import('@/vendor/Export2Excel').then(excel => {
          const tHeader = ['参数主键', '参数名稱', '参数鍵值', '参数键值', '備註', '創建時間']
          const filterVal = ['configId', 'configName', 'configKey', 'configValue', 'remark', 'createdAt']
          const list = this.configList
          const data = formatJson(filterVal, list)
          excel.export_json_to_excel({
            header: tHeader,
            data,
            filename: '参数設定',
            autoWidth: true, // Optional
            bookType: 'xlsx' // Optional
          })
          this.downloadLoading = false
        })
      })
    }
  }
}
</script>
