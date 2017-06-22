//
//  HeaderView.h
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanModal.h"
@protocol  planRightButtonDelegate<NSObject>
@optional
- (void)headerPressed:(UIButton *)button;
- (void)deletePlanOfFinished:(UIButton *)button;
- (void)buttonOnCellDidClick:(UIButton *)button;
- (void)cuxButtonClick:(NSInteger )section;
@end

@interface HeaderView : UIView
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UITextField *planNameLabel;
@property (retain, nonatomic) IBOutlet UIImageView *planDirectionImage;
@property (retain, nonatomic) IBOutlet UIImageView *planSeparateImage;
@property (retain, nonatomic) IBOutlet UIImageView *planIconImage;
@property (retain, nonatomic) IBOutlet UIButton *planChangeButton;
@property (retain, nonatomic) IBOutlet UIImageView *planFinishedImage;
@property (retain, nonatomic) IBOutlet UILabel *countLabel;
@property (retain, nonatomic) IBOutlet UIImageView *countRedImage;
@property (retain, nonatomic) IBOutlet UIImageView *planDisc_image;

@property(nonatomic,assign)id delegate;
@property (retain, nonatomic) IBOutlet UIButton *cuxButton;
- (IBAction)cuxButonDidClick:(id)sender;

- (IBAction)btnClick:(id)sender;


-(void)setHeaderViewValue:(PlanModal *)plan WithSection:(NSInteger)section;
@end
