//
//  ProductDetail.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetail : NSObject

@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSMutableArray *commodityImage;
@property (nonatomic,retain)NSString *commodityName;
@property (nonatomic,retain)NSArray *keyWord;
@property (nonatomic,assign)float marketPrice;
@property (nonatomic,assign)float sellPrice;
@property (nonatomic,assign)BOOL isCollect;
@property (nonatomic,assign)BOOL isPlan;
@property (nonatomic,retain)NSString *afterSaleService;//售后服务
@property (nonatomic,assign)int recommendType;
@property (nonatomic,retain)NSMutableArray *recommendProArray;
@property (nonatomic,retain)NSMutableDictionary *introduceDict;
@property (nonatomic,assign)BOOL isLogined;//判断当前是否有用户登录
@property (nonatomic,retain)NSString *shareImageURL;//分享的图品的URL
@property (nonatomic,assign)int countInCart;//购物车数量
@property (nonatomic,assign)int buyCount;//购买数量
@property (nonatomic,assign)int type;//类型ID
@property (nonatomic,retain)NSString *categoryID;//类别ID
@property (nonatomic,assign)BOOL isBuyNow;//是否为立即购买
@property (nonatomic,retain)NSString *realInventory;//真实库存
@property (nonatomic,retain)NSString *virtualInventory;//虚拟库存
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,assign)BOOL isSalesOpen;
@property (nonatomic,retain)NSString *salesPromotion;//促销信息
-(id)initProductModalWithDic:(NSDictionary *)dic AndIsLogin:(BOOL)isLogin WithType:(int)thisType AndCatID:(NSString *)catID;
@end
