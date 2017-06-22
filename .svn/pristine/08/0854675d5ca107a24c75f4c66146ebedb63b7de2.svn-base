//
//  TAllScoChoiceView.m
//  DBuyer
//
//  Created by dilei liu on 14-4-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoChoiceView.h"
#import "TBlockPayCardView.h"
#import "TAllScoCard.h"

#define choice_btn_width    45
#define showLabel_Font_Size 16

@implementation TAllScoChoiceView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 2.0;
    self.layer.masksToBounds = YES;
    
    _choiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-choice_btn_width-.3, .5, choice_btn_width, frame.size.height-1)];
    [_choiceBtn setImage:[UIImage imageNamed:@"AllScoPay_Choice_DownBtn.png"] forState:UIControlStateNormal];
    [_choiceBtn setImage:[UIImage imageNamed:@"AllScoPay_Choice_UpBtn.png"] forState:UIControlStateHighlighted];
    [self addSubview:_choiceBtn];
    
    _showAllscoLabel = [[UILabel alloc]init];
    _showAllscoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _showAllscoLabel.numberOfLines = 0;
    [_showAllscoLabel setBackgroundColor:[UIColor clearColor]];
    [_showAllscoLabel setFont:[UIFont systemFontOfSize:showLabel_Font_Size]];
    [_showAllscoLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [_showAllscoLabel setFrame:CGRectMake(5, 5, frame.size.width-5-.3-choice_btn_width, frame.size.height-10)];
    [self addSubview:_showAllscoLabel];
    
    return self;
}

- (void)setTargetForView:(id)target {
    [_choiceBtn addTarget:target action:@selector(doChoiseAlloscoAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)switchAllscoListView:(BOOL)boolValue {
    [self updateBtnImage:boolValue]; // 更新图片背景图
}

- (void)setValueForControl:(NSString*)value {
    [_showAllscoLabel setText:value];
}

- (void)updateBtnImage:(BOOL)isSelected {
    if (isSelected) {
        [_choiceBtn setImage:[UIImage imageNamed:@"AllScoPay_Choice_UpBtn.png"] forState:UIControlStateSelected];
        [_choiceBtn setSelected:YES];
        
    } else {
        [_choiceBtn setImage:[UIImage imageNamed:@"AllScoPay_Choice_DownBtn.png"] forState:UIControlStateNormal];
        [_choiceBtn setSelected:NO];
        
    }
}

- (void)dealloc {
    [super dealloc];
    
    [_choiceBtn release];
    _choiceBtn = nil;
    
    [_showAllscoLabel release];
    _showAllscoLabel = nil;
}

@end
