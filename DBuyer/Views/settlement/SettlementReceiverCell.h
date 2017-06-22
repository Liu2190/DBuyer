//
//  SettlementReceiverCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressItem.h"
@interface SettlementReceiverCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *receiverLabel;
@property (retain, nonatomic) IBOutlet UILabel *phoneLabel;
-(void)setCellValueWith:(AddressItem *)address;
+(float)cellHeightWith:(NSString *)string;
@end
