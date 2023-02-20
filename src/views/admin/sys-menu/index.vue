<template>
  <BasicLayout>
    <template #wrapper>
      <el-card class="box-card">
        <el-form :inline="true">
          <el-form-item label="選單名稱">
            <el-input
              v-model="queryParams.title"
              placeholder="請輸入選單名稱"
              clearable
              size="small"
              @keyup.enter.native="handleQuery"
            />
          </el-form-item>
          <el-form-item label="狀態">
            <el-select v-model="queryParams.visible" placeholder="選單狀態" clearable size="small">
              <el-option
                v-for="dict in visibleOptions"
                :key="dict.value"
                :label="dict.label"
                :value="dict.value"
              />
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">查詢</el-button>
            <el-button
              v-permisaction="['admin:sysMenu:add']"
              type="primary"
              icon="el-icon-plus"
              size="mini"
              @click="handleAdd"
            >新增</el-button>
          </el-form-item>
        </el-form>

        <el-table
          v-loading="loading"
          :data="menuList"
          border
          row-key="menuId"
          :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        >
          <el-table-column prop="title" label="選單名稱" :show-overflow-tooltip="true" width="180px" />
          <el-table-column prop="icon" label="Icon" align="center" width="100px">
            <template slot-scope="scope">
              <svg-icon :icon-class="scope.row.icon" />
            </template>
          </el-table-column>
          <el-table-column prop="sort" label="排序" width="60px" />
          <el-table-column prop="permission" label="權限標示" :show-overflow-tooltip="true">
            <template slot-scope="scope">
              <el-popover v-if="scope.row.sysApi.length>0" trigger="hover" placement="top">
                <el-table
                  :data="scope.row.sysApi"
                  border
                  style="width: 100%"
                >
                  <el-table-column
                    prop="title"
                    label="title"
                    width="260px"
                  >
                    <template slot-scope="scope">
                      <span v-if="scope.row.type=='SYS' && scope.row.title!=''"><el-tag type="success">{{ '['+scope.row.type +'] '+ scope.row.title }}</el-tag></span>
                      <span v-if="scope.row.type!='SYS' && scope.row.title!=''"><el-tag type="">{{ '['+scope.row.type +'] '+scope.row.title }}</el-tag></span>
                      <span v-if="scope.row.title==''"><el-tag type="danger">暂無</el-tag></span>

                    </template>
                  </el-table-column>
                  <el-table-column
                    prop="path"
                    label="path"
                    width="270px"
                  >
                    <template slot-scope="scope">
                      <el-tag v-if="scope.row.action=='GET'">{{ scope.row.action }}</el-tag>
                      <el-tag v-if="scope.row.action=='POST'" type="success">{{ scope.row.action }}</el-tag>
                      <el-tag v-if="scope.row.action=='PUT'" type="warning">{{ scope.row.action }}</el-tag>
                      <el-tag v-if="scope.row.action=='DELETE'" type="danger">{{ scope.row.action }}</el-tag>
                      {{ scope.row.path }}
                    </template>
                  </el-table-column>

                </el-table>
                <div slot="reference" class="name-wrapper">
                  <span v-if="scope.row.permission==''">-</span>
                  <span v-else>{{ scope.row.permission }}</span>
                </div>
              </el-popover>
              <span v-else>
                <span v-if="scope.row.permission==''">-</span>
                <span v-else>{{ scope.row.permission }}</span>
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="path" label="组件路径" :show-overflow-tooltip="true">
            <template slot-scope="scope">
              <span v-if="scope.row.menuType=='A'">{{ scope.row.path }}</span>
              <span v-else>{{ scope.row.component }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="visible" label="可见" :formatter="visibleFormat" width="80">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.visible === '1' ? 'danger' : 'success'"
                disable-transitions
              >{{ visibleFormat(scope.row) }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column label="創建時間" align="center" prop="createdAt" width="180">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdAt) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="180">
            <template slot-scope="scope">
              <el-button
                v-permisaction="['admin:sysMenu:edit']"
                size="mini"
                type="text"
                icon="el-icon-edit"
                @click="handleUpdate(scope.row)"
              >修改</el-button>
              <el-button
                v-permisaction="['admin:sysMenu:add']"
                size="mini"
                type="text"
                icon="el-icon-plus"
                @click="handleAdd(scope.row)"
              >新增</el-button>
              <el-button
                v-permisaction="['admin:sysMenu:remove']"
                size="mini"
                type="text"
                icon="el-icon-delete"
                @click="handleDelete(scope.row)"
              >删除</el-button>
            </template>
          </el-table-column>
        </el-table>

        <!-- 新增或修改選單对话框 -->
        <el-drawer
          ref="drawer"
          :title="title"
          :before-close="cancel"
          :visible.sync="open"
          direction="rtl"
          custom-class="demo-drawer"
          size="830px"
        >
          <div class="demo-drawer__content">
            <el-form ref="form" :model="form" :rules="rules" label-position="top" label-width="106px">
              <el-row>
                <el-col :span="24">
                  <el-form-item prop="parentId">
                    <span slot="label">
                      上級選單
                      <el-tooltip content="指当前選單停靠的選單归属" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <treeselect
                      v-model="form.parentId"
                      :options="menuOptions"
                      :normalizer="normalizer"
                      :show-count="true"
                      placeholder="選擇上級選單"
                    />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item prop="title">
                    <span slot="label">
                      選單标题
                      <el-tooltip content="選單位置顯示的说明訊息" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input v-model="form.title" placeholder="請輸入選單标题" />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item prop="sort">
                    <span slot="label">
                      顯示排序
                      <el-tooltip content="根据序号升序排列" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input-number v-model="form.sort" controls-position="right" :min="0" />
                  </el-form-item>
                </el-col>

                <el-col :span="24">
                  <el-form-item prop="menuType">
                    <span slot="label">
                      選單類型
                      <el-tooltip content="包含目录：以及選單或者選單组，選單：具体对应某一个頁面，按钮：功能才做按钮；" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-radio-group v-model="form.menuType">
                      <el-radio label="M">目录</el-radio>
                      <el-radio label="C">選單</el-radio>
                      <el-radio label="F">按钮</el-radio>
                    </el-radio-group>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item label="選單Icon">
                    <el-popover
                      placement="bottom-start"
                      width="460"
                      trigger="click"
                      @show="$refs['iconSelect'].reset()"
                    >
                      <IconSelect ref="iconSelect" @selected="selected" />
                      <el-input slot="reference" v-model="form.icon" placeholder="点击選擇Icon" readonly>
                        <svg-icon
                          v-if="form.icon"
                          slot="prefix"
                          :icon-class="form.icon"
                          class="el-input__icon"
                          style="height: 32px;width: 16px;"
                        />
                        <i v-else slot="prefix" class="el-icon-search el-input__icon" />
                      </el-input>
                    </el-popover>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item v-if="form.menuType == 'M' || form.menuType == 'C'" prop="menuName">
                    <span slot="label">
                      路由名稱
                      <el-tooltip content="需要和頁面name保持一致，对应頁面即可選擇缓存" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input v-model="form.menuName" placeholder="請輸入路由名稱" />
                  </el-form-item>
                </el-col>

                <el-col v-if="form.menuType == 'M' || form.menuType == 'C'" :span="12">
                  <el-form-item prop="component">
                    <span slot="label">
                      组件路径
                      <el-tooltip content="選單对应的具体vue頁面文件路径views的下級路径/admin/sys-api/index；目录類型：填写Layout，如何有二級目录請参照日志目录填写；" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input v-model="form.component" placeholder="請輸入组件路径" />
                  </el-form-item>
                </el-col>

                <el-col :span="12">
                  <el-form-item v-if="form.menuType == 'M' || form.menuType == 'C'">
                    <span slot="label">
                      是否外链
                      <el-tooltip content="可以通過iframe打开指定地址" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-radio-group v-model="form.isFrame">
                      <el-radio label="0">是</el-radio>
                      <el-radio label="1">否</el-radio>
                    </el-radio-group>
                  </el-form-item>
                </el-col>

                <el-col :span="12">
                  <el-form-item v-if="form.menuType != 'F'" prop="path">
                    <span slot="label">
                      路由地址
                      <el-tooltip content="访问此頁面自定义的url地址，建议/开头书写，例如 /app-name/menu-name" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input v-model="form.path" placeholder="請輸入路由地址" />
                  </el-form-item>
                </el-col>

                <el-col :span="12">
                  <el-form-item v-if="form.menuType == 'F' || form.menuType == 'C'">
                    <span slot="label">
                      權限標示
                      <el-tooltip content="前端權限控制按钮是否顯示" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-input v-model="form.permission" placeholder="請權限標示" maxlength="50" />
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-form-item v-if="form.menuType != 'F'">
                    <span slot="label">
                      選單狀態
                      <el-tooltip content="需要顯示在選單列表的選單设置為顯示，否则设置為隐藏" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-radio-group v-model="form.visible">
                      <el-radio
                        v-for="dict in visibleOptions"
                        :key="dict.value"
                        :label="dict.value"
                      >{{ dict.label }}</el-radio>
                    </el-radio-group>
                  </el-form-item>
                </el-col>
                <el-col :span="24">
                  <el-form-item v-if="form.menuType == 'F' || form.menuType == 'C'">
                    <span slot="label">
                      api權限
                      <el-tooltip content="設定在这个才做上需要使用到的接口，否则在设置用户角色時，接口将無权访问。" placement="top">
                        <i class="el-icon-question" />
                      </el-tooltip>
                    </span>
                    <el-transfer
                      v-model="form.apis"
                      style="text-align: left; display: inline-block"
                      filterable
                      :props="{
                        key: 'id',
                        label: 'title'
                      }"
                      :titles="['未授权', '已授权']"
                      :button-texts="['收回', '授权 ']"
                      :format="{
                        noChecked: '${total}',
                        hasChecked: '${checked}/${total}'
                      }"
                      class="panel"
                      :data="sysapiList"
                      @change="handleChange"
                    >
                      <span slot-scope="{ option }">{{ option.title }}</span>
                    </el-transfer>
                  </el-form-item>
                </el-col>
              </el-row>
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
import { listMenu, getMenu, delMenu, addMenu, updateMenu } from '@/api/admin/sys-menu'
import { listSysApi } from '@/api/admin/sys-api'

import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import IconSelect from '@/components/IconSelect'

export default {
  name: 'SysMenuManage',
  components: { Treeselect, IconSelect },
  data() {
    return {
      // 遮罩层
      loading: true,
      // 選單表格树資料
      menuList: [],
      sysapiList: [],
      // 選單树選项
      menuOptions: [],
      // 弹出层标题
      title: '',
      // 是否顯示弹出层
      open: false,
      // 選單狀態資料字典
      visibleOptions: [],
      // 查询参数
      queryParams: {
        title: undefined,
        visible: undefined
      },
      // 表單参数
      form: {
        apis: [],
        sysApi: []
      },
      // 表單校验
      rules: {
        title: [{ required: true, message: '選單标题不能為空', trigger: 'blur' }],
        sort: [{ required: true, message: '選單顺序不能為空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()

    this.getApiList()
    this.getDicts('sys_show_hide').then(response => {
      this.visibleOptions = response.data
    })
  },
  methods: {
    handleChange(value, direction, movedKeys) {
      console.log(value, direction, movedKeys)
      const list = this.form.sysApi
      this.form.apis = value
      if (direction === 'right') {
        for (let x = 0; x < movedKeys.length; x++) {
          for (let index = 0; index < this.sysapiList.length; index++) {
            const element = this.sysapiList[index]
            if (element.id === movedKeys[x]) {
              list.push(element)
              break
            }
          }
        }
        this.form.sysApi = list
      } else if (direction === 'left') {
        const l = []
        for (let index = 0; index < movedKeys.length; index++) {
          const element = movedKeys[index]
          for (let x = 0; x < list.length; x++) {
            const e = list[x]
            if (element !== e.id) {
              l.push()
              break
            }
          }
        }
        this.form.sysApi = l
      }
      // this.setApis(this.form.SysApi)
      console.log(this.form.sysApi)
    },
    getApiList() {
      this.loading = true
      listSysApi({ 'pageSize': 10000, 'type': 'BUS' }).then(response => {
        this.sysapiList = response.data.list
        this.loading = false
      }
      )
    },
    handleClose(done) {
      // if (this.loading) {
      //   return
      // }
      // this.$confirm('需要提交表單吗？')
      //   .then(_ => {
      //     this.loading = true
      //     this.timer = setTimeout(() => {
      //       done()
      //       // 动画关闭需要一定的時间
      //       setTimeout(() => {
      //         this.loading = false
      //       }, 400)
      //     }, 1000)
      //   })
      //   .catch(_ => {})
    },
    // 選擇Icon
    selected(name) {
      this.form.icon = name
    },
    /** 查询選單列表 */
    getList() {
      this.loading = true
      listMenu(this.queryParams).then(response => {
        this.menuList = response.data
        this.loading = false
      })
    },
    /** 转换選單資料结构 */
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.menuId,
        label: node.title,
        children: node.children
      }
    },
    /** 查询選單下拉树结构 */
    getTreeselect() {
      listMenu().then(response => {
        this.menuOptions = []
        const menu = { menuId: 0, title: '主类目', children: [] }
        menu.children = response.data
        this.menuOptions.push(menu)
      })
    },
    // 選單顯示狀態字典翻译
    visibleFormat(row) {
      if (row.menuType === 'F') {
        return '-- --'
      }
      return this.selectDictLabel(this.visibleOptions, row.visible)
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表單重置
    reset() {
      this.form = {
        menuId: undefined,
        parentId: 0,
        menuName: undefined,
        icon: undefined,
        menuType: 'M',
        apis: [],
        sort: 0,
        action: this.form.menuType === 'A' ? this.form.action : '',
        isFrame: '1',
        visible: '0'
      }
      this.resetForm('form')
    },
    /** 查詢按钮操作 */
    handleQuery() {
      this.getList()
    },
    /** 新增按钮操作 */
    handleAdd(row) {
      this.reset()
      this.getTreeselect()
      if (row != null) {
        this.form.parentId = row.menuId
      }
      this.open = true
      this.title = '新增選單'
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      this.getTreeselect()
      getMenu(row.menuId).then(response => {
        this.form = response.data
        this.open = true
        this.title = '修改選單'
      })
    },
    setApis(apiArray) {
      var l = []
      for (var index = 0; index < apiArray.length; index++) {
        const element = apiArray[index]
        l.push(element.id)
      }
      this.form.apis = l
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs['form'].validate(valid => {
        if (valid) {
          if (this.form.menuId !== undefined) {
            updateMenu(this.form, this.form.menuId).then(response => {
              if (response.code === 200) {
                this.msgSuccess(response.msg)
                this.open = false
                this.getList()
              } else {
                this.msgError(response.msg)
              }
            })
          } else {
            addMenu(this.form).then(response => {
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
      this.$confirm('是否確認删除名稱為"' + row.title + '"的資料项?', '警告', {
        confirmButtonText: '確定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(function() {
        var Ids = (row.menuId && [row.menuId]) || this.ids
        return delMenu({ 'ids': Ids })
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
<style lang="css">
.panel .el-transfer__buttons{
  width: 150px;
}
.panel .el-transfer__buttons .el-button + .el-button{
  margin-left:0;
}
.panel .el-transfer-panel{
  width: 300px;
}

.el-col {
padding: 0 5px;
}
.el-drawer__header{
margin-bottom: 0;
}
</style>
