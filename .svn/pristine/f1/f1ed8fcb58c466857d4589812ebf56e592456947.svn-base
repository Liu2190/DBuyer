
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef enum {
    DefaultRequest,     // default
    TUploadFile,
    
    DoQueryOrderRequest,        // 查询订单接口
    DoGetOrderNumRequest,
    DoOrderPaySuccessRequest,   // 订单支付成功的回调
    DoGetAbountDataRequest,     // 获取有关我们
    
    DoExitLoginRequest,         // 退出登录请求
    DoLoginRequest,             // 登录请求
    DoVerifyRequest,            // 请求验证码
    DoRegisterRequest,          // 请求注册
    DoUpdatePasswordRequest,    // 重置密码
    DogetReturnOrderListRequest,// 获取退款订单列表
    DoGetOrderFollowUp,         // 获取订单跟踪进度
    DoRequestPaidDataRequest,   // 向后台请求支付界面形成的数据
    DoRequestPaidForKQRequest,  // 发送快钱支付接口
    DoRequestPaidData2MeServer, // 向后台请求支付界面形成的数据
    
    DoAllScoValidataRequest,        // 获取商银信验证码
    DoAllScoCardsListRequest,       // 获取商银信绑定的虚拟卡列表
    DotAllScoCardsPayReques,        // 获取商银信虚拟卡支付
    DotAllScoCardsBindingReques,    // 获取商银信虚拟卡绑定
    DotAllScoCardsChargeRequest,    // 商银信虚拟卡充值
    DoGetAllScoCardsGoodsRequest,   // 获取奥斯卡商品列表
    DoBuyerAllScoCardsGoodsRequest, // 购买奥斯卡接口
    DoGetAllScoBuyerOrderListRequest,    // 购买奥斯卡订单列表接口
    DoGetAllScoChargeOrderListRequest,    // 购买奥斯卡订单列表接口
    DoGetAllScoBuyerOrderDetailRequest,    // 购买奥斯卡订单详情接口
    DoGetAllScoChargeOrderDetailRequest,    // 储值奥斯卡订单详情接口
    
    DoUmPayRequest,             // 银联支付请求界面数据
    DoGetAddress2MapRequest,    // 获取超市在地图的详细地址
    
    DoGetProductListRequest,    // 获取商品列表
    DoGetProductDetailRequest,  // 获取商品详情接口
    DoGetPromotionProductRequest,//获取促销商品详情接口
    
    DoGetDeliveryMethodRequest, //获取收货方式接口
    DoGetAddressListRequest,    //获取用户收货地址列表
    DoGetFreightAndTimeRequest, //获取运费及自提时间
    DoGetDefaultMarketRequest,   //获取自提默认超市
    
    DoSubmitCartSettlementRequest, //提交购物车类型结算
    DoSubmitPackageSettlementRequest,//提交礼包类型结算
    DoSubmitProductSettlementRequest,//提交商品详情结算
    
    DoGetRecommendedGoodsRequest,//搜索页面获取推荐商品接口
    DoSearchGoodsRequest,          //搜索商品接口
    DosearchEnterConnectWordsRequest,//搜索联想接口
    
    DoGetAClassGoodsRequest,//获取一级分类接口
    DoGetSecondClassGoodsRequest,//获取二级分类接口
    
    DoGetHomeAllThingsRequest,//获取首页所有数据接口
    DoGetPackageListRequest,//礼包列表网络请求接口
    DoGetPackageDetailsRequest,//礼包详情网络请求接口
    
    DoGetCharacteristicCategory,//特色商品分类接口
    DoGetCharacteristicList,//特色商品列表接口
    DoGetMonthlyCategory,//每月新品分类接口
    DoGetMonthlyList,//每月新品列表接口
    DoGetBargainGoods,//特价商品列表接口
    DoGetSalesRankingCategory, //销售排行分类接口
    DoGetSalesRankingList,//销售排行列表接口
    DoGetSeasonalGoodsList,//应季商品列表接口
    
    DoGetActivityListRequest,//获取首页活动列表数据接口
    
    DoVersionUpdateRequest,//获取版本更新的接口
    DoGetPlanListRequest,//获取购物计划接口
    DoDeleteAPlanRequest,//删除一条购物计划接口
    DoGetRecommendFromCartRequest//购物车为空时的推荐商品接口
    
}RequestType;

@protocol RequestDelegate <NSObject>
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;

@end