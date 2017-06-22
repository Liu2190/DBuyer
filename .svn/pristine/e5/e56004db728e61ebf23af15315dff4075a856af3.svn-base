//
//  SettlementModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqliteMarketObject.h"
#import "AddressItem.h"
@interface SettlementModel : NSObject

@property (nonatomic,retain)SqliteMarketObject *zitiAreaItem;//自提地址
@property (nonatomic,assign)float freight;//运费
@property (nonatomic,assign)NSInteger useIntegral;//使用的积分数量
@property (nonatomic,retain)AddressItem *addressItem;//物流地址
@property (nonatomic,assign)NSInteger allIntegral;//总积分
@property (nonatomic,assign)CGFloat totalPrice;//总价
@property (nonatomic,retain)NSMutableArray *productlistArray;//商品列表数组
@property (nonatomic,assign)int buyType;//购买类型
@property (nonatomic,assign)BOOL logisticsStatus;//是否为物流
@property (nonatomic,assign)BOOL isHaveAddress;//是否有地址
@property (nonatomic,retain)NSString *beginTime;
@property (nonatomic,retain)NSString *endTime;
@property (nonatomic,retain)NSString *destorTime;//订单失效时间
@property (nonatomic,retain)NSMutableString *takeBySelfTime;//用户自提时间
@property (nonatomic,assign)int networkStatus;
@property (nonatomic,retain)NSArray *exDateHourArray;//时间选择器右栏
@property (nonatomic,retain)NSArray *exDateDayArray;//时间选择器左栏
@property (nonatomic,assign)int countOfFirst;//时间选择器右边第一栏的数量
@property (nonatomic,assign)int orderDeadTime;//订单失效时间
@property (nonatomic,assign)float giftPrice;//如果是礼包，总价为礼包价格
@property (nonatomic,retain)NSMutableString *timeOnTheButton;//在按钮上显示的时间
@property (nonatomic,assign)BOOL isWuliuHidden;//物流按钮是否隐藏
@property (nonatomic,assign)BOOL isZitiHidden;//自提按钮是否隐藏
@property (nonatomic,retain)NSString *productIds;
@property (nonatomic,retain)NSString *productIdsAndCounts;
@property (nonatomic,retain)NSMutableDictionary *zitiDict;//自提时间
@property (nonatomic,assign)float reducePrice;//减免的费用
@property (nonatomic,assign)int setType;
@property (nonatomic,retain)NSString *gid;
-(void)setModelWithProducts:(NSMutableArray *)productArr SeettType:(int )SettType GiftID:(NSString *)giftId Price:(float)price;
-(void)getDefaultSuperMarketArea:(NSDictionary *)dict;//获取默认超市地址

-(void)getDefaultAddress:(NSDictionary *)dict;//获取默认地址

-(void)getFreightAndZitiTime:(NSDictionary *)dict;//获取运费及自提时间

-(void)getIntegral:(NSDictionary *)dict;//获取用户积分

-(void)getDeliveryWay:(NSDictionary *)dict;//获取用户的送货方式
@end
