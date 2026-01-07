/**
 * 根据用户菜单权限设置路由
 * @param menuData
 */
/* -------------------------------------分割线-------------------------------------------- */
import layout from "../layout/index.vue";

import flightIndex from "../views/Flight/index.vue";
import flightType from "../views/Flight/type.vue";
import flightOrder from "../views/Flight/order.vue";
import flightAnalysis from "../views/Flight/analysis.vue";
import newsIndex from "../views/News/index.vue";
import newsType from "../views/News/type.vue";
import userIndex from "../views/User/index.vue";



const componentObj = {
  layout,
  flightIndex,
  flightType,
  newsIndex,
  newsType,
  userIndex,
  flightOrder,
  flightAnalysis
};

const iconList = {
  flight: "Promotion",
  news: "Tickets",
  user: "User"
};

/**
 * 动态添加用户路由权限
 * @param menuData json格式的字符串
 * @returns {[]}
 */
export function getAuthRouters(menuData) {
  const routerList = [];
  let obj, children;
  menuData &&
    menuData.map((item) => {
      obj = {
        path: item.path,
        component: layout,
        redirect: "noRedirect",
        name: item.name,
        meta: {
          breadcrumbName: item.meta.title,
          icon: iconList[item.name],
        },
      };
      // 设置子菜单
      children = [];
      item["children"].map((it) => {
        children.push({
          path: it.path,
          component: componentObj[it.name],
          name: it.name, // 如果该组件需要缓存,这里的name属性请与组件的name保持一致
          meta: {
            breadcrumbName: it.meta.title,
            cached: true, // 是否需要缓存
            keepAlive: true,
          },
        });
      });
      obj.children = children;
      routerList.push(obj);
    });
  return routerList;
}
