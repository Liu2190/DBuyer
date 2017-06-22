//
//  SettlementExtractTableHeaderView.h
//  DBuyer
//
//  Created by simman on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementExtractTableHeaderView : UIView
@property (retain, nonatomic) IBOutlet UILabel *SuperMaketNameLable;    // 超市名称
@property (retain, nonatomic) IBOutlet UILabel *SuperMaketAddressLable; // 超市地址
@property (retain, nonatomic) IBOutlet UIButton *ExtractDateButton; // 显示自提时间
- (IBAction)SuperMaketAction:(id)sender;    // 选择超市事件
- (IBAction)ExtractDateAction:(id)sender;   // 自提时间事件

@end
