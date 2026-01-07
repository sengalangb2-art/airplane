package com.utils.pay;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * 支付宝支付服务类
 */
@Component
public class AlipayService {

    /**
     * 调用支付宝支付接口
     * @param outTradeNo 商户订单号，必填
     * @param totalAmount 付款金额，必填
     * @param subject 订单名称，必填
     * @param body 商品描述，可空
     * @return 支付表单的HTML
     * @throws AlipayApiException
     */
    public String pay(String outTradeNo, String totalAmount, String subject, String body) throws AlipayApiException {
        // 获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(
                AlipayConfig.URL, 
                AlipayConfig.APPID, 
                AlipayConfig.RSA_PRIVATE_KEY, 
                AlipayConfig.FORMAT, 
                AlipayConfig.CHARSET, 
                AlipayConfig.ALIPAY_PUBLIC_KEY, 
                AlipayConfig.SIGNTYPE);
        
        // 设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
        
        // 商户订单号，商户网站订单系统中唯一订单号，必填
        // 付款金额，必填
        // 订单名称，必填
        // 商品描述，可空
        alipayRequest.setBizContent("{\"out_trade_no\":\"" + outTradeNo + "\","
                + "\"total_amount\":\"" + totalAmount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
        
        // 请求
        String result = alipayClient.pageExecute(alipayRequest).getBody();
        return result;
    }
    
    /**
     * 支付宝支付异步通知处理
     * @param request
     * @return
     * @throws Exception
     */
    public boolean rsaCheckV1(HttpServletRequest request) throws Exception {
        // 获取支付宝POST过来反馈信息
        Map<String, String> params = new HashMap<>();
        Map<String, String[]> requestParams = request.getParameterMap();
        for (String name : requestParams.keySet()) {
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            params.put(name, valueStr);
        }
        
        // 调用SDK验证签名
        return AlipaySignature.rsaCheckV1(params, AlipayConfig.ALIPAY_PUBLIC_KEY, AlipayConfig.CHARSET, AlipayConfig.SIGNTYPE);
    }
    
    /**
     * 获取支付宝POST过来的反馈信息
     * @param request
     * @return
     */
    public Map<String, String> getParams(HttpServletRequest request) {
        Map<String, String> params = new HashMap<>();
        Map<String, String[]> requestParams = request.getParameterMap();
        Set<String> names = requestParams.keySet();
        
        for (String name : names) {
            String[] values = requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
            }
            params.put(name, valueStr);
        }
        
        return params;
    }
} 