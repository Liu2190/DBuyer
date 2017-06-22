//
//  DatePickerOfSettlement.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerOfSettlement : UIView
- (IBAction)cancel:(id)sender;
- (IBAction)finish:(id)sender;
@property (retain, nonatomic) IBOutlet UIPickerView *datePicker;
-(void)addTarget:(id)thisTarget withCancelAction:(SEL)cancleAction AndFinishAction:(SEL)finishAction;
@end
