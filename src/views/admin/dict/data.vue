<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true">
          <el-form-item label="字典名稱" prop="dictType">
            <el-select v-model="queryParams.dictType" size="small">
              <el-option
                v-for="item in typeOptions"
                :key="item.dictId"
                :label="item.dictName"
                :value="item.dictType"
              />
            </el-select>
          </el-form-item>
          <el-form-item label="字典標签" prop="dictLabel">
            <el-input
              v-model="queryParams.dictLabel"
              placeholder="請輸入字典標签"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="狀態" prop="status">
            <el-select v-model="queryParams.status" placeholder="資料狀態" clearable size="small">
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
              v-permisaction="['admin:sysDictData:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysDictData:edit']"
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleUpdate"
            >修改</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:sysDictData:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >刪除</el-button>
          </el-col>
        </el-row>

        <el-table v-loading="loading" :data="dataList" border @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column label="字典編碼" width="80" align="center" prop="dictCode" />
          <el-table-column label="字典標签" align="center" prop="dictLabel" />
          <el-table-column label="字典键值" align="center" prop="dictValue" />
          <el-table-column label="字典排序" align="center" prop="dictSort" />
          <el-table-column label="狀態" align="center" prop="status" :formatter="statusFormat" />
          <el-table-column label="備註" align="center" prop="remark" :show-overflow-tooltip="true" />
          <el-table-column label="創建時間" align="center" prop="createdAt" width="180">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysDictData:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改</el-button>
              <el-button
                v-permisaction="['admin:sysDictData:remove']"
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
            <el-form-item label="字典類型">
              <el-input v-model="form.dictType" :disabled="true" />
            </el-form-item>
            <el-form-item label="資料標签" prop="dictLabel">
              <el-input v-model="form.dictLabel" placeholder="請輸入資料標签" :disabled="isEdit" />
            </el-form-item>
            <el-form-item label="資料键值" prop="dictValue">
              <el-input v-model="form.dictValue" placeholder="請輸入資料键值" :disabled="isEdit" />
            </el-form-item>
            <el-form-item label="顯示排序" prop="dictSort">
              <el-input-number v-model="form.dictSort" controls-position="right" :min="0" />
            </el-form-item>
            <el-form-item label="狀態" prop="status">
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
import { listData, getData, delData, addData, updateData, exportData } from '@/api/admin/dict/data'
import { listType, getType } from '@/api/admin/dict/type'

export default {
  name: 'SysDictDataManage',
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
      // 字典表格資料
      dataList: [],
      // 默認字典類型
      defaultDictType: '',
      // 弹出层標题
      title: '',
      isEdit: false,
      // 是否顯示弹出层
      open: false,
      // 狀態資料字典
      statusOptions: [],
      // 類型資料字典
      typeOptions: [],
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        dictName: undefined,
        dictType: undefined,
        status: undefined
      },
      // 表單参数
      form: {},
      // 表單校验
      rules: {
        dictLabel: [
          { required: true, message: '資料標签不能為空', trigger: 'blur' }
        ],
        dictValue: [
          { required: true, message: '資料键值不能為空', trigger: 'blur' }
        ],
        dictSort: [
          { required: true, message: '資料顺序不能為空', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    const dictId = this.$route.params && this.$route.params.dictId
    this.getType(dictId)
    this.getTypeList()
    this.getDicts('sys_normal_disable').then(response => {
      this.statusOptions = response.data
    })
  },
  methods: {
    /** 查询字典類型詳细 */
    getType(dictId) {
      getType(dictId).then(response => {
        this.queryParams.dictType = response.data.dictType
        this.defaultDictType = response.data.dictType
        this.getList()
      })
    },
    /** 查询字典類型列表 */
    getTypeList() {
      listType({ pageSize: 1000 }).then(response => {
        this.typeOptions = response.data.list
      })
    },
    /** 查询字典資料列表 */
    getList() {
      this.loading = true
      listData(this.queryParams).then(response => {
        this.dataList = response.data.list
        this.total = response.data.count
        this.loading = false
      })
    },
    // 資料狀態字典翻译
    statusFormat(row, column) {
      return this.selectDictLabel(this.statusOptions, row.status)
    },
    // 取消按鈕
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        dictCode: undefined,
        dictLabel: undefined,
        dictValue: undefined,
        dictSort: 0,
        status: '2',
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
      this.resetForm('queryForm')
      this.queryParams.dictType = this.defaultDictType
      this.handleQuery()
    },
    /** 新增按鈕操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增字典資料'
      this.isEdit = false
      this.form.dictType = this.queryParams.dictType
    },
    // 多選框選中資料
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.dictCode)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 修改按鈕操作 */
    handleUpdate(row) {
      this.reset()
      const dictCode = row.dictCode || this.ids
      getData(dictCode).then(response => {
        this.form = response.data
        this.form.status = String(this.form.status)
        this.open = true
        this.title = '修改字典資料'
        this.isEdit = true
      })
    },
    /** 提交按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          this.form.status = parseInt(this.form.status)
          if (this.form.dictCode !== undefined) {
            updateData(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addData(this.form).then(response => {
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
      const dictCodes = (row.dictCode && [row.dictCode]) || this.ids
      this.$confirm('是否確認刪除字典編碼為"' + dictCodes + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delData({ 'ids': dictCodes })
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
      this.$confirm('是否確認匯出所有資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return exportData(queryParams)
      }).then(response => {
        this.download(response.msg)
      }).catch(function() {})
    }
  }
}
</script>
