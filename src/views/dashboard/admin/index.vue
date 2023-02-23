<template>

  <div class="dashboard-editor-container">
    <el-row :gutter="12">
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '12px' }">
        <chart-card title="總業績" total="$126,560">
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
          <template slot="footer">日均銷售額<span>￥ 234.56</span></template>
        </chart-card>
      </el-col>
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '12px' }">
        <chart-card title="客戶數" :total="8846">
          <el-tooltip slot="action" class="item" effect="dark" content="指標說明" placement="top-start">
            <i class="el-icon-warning-outline" />
          </el-tooltip>
          <div>
            <mini-area />
          </div>
          <template slot="footer">日增客戶<span> {{ '1234' }}</span></template>
        </chart-card>
      </el-col>
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '12px' }">
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
      <el-col :sm="24" :xs="24" :md="6" :xl="6" :lg="6" :style="{ marginBottom: '12px' }">
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

    <el-card :bordered="false" :body-style="{padding: '0'}">
      <div class="salesCard">
        <el-tabs lazy="true">
          <el-tab-pane label="本年度業績(TWD)">
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data1" title="業績額排行" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="排行榜" :list="rankList" />
              </el-col>
            </el-row>
          </el-tab-pane>
          <el-tab-pane label="本年度業績(USD)">
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data2" title="業績額排行" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="排行榜" :list="rankList" />
              </el-col>
            </el-row>
          </el-tab-pane>
          <el-tab-pane label="本年度業績(CNY)">
            <el-row>
              <el-col :xl="16" :lg="12" :md="12" :sm="24" :xs="24">
                <bar :list="Data3" title="業績額排行" />
              </el-col>
              <el-col :xl="8" :lg="12" :md="12" :sm="24" :xs="24">
                <rank-list title="排行榜" :list="rankList" />
              </el-col>
            </el-row>
          </el-tab-pane>
        </el-tabs>
      </div>
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
import { getSalesByM } from '@/api/dashboard'

const Data1 = []
const Data2 = []
const Data3 = []

const rankList = []
for (let i = 0; i < 7; i++) {
  rankList.push({
    name: 'xxxx ' + (i + 1),
    total: 1234.56 - i * 100
  })
}

export default {
  name: 'DashboardAdmin',
  components: {
    ChartCard,
    Trend,
    MiniArea,
    MiniBar,
    MiniProgress,
    RankList,
    Bar
  },
  data() {
    return {
      Data1,
      Data2,
      Data3,
      rankList,
      myChart: null
    }
  },
  mounted() {
  },
  created() {
    this.getSalesByM()
  },
  methods: {
    getSalesByM() {
      getSalesByM({
        currency: 'TWD',
        year: '2022'
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data1.push({
            x: `${item[index].sales_data}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
          })
        })
      })

      getSalesByM({
        currency: 'USD',
        year: '2022'
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data2.push({
            x: `${item[index].sales_data}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
          })
        })
      })

      getSalesByM({
        currency: 'CNY',
        year: '2022'
      }).then(response => {
        response.data.list.map((value, index, item) => {
          Data3.push({
            x: `${item[index].sales_data}`,
            y: Math.floor(parseInt(item[index].sales_sum, 10))
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
