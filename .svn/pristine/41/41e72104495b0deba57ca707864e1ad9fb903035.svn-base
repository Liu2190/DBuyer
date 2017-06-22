//
//  PatternOfPaymenViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-29.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP.h"
//#import "ClientWaitingViewController.h"
@protocol PatternOfPaymenViewControllerDelegate <NSObject>

-(void) pushToDshDDVC;

@end

@interface PatternOfPaymenViewController : UIViewController <UPOMPDelegate,UIAlertViewDelegate>{
//    ClientWaitingViewController *_waitingVC;//等待页
}

@property (retain, nonatomic) IBOutlet UIImageView *img1;
@property (retain, nonatomic) IBOutlet UIButton *btn1;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UIImageView *img2;
@property (retain, nonatomic) IBOutlet UIImageView *img3;
@property (retain, nonatomic) IBOutlet UIImageView *img4;
@property (retain, nonatomic) IBOutlet UIImageView *img5;
@property (retain, nonatomic) IBOutlet UILabel *label2;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,assign)id delegate;
@property (retain, nonatomic) IBOutlet UILabel *label3;
@property (retain, nonatomic) IBOutlet UIImageView *img6;

@property (retain, nonatomic) IBOutlet UIImageView *img7;

@property (retain, nonatomic) IBOutlet UIImageView *img8;

@property (retain, nonatomic) IBOutlet UILabel *yingfujifen;

@property (retain, nonatomic) IBOutlet UILabel *zengsongjifen;

@property (retain, nonatomic) IBOutlet UILabel *jiangliwenan;

@property (retain, nonatomic) IBOutlet UIImageView *img9;
@property (retain, nonatomic) IBOutlet UIImageView *img10;

@property (retain, nonatomic) IBOutlet UIImageView *img11;
@property (retain, nonatomic) IBOutlet UIImageView *img12;

@property (retain, nonatomic) IBOutlet UILabel *dingdanhao;
@property (retain, nonatomic) IBOutlet UILabel *haoma;
@property (retain, nonatomic) IBOutlet UIImageView *img13;

@property (retain, nonatomic) IBOutlet UIImageView *img14;

@property (retain, nonatomic) IBOutlet UIImageView *img15;
@property (retain, nonatomic) IBOutlet UIImageView *img16;

@property (retain, nonatomic) IBOutlet UILabel *yinlianzhifu;
@property (retain, nonatomic) IBOutlet UIButton *yinlian;
@property (nonatomic,copy) NSString * orderID;//订单号
@property (nonatomic,copy) NSString * amountPayable; //消费金额
@property (nonatomic,copy) NSString * integral; //返回积分
@property (nonatomic,assign) NSInteger rootControlType;
@property (retain, nonatomic) IBOutlet UILabel *totalPriceLabel;
- (IBAction)didClickPayButton:(UIButton *)sender;



@end
