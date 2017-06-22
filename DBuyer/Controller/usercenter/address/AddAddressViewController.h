//
//  AddAddressViewController.h
//  DBuyer
//
//  Created by liuxiaodan on 13-11-22.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadView.h"



@interface AddAddressViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
@property (retain, nonatomic) IBOutlet UITextField *nameTextField;

@property (retain, nonatomic) IBOutlet UITextField *phoneNumberTextField;
- (IBAction)didClickFindAreaId:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITextView *addressDetailInfoTextView;
- (IBAction)didClickAddAddress:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIButton *findAreaIdBtn;
- (IBAction)didClickBack:(id)sender;
@property (nonatomic,copy) NSString * areaId;

@property (retain, nonatomic) IBOutlet UITextField *backGroundView; // 背景View

@property (nonatomic,copy) NSString * boutique;//精品店id
@property (nonatomic,copy) NSString * stores;//综合店id

- (void)addTarget:(id)target action:(SEL)action;


@end

