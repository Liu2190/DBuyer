//
//  OrderDetailFooterView.h
//  DBuyer
//
//  Created by simman on 14-1-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailFooterView : UIView

@property (retain, nonatomic) IBOutlet UILabel *integralLable;  // 积分
@property (retain, nonatomic) IBOutlet UILabel *priceLable;     // 价钱

/**
 *  设置积分视图内容
 *
 *  @param integral 积分
 *  @param price    价钱
 */
- (void)setOrderDetailFooterViewWithIntegra:(NSString *)integral price:(NSString *)price;
@end
