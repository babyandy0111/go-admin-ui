
<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
          <el-form-item label="報價單號" prop="quoteNumber"><el-input
            v-model="queryParams.quoteNumber"
            placeholder="請輸入報價單號"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
          </el-form-item>

          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">查詢</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <!--        <el-row :gutter="10" class="mb8">-->
        <!--          <el-col :span="1.5">-->
        <!--            <el-button-->
        <!--              v-permisaction="['admin:quote:add']"-->
        <!--              type="primary"-->
        <!--              icon="el-icon-plus"-->
        <!--              size="mini"-->
        <!--              @click="handleAdd"-->
        <!--            >新增-->
        <!--            </el-button>-->
        <!--          </el-col>-->
        <!--          <el-col :span="1.5">-->
        <!--            <el-button-->
        <!--              v-permisaction="['admin:quote:edit']"-->
        <!--              type="success"-->
        <!--              icon="el-icon-edit"-->
        <!--              size="mini"-->
        <!--              :disabled="single"-->
        <!--              @click="handleUpdate"-->
        <!--            >更新-->
        <!--            </el-button>-->
        <!--          </el-col>-->
        <!--          <el-col :span="1.5">-->
        <!--            <el-button-->
        <!--              v-permisaction="['admin:quote:remove']"-->
        <!--              type="danger"-->
        <!--              icon="el-icon-delete"-->
        <!--              size="mini"-->
        <!--              :disabled="multiple"-->
        <!--              @click="handleDelete"-->
        <!--            >刪除-->
        <!--            </el-button>-->
        <!--          </el-col>-->
        <!--        </el-row>-->

        <el-table v-loading="loading" :data="quoteList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" /><el-table-column
            label="報價單號"
            align="center"
            prop="quoteNumber"
            :show-overflow-tooltip="true"
          /><el-table-column label="公司流水號" align="center" prop="companyTypeId" :formatter="companyTypeIdFormat" width="100">
            <template slot-scope="scope">
              {{ companyTypeIdFormat(scope.row) }}
            </template>
          </el-table-column><el-table-column label="客戶" align="center" prop="accountId" :formatter="accountIdFormat" width="100">
            <template slot-scope="scope">
              {{ accountIdFormat(scope.row) }}
            </template>
          </el-table-column><el-table-column label="幣別" align="center" prop="currencyId" :formatter="currencyIdFormat" width="100">
            <template slot-scope="scope">
              {{ currencyIdFormat(scope.row) }}
            </template>
          </el-table-column><el-table-column
            label="報價名稱"
            align="center"
            prop="quoteName"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="報價單總額"
            align="center"
            prop="total"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="税"
            align="center"
            prop="tax"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="含稅總額"
            align="center"
            prop="grandTotal"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="折扣"
            align="center"
            prop="discount"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="備註"
            align="center"
            prop="quoteNote"
            :show-overflow-tooltip="true"
          />
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-popconfirm
                class="delete-popconfirm"
                title="確認要更新吗?"
                confirm-button-text="更新"
                @confirm="handleUpdate(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:quote:edit']"
                  size="mini"
                  type="text"
                  icon="el-icon-edit"
                >更新
                </el-button>
              </el-popconfirm>
              <el-popconfirm
                class="delete-popconfirm"
                title="確定刪除?"
                confirm-button-text="刪除"
                @confirm="handleDelete(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:quote:remove']"
                  size="mini"
                  type="text"
                  icon="el-icon-delete"
                >刪除
                </el-button>
              </el-popconfirm>
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

        <!-- 新增或更新的popup -->
        <el-dialog :title="title" :visible.sync="open" width="50%">
          <el-form ref="form" :model="form" :rules="rules" label-width="100px">

            <el-form-item label="報價單總額" prop="total">
              <el-input
                v-model="form.total"
                placeholder="報價單總額"
              />
            </el-form-item>
            <el-form-item label="税" prop="tax">
              <el-input
                v-model="form.tax"
                placeholder="税"
              />
            </el-form-item>
            <el-form-item label="含稅總額" prop="grandTotal">
              <el-input
                v-model="form.grandTotal"
                placeholder="含稅總額"
              />
            </el-form-item>
            <el-form-item label="折扣" prop="discount">
              <el-input
                v-model="form.discount"
                placeholder="折扣"
              />
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
import { addQuote, delQuote, getQuote, listQuote, updateQuote } from '@/api/admin/quote'

import { listCompanyType } from '@/api/admin/company-type'
import { listAccount } from '@/api/admin/account'
import { listCurrency } from '@/api/admin/currency'
export default {
  name: 'Quote',
  components: {
  },
  data() {
    return {
      // 遮罩
      loading: true,
      // 選中資料
      ids: [],
      // 非單個禁用
      single: true,
      // 非多個禁用
      multiple: true,
      // 總筆數
      total: 0,
      // popup標題
      title: '',
      // 是否顯示popup
      open: false,
      isEdit: false,
      // 類型資料字典
      typeOptions: [],
      quoteList: [],

      // 關係表類型
      companyTypeIdOptions: [],
      accountIdOptions: [],
      currencyIdOptions: [],

      // 查詢參數
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        quoteNumber: undefined,
        companyTypeId: undefined,
        accountId: undefined

      },
      // 表單參數
      form: {
      },
      // 表單驗證
      rules: { quoteNumber: [{ required: true, message: '報價單號不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
    this.getCompanyTypeItems()
    this.getAccountItems()
    this.getCurrencyItems()
  },
  methods: {
    /** 查詢參數列表 */
    getList() {
      this.loading = true
      listQuote(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.quoteList = response.data.list
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
        total: undefined,
        tax: undefined,
        grandTotal: undefined,
        discount: undefined
      }
      this.resetForm('form')
    },
    getImgList: function() {
      this.form[this.fileIndex] = this.$refs['fileChoose'].resultList[0].fullUrl
    },
    fileClose: function() {
      this.fileOpen = false
    },
    companyTypeIdFormat(row) {
      return this.selectItemsLabel(this.companyTypeIdOptions, row.companyTypeId)
    },
    accountIdFormat(row) {
      return this.selectItemsLabel(this.accountIdOptions, row.accountId)
    },
    currencyIdFormat(row) {
      return this.selectItemsLabel(this.currencyIdOptions, row.currencyId)
    },
    // 關係
    getCompanyTypeItems() {
      this.getItems(listCompanyType, undefined).then(res => {
        this.companyTypeIdOptions = this.setItems(res, 'id', 'name')
      })
    },
    getAccountItems() {
      this.getItems(listAccount, undefined).then(res => {
        this.accountIdOptions = this.setItems(res, 'id', 'name')
      })
    },
    getCurrencyItems() {
      this.getItems(listCurrency, undefined).then(res => {
        this.currencyIdOptions = this.setItems(res, 'id', 'name')
      })
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
      this.title = '添加報價單管理'
      this.isEdit = false
    },
    // 多選選中資料
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 更新按鈕操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getQuote(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = '更新報價單管理'
        this.isEdit = true
      })
    },
    /** 送出按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateQuote(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addQuote(this.form).then(response => {
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

      this.$confirm('是否確認刪除流水號為"' + Ids + '"的資料?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        return delQuote({ 'ids': Ids })
      }).then((response) => {
        if (response.code === 200) {
          this.msgSuccess(response.msg)
          this.open = false
          this.getList()
        } else {
          this.msgError(response.msg)
        }
      }).catch(function() {
      })
    }
  }
}
</script>
