<template>

  <div class="dashboard-editor-container">
    <el-card class="box-card">
      <el-form ref="queryForm" :model="queryParams" :inline="true" label-width="68px">
        <el-form-item label="年份" prop="status">
          <el-select v-model="queryParams.year" placeholder="選擇年度" @change="selectGet">
            <el-option label="2023" value="2023" />
            <el-option label="2022" value="2022" />
          </el-select>
        </el-form-item>
      </el-form>
    </el-card>
    <hr>
    <el-row :gutter="12">
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '10px' }">
        <chart-card title="總業績" :total="total">
          <el-tooltip slot="action" class="item" effect="dark" content="指標說明" placement="top-start">
            <i class="el-icon-warning-outline" />
          </el-tooltip>
          <div>
            <trend flag="top" style="margin-right: 16px;" rate="12">
              <span slot="term">周同比</span>
            </trend>
            <trend flag="bottom" rate="11">
              <span slot="term">日同比</span>
            </trend>
          </div>
          <template slot="footer">日均銷售額:<span> {{ total_avg }}</span></template>
        </chart-card>
      </el-col>
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '10px' }">
        <chart-card title="客戶數" :total="account">
          <el-tooltip slot="action" class="item" effect="dark" content="指標說明" placement="top-start">
            <i class="el-icon-warning-outline" />
          </el-tooltip>
          <div>
            <mini-area />
          </div>
          <template slot="footer">均日增客戶<span> {{ account_avg }}</span></template>
        </chart-card>
      </el-col>
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '10px' }">
        <chart-card title="已勾稽總額" :total="6560000">
          <el-tooltip slot="action" class="item" effect="dark" content="指標說明" placement="top-start">
            <i class="el-icon-warning-outline" />
          </el-tooltip>
          <div>
            <mini-bar />
          </div>
          <template slot="footer">轉化率 <span>60%</span></template>
        </chart-card>
      </el-col>
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '10px' }">
        <chart-card title="業績比較" total="78%">
          <el-tooltip slot="action" class="item" effect="dark" content="指標說明" placement="top-start">
            <i class="el-icon-warning-outline" />
          </el-tooltip>
          <div>
            <mini-progress color="rgb(19, 194, 194)" :target="80" :percentage="78" height="8px" />
          </div>
          <template slot="footer">
            <trend flag="top" style="margin-right: 16px;" rate="12">
              <span slot="term">同周比</span>
            </trend>
            <trend flag="bottom" rate="80">
              <span slot="term">同月比</span>
            </trend>
          </template>
        </chart-card>
      </el-col>
    </el-row>

    <el-card :bordered="false" :body-style="{padding: '10'}">
      <div class="salesCard">
        <el-tabs v-model="activeTab" @tab-click="handleTabClick">
          <el-tab-pane label="TWD" name="TWD" lazy>
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data1" title="業績額" />
                <bar :list="AccountData1" title="成交客量" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="Top15排行榜" :list="rankList1" />
              </el-col>
            </el-row>
          </el-tab-pane>
          <el-tab-pane label="USD" name="USD" lazy>
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data2" title="業績額" />
                <bar :list="AccountData2" title="成交客量" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="Top15排行榜" :list="rankList2" />
              </el-col>
            </el-row>
          </el-tab-pane>
          <el-tab-pane label="CNY" name="CNY" lazy>
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data3" title="業績額" />
                <bar :list="AccountData3" title="成交客量" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="Top15排行榜" :list="rankList3" />
              </el-col>
            </el-row>
          </el-tab-pane>
        </el-tabs>
        <hr>
        <el-row>
          <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
            <vbar :list="Data4" title="產品年度排行" lazy />
          </el-col>
          <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
            <gauge />
          </el-col>
        </el-row>
      </div>
    </el-card>

    <el-card :bordered="false" :body-style="{padding: '10'}">
      <test />
    </el-card>

  </div>
</template>

<script>
import ChartCard from '@/components/ChartCard'
import Trend from '@/components/Trend'
import MiniArea from '@/components/MiniArea'
import MiniBar from '@/components/MiniBar'
import MiniProgress from '@/components/MiniProgress'
import RankList from '@/components/RankList/index'
import Bar from '@/components/Bar.vue'
import Vbar from '@/components/VBar.vue'
import Test from '@/components/Test.vue'
import { getSalesByM, getSalesByMAccount, getSalesByProduct, getSalesTop15 } from '@/api/dashboard'
import { kFormatter } from '@/utils'
import Gauge from '@/components/Gauge'

const Data1 = []
const AccountData1 = []
const Data2 = []
const AccountData2 = []
const Data3 = []
const Data4 = []
const AccountData3 = []
const rankList1 = []
const rankList2 = []
const rankList3 = []
const total = 0
const total_twd = 0
const total_usd = 0
const total_cny = 0
const total_avg = 0
const account = 0
const account_twd = 0
const account_usd = 0
const account_cny = 0
const account_avg = 0
const activeTab = 'TWD'
export default {
  name: 'DashboardAdmin',
  components: {
    Gauge,
    ChartCard,
    Trend,
    MiniArea,
    MiniBar,
    MiniProgress,
    RankList,
    Bar,
    Vbar,
    Test
  },
  data() {
    return {
      Data1,
      AccountData1,
      Data2,
      AccountData2,
      Data3,
      AccountData3,
      Data4,
      rankList1,
      rankList2,
      rankList3,
      total,
      total_twd,
      total_usd,
      total_cny,
      total_avg,
      account,
      account_avg,
      account_twd,
      account_usd,
      account_cny,
      activeTab,
      queryParams: {
        year: '2023',
        currency: 'TWD'
      }
    }
  },
  mounted() {
  },
  created() {
    const objectDate = new Date()
    this.queryParams.year = objectDate.getFullYear() - 1
    this.SalesByM()
    this.SalesTop15()
    this.SalesAccountNumber()
    this.SalesProductTop10('TWD')
  },
  methods: {
    selectGet(value) {
      this.resetData()
      this.queryParams.year = value
      this.queryParams.currency = 'TWD'
      this.activeTab = this.queryParams.currency
      this.SalesByM()
      this.SalesTop15()
      this.SalesAccountNumber()
      this.SalesProductTop10(this.queryParams.currency)
    },
    resetData() {
      Data1.length = 0
      Data2.length = 0
      Data3.length = 0
      Data4.length = 0
      rankList1.length = 0
      rankList2.length = 0
      rankList3.length = 0
      AccountData1.length = 0
      AccountData2.length = 0
      AccountData3.length = 0
      this.total = 0
      this.total_twd = 0
      this.total_usd = 0
      this.total_cny = 0
      this.total_avg = 0
      this.account = 0
      this.account_twd = 0
      this.account_usd = 0
      this.account_cny = 0
      this.account_avg = 0
    },
    handleTabClick(tab) {
      Data4.length = 0
      switch (tab.index) {
        case '0':
          console.log(this.total_twd)
          this.total = this.total_twd
          this.total_avg = kFormatter(this.total / 365)
          this.account = this.account_twd
          this.account_avg = kFormatter(this.account / 365)
          this.SalesProductTop10(tab.label)
          break
        case '1':
          this.total = this.total_usd
          this.total_avg = kFormatter(this.total / 365)
          this.account = this.account_usd
          this.account_avg = kFormatter(this.account / 365)
          this.SalesProductTop10(tab.label)
          break
        case '2':
          this.total = this.total_cny
          this.total_avg = kFormatter(this.total / 365)
          this.account = this.account_cny
          this.account_avg = kFormatter(this.account / 365)
          this.SalesProductTop10(tab.label)
          break
      }
    },
    SalesByM() {
      getSalesByM({
        currency: 'TWD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data1.push({
            x: `${item[index].sales_date}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
          })
          this.total_twd += parseInt(item[index].sales_sum, 10)
          this.total += parseInt(item[index].sales_sum, 10)
        })
        this.total_avg = kFormatter(this.total / 365)
      })

      getSalesByM({
        currency: 'USD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data2.push({
            x: `${item[index].sales_date}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
          })
          this.total_usd += parseInt(item[index].sales_sum, 10)
        })
      })

      getSalesByM({
        currency: 'CNY',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data3.push({
            x: `${item[index].sales_date}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
          })
          this.total_cny += parseInt(item[index].sales_sum, 10)
        })
      })
    },
    SalesTop15() {
      getSalesTop15({
        currency: 'TWD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          rankList1.push({
            name: item[index].name,
            total: kFormatter(parseInt(item[index].sales_sum, 10))
          })
        })
      })

      getSalesTop15({
        currency: 'USD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          rankList2.push({
            name: item[index].name,
            total: kFormatter(parseInt(item[index].sales_sum, 10))
          })
        })
      })

      getSalesTop15({
        currency: 'CNY',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          rankList3.push({
            name: item[index].name,
            total: kFormatter(parseInt(item[index].sales_sum, 10))
          })
        })
      })
    },
    SalesAccountNumber() {
      getSalesByMAccount({
        currency: 'TWD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          AccountData1.push({
            x: item[index].sales_date,
            y: parseInt(item[index].account_number, 10)
          })
          this.account_twd += parseInt(item[index].account_number, 10)
        })
        this.account = this.account_twd
        this.account_avg = this.account_twd / 365
      })

      getSalesByMAccount({
        currency: 'USD',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          AccountData2.push({
            x: item[index].sales_date,
            y: parseInt(item[index].account_number, 10)
          })
          this.account_usd += parseInt(item[index].account_number, 10)
        })
      })

      getSalesByMAccount({
        currency: 'CNY',
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          AccountData3.push({
            x: item[index].sales_date,
            y: parseInt(item[index].account_number, 10)
          })
          this.account_cny += parseInt(item[index].account_number, 10)
        })
      })
    },
    SalesProductTop10(currency) {
      getSalesByProduct({
        currency: currency,
        year: this.queryParams.year
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data4.push({
            x: item[index].product_name,
            y: parseInt(item[index].sales_sum, 10)
          })
        })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 12px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .github-corner {
    position: absolute;
    top: 0;
    border: 0;
    right: 0;
  }

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}

::v-deep .el-tabs__item {
  padding-left: 16px !important;
  height: 50px;
  line-height: 50px;
}

@media (max-width: 1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}

#test {
  width: 100%;
  height: 600px;
}
</style>
