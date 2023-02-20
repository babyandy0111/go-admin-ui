<template>
  <el-form ref="basicInfoForm" :model="info" :rules="rules" label-width="150px">
    <el-row>
      <el-col :span="12">
        <el-form-item prop="tableName">
          <span slot="label">
            資料表名稱
            <el-tooltip content="資料库表名稱，针对gorm對應的table()使用，⚠️这里必须是蛇形结构" placement="top">
              <i class="el-icon-question" />
            </el-tooltip>
          </span>
          <el-input v-model="info.tableName" placeholder="請輸入表名稱" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item prop="tableComment">
          <span slot="label">
            選單名稱
            <el-tooltip content="同步的資料库表名稱，生成設定資料時，用作選單名稱" placement="top">
              <i class="el-icon-question" />
            </el-tooltip>
          </span>
          <el-input v-model="info.tableComment" placeholder="請輸入選單名稱" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item prop="className">
          <span slot="label">
            结构体模型名稱
            <el-tooltip content="结构体模型名稱，代碼中的struct名稱定義使用" placement="top">
              <i class="el-icon-question" />
            </el-tooltip>
          </span>
          <el-input v-model="info.className" placeholder="請輸入" />
        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item label="作者名稱" prop="functionAuthor">
          <el-input v-model="info.functionAuthor" placeholder="請輸入作者名稱" />
        </el-form-item>
      </el-col>
      <!-- <el-col :span="12">
        <el-form-item prop="isLogicalDelete">
          <span slot="label">
            是否逻辑刪除
            <el-tooltip content="目前只支持逻辑刪除" placement="top">
              <i class="el-icon-question" />
            </el-tooltip>
          </span>
          <el-radio-group v-model="info.isLogicalDelete">
            <el-radio label="1">是</el-radio>
            <el-radio label="0">否</el-radio>
          </el-radio-group>

        </el-form-item>
      </el-col>
      <el-col :span="12">
        <el-form-item v-if="info.isLogicalDelete == '1'" label="逻辑刪除字段" prop="logicalDeleteColumn">
          <el-input v-model="info.logicalDeleteColumn" placeholder="請輸入" />
        </el-form-item>
      </el-col> -->
      <el-col :span="24">
        <el-form-item label="備註" prop="remark">
          <el-input v-model="info.remark" type="textarea" :rows="3" />
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>
<script>
export default {
  name: 'BasicInfoForm',
  props: {
    info: {
      type: Object,
      default: null
    }
  },
  data() {
    return {
      rules: {
        tableName: [
          { required: true, message: '請輸入表名稱', trigger: 'blur' },
          { pattern: /^[a-z\._]*$/g, trigger: 'blur', message: '只允许小寫字母,例如 sys_demo 格式' }
        ],
        tableComment: [
          { required: true, message: '請輸入選單名稱', trigger: 'blur' }
        ],
        className: [
          { required: true, message: '請輸入模型名稱', trigger: 'blur' },
          { pattern: /^[A-Z][A-z0-9]*$/g, trigger: 'blur', message: '必须以大寫字母開頭,例如 SysDemo 格式' }
        ],
        functionAuthor: [
          { required: true, message: '請輸入作者', trigger: 'blur' },
          { pattern: /^[A-Za-z]+$/, trigger: 'blur', message: '校验规则:  只允许输入字母 a-z 或大寫 A-Z' }
        ]
      }
    }
  }
}
</script>
