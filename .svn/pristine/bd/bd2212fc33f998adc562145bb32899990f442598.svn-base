//
//  OrderDetailTableViewHeader.h
//  DBuyer
//
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum logisticPattern {
    Logistics = 0,  // 物流
    Extract         // 自提
}_logisticPattern;

@class AddressItem;

@interface OrderDetailTableViewHeader : UIView

@property (retain, nonatomic) IBOutlet UIButton *couponButton;          //优惠券
@property (retain, nonatomic) IBOutlet UILabel *consigneeLable;         // 收货人
@property (retain, nonatomic) IBOutlet UILabel *consigneeTelLable;      //收货人手机号
@property (retain, nonatomic) IBOutlet UILabel *consigneeAddressLable;  //收货人地址
@property (retain, nonatomic) IBOutlet UILabel *consigneeAddressTitle;  // 收货地址Title（用来区分是自提还是物流）

//----  如果是自提的话，隐藏收货人和手机号
@property (retain, nonatomic) IBOutlet UILabel *consigneeTitle;     // 收货人title
@property (retain, nonatomic) IBOutlet UILabel *consigneeTelTitle;  // 收货人手机号

@property (retain,nonatomic) IBOutlet UILabel *orderNumberLabel;

@property (retain,nonatomic) UILabel *selfPushShopTitle;
@property (retain,nonatomic) UILabel *selfPushShopValue;


- (IBAction)couponButtonAction:(id)sender;  // 优惠券按钮

/**
 *  设置header
 *
 *  @param addItem 地址对象
 *  @param pattern 收货类型
 */
- (void)setHeaderViewDataWithAddressItem:(AddressItem *)addItem
                         logisticPattern:(_logisticPattern)pattern;
@end
