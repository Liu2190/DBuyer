//
//  TOrderMenuBlock.m
//  DBuyer
//
//  Created by dilei liu on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderMenuBlock.h"

#define MenuButton_W  40

@implementation TOrderMenuBlock

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _menuButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, MenuButton_W, self.frame.size.height-15)];
    [self addSubview:_menuButton];
    
    _remindNumImageView = [[UIImageView alloc]init];
    [_remindNumImageView setImage:[UIImage imageNamed:@"OrderMenu_Mark.png"]];
    [self addSubview:_remindNumImageView];
    
    _remindNumLabel = [[UILabel alloc]init];
    [_remindNumLabel setFont:[UIFont systemFontOfSize:8]];
    [_remindNumImageView addSubview:_remindNumLabel];

    return self;
}

- (id)initWithFrame:(CGRect)frame andDelegate:(id)delObj {
    self = [super initWithFrame:frame];
    self.delegate = delObj;
    
    _menuButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, MenuButton_W, self.frame.size.height-15)];
    [_menuButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_menuButton setShowsTouchWhenHighlighted:YES];
    [self addSubview:_menuButton];
    
    _remindNumImageView = [[UIImageView alloc]init];
    [_remindNumImageView setImage:[UIImage imageNamed:@"OrderMenu_Mark.png"]];
    [self addSubview:_remindNumImageView];
    
    _remindNumLabel = [[UILabel alloc]init];
    [_remindNumLabel setFont:[UIFont systemFontOfSize:8]];
    [_remindNumImageView addSubview:_remindNumLabel];
    
    return self;
}

- (void)menuButtonClicked:(id)sender {
    UIButton *btn = (UIButton*)sender;
    if (btn.tag == 0) [self.delegate toParyOrderList];
    if (btn.tag == 1) [self.delegate toReceiveOrderList];
    if (btn.tag == 2) [self.delegate finishedOrderList];
    if (btn.tag == 3) [self.delegate exitOrderList];
}

- (void)setOrderMenuViewData:(NSString *)imageName {
    [_menuButton setImage:imageName];
}

- (void) showMarkNumber:(int)number {
    if (number == 0) {
        _remindNumImageView.hidden = YES;
        return;
    }
    
    _remindNumImageView.hidden = NO;
    NSString *numberValue = [NSString stringWithFormat:@"%i",number];
    if (number>99) numberValue = [NSString stringWithFormat:@"99+"];
    
    _remindNumLabel.text = numberValue;
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_remindNumLabel.text sizeWithFont:_remindNumLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    float menuRemindView_w = titleSize.width+10;
    float menuRemindView_h = titleSize.height+5;
    [_remindNumImageView setFrame:CGRectMake(_menuButton.frame.origin.x+_menuButton.frame.size.width-5, 5, menuRemindView_w, menuRemindView_h)];
    
    
    [_remindNumLabel setFrame:CGRectMake((_remindNumImageView.frame.size.width-titleSize.width)/2, (_remindNumImageView.frame.size.height-titleSize.height)/2, titleSize.width,titleSize.height)];
    [_remindNumLabel setFont:[UIFont systemFontOfSize:8]];
    [_remindNumLabel setBackgroundColor:[UIColor clearColor]];
    [_remindNumLabel setTextColor:[UIColor whiteColor]];
    _remindNumLabel.text = numberValue;
}

- (void)setFlagForMenuBtn:(int)flag {
    _menuButton.tag = flag;
}

- (int)getFlagForMenuBtn {
    return _menuButton.tag;
}

- (void)dealloc {
    [super dealloc];
    
    [_menuButton release];
    _menuButton = nil;
    
    [_remindNumImageView release];
    _remindNumImageView = nil;
    
    [_remindNumLabel release];
    _remindNumLabel = nil;
}

@end
