package com.utils.pay;

/**
 * 支付宝支付配置类
 */
public class AlipayConfig {
    // 商户appid - 沙箱环境
    public static String APPID = "2021000147632505";
    //私钥 pkcs8格式的
    public static String RSA_PRIVATE_KEY = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCJJkT2VnPgGeOlbXzfN/fAsE9L6NaWMa+2GiwIUFQeHZcw4i+KzTNK85f1/cNdaVbu/Q7hOxF225UGjh8vY+G8LAHYOZkim4RPONjfbyF58tMtukSGzaeOJhV1tnPRbycpfIw+c+Q3uvKUBg72Emo/nKEWYqLQwXCkPBFri8cta0wMln3NKaltO/g2+LsLuYAbCHbha3DoGUgSCCKzneulwwGPFjIjXJizo5cq1EZRplPVtX8lA5x3YVqEFqK4EO0hh8obwoL3uyI4CHYDAOb4o9+Vpu4l6Fl5aRQR6RFTBEv1xlet5CF3j+qeSDZBBVrN2pnXyl364sHQODrNiXYXAgMBAAECggEAPZ0Fqi0YjXrT/EN9r8Iy+Uu7s/x8OqlDqOmFEo8T2xusCnfyp8ab3nYktIw2MkbamS7yeljQ9bab8n/ynpWemayjf4IQu61l+TkupOIGBgUCvi5KDs1hEsklJua6jUIEM+0SDBSAWFESHVHDcuS++qjg7W+OeX4NnpqlsMzwxAQgUCb3iDAuiVbS/m2KwLTi4WH4+VDYWcaiIpdcf3F9Pr+MLl3xASpMDgPjf42nJBSfmNv91PaCqKtD24NqFvHeMJOCtY2FP6FPMkTV5LTXQoXyJzuaf5nPWRK28Fr1QTWuPMBZo/h0UXGO4W2zBwAkgnkSwR111EtXTYoe4qgzIQKBgQDUSnbIv1z+/66bqy4lfo1B9zIGBQWedds/jKZyis4MSjqcmE0SAa/sLXLO7F5+1N757IBS58+6xcS+wxfIw6ipHLEvVKOISCtKJLU7y5QYHmNbFGXtX98NJ+Q9A0jLUoLttVPvBwYCy8qxP3HxDRTIDOakE/zRRqi1Gv3ewQo4+QKBgQClYzb+0BEovI+i//zL7Z8gH08OP2suXXPbQuLaPIzGgUekk+v2oQu8MKGzVBnL/mggLiVOl/nji1Y1Z//LPVMOqYIK6t+EBeGxMeEYOQkym5oxTOCB79tc0GEabz8Zz+01iad65CrBbRANDUWzx9Uiym8oitkxWxeacnjofBR7jwKBgBycwK/D4wPXcDA4/So+iUlnyM045g36cod5LIHppWXQp1+tw012/sAFTCEJiJ7tj/P9ZTpHVh8lQqQ3ZUBA5r2MSXFIphXbLEJ8+hRKFva9OcTv1eENd+GtC70RcUE+KLljJCHmP3AnCXWkSHYlvjRMUNWyf/Ow41IthiP8vqT5AoGBAKCHmM3kL4OW4uSYDEv0rUuEmDuAGwy58MaWOZMSyqGywlNgsNyGnNlhatKhgxiaK39wyw1qPkc668aS15nyQDgvF+Z469M90j8n5xCX6/GPTy8jK5dztTx1losOB/WJ+PjKUCHcbhOpRLcmds113c8TJqn3e7GIdXSYP/uI1GjJAoGADIGRaqOfC/NrOc8UvXgO6iXbWIVgmO1em4ErMxUBSWrgIApes9KldrwOw18yOq1bKExcpPPFefaiUpSMcXzBJ0a5utAf3ARrxEAS6hDkbsV1F/As9sbI8TWLfSi0QT4YctmuJ+K8HRSn8Gl/fv4REcfUrtv6YfXSJ5UqOpE/+6I=";
    // 服务器异步通知页面路径 - 修改为项目实际接口
    public static String notify_url = "http://localhost:9090/api/alipayNotify";
    // 页面跳转同步通知页面路径 - 修改为前端页面
    public static String return_url = "http://localhost:8080/#/";
    // 请求网关地址 - 沙箱环境
    public static String URL = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";
    // 编码
    public static String CHARSET = "UTF-8";
    // 返回格式
    public static String FORMAT = "json";
    // 支付宝公钥
    public static String ALIPAY_PUBLIC_KEY = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAiSZE9lZz4BnjpW183zf3wLBPS+jWljGvthosCFBUHh2XMOIvis0zSvOX9f3DXWlW7v0O4TsRdtuVBo4fL2PhvCwB2DmZIpuETzjY328hefLTLbpEhs2njiYVdbZz0W8nKXyMPnPkN7rylAYO9hJqP5yhFmKi0MFwpDwRa4vHLWtMDJZ9zSmpbTv4Nvi7C7mAGwh24Wtw6BlIEggis53rpcMBjxYyI1yYs6OXKtRGUaZT1bV/JQOcd2FahBaiuBDtIYfKG8KC97siOAh2AwDm+KPflabuJehZeWkUEekRUwRL9cZXreQhd4/qnkg2QQVazdqZ18pd+uLB0Dg6zYl2FwIDAQAB";
    // 日志记录目录
    public static String log_path = "/log";
    // RSA2
    public static String SIGNTYPE = "RSA2";
} 