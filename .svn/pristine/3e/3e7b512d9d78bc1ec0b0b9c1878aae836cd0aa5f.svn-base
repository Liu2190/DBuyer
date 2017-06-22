//
//  TBaseContentController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseContentController.h"

@implementation TBaseContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect contentFrame = CGRectMake(0, self.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navigationBar.frame.size.height);
    self.contentView = [[UIView alloc]initWithFrame:contentFrame];

    [self addSubView];
}

- (void)addSubView {
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:_contentView];
}


@end
