//
//  AboutMeFirstCell.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeFirstCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *currentVersionLabel;
@property (retain, nonatomic) IBOutlet UILabel *contactLabel;
@property (retain, nonatomic) IBOutlet UILabel *areaLabel;
@property (retain, nonatomic) IBOutlet UILabel *detailAddressLabel;
- (IBAction)callAction:(id)sender;
@property (retain, nonatomic) IBOutlet UIImageView *backView;
-(void)setFirstCellWithTelephoneNum:(NSString *)TelephoneNum AndArea:(NSString *)areaString AndDetailAddress:(NSString *)detailAddress;
-(void)addtarget:(id)thisTarget AndCallAction:(SEL)callAction;
@end
