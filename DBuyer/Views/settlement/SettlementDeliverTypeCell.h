//
//  SettlementDeliverTypeCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementDeliverTypeCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UIButton *button;
-(void)setButtonValueWith:(BOOL)status;

@end
