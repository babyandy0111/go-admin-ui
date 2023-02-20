<template>
  <!-- 導入表 -->
  <el-dialog title="導入表" :visible.sync="visible" width="800px" top="5vh">
    <el-form ref="queryForm" :model="queryParams" :inline="true">
      <el-form-item label="表名稱" prop="tableName">
        <el-input
          v-model="queryParams.tableName"
          placeholder="請輸入表名稱"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="表描述" prop="tableComment">
        <el-input
          v-model="queryParams.tableComment"
          placeholder="請輸入表描述"
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
    <el-row>
      <el-table ref="table" :data="dbTableList" height="260px" @row-click="clickRow" @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" />
        <el-table-column prop="tableName" label="表名稱" />
        <el-table-column prop="tableComment" label="表描述" />
        <el-table-column prop="createdAt" label="創建時間" />
        <el-table-column prop="updatedAt" label="更新時间" />
      </el-table>
      <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageIndex"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
      />
    </el-row>
    <div slot="footer" class="dialog-footer">
      <el-button type="primary" :loading="loading" @click="handleImportTable">確 定</el-button>
      <el-button @click="visible = false">取 消</el-button>
    </div>
  </el-dialog>
</template>

<script>
import { listDbTable, importTable } from '@/api/tools/gen'
export default {
  data() {
    return {
      loading: false,
      // 遮罩层
      visible: false,
      // 選中数组值
      tables: [],
      // 总条数
      total: 0,
      // 表資料
      dbTableList: [],
      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        tableName: undefined,
        tableComment: undefined
      }
    }
  },
  methods: {
    // 顯示弹框
    show() {
      this.getList()
      this.visible = true
    },
    clickRow(row) {
      this.$refs.table.toggleRowSelection(row)
    },
    // 多選框選中資料
    handleSelectionChange(selection) {
      this.tables = selection.map(item => item.tableName)
    },
    // 查询表資料
    getList() {
      listDbTable(this.queryParams).then(res => {
        if (res.code === 200) {
          this.dbTableList = res.data.list
          this.total = res.data.count
        }
      })
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
    /** 導入按钮操作 */
    handleImportTable() {
      this.loading = true
      this.visible = true
      importTable({ tables: this.tables.join(',') }).then(res => {
        this.msgSuccess(res.msg)
        if (res.code === 200) {
          this.visible = false
          this.$emit('ok')
        }
        this.loading = false
      })
    }
  }
}
</script>
