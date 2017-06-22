//
//  KQPayOrder.h
//  KQPayPlugin
//
//  Created by Hunter Li on 13-4-12.
//
//

#import <Foundation/Foundation.h>

@interface KQPayOrder : NSObject
{
    NSString    *orderId;   //订单编号
    
    NSString    *amt;       //订单金额(单位 分)
    
    NSString    *merchantName;  //商户名称
    
    NSString    *productName;  //商品名称
    
    NSString    *unitPrice;     //商品单价
    
    NSString    *total;         //商品数量
    
    NSString    *merchantOrderTime;     //商户订单时间
}

@property (nonatomic, retain)NSString	*orderId;

@property (nonatomic, retain)NSString	*amt;

@property (nonatomic, retain)NSString	*merchantName;

@property (nonatomic, retain)NSString	*productName;

@property (nonatomic, retain)NSString   *unitPrice;

@property (nonatomic, retain)NSString   *total;

@property (nonatomic, retain)NSString   *merchantOrderTime;

@end
