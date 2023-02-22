
<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
          <el-form-item label="產品代碼" prop="pnCode"><el-input
            v-model="queryParams.pnCode"
            placeholder="請輸入產品代碼"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
          </el-form-item>
          <el-form-item label="sf_id" prop="sfId"><el-input
            v-model="queryParams.sfId"
            placeholder="請輸入sf_id"
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

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:products:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:products:edit']"
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleUpdate"
            >修改
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:products:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >刪除
            </el-button>
          </el-col>
        </el-row>

        <el-table v-loading="loading" :data="productsList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" /><el-table-column
            label="產品代碼"
            align="center"
            prop="pnCode"
            :show-overflow-tooltip="true"
          /><el-table-column label="brand" align="center" prop="brandId" :formatter="brandIdFormat" width="100">
            <template slot-scope="scope">
              {{ brandIdFormat(scope.row) }}
            </template>
          </el-table-column><el-table-column
            label="產品名稱"
            align="center"
            prop="name"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="description"
            align="center"
            prop="part"
            :show-overflow-tooltip="true"
          />
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-popconfirm
                class="delete-popconfirm"
                title="確認要修改吗?"
                confirm-button-text="修改"
                @onConfirm="handleUpdate(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:products:edit']"
                  size="mini"
                  type="text"
                  icon="el-icon-edit"
                >修改
                </el-button>
              </el-popconfirm>
              <el-popconfirm
                class="delete-popconfirm"
                title="確認要刪除吗?"
                confirm-button-text="刪除"
                @onConfirm="handleDelete(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:products:remove']"
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

        <!-- 新增或修改对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">

            <el-form-item label="產品代碼" prop="pnCode">
              <el-input
                v-model="form.pnCode"
                placeholder="產品代碼"
              />
            </el-form-item>
            <el-form-item label="brand" prop="brandId">
              <el-select
                v-model="form.brandId"
                placeholder="請選擇"
              >
                <el-option
                  v-for="dict in brandIdOptions"
                  :key="dict.key"
                  :label="dict.value"
                  :value="dict.key"
                />
              </el-select>
            </el-form-item>
            <el-form-item label="category" prop="categoryId">
              <el-input
                v-model="form.categoryId"
                placeholder="category"
              />
            </el-form-item>
            <el-form-item label="sub_category" prop="subCategoryId">
              <el-input
                v-model="form.subCategoryId"
                placeholder="sub_category"
              />
            </el-form-item>
            <el-form-item label="currency" prop="currencyId">
              <el-input
                v-model="form.currencyId"
                placeholder="currency"
              />
            </el-form-item>
            <el-form-item label="unit" prop="unitId">
              <el-input
                v-model="form.unitId"
                placeholder="unit"
              />
            </el-form-item>
            <el-form-item label="term" prop="termId">
              <el-input
                v-model="form.termId"
                placeholder="term"
              />
            </el-form-item>
            <el-form-item label="產品名稱" prop="name">
              <el-input
                v-model="form.name"
                placeholder="產品名稱"
              />
            </el-form-item>
            <el-form-item label="owner" prop="ownerId">
              <el-input
                v-model="form.ownerId"
                placeholder="owner"
              />
            </el-form-item>
            <el-form-item label="description" prop="description">
              <el-input
                v-model="form.description"
                placeholder="description"
              />
            </el-form-item>
            <el-form-item label="description" prop="part">
              <el-input
                v-model="form.part"
                placeholder="description"
              />
            </el-form-item>
            <el-form-item label="en-description" prop="enPart">
              <el-input
                v-model="form.enPart"
                placeholder="en-description"
              />
            </el-form-item>
            <el-form-item label="是否停用" prop="active">
              <el-radio-group v-model="form.active">
                <el-radio
                  v-for="dict in activeOptions"
                  :key="dict.value"
                  :label="dict.value"
                >{{ dict.label }}</el-radio>
              </el-radio-group>
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
import { addProducts, delProducts, getProducts, listProducts, updateProducts } from '@/api/admin/products'

import { listBrand } from '@/api/admin/brand'
export default {
  name: 'Products',
  components: {
  },
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
      // 弹出层標题
      title: '',
      // 是否顯示弹出层
      open: false,
      isEdit: false,
      // 類型資料字典
      typeOptions: [],
      productsList: [],

      // 關系表類型
      brandIdOptions: [],

      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        productNameId: undefined,
        pnCode: undefined,
        brandId: undefined,
        categoryId: undefined,
        subCategoryId: undefined,
        currencyId: undefined,
        unitId: undefined,
        sfId: undefined,
        termId: undefined

      },
      // 表單参数
      form: {
      },
      // 表單校验
      rules: { pnCode: [{ required: true, message: '產品代碼不能為空', trigger: 'blur' }],
        sfId: [{ required: true, message: 'sf_id不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
    this.getBrandItems()
  },
  methods: {
    /** 查询参数列表 */
    getList() {
      this.loading = true
      listProducts(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.productsList = response.data.list
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
        pnCode: undefined,
        brandId: undefined,
        categoryId: undefined,
        subCategoryId: undefined,
        currencyId: undefined,
        unitId: undefined,
        termId: undefined,
        name: undefined,
        ownerId: undefined,
        description: undefined,
        part: undefined,
        enPart: undefined,
        active: undefined
      }
      this.resetForm('form')
    },
    getImgList: function() {
      this.form[this.fileIndex] = this.$refs['fileChoose'].resultList[0].fullUrl
    },
    fileClose: function() {
      this.fileOpen = false
    },
    brandIdFormat(row) {
      return this.selectItemsLabel(this.brandIdOptions, row.brandId)
    },
    // 關系
    getBrandItems() {
      this.getItems(listBrand, undefined).then(res => {
        this.brandIdOptions = this.setItems(res, 'id', 'name')
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
      this.title = '新增Products'
      this.isEdit = false
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
      getProducts(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改Products'
        this.isEdit = true
      })
    },
    /** 提交按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateProducts(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addProducts(this.form).then(response => {
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
        return delProducts({ 'ids': Ids })
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
