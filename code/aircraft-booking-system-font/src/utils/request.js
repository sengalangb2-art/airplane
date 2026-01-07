import axios from "axios";
import { useCommonStore } from "@/stores/common";
import { useUserStore } from "@/stores/user";
import { ElMessage } from "element-plus";

const userStore = useUserStore();
const { showLoading, closeLoading } = useCommonStore();

//使用axios.create()创建一个axios请求实例
const service = axios.create();

// //请求前拦截
// service.interceptors.request.use(
//   (req) => {
//     const { token, axiosPromiseArr } = useBasicStore()
//     //axiosPromiseArr收集请求地址,用于取消请求
//     req.cancelToken = new axios.CancelToken((cancel) => {
//       tempReqUrlSave = req.url
//       axiosPromiseArr.push({
//         url: req.url,
//         cancel
//       })
//     })

//     //设置token到header
//     if (token) req.headers['Authorization'] = token
//     //如果req.method给get 请求参数设置为 ?name=xxx
//     if ('get'.includes(req.method?.toLowerCase()) && !req.params) req.params = req.data

//     //req loading
//     // @ts-ignore
//     if (req.reqLoading ?? true) {
//       loadingInstance = ElLoading.service({
//         lock: true,
//         fullscreen: true,
//         // spinner: 'CircleCheck',
//         text: '数据载入中...',
//         background: 'rgba(0, 0, 0, 0.1)'
//       })
//     }
//     return req
//   },
//   (err) => {
//     //发送请求失败
//     Promise.reject(err)
//   }
// )

service.interceptors.request.use(
  (config) => {
    const { token } = userStore;
    if (token) config.headers.token = token;
    showLoading();
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

//请求后拦截
service.interceptors.response.use(
  (res) => {
    closeLoading();
    const { code, msg } = res.data;
    const successCode = [0, 200, 20000];
    const noAuthCode = [401, 403];
    if (successCode.includes(code)) {
      return res.data;
    } else if (noAuthCode.includes(code)) {
      ElMessage.warning({
        message: "登录过期，请重新登录",
        duration: 3 * 1000,
      });
      userStore.LOGOUT();
      return Promise.reject(res.data);
    } else if (code === 500) {
      ElMessage.error({
        message: msg,
        duration: 2 * 1000,
      });
      return Promise.reject(msg);
    } else {
      ElMessage.error({
        message: "请求失败，请稍后再试",
        duration: 2 * 1000,
      });
      return Promise.reject("请求失败，请稍后再试");
    }
  },
  //响应报错
  (err) => {
    ElMessage.error({
      message: "请求失败，请稍后再试",
      duration: 3 * 1000,
    });
    closeLoading();
    return Promise.reject(err);
  }
);

//导出service实例给页面调用 , config->页面的配置
export default function request(config) {
  return service({
    baseURL: import.meta.env.VITE_APP_BASE_URL,
    timeout: 8000,
    ...config,
  });
}
