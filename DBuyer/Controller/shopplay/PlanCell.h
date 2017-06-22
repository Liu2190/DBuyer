//
//  PlanCell.h
//  DBuyer
//
//  Created by liuxiaodan on 13-11-14.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *imgback;
@property (retain, nonatomic) IBOutlet UILabel *contentLabel;
@property (retain, nonatomic) IBOutlet UILabel *xianjia;

@property (retain, nonatomic) IBOutlet UIButton *btnClick;
@property (retain, nonatomic) IBOutlet UILabel *jiarugouwuche;
@property (retain, nonatomic) IBOutlet UIImageView *backimg;
- (IBAction)buttonClick:(id)sender;
@property(nonatomic,assign)id delegate;
@property (retain, nonatomic) IBOutlet UIImageView *planImage;










@end
