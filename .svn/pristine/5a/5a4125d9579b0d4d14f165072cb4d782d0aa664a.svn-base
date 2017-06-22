//
//  TUserCenterCell_3.m
//  DBuyer
//
//  Created by dilei liu on 14-3-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterCell_3.h"

#define quitLogin_btn_margin    15

@implementation TUserCenterCell_3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    _quitLoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(quitLogin_btn_margin, 0, self.frame.size.width-2*quitLogin_btn_margin, self.frame.size.height)];
    [_quitLoginBtn setBackgroundImage:[UIImage imageNamed:@"UserCenter_QuitBtn.png"] forState:UIControlStateNormal];
    [_quitLoginBtn setBackgroundImage:[UIImage imageNamed:@"UserCenter_QuitBtn_Clicked.png"] forState:UIControlStateHighlighted];
    [self.contentView addSubview:_quitLoginBtn];
    
    return self;
}



- (void)setActionForTarget:(id)target {
    [_quitLoginBtn addTarget:target action:@selector(doExitLoginAction) forControlEvents:UIControlEventTouchUpInside];
}


@end
