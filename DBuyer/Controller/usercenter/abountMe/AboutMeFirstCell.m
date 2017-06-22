//
//  AboutMeFirstCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "AboutMeFirstCell.h"
@interface AboutMeFirstCell()
{
    id _target;
    SEL _callAction;
}
@end
@implementation AboutMeFirstCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    self.backView.layer.cornerRadius = 5.0f;//背景圆边
    NSDictionary *infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *banbenhao =[infoDict objectForKey:@"CFBundleVersion"];
    NSString *current=[NSString stringWithFormat:@"当前版本:%@",banbenhao];
    self.currentVersionLabel.text = current;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_currentVersionLabel release];
    [_contactLabel release];
    [_areaLabel release];
    [_detailAddressLabel release];
    [_backView release];
    [super dealloc];
}
- (IBAction)callAction:(id)sender {
    [_target performSelector:_callAction];
}
-(void)setFirstCellWithTelephoneNum:(NSString *)TelephoneNum AndArea:(NSString *)areaString AndDetailAddress:(NSString *)detailAddress
{
    NSString *area = [NSString stringWithFormat:@"所在地区：%@",areaString];
    self.areaLabel.text = area;
    NSString *detail = [NSString stringWithFormat:@"详细地址：%@",detailAddress];
    self.detailAddressLabel.text = detail;
    NSString *telephone = [NSString stringWithFormat:@"联系电话：%@",TelephoneNum];
    self.contactLabel.text = telephone;
}
-(void)addtarget:(id)thisTarget AndCallAction:(SEL)callAction
{
    _target = thisTarget;
    _callAction = callAction;
}
@end
