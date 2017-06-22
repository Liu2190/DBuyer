//
//  TAllScoBindingController.m
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoBindingController.h"
#import "TServerFactory.h"
#import "TAllScoServer.h"
#import "TUtilities.h"
#import "TAllScoCard.h"

#define blockView_w 250
#define blockView_h 192


@implementation TAllScoBindingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.contentView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    keyboardShown = NO;
    viewMoved = NO;
    
    // bg
    CGRect mainRect = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _mainScrollView = [[[UIScrollView alloc]initWithFrame:mainRect]autorelease];
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, _mainScrollView.frame.size.height+1)];
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    _mainScrollView.delegate = self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    tap.numberOfTouchesRequired = 1;
    [self.contentView addGestureRecognizer:tap];
    
    // content block bg
    float x = 10,y = 10;
    _contentBlockView = [[TAllScoBindingView alloc]initWithFrame:CGRectMake(x, y, self.contentView.frame.size.width-2*x, blockView_h)];
    [_contentBlockView setTargetForAction:self];
    [_mainScrollView addSubview:_contentBlockView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#define adjust_h    180
- (void)keyboardWillShow:(NSNotification*)notification {
    if (keyboardShown || isIPhone5) return;

    NSDictionary *info = [notification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    
    NSTimeInterval animationDuration = 0.300000011920929;
    CGRect frame = self.contentView.frame;
    frame.origin.y -= keyboardSize.height-adjust_h;
    frame.size.height += keyboardSize.height-adjust_h;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.contentView.frame = frame;
    [UIView commitAnimations];
    
    viewMoved = YES;
    
    keyboardShown = YES;
}


- (void)keyboardWillHide:(NSNotification*)notification {
    if ( viewMoved) {
        NSDictionary *info = [notification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [aValue CGRectValue].size;
        
        NSTimeInterval animationDuration = 0.300000011920929;
        CGRect frame = self.contentView.frame;
        frame.origin.y += keyboardSize.height-adjust_h;
        frame.size.height -= keyboardSize.height-adjust_h;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.contentView.frame = frame;
        [UIView commitAnimations];
        
        viewMoved = NO;
    }
    
    keyboardShown = NO;
}


/**
 * 绑定商银信虚拟卡
 */
- (void)doBindingCards:(id)sender {
    // 验证表单录入是否允许提交
    BOOL booleValue = [_contentBlockView validataFormAction];
    if (!booleValue) return;
    
    TAllScoBindingForm *allScoBindingForm = [_contentBlockView getAllscoBindingEnity];
    [[TUtilities getInstance]popTarget:self.view status:@"处理中..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]doBingCardByPhoneNumber:allScoBindingForm.phoneNumber
                                                                  andCardNumber:allScoBindingForm.cardNumber
                                                              andValidataNumber:allScoBindingForm.validaNumber
                                                                    andCallback:^(NSString *datas) {
                                                                        [[TUtilities getInstance]dismiss];
                                                                        [[NSNotificationCenter defaultCenter]postNotificationName:@"Notification_BindingSuccess" object:self userInfo:nil];
                                                                        [self.navigationController popViewControllerAnimated:YES];
                                                                    } failureCallback:^(NSString *resp) {
                                                                        [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.f];
                                                                    }];
}

- (void)handleTap {[_contentBlockView cancelKeyboard];}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_contentBlockView cancelKeyboard];
}

- (void) textFieldDidChange:(UITextField *) textField{
    [_contentBlockView validataTextFieldAction:textField];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)layoutSubView {
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.contentView];
}


@end
