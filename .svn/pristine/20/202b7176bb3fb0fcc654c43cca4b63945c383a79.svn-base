
//
//  OrderDetailTableViewHeader.m
//  DBuyer
//
//  Created by simman on 14-1-10.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "OrderDetailTableViewHeader.h"
#import "AddressItem.h"


#define selfPushLabel_Font_size     14
#define selfPushLabel_size_w     14




@implementation OrderDetailTableViewHeader

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initLayoutView];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initLayoutView];
    
    return self;
}

- (void)initLayoutView {
    // 320 140
    self.selfPushShopTitle = [[UILabel alloc]init];
    _selfPushShopTitle.font = [UIFont systemFontOfSize:selfPushLabel_Font_size];
    [_selfPushShopTitle setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_selfPushShopTitle];
    
    self.selfPushShopValue = [[UILabel alloc]init];
    [_selfPushShopValue setBackgroundColor:[UIColor clearColor]];
    [_selfPushShopValue setFont:[UIFont systemFontOfSize:selfPushLabel_Font_size-3]];
    [self addSubview:_selfPushShopValue];
}

#pragma mark 使用礼券按钮事件（礼券功能没有，暂未实现）
- (void)couponButtonAction:(id)sender {
    
}

#pragma mark -设置数据
- (void)setHeaderViewDataWithAddressItem:(AddressItem *)addItem logisticPattern:(_logisticPattern)pattern {
    // 0 物流 1 自提
    if (pattern == 1) { // 自提
        self.consigneeAddressTitle.text = @"详细地址";
        self.consigneeTelTitle.hidden = YES;
        self.consigneeTitle.hidden = YES;
        self.consigneeTelLable.hidden = YES;
        self.consigneeLable.hidden = YES;
        
        float x = 13; float y = 60;
        _selfPushShopTitle.text = @"自提超市";
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        CGSize titleSize = [_selfPushShopTitle.text sizeWithFont:_selfPushShopTitle.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        [_selfPushShopTitle setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
        
        x = self.selfPushShopTitle.frame.origin.x+self.selfPushShopTitle.frame.size.width+14;
        y = self.selfPushShopTitle.frame.origin.y+2;
        _selfPushShopValue.text = addItem.name;
        maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [_selfPushShopValue.text sizeWithFont:_selfPushShopValue.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        [_selfPushShopValue setFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
    } else {
        
    }
    
    self.consigneeAddressLable.text = [addItem.storesAdd isKindOfClass:[NSNull class]] ? @"" : addItem.storesAdd;
    self.consigneeLable.text = [addItem.name isKindOfClass:[NSNull class]] ? @"" : addItem.name;
    self.consigneeTelLable.text = [addItem.phoneNumber isKindOfClass:[NSNull class]] ? @"" : addItem.phoneNumber;
    
    self.orderNumberLabel.text = addItem.orderNumber;
    
    
}

- (void)dealloc {
    [_consigneeAddressTitle release];
    [_consigneeTitle release];
    [_consigneeTelTitle release];
    [super dealloc];
}
@end
