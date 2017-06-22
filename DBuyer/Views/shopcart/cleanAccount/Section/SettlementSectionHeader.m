//
//  SettlementSectionHeader.m
//  DBuyer
//
//  Created by simman on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "SettlementSectionHeader.h"

@interface SettlementSectionHeader() {
    id _target;
    SEL _laction;   // 物流事件
    SEL _eaction;   // 自提事件
    
    BOOL lactionStatus; // 物流按钮状态
    BOOL eactionStatus; // 自提按钮状态
}

@end

@implementation SettlementSectionHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lactionStatus = YES;     // 物流
        eactionStatus = NO;     // 自提
    }
    return self;
}
-(void)awakeFromNib
{
    self.logisticsPrice.text = @"";
}
- (IBAction)logisticsCheckBoxAction:(id)sender {
    [_target performSelector:_laction withObject:sender];
}
- (IBAction)extractCheckBoxAction:(id)sender {
    [_target performSelector:_eaction withObject:sender];
}
- (void)setSectionLogisticsPrice:(NSInteger)price
{
    self.logisticsPrice.text = [NSString stringWithFormat:@"运费：%d元", price];
}
- (void)addTarget:(id)target logisticsAction:(SEL)laction extractAction:(SEL)eaction {
    _target = target;
    _laction = laction;
    _eaction = eaction;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_backGroundView release];
    [_logisticsCheckBox release];
    [_extractCheckBox release];
    [_wuliuLabel release];
    [_zitiLabel release];
    [super dealloc];
}
- (void)setButtonCanClickWith:(BOOL)logistics AndZitiHidden:(BOOL)isVIP AndlogisticsPrice:(float)price{
    NSString *logisticsImageName = logistics?@""@"checkBox_highlighted" : @"checkBox_normal";
    [self.logisticsCheckBox  setBackgroundImage:[UIImage imageNamed:logisticsImageName] forState:UIControlStateNormal];
    NSString *zitiImageName = (!logistics) ? @"checkBox_highlighted" : @"checkBox_normal";
    [self.extractCheckBox  setBackgroundImage:[UIImage imageNamed:zitiImageName] forState:UIControlStateNormal];
    
    [self setSectionLogisticsPrice:price];
    self.logisticsPrice.hidden = !logistics;
    self.logisticsCheckBox.userInteractionEnabled = !logistics;
    self.extractCheckBox.userInteractionEnabled = logistics;
}
-(void)setDeliveryMethod:(SettlementModel *)thisModel
{
    self.logisticsCheckBox.hidden = thisModel.isWuliuHidden;
    self.wuliuLabel.hidden = thisModel.isWuliuHidden;
    self.logisticsPrice.hidden = thisModel.isWuliuHidden;
    self.extractCheckBox.hidden = thisModel.isZitiHidden;
    self.zitiLabel.hidden = thisModel.isZitiHidden;
    if(thisModel.isWuliuHidden == YES && thisModel.isZitiHidden == NO)
    {
        self.extractCheckBox.frame = self.logisticsCheckBox.frame;
        self.zitiLabel.frame = self.wuliuLabel.frame;
    }
}
@end
