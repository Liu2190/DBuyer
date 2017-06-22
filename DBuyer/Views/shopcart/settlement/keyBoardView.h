//
//  keyBoardView.h
//  DBuyer
//
//  Created by simman on 14-1-16.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface keyBoardView : UIView

- (IBAction)finishButtonAction:(id)sender;  // 完成按钮

- (IBAction)cancelButtonAction:(id)sender;  // 取消按钮

- (void)addTarget:(id)target finishAction:(SEL)faction cancelAction:(SEL)caction;

- (id)initWithNib;
+(float)keyBoardViewHeight;
@end
