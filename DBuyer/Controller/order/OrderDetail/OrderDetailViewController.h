//
//  OrderDetailViewController.h
//  DBuyer
//
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailFooterView.h"
#import "Order.h"
#import "OrderFooterView.h"
#import "AddressItem.h"
#import "OrderDetailTableViewHeader.h"

/**
 *  商品类型，用于判断当前页面是哪个分类下面的详情页
 */
typedef enum ORDER_Detail_TYPE {
    WaitBuyerPayOrderDetail = 0,  // 等待支付
    DidFinishOrderDetail,         // 已经完成
    WaitConsigneeDetail           // 等待收货
} _ORDERDETAILTYPE;

#define WaitBuyerPayOrderDetailFooterTitle  @"确认付款"
#define WaitConsigneeDetailFooterTitle      @"查物流"


@interface OrderDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,copy) NSString * orderId;                           // 订单ID
@property (nonatomic, assign) _ORDERDETAILTYPE orderDetailType;          // 详情页面类型


/**
 * 应付价格（此价格为服务器返回，已经计算了积分、运费等信息）
 */
@property (nonatomic,assign) CGFloat paidAmount;
@property (nonatomic,assign) NSInteger maxPoints;                       // 可以用积分
@property (nonatomic,assign) NSInteger integral;                        // 总积分
@property (nonatomic,retain) OrderDetailFooterView *detailFooterView;   // 积分视图
@property (nonatomic,retain) Order *order;                              // 当前的ORDER
@property (nonatomic,assign) NSInteger logisticsType;                   // 物流类型  0 物流 ， 1 自提
@property (nonatomic,assign) float transportation;                      // 网络返回的邮费
@property (nonatomic,retain) NSString *buyType;                         // 购买类型 为8时为礼包，0为分类，1为打折
@property (nonatomic, retain)NSString *getOrderTime;                    // 接口返回的自提时间
@property (nonatomic,retain) NSString *amountPayable;                   // 订单为礼包时，总价钱由网络返回
@property (nonatomic,retain) NSMutableArray *goodsList;                 // 列表数据
@property (nonatomic, retain)AddressItem *addressItem;                  // 地址对象
@property (nonatomic,retain) OrderFooterView *footerView;
@property (nonatomic,retain) UITableView *tableView;                    // 当前的TableView
@property (nonatomic,retain) OrderDetailTableViewHeader *tableHeaderView;
@property (nonatomic,assign) NSInteger networkStatus;

/**
 *  用于确认支付用的回调事件
 *
 *  @param target 控制器
 *  @param action 事件
 */
- (void)addTarget:(id)target Action:(SEL)action;
-(void)countTotalPariceWithPoint:(NSInteger) point;
@end
