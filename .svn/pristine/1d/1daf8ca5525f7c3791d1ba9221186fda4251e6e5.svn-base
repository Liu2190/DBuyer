//
//  ShbjViewController.h
//  DBuyer
//  编辑收货地址
//  Created by liuxiaodan on 13-9-25.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "AddressItem.h"

@protocol ShbjViewControllerDelegate <NSObject>
-(void) refreshAddressList;
@end

@interface EditReceivingViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    View *sView;
}
@property (nonatomic,retain) AddressItem                * address;      // 地址对象
@property (nonatomic,assign) NSInteger                  chooseFlag;     //....
@property (nonatomic,assign) id<ShbjViewControllerDelegate> delegate;   // 代理方法

// 新增加
@property (retain, nonatomic) IBOutlet UITextField *consigneeTextField; // 收货人地址
@property (retain, nonatomic) IBOutlet UITextField *contactsTel;        // 联系人电话
@property (retain, nonatomic) IBOutlet UIButton    *setDefaultButton;   // 设为默认按钮
@property (retain, nonatomic) IBOutlet UIButton    *setDistrictButton;  // 设置区域button
@property (retain, nonatomic) IBOutlet UILabel *setDistrictLable;
@property (retain, nonatomic) IBOutlet UITextView  *addressContent;     // 详细地址
@property (retain, nonatomic) IBOutlet UIButton    *deleteButton;       // 删除按钮

/**
 *  设为默认按钮事件
 *
 *  @param sender UIButton
 */
- (IBAction)setDefaultButtonAction:(id)sender;
/**
 *  设置区域Button事件
 *
 *  @param sender UIButton
 */
- (IBAction)setDistrictButtonAction:(id)sender;
/**
 *  删除按钮事件
 *
 *  @param sender UIButton
 */
- (IBAction)deleteButtonAction:(id)sender;
/**
 *  回调方法
 *
 *  @param target 控制器
 *  @param action 方法
 */
- (void)addTarget:(id)target
           action:(SEL)action;

@end
