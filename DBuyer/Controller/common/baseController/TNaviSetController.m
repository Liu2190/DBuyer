//
//  TNaviSetController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TNaviSetController.h"
#import "UIButton+Extensions.h"

#define title_label_size  17
#define title_button_size 35

#define left_btn_size_width     20
#define left_btn_size_height    16

#define right_btn_size_width     25
#define right_btn_size_height    20

@implementation TNaviSetController

- (id)initWithNavigationTitle:(NSString*)title {
    [super init];
    self.titleAttached = title;
    self.isPushOpen = YES;
    self.hasBackAction = YES;
    self.hasNavi = YES;
    
    return self;
}

- (id)initWithNavigationTitle:(NSString *)title andRightAttached:(NSString *)rightAttached {
    [super init];
    self.titleAttached = title;
    self.rightAttached = rightAttached;
    self.rightAttachedImage = rightAttached;
    self.isPushOpen = YES;
    self.hasBackAction = YES;
    self.hasNavi = YES;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftAttached = @"Image_HomeView_back.png";
    [self.navigationController setNavigationBarHidden:YES];
    
    if (self.hasNavi) {
        [self setNavigationBar];
        [self setNavigationTitle];
    }
    
    if (_hasBackAction)
    [self setNavigationLeftButton];
    [self setNavigationRightButton];
    
}

- (void)setNavigationBar {
    float navi_h = 44; IsIOS7?navi_h+=20:20;
    CGRect navigationRect = CGRectMake(0, 0, self.view.frame.size.width, navi_h);
    
    self.navigationBar=[[UIView alloc]initWithFrame:navigationRect];
    [_navigationBar setBackgroundColor:[UIColor colorWithRed:58/255.0f green:106.0/255.0 blue:91.0/255.0 alpha:1.0]];
    _navigationBar.userInteractionEnabled=YES;
}


- (void)setNavigationTitle {
    NSString *titleAttached = _titleAttached;
    BOOL isImageTitle = YES;
    if (titleAttached.length ==0) return;

    CGSize titleSize;
    
    // if titleAttached has "." and can gen a image object
    if(!([titleAttached rangeOfString:@"."].location == NSNotFound)) {
        UIImage *image = [UIImage imageNamed:titleAttached];
        if(image == nil) {isImageTitle = NO;}
        
        titleSize = CGSizeMake(title_button_size, title_button_size);
        
        float x = (_navigationBar.frame.size.width - titleSize.width)/2;
        float y = _navigationBar.frame.size.height - titleSize.height - 5;
        UIImageView *titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
        titleImageView.image = image;
        
        [_navigationBar addSubview:titleImageView];
        [titleImageView release];
    }
    
    // else
    if(([titleAttached rangeOfString:@"."].location == NSNotFound) || !isImageTitle) {
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        titleSize = [titleAttached sizeWithFont:[UIFont systemFontOfSize:title_label_size] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        float x = (_navigationBar.frame.size.width - titleSize.width)/2;
        float y = (_navigationBar.frame.size.height - titleSize.height)/2+(IsIOS7?10:0);
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
        titleLabel.font = [UIFont systemFontOfSize:title_label_size];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setText:titleAttached];
        
        [_navigationBar addSubview:titleLabel];
        [titleLabel release];
    }
}

- (void)setNavigationLeftButton {
    BOOL isImageBtn = YES;
    NSString *leftAttached = self.leftAttached;
    if (leftAttached.length == 0) return;
    
    //
    if(!([leftAttached rangeOfString:@"."].location == NSNotFound)) {
        UIImage *image = [UIImage imageNamed:leftAttached];
        if(image == nil) {isImageBtn = NO;}
        
        float x = 5;
        float y = (_navigationBar.frame.size.height-left_btn_size_height)/2+(IsIOS7?10:0);
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, left_btn_size_width, left_btn_size_height)];
        [leftBtn setImage:image forState:UIControlStateNormal];
        [leftBtn setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -30)];
        [leftBtn setContentMode:UIViewContentModeCenter];
        [leftBtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationBar addSubview:leftBtn];
    }
}

- (void)setNavigationRightButton {
    BOOL isImageBtn = YES;
    NSString *rightAttached = self.rightAttached;
    if (rightAttached.length == 0) return;
    
    //
    if(!([rightAttached rangeOfString:@"."].location == NSNotFound)) {
        UIImage *image = [UIImage imageNamed:rightAttached];
        UIImage *selectedImage = [UIImage imageNamed:_rightAttachedImage];
        if(image == nil) {isImageBtn = NO;}
        
        float x = _navigationBar.frame.size.width-5-right_btn_size_width;
        float y = (_navigationBar.frame.size.height-right_btn_size_height)/2+(IsIOS7?10:0);
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, right_btn_size_width, right_btn_size_height)];
        [rightBtn setBackgroundImage:image forState:UIControlStateNormal];
        [rightBtn setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_navigationBar addSubview:rightBtn];
    }
    
    // else
    if(([rightAttached rangeOfString:@"."].location == NSNotFound) || !isImageBtn) {
        CGSize maximumLabelSize = CGSizeMake(200, 999);
        CGSize titleSize = [rightAttached sizeWithFont:[UIFont systemFontOfSize:title_label_size] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        
        float x = _navigationBar.frame.size.width - titleSize.width - 5;
        float y = (_navigationBar.frame.size.height - titleSize.height)/2+(IsIOS7?12:0);
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, titleSize.width, titleSize.height)];
        [rightBtn setTitle:rightAttached forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor colorWithRed:60.0/255.0 green:142.0/255.0 blue:155.0/255.0 alpha:1] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBar addSubview:rightBtn];
        [rightBtn release];
    }
}

/**
 * 点击返回按钮
 */
- (void)leftButtonAction {
    
    if (self.isPushOpen)
        [self.navigationController popViewControllerAnimated:YES];
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击右按钮
 */
- (void)rightButtonAction {
    
}


- (void)dealloc {
    [super dealloc];
    
    [_navigationBar release];
    _navigationBar = nil;
    
    [_leftAttached release];
    _leftAttached = nil;
    
    [_rightAttached release];
    _rightAttached = nil;
    
    [_titleAttached release];
    _titleAttached = nil;
}

@end
