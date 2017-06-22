//
//  LoginReminderView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginReminderView : UIView

@property (retain, nonatomic) IBOutlet UILabel *reminderLabel;
- (IBAction)reminderButton:(id)sender;
-(void)addTarget:(id)thisTarget withLoginAction:(SEL)thisAction;
@end
