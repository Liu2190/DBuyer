//
//  PlanDatePickerView.h
//  DBuyer
//
//  Created by liuxiaodan on 14-3-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanDatePickerView : UIView
- (IBAction)finishPickDate:(id)sender;
- (IBAction)cancelPickDate:(id)sender;
@property (retain, nonatomic) IBOutlet UIDatePicker *planDatePicker;
-(void)addTarget:(id)thisTarget WithFinishAction:(SEL)finishAction;
-(void)setPlanDatePickerVisible;
@end
