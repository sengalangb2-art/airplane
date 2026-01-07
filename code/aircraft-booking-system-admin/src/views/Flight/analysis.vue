<template>
  <div class="container">
    <common-title button title="航班订单统计分析">
    </common-title>

    <div class="tab-container">
      <el-tabs v-model="activeTab" @tab-click="handleTabClick">
        <el-tab-pane label="机票年度分析" name="yearly">
          <div class="filter-container">
            <el-select v-model="selectedYear" placeholder="选择年份" @change="loadYearlyData" style="width: 150px;">
              <el-option
                v-for="year in availableYears"
                :key="year"
                :label="year + '年'"
                :value="year"
              />
            </el-select>
          </div>
          <div class="chart-container">
            <div id="yearlyChart" ref="yearlyChartRef" class="chart"></div>
          </div>
        </el-tab-pane>

        <el-tab-pane label="航班类型销售分析" name="flightType">
          <div class="filter-container">
            <el-select v-model="selectedTypeYear" placeholder="选择年份" style="width: 150px;" @change="loadTypeData">
              <el-option
                v-for="year in availableYears"
                :key="year"
                :label="year + '年'"
                :value="year"
              />
            </el-select>
          </div>
          <div class="chart-container">
            <div id="typeChart" ref="typeChartRef" class="chart"></div>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue';
import { getAllOrders, getAllFlightTypes } from '@/api/flight';
import * as echarts from 'echarts';

// Tab相关
// 调整Tab切换逻辑
const handleTabClick = async (tab) => {
  if (tab.props.name === 'yearly') {
    await loadOrderData(); // 切换Tab时刷新数据
    nextTick(() => initYearlyChart());
  } else if (tab.props.name === 'flightType') {
    await Promise.all([loadOrderData(), loadTypeListData()]); // 确保类型+订单数据最新
    nextTick(() => initTypeChart());
  }
};

// 年份选择相关
const currentYear = new Date().getFullYear();
const availableYears = ref([]);
const selectedYear = ref(currentYear);
const selectedTypeYear = ref(currentYear);

// 初始化可选年份
for (let i = 0; i < 5; i++) {
  availableYears.value.push(currentYear - i);
}

// 图表实例
let yearlyChart = null;
let typeChart = null;

// 图表引用
const yearlyChartRef = ref(null);
const typeChartRef = ref(null);

// 数据
const orderList = ref([]);
const typeList = ref([]);

// 获取机票订单数据
const loadOrderData = async () => {
  try {
    const { data } = await getAllOrders();

    if (data && data.list) {
      orderList.value = data.list;
    }
  } catch (error) {
    console.error('获取订单数据失败:', error);
  }
};

// 获取航班类型数据
const loadTypeListData = async () => {
  try {
    const { data } = await getAllFlightTypes();

    if (data && data.list) {
      typeList.value = data.list;
    }
  } catch (error) {
    console.error('获取航班类型数据失败:', error);
  }
};

// 处理年度数据
const loadYearlyData = async (year = selectedYear.value) => {
  selectedYear.value = year;
  await loadOrderData(); // 重新加载最新订单数据
  nextTick(() => initYearlyChart());
};

// 处理航班类型数据
const loadTypeData = (year = selectedTypeYear.value) => {
  selectedTypeYear.value = year;
  initTypeChart();
};


// 初始化机票年度分析图表 - 补充无数据兜底
const initYearlyChart = () => {
  if (!yearlyChartRef.value) return;
  if (yearlyChart) yearlyChart.dispose();
  yearlyChart = echarts.init(yearlyChartRef.value);

  const monthlyData = Array(12).fill(0);
  const yearStr = selectedYear.value.toString();

  orderList.value.forEach(order => {
    let orderDate;
    try {
      orderDate = new Date(order.insertTime || order.createTime);
    } catch (e) {
      return; // 日期解析失败则跳过
    }
    const orderYear = orderDate.getFullYear().toString();
    if (orderYear === yearStr) {
      const month = orderDate.getMonth();
      monthlyData[month]++;
    }
  });

  const option = {
    title: {
      text: `${selectedYear.value}年机票订单数量统计`,
      left: 'center'
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow'
      }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '20%', // 增大底部间距，避免图例挤压
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data:['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
      axisLabel: {
        interval: 0,
        rotate: 30, // 旋转标签防止重叠
        margin: 15 // 增加标签与坐标轴的间距
      }
    },
    yAxis: {
      type: 'value',
      name: '订单数量'
    },

    series: [
      {
        name: '订单数量',
        type: 'bar',
        barWidth: '50%',
        data: monthlyData,
        itemStyle: {
          color: '#4e9ff5'
        }
      }
    ]
  };

  yearlyChart.setOption(option);
};

// 初始化航班类型销售分析图表
const initTypeChart = () => {
  if (!typeChartRef.value) return;

  if (typeChart) {
    typeChart.dispose();
  }

  typeChart = echarts.init(typeChartRef.value);

  // 创建航班类型映射
  const typeMap = {};
  typeList.value.forEach(type => {
    typeMap[type.codeIndex] = type.indexName;
  });

  // 按航班类型统计数据
  const typeData = {};
  const yearStr = selectedTypeYear.value.toString();

// 按航班类型统计数据时的调整
  orderList.value.forEach(order => {
    let orderDate;
    try {
      orderDate = new Date(order.insertTime || order.createTime);
    } catch (e) {
      orderDate = new Date(); // 日期解析失败时默认按当前年处理
    }
    const orderYear = orderDate.getFullYear().toString();

    if (orderYear === yearStr) {
      const type = order.jipiaoTypes || 'unknown'; // 类型编码缺失时兜底
      const typeName = typeMap[type] || `未知类型(${type})`; // 无匹配类型时显示编码

      if (!typeData[typeName]) {
        typeData[typeName] = { count: 0, revenue: 0 };
      }
      typeData[typeName].count++;
      typeData[typeName].revenue += Number(order.jipiaoOrderTruePrice || 0);
    }
  });

  const typeNames = Object.keys(typeData);
  const typeCounts = typeNames.map(name => typeData[name].count);
  const typeRevenues = typeNames.map(name => typeData[name].revenue.toFixed(2));

  const option = {
    title: {
      text: `${selectedTypeYear.value}年各航班类型销售统计`,
      left: 'center'
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'shadow'
      },
      formatter: function(params) {
        const typeName = params[0].name;
        const count = typeData[typeName].count;
        const revenue = typeData[typeName].revenue.toFixed(2);
        return `${typeName}<br/>订单数量: ${count}<br/>销售金额: ${revenue}元`;
      }
    },
    legend: {
      data: ['订单数量', '销售金额(元)'],
      top: 'bottom'
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: typeNames,
      axisLabel: {
        interval: 0,
        rotate: 0
      }
    },
    yAxis: [
      {
        type: 'value',
        name: '订单数量',
        position: 'left'
      },
      {
        type: 'value',
        name: '销售金额(元)',
        position: 'right'
      }
    ],
    series: [
      {
        name: '订单数量',
        type: 'bar',
        data: typeCounts,
        itemStyle: {
          color: '#4e9ff5'
        }
      },
      {
        name: '销售金额(元)',
        type: 'line',
        yAxisIndex: 1,
        data: typeRevenues,
        itemStyle: {
          color: '#f56c6c'
        }
      }
    ]
  };

  typeChart.setOption(option);
};

// 窗口大小变化时重绘图表
const handleResize = () => {
  if (yearlyChart) {
    yearlyChart.resize();
  }
  if (typeChart) {
    typeChart.resize();
  }
};

onMounted(async () => {
  await loadOrderData(); // 先加载订单数据
  nextTick(() => initYearlyChart()); // 再初始化图表
  window.addEventListener('resize', handleResize);
  });

onUnmounted(() => {
  window.removeEventListener('resize', handleResize);

  if (yearlyChart) {
    yearlyChart.dispose();
    yearlyChart = null;
  }

  if (typeChart) {
    typeChart.dispose();
    typeChart = null;
  }
});
</script>

<style scoped>
.container {
  box-sizing: border-box;
  padding: 20px;
  background-color: #fff;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  width: 100%;
  overflow-x: hidden;
}

.tab-container {
  width: 100%;
}

.filter-container {
  margin-bottom: 20px;
  display: flex;
}

.chart-container {
  width: 95%;
  margin: 20px auto;
  overflow-x: auto;
}

.chart {
  width: 100%;
  height: 500px;
  min-width: 600px;
}

@media screen and (max-width: 768px) {
  .chart {
    height: 400px;
  }

  .filter-container {
    justify-content: center;
  }
}
</style>
