const routes = [
  {
    path: "/flight",
    name: "flight",
    meta: {
      title: "航班管理",
    },
    children: [
      {
        path: "index",
        name: "flightIndex",
        meta: {
          title: "航班信息",
        },
      },
      {
        path: "type",
        name: "flightType",
        meta: {
          title: "航班类型",
        },
      },
      {
        path: "order",
        name: "flightOrder",
        meta: {
          title: "航班订单",
        },
      },
      {
        path: "analysis",
        name: "flightAnalysis",
        meta: {
          title: "统计分析",
        },
      },
    ],
  },
  {
    path: "/news",
    name: "news",
    meta: {
      title: "新闻管理",
    },
    children: [
      {
        path: "index",
        name: "newsIndex",
        meta: {
          title: "新闻信息",
        },
      },
      {
        path: "type",
        name: "newsType",
        meta: {
          title: "新闻类型",
        },
      },
    ],
  },
  {
    path: "/user",
    name: "user",
    meta: {
      title: "用户管理",
    },
    children: [
      {
        path: "index",
        name: "userIndex",
        meta: {
          title: "用户信息",
        },
      },
    ],
  },
];

// 模拟获取动态路由数据
export function getDynamicRoutes() {
  return new Promise((resolve) => {
    resolve(routes);
  });
}
