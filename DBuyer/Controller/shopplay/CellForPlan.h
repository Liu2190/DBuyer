//
//  CellForPlan.h
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForPlan : UITableViewCell
@property (retain, nonatomic) IBOutlet UIButton *takepicBtn;
@property (retain, nonatomic) IBOutlet UIButton *clockBtn;
@property (retain, nonatomic) IBOutlet UIButton *searchBtn;
@property (retain, nonatomic) IBOutlet UIButton *garbageBtn;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,assign)id delegate;

@end
