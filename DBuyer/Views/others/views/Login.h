//
//  Login.h
//  DBuyer
//
//  Created by liuxiaodan on 13-9-20.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIView
@property (retain, nonatomic) IBOutlet UIImageView *img1;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UILabel *denglu;
@property (retain, nonatomic) IBOutlet UIImageView *img2;

@property (retain, nonatomic) IBOutlet UIImageView *img3;
@property (retain, nonatomic) IBOutlet UIImageView *img4;

@property (retain, nonatomic) IBOutlet UIImageView *img5;
@property (retain, nonatomic) IBOutlet UIImageView *img6;

@property (retain, nonatomic) IBOutlet UIImageView *img7;

@property (retain, nonatomic) IBOutlet UILabel *zhanghao;
@property (retain, nonatomic) IBOutlet UILabel *mima;


@property (retain, nonatomic) IBOutlet UIButton *btb2;

@property (retain, nonatomic) IBOutlet UILabel *dneglu1;

- (IBAction)btnClick:(id)sender;
@property(nonatomic,assign)id delegate;

@property (retain, nonatomic) IBOutlet UITextField *tf1;
@property (retain, nonatomic) IBOutlet UITextField *tf2;

@end
