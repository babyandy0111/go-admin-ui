<template>
  <div :style="{ padding: '0 0 32px 32px' }">
    <h4 :style="{ marginBottom: '20px' }">{{ title }}</h4>
    <v-chart
      height="254"
      :data="arr"
      :force-fit="true"
      :padding="['auto', 'auto', '40', '50']"
      :scale="defaultScale"
    >
      <v-interval
        position="x*y"
        opacity="1"
      >
      </v-interval>

      <v-tooltip
        :shared="true"
      />

      <v-axis
        data-key="x"
        :label="label"
        :tick-line="tickLine"
      />
      <v-axis
        data-key="y"
        :label="labelFormat"
        :title="title"
      />
    </v-chart>
  </div>
</template>

<script>
const label = {
  textStyle: {
    fill: '#aaaaaa'
  }
}

const labelFormat = {
  textStyle: {
    fill: '#aaaaaa'
  },
  formatter: function formatter(text) {
    return kFormatter(text)
  }
}

function kFormatter(num) {
  return Math.abs(num) > 999 ? Math.sign(num) * ((Math.abs(num) / 1000).toFixed(1)) + 'k' : Math.sign(num) * Math.abs(num)
}

const tickLine = {
  alignWithLabel: false,
  length: 0
}

const defaultScale = [{
  dataKey: 'x',
  min: 1
}, {
  dataKey: 'y',
  min: 1,
  max: 10000000,
  alias: '總金額'
}]

export default {
  name: 'Bar',
  props: {
    title: {
      type: String,
      default: ''
    },
    list: {
      type: Array,
      default: () => {}
    },
    scale: {
      type: Array,
      default: () => {
        return [{
          dataKey: 'x',
          min: 1
        }, {
          dataKey: 'y',
          min: 1,
          max: 10000000,
          alias: '總金額'
        }]
      }
    },
    tooltip: {
      type: Array,
      default: () => {
        return [
          'x*y',
          (x, y) => ({
            name: x,
            value: y
          })
        ]
      }
    }
  },
  data() {
    return {
      arr: [],
      label,
      labelFormat,
      tickLine,
      defaultScale
    }
  },
  mounted() {
    setTimeout(_ => {
      this.arr = this.list
    }, 300)
  }
}
</script>
