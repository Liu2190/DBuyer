//
//  TDbuyerFieldController.h
//  DBuyer
//
//  Created by dilei liu on 14-3-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDbuyerTextField.h"


typedef enum {
    Input_Default, // 设定默认为手机号输入页
    Input_NO,
    Input_YES,
} InputTextFieldStatus;


/**
 *  封装型输入控件，该控件有图像标识
 */
@interface TDbuyerFieldController : UIViewController<UITextFieldDelegate> {
    
    /**
     * dbuyer输入控件
     */
    TDbuyerTextField *_dbuyerTextField;
    
    /**
     *  输入框头部图片标记
     */
    UIImageView *_validationImageView;
    
    /**
     * 输入框头部文字标记
     */
    UILabel *_textLabel;
    
    /**
     * 文字提示验证
     */
    UILabel *_validaLabel;
    
    /**
     * 控件输入状态
     */
    InputTextFieldStatus _inputStatus;
}

/**
 * 控件图片标识
 */
@property (nonatomic,retain) NSString *imageName;


/**
 *  控件文本标识
 */
@property (nonatomic,retain) NSString *textName;


@property (nonatomic,retain) NSString *placeholder;
@property (nonatomic,retain) UIColor *backgroundColor;

@property (nonatomic,assign) CGRect frame;
@property (nonatomic,assign) BOOL secureTextEntry;

/**
 * 验证标识符图
 */
@property (nonatomic,retain) NSString *validationAttached_yes; // 验证通过
@property (nonatomic,retain) NSString *validationAttached_no;  // 验证失败

/**
 * 是否启动验证功能
 */
@property (nonatomic,assign) BOOL isValidation;

/**
 * 控件是否可编辑
 */
@property (nonatomic,assign) BOOL isEdit;

/**
 *  控件构造方法,创建带有图像的textfield控件
 */
- (id)initWithImageName:(NSString*)imageName andPlaceholder:(NSString*)placeholder andFrame:(CGRect)frame;

/**
    控件构造方法，创建带文字标记的文本控件
 */
- (id)initWithTextName:(NSString*)textName andPlaceholder:(NSString*)placeholder andFrame:(CGRect)frame;


/**
 *  控件构造方法,常用控件
 */
- (id)initWithPlaceholder:(NSString*)placeholder andFrame:(CGRect)frame;

/**
 *  设置控件键盘类型
 */
- (void)setKeyboardType:(UIKeyboardType)keyboardType;

/**
 *  设置输入控件的字体大小
 */
- (void)setFont:(UIFont*)font;


/**
 *  设置控件协议代理对象
 */
- (void)setTextFieldDelegate:(id)delegate;



/**
 *  添加验证标识符 默认为图片,后继可以扩展成文字或其它
 */
- (void)addValidationAttached:(NSString*)attached_yes andAttach_no:(NSString*)attached_no;

/**
 * 改变验证是否通过标记值
 */
- (void)changeValidationValue:(InputTextFieldStatus)inputStatus andText:(NSString*)text;

/**
 *  获取控件值
 */
- (NSString*)getDbuyerTextFieldValue;

/**
 * 为控件设值
 */
- (void)setDbuyerTextValue:(NSString*)textFieldValue;


/**
    关闭键盘
 */
- (void)cancelKeyboard;


/**
    设置placeholder_size值
 */
- (void)setPlaceholderFontSize:(int)placeholderSize;



/**
 *  获取textfield对象
 */
- (TDbuyerTextField*)getDbuyerTextField;

/**
 * 设置控件是否可编辑
 */
- (void)setEditForTextField:(BOOL)isEdit;

@end
