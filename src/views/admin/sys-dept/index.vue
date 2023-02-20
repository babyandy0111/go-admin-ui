<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form :inline="true">
          <el-form-item label="部門名稱">
            <el-input
              v-model="queryParams.deptName"
              placeholder="請輸入部門名稱"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="狀態">
            <el-select v-model="queryParams.status" placeholder="部門狀態" clearable size="small">
              <el-option
                v-for="dict in statusOptions"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button
              class="filter-item"
              type="primary"
              icon="el-icon-search"
              size="mini"
              @click="handleQuery"
            >查詢</el-button>
            <el-button
              v-permisaction="['admin:sysDept:add']"
              class="filter-item"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增</el-button>
          </el-form-item>
        </el-form>

        <el-table
          v-loading="loading"
          :data="deptList"
          row-key="deptId"
          default-expand-all
          border
          :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        >
          <el-table-column prop="deptName" label="部門名稱" />
          <el-table-column prop="sort" label="排序" width="200" />
          <el-table-column prop="status" label="狀態" :formatter="statusFormat" width="100">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.status === 1 ? 'danger' : 'success'"
                disable-transitions
              >{{ statusFormat(scope.row) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="建立時間" align="center" prop="createdAt" width="200">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysDept:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改</el-button>
              <el-button
                v-permisaction="['admin:sysDept:add']"
                size="mini"
                type="text"
                icon="el-icon-plus"
                @click="handleAdd(scope.row)"
              >新增</el-button>
              <el-button
                v-if="scope.row.p_id != 0"
                v-permisaction="['admin:sysDept:remove']"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
              >删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- 新增或修改部門对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="600px" :close-on-click-modal="false">
          <el-form ref="form" :model="form" :rules="rules" label-width="80px">
            <el-row>
              <el-col :span="24">
                <el-form-item label="上級部門" prop="parentId">
                  <treeselect
                    v-model="form.parentId"
                    :options="deptOptions"
                    :normalizer="normalizer"
                    :show-count="true"
                    placeholder="選擇上級部門"
                    :is-disabled="isEdit"
                  />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="部門名稱" prop="deptName">
                  <el-input v-model="form.deptName" placeholder="請輸入部門名稱" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="顯示排序" prop="orderNum">
                  <el-input-number v-model="form.sort" controls-position="right" :min="0" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="負責人" prop="leader">
                  <el-input v-model="form.leader" placeholder="請輸入負責人" maxlength="20" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="聯繫電話" prop="phone">
                  <el-input v-model="form.phone" placeholder="請輸入聯繫電話" maxlength="11" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="E-mail" prop="email">
                  <el-input v-model="form.email" placeholder="請輸入E-mail" maxlength="50" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="部門狀態">
                  <el-radio-group v-model="form.status">
                    <el-radio
                      v-for="dict in statusOptions"
                      :key="dict.value"
                      :label="dict.value"
                    >{{ dict.label }}</el-radio>
                  </el-radio-group>
                </el-form-item>
              </el-col>
            </el-row>
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
import { getDeptList, getDept, delDept, addDept, updateDept } from '@/api/admin/sys-dept'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'

export default {
  name: 'SysDeptManage',
  components: { Treeselect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 表格树資料
      deptList: [],
      // 部門树選项
      deptOptions: [],
      // 弹出层标题
      title: '',
      isEdit: false,
      // 是否顯示弹出层
      open: false,
      // 狀態資料字典
      statusOptions: [],
      // 查询参数
      queryParams: {
        deptName: undefined,
        status: undefined
      },
      // 表單参数
      form: {
      },
      // 表單校验
      rules: {
        parentId: [
          { required: true, message: '上級部門不能為空', trigger: 'blur' }
        ],
        deptName: [
          { required: true, message: '部門名稱不能為空', trigger: 'blur' }
        ],
        sort: [
          { required: true, message: '選單顺序不能為空', trigger: 'blur' }
        ],
        leader: [
          { required: true, message: '負責人不能為空', trigger: 'blur' }
        ],
        email: [
          {
            type: 'email',
            message: "'請輸入正確的E-mail地址",
            trigger: ['blur', 'change']
          }
        ],
        phone: [
          {
            pattern: /^09[0-9]{8}$/,
            message: '請輸入正確的手機號碼',
            trigger: 'blur'
          }
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
    /** 查询部門列表 */
    getList() {
      this.loading = true
      getDeptList(this.queryParams).then(response => {
        this.deptList = response.data
        this.loading = false
      })
    },
    /** 转换部門資料结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.deptId,
        label: node.deptName,
        children: node.children
      }
    },
    /** 查询部門下拉树结构 */
    getTreeselect(e) {
      getDeptList().then(response => {
        this.deptOptions = []

        if (e === 'update') {
          const dept = { deptId: 0, deptName: '主类目', children: [], isDisabled: true }
          dept.children = response.data
          this.deptOptions.push(dept)
        } else {
          const dept = { deptId: 0, deptName: '主类目', children: [] }
          dept.children = response.data
          this.deptOptions.push(dept)
        }
      })
    },
    // 字典狀態字典翻译
    statusFormat(row) {
      return this.selectDictLabel(this.statusOptions, parseInt(row.status))
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        deptId: undefined,
        parentId: undefined,
        deptName: undefined,
        sort: 10,
        leader: undefined,
        phone: undefined,
        email: undefined,
        status: '2'
      }
    },
    /** 查詢按钮操作 */
    handleQuery() {
      this.getList()
    },
    /** 新增按钮操作 */
    handleAdd(row) {
      this.reset()
      this.getTreeselect('add')
      if (row !== undefined) {
        this.form.parentId = row.deptId
      }
      this.open = true
      this.title = '新增部門'
      this.isEdit = false
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      this.getTreeselect('update')

      getDept(row.deptId).then(response => {
        this.form = response.data
        this.form.status = String(this.form.status)
        this.form.sort = String(this.form.sort)
        this.open = true
        this.title = '修改部門'
        this.isEdit = true
      })
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          this.form.status = parseInt(this.form.status)
          this.form.sort = parseInt(this.form.sort)
          if (this.form.deptId !== undefined) {
            updateDept(this.form, this.form.deptId).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addDept(this.form).then(response => {
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
      const Ids = (row.deptId && [row.deptId]) || this.ids
      this.$confirm(
        '是否確認删除名稱為"' + row.deptName + '"的資料项?',
        '警告',
        {
          confirmButtonText: '確定',
          cancelButtonText: '取消',
          type: 'warning'
        }
      )
        .then(function() {
          return delDept({ 'ids': Ids })
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
