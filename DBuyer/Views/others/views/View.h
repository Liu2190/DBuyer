//
//  View.h
//  DBuyer
//
//  Created by liuxiaodan on 13-9-21.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView
@property (retain, nonatomic) IBOutlet UIImageView *img1;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UILabel *shangpinxiangqing;
@property (retain, nonatomic) IBOutlet UIButton *fenxiang;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,assign)id delegate;
@property (retain, nonatomic) IBOutlet UILabel *fenx;

@end
