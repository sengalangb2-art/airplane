package com.controller;

import com.alipay.api.AlipayApiException;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.entity.JipiaoEntity;
import com.entity.JipiaoOrderEntity;
import com.entity.YonghuEntity;
import com.service.JipiaoOrderService;
import com.service.JipiaoService;
import com.service.YonghuService;
import com.utils.R;
import com.utils.pay.AlipayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Map;

/**
 * 支付宝支付控制器
 */
@RestController
@RequestMapping("/api")
public class AlipayController {

    @Autowired
    private AlipayService alipayService;
    
    @Autowired
    private JipiaoOrderService jipiaoOrderService;
    
    @Autowired
    private JipiaoService jipiaoService;
    
    @Autowired
    private YonghuService yonghuService;

    /**
     * 支付宝支付接口
     * @param outTradeNo 商户订单号
     * @param totalAmount 订单金额
     * @param subject 订单标题
     * @param body 订单描述
     * @return 支付表单HTML
     */
    @GetMapping("/alipay")
    public String alipay(
            @RequestParam("outTradeNo") String outTradeNo,
            @RequestParam("totalAmount") String totalAmount,
            @RequestParam("subject") String subject,
            @RequestParam(value = "body", required = false, defaultValue = "") String body) {
        try {
            return alipayService.pay(outTradeNo, totalAmount, subject, body);
        } catch (AlipayApiException e) {
            e.printStackTrace();
            return "调用支付宝接口失败，请稍后再试";
        }
    }

    /**
     * 支付宝异步通知接口
     * @param request
     * @return
     */
    @PostMapping("/alipayNotify")
    public String alipayNotify(HttpServletRequest request) {
        try {
            // 验证签名
            boolean signVerified = alipayService.rsaCheckV1(request);
            if (signVerified) {
                // 验签成功后，按照支付结果异步通知中的描述，对支付结果中的业务内容进行二次校验
                Map<String, String> params = alipayService.getParams(request);
                
                // 商户订单号
                String outTradeNo = params.get("out_trade_no");
                // 支付宝交易号
                String tradeNo = params.get("trade_no");
                // 交易状态
                String tradeStatus = params.get("trade_status");
                
                // 交易成功处理
                if ("TRADE_SUCCESS".equals(tradeStatus)) {
                    // 根据商户订单号查询订单
                    EntityWrapper<JipiaoOrderEntity> ew = new EntityWrapper<JipiaoOrderEntity>();
                    ew.eq("order_pay_order", outTradeNo);
                    JipiaoOrderEntity jipiaoOrder = jipiaoOrderService.selectOne(ew);
                    
                    if (jipiaoOrder != null) {
                        // 更新订单状态为已支付
                        jipiaoOrder.setIsPay("已支付");
                        jipiaoOrder.setJieshuanshijian(new Date());
                        jipiaoOrderService.updateById(jipiaoOrder);
                        
                        // 更新用户余额
                        JipiaoEntity jipiaoEntity = jipiaoService.selectById(jipiaoOrder.getJipiaoId());
                        if (jipiaoEntity != null) {
                            YonghuEntity yonghuEntity = yonghuService.selectById(jipiaoOrder.getYonghuId());
                            if (yonghuEntity != null && yonghuEntity.getNewMoney() != null) {
                                // 计算新余额
                                double balance = yonghuEntity.getNewMoney() - jipiaoOrder.getJipiaoOrderTruePrice();
                                if (balance >= 0) {
                                    yonghuEntity.setNewMoney(balance);
                                    yonghuService.updateById(yonghuEntity);
                                }
                            }
                        }
                    }
                    
                    System.out.println("订单号: " + outTradeNo + " 支付成功, 支付宝交易号: " + tradeNo);
                }
                
                return "success";
            } else {
                // 验签失败
                return "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    
    /**
     * 查询支付状态
     * @param outTradeNo 商户订单号
     * @return
     */
    @GetMapping("/queryPayStatus")
    public R queryPayStatus(@RequestParam("outTradeNo") String outTradeNo) {
        try {
            // TODO: 根据订单号查询订单支付状态
            // 这里简单演示，实际应该查询数据库中的订单支付状态
            return R.ok().put("status", "pending");
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("查询支付状态失败");
        }
    }
} 