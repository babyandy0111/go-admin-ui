
<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
          <el-form-item label="user名稱" prop="username"><el-input
            v-model="queryParams.username"
            placeholder="請輸入user名稱"
            clearable
            size="small"
            @keyup.enter.native="handleQuery"
          />
          </el-form-item>
          <el-form-item label="狀態" prop="status"><el-select
            v-model="queryParams.status"
            placeholder="系统Login log 狀態"
            clearable
            size="small"
          >
            <el-option
              v-for="dict in statusOptions"
              :key="dict.value"
              :label="dict.label"
              :value="dict.value"
            />
          </el-select>
          </el-form-item>
          <el-form-item label="ip地址" prop="ipaddr"><el-input
            v-model="queryParams.ipaddr"
            placeholder="請輸入ip地址"
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
              v-permisaction="['admin:sysLoginLog:remove']"
              type="danger"
              icon="el-icon-delete"
              size="mini"
              :disabled="multiple"
              @click="handleDelete"
            >刪除
            </el-button>
          </el-col>
        </el-row>

        <el-table v-loading="loading" :data="sysloginlogList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="55" align="center" />
          <el-table-column
            label="user名稱"
            align="center"
            prop="username"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="類型"
            align="center"
            prop="msg"
            :show-overflow-tooltip="true"
          />
          <el-table-column
            label="狀態"
            align="center"
            prop="status"
            :formatter="statusFormat"
            width="100"
          >
            <template slot-scope="scope">
              {{ statusFormat(scope.row) }}
            </template>
          </el-table-column>
          <el-table-column
            label="ip地址"
            align="center"
            prop="ipaddr"
          >
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p>IP: {{ scope.row.ipaddr }}</p>
                <p>位置: {{ scope.row.loginLocation }}</p>
                <p>瀏覽器: {{ scope.row.browser }}</p>
                <p>系統: {{ scope.row.os }}</p>
                <p>平台: {{ scope.row.platform }}</p>
                <div slot="reference" class="name-wrapper">
                  {{ scope.row.ipaddr }}
                </div>
              </el-popover>
            </template>
          </el-table-column>

          <el-table-column
            label="登入時間"
            align="center"
            prop="loginTime"
            width="180"
          >
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.loginTime) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysLoginLog:remove']"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
              >刪除
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
      </el-card>
    </template>
  </BasicLayout>
</template>

<script>
import { delSysLoginlog, getSysLoginlog, listSysLoginlog } from '@/api/admin/sys-login-log'

export default {
  name: 'SysLoginLogManage',
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
      fileOpen: false,
      fileIndex: undefined,
      // 類型資料字典
      typeOptions: [],
      sysloginlogList: [],
      statusOptions: [],
      // 關系表類型

      // 查询参数
      queryParams: {
        pageIndex: 1,
        pageSize: 10,
        username: undefined,
        status: undefined,
        ipaddr: undefined,
        loginLocation: undefined,
        createdAtOrder: 'desc'
      },
      // 表單参数
      form: {
      },
      // 表單校验
      rules: {
      }
    }
  },
  created() {
    this.getList()
    this.getDicts('sys_common_status').then(response => {
      this.statusOptions = response.data
    })
  },
  methods: {
    /** 查询参数列表 */
    getList() {
      this.loading = true
      listSysLoginlog(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.sysloginlogList = response.data.list
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
        ID: undefined,
        username: undefined,
        status: undefined,
        ipaddr: undefined,
        loginLocation: undefined,
        browser: undefined,
        os: undefined,
        platform: undefined,
        loginTime: undefined,
        remark: undefined,
        msg: undefined
      }
      this.resetForm('form')
    },
    getImgList: function() {
      this.form[this.fileIndex] = this.$refs['fileChoose'].resultList[0].fullUrl
    },
    fileClose: function() {
      this.fileOpen = false
    },
    statusFormat(row) {
      return this.selectDictLabel(this.statusOptions, row.status)
    },
    // 關系
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
      this.title = '新增系统Loginlog'
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
      const ID =
                row.id || this.ids
      getSysLoginlog(ID).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改系统Loginlog'
        this.isEdit = true
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
        return delSysLoginlog({ 'ids': Ids })
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
