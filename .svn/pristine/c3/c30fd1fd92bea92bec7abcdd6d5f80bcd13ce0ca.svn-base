//
//  TNaviSetController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TNaviSetController : UIViewController {
    
}

@property (nonatomic,retain) UIView *navigationBar;
@property (nonatomic,assign) BOOL hasNavi;

@property (nonatomic,assign) id leftAttached;
@property (nonatomic,assign) id rightAttached;
@property (nonatomic,assign) id titleAttached;

@property (nonatomic,retain) NSString *rightAttachedImage;

@property (nonatomic,assign) BOOL hasBackAction;
@property (nonatomic,assign) BOOL isPushOpen;

- (id)initWithNavigationTitle:(NSString*)title;
- (id)initWithNavigationTitle:(NSString*)title andRightAttached:(NSString*)rightAttached;

// set navigation
- (void)setNavigationBar;

// and navigation title
- (void)setNavigationTitle;

// add button for navigation's bar
- (void)setNavigationLeftButton;
- (void)setNavigationRightButton;

// there is target action on navigation'bar button
- (void)leftButtonAction;
- (void)rightButtonAction;

@end
