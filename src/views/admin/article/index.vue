
<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
          <el-form-item label="狀態" prop="status"><el-input
            v-model="queryParams.status"
            placeholder="請輸入狀態"
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
              v-permisaction="['admin:article:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:article:edit']"
              type="success"
              icon="el-icon-edit"
              size="mini"
              :disabled="single"
              @click="handleUpdate"
            >更新
            </el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button
              v-permisaction="['admin:article:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >刪除
            </el-button>
          </el-col>
        </el-row>

        <el-table v-loading="loading" :data="articleList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" /><el-table-column
            label="標題"
            align="center"
            prop="title"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="作者"
            align="center"
            prop="author"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="内容"
            align="center"
            prop="content"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="狀態"
            align="center"
            prop="status"
            :show-overflow-tooltip="true"
          /><el-table-column
            label="發佈時間"
            align="center"
            prop="publishAt"
            :show-overflow-tooltip="true"
          >
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.publishAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-popconfirm
                class="delete-popconfirm"
                title="確認要更新吗?"
                confirm-button-text="更新"
                @onConfirm="handleUpdate(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:article:edit']"
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
                @onConfirm="handleDelete(scope.row)"
              >
                <el-button
                  slot="reference"
                  v-permisaction="['admin:article:remove']"
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
        <el-dialog :title="title" :visible.sync="open" width="500px">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">

            <el-form-item label="標題" prop="title">
              <el-input
                v-model="form.title"
                placeholder="標題"
              />
            </el-form-item>
            <el-form-item label="作者" prop="author">
              <el-input
                v-model="form.author"
                placeholder="作者"
              />
            </el-form-item>
            <el-form-item label="内容" prop="content">
              <el-input
                v-model="form.content"
                placeholder="内容"
              />
            </el-form-item>
            <el-form-item label="狀態" prop="status">
              <el-input
                v-model="form.status"
                placeholder="狀態"
              />
            </el-form-item>
            <el-form-item label="發佈時間" prop="publishAt">
              <el-date-picker
                v-model="form.publishAt"
                type="datetime"
                placeholder="選擇日期"
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
import { addArticle, delArticle, getArticle, listArticle, updateArticle } from '@/api/admin/article'

export default {
  name: 'Article',
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
      articleList: [],

      // 關係表類型

      // 查詢參數
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        status: undefined

      },
      // 表單參數
      form: {
      },
      // 表單驗證
      rules: { status: [{ required: true, message: '狀態不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查詢參數列表 */
    getList() {
      this.loading = true
      listArticle(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.articleList = response.data.list
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
        title: undefined,
        author: undefined,
        content: undefined,
        status: undefined,
        publishAt: undefined
      }
      this.resetForm('form')
    },
    getImgList: function() {
      this.form[this.fileIndex] = this.$refs['fileChoose'].resultList[0].fullUrl
    },
    fileClose: function() {
      this.fileOpen = false
    },
    // 關係
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
      this.title = '添加內容'
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
      const id =
                row.id || this.ids
      getArticle(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = '更新內容'
        this.isEdit = true
      })
    },
    /** 送出按鈕 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.id !== undefined) {
            updateArticle(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addArticle(this.form).then(response => {
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
        return delArticle({ 'ids': Ids })
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
