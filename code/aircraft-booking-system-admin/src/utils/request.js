import axios from "axios";
import { ElMessage } from "element-plus";
import { useUserStore } from "@/stores/user";
import NProgress from "@/utils/progress.js";

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
    NProgress.start();
    const userStore = useUserStore();
    const { token } = userStore;
    if (token) config.headers.token = token;
    return config;
  },
  (error) => {
    NProgress.done();
    return Promise.reject(error);
  }
);

//请求后拦截
service.interceptors.response.use(
  (res) => {
    NProgress.done();
    const userStore = useUserStore();
    const { LOGOUT } = userStore;
    const { code } = res.data;
    const successCode = [0, 200, 20000];
    const noAuthCode = [401, 403];
    if (successCode.includes(code)) {
      return res.data;
    } else if (noAuthCode.includes(code)) {
      ElMessage.warning({
        message: "登录信息失效，请重新登录",
        duration: 3 * 1000,
      });
      LOGOUT();
      return Promise.reject("登录信息失效，请重新登录");
    } else {
      ElMessage.error({
        message: "请求失败，请稍后再试",
        duration: 2 * 1000,
      });
      return Promise.reject(msg);
    }
  },
  //响应报错
  (err) => {
    NProgress.done();
    ElMessage.error({
      message: err,
      duration: 2 * 1000,
    });
    return Promise.reject(err);
  }
);

export default function request(config) {
  return service({
    baseURL: import.meta.env.VITE_APP_BASE_URL,
    timeout: 8000,
    ...config,
  });
}
