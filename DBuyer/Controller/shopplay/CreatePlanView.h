//
//  CreatePlanView.h
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-8.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol createPlanDelegate <NSObject>

@optional

-(void)createBoxDidClick:(UIButton *)button;

@end

@interface CreatePlanView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *imageCancel;
@property (retain, nonatomic) IBOutlet UIImageView *confirmImage;
@property (retain, nonatomic) IBOutlet UIButton *cancelButton;
@property (retain, nonatomic) IBOutlet UIButton *confirmButton;
@property (retain, nonatomic) IBOutlet UIImageView *createBackImage;
@property (retain, nonatomic) IBOutlet UIButton *chooseButton;
@property (retain, nonatomic) IBOutlet UITextField *createTf;
@property (retain, nonatomic) IBOutlet UIImageView *indicateImage;
@property (retain, nonatomic) IBOutlet UIImageView *planImage;
@property (nonatomic,assign)id delegate;
- (IBAction)btnClick:(id)sender;
-(void)setCreatePlanViewWithIcon;
-(void)setCreatePlanViewVisible;
- (IBAction)makeScrolVisible:(id)sender;
-(void)backViewVisibleAction:(id)sender AndAction:(SEL)visibleAction;
@end
