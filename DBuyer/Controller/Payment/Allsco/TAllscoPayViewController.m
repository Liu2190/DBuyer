//
//  TAllscoPayViewController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-18.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoPayViewController.h"
#import "TDbuyerUser.h"
#import "TUtilities.h"
#import "SBJsonWriter.h"
#import "TServerFactory.h"
#import "TAllScoServer.h"
#import "TAllScoCard.h"

#define right_btn_size_width     70
#define right_btn_size_height    30

#define allscoLogo_size_width     60
#define allscoLogo_size_height    30

#define left_margin   15
#define top_margin    10
#define sp_margin     5

#define font_size     16

#define allsco_validata_height  40
#define allsco_choice_height    40

@implementation TAllscoPayViewController

- (id)initWithNavigationTitle:(NSString *)title andDatas:(NSArray*)datas {
    self = [super initWithNavigationTitle:title];
    self.allscoList = [[NSMutableArray alloc]init];
    
    for (TAllScoCard *card in datas) {
        [_allscoList addObject:card];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPushOpen = NO;
    keyboardShown = NO;
    viewMoved = NO;
    
    CGRect rect = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _mainScrollView = [[[UIScrollView alloc]initWithFrame:rect]autorelease];
    [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, _mainScrollView.frame.size.height+.5)];
    [_mainScrollView setBackgroundColor:[UIColor colorWithRed:207.0/255.0 green:224.0/255.0 blue:239.0/255.0 alpha:1]];
    _mainScrollView.delegate = self;
    // _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:_mainScrollView];
    
    // 商户名称
    UILabel *goodsNameLabel = [[[UILabel alloc]init]autorelease];
    goodsNameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    goodsNameLabel.numberOfLines = 0;
    [goodsNameLabel setBackgroundColor:[UIColor clearColor]];
    [goodsNameLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [goodsNameLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [goodsNameLabel setText:@"商户名称:  "];
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [goodsNameLabel.text sizeWithFont:goodsNameLabel.font constrainedToSize:maximumLabelSize
                                           lineBreakMode:NSLineBreakByWordWrapping];
    [goodsNameLabel setFrame:CGRectMake(left_margin, top_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:goodsNameLabel];
    float h = goodsNameLabel.frame.origin.y+goodsNameLabel.frame.size.height;
    
     UILabel *goodsNameValue = [[[UILabel alloc]init]autorelease];
    goodsNameValue.lineBreakMode = NSLineBreakByWordWrapping;
    goodsNameValue.numberOfLines = 0;
    [goodsNameValue setBackgroundColor:[UIColor clearColor]];
    [goodsNameValue setFont:[UIFont systemFontOfSize:font_size]];
    [goodsNameValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [goodsNameValue setText:@"尚超市BHG"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [goodsNameValue.text sizeWithFont:goodsNameValue.font constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByWordWrapping];
    [goodsNameValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, top_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:goodsNameValue];
    
    
    // 金额
    UILabel *moneyLabel = [[[UILabel alloc]init]autorelease];
    moneyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    moneyLabel.numberOfLines = 0;
    [moneyLabel setBackgroundColor:[UIColor clearColor]];
    [moneyLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [moneyLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [moneyLabel setText:@"金额:  "];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [moneyLabel.text sizeWithFont:moneyLabel.font constrainedToSize:maximumLabelSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    [moneyLabel setFrame:CGRectMake(left_margin,h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:moneyLabel];
    
    UILabel *moneyValue = [[[UILabel alloc]init]autorelease];
    moneyValue.lineBreakMode = NSLineBreakByWordWrapping;
    moneyValue.numberOfLines = 0;
    [moneyValue setBackgroundColor:[UIColor clearColor]];
    [moneyValue setFont:[UIFont systemFontOfSize:font_size]];
    [moneyValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [moneyValue setText:_confirmPay.paidAmount];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [moneyValue.text sizeWithFont:moneyValue.font constrainedToSize:maximumLabelSize
                                 lineBreakMode:NSLineBreakByWordWrapping];
    [moneyValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:moneyValue];
    h = moneyLabel.frame.origin.y+moneyLabel.frame.size.height;
    
    // 订单号
    UILabel *orderNumLabel = [[[UILabel alloc]init]autorelease];
    orderNumLabel.lineBreakMode = NSLineBreakByWordWrapping;
    orderNumLabel.numberOfLines = 0;
    [orderNumLabel setBackgroundColor:[UIColor clearColor]];
    [orderNumLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [orderNumLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [orderNumLabel setText:@"订单号:"];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [orderNumLabel.text sizeWithFont:orderNumLabel.font constrainedToSize:maximumLabelSize
                                   lineBreakMode:NSLineBreakByWordWrapping];
    [orderNumLabel setFrame:CGRectMake(left_margin,h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:orderNumLabel];
    
    UILabel *orderNumValue = [[[UILabel alloc]init]autorelease];
    orderNumValue.lineBreakMode = NSLineBreakByTruncatingTail;
    orderNumValue.numberOfLines = 1;
    [orderNumValue setBackgroundColor:[UIColor clearColor]];
    [orderNumValue setFont:[UIFont systemFontOfSize:font_size]];
    [orderNumValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [orderNumValue setText:_confirmPay.orderIdList];
    maximumLabelSize = CGSizeMake(_mainScrollView.frame.size.width-goodsNameLabel.frame.origin.x-goodsNameLabel.frame.size.width-20, font_size);
    titleSize = [orderNumValue.text sizeWithFont:moneyValue.font constrainedToSize:maximumLabelSize
                                    lineBreakMode:NSLineBreakByTruncatingTail];
    [orderNumValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:orderNumValue];
    h = orderNumValue.frame.origin.y+orderNumValue.frame.size.height;
    
    
    // 交易时间
    UILabel *tradeTimeLabel = [[[UILabel alloc]init]autorelease];
    tradeTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tradeTimeLabel.numberOfLines = 0;
    [tradeTimeLabel setBackgroundColor:[UIColor clearColor]];
    [tradeTimeLabel setFont:[UIFont boldSystemFontOfSize:font_size]];
    [tradeTimeLabel setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [tradeTimeLabel setText:@"交易时间:  "];
    maximumLabelSize = CGSizeMake(200, 999);
    titleSize = [tradeTimeLabel.text sizeWithFont:tradeTimeLabel.font constrainedToSize:maximumLabelSize
                                    lineBreakMode:NSLineBreakByWordWrapping];
    [tradeTimeLabel setFrame:CGRectMake(left_margin,h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:tradeTimeLabel];
    
    UILabel *tradeTimeValue = [[[UILabel alloc]init]autorelease];
    tradeTimeValue.lineBreakMode = NSLineBreakByTruncatingTail;
    tradeTimeValue.numberOfLines = 1;
    [tradeTimeValue setBackgroundColor:[UIColor clearColor]];
    [tradeTimeValue setFont:[UIFont systemFontOfSize:font_size]];
    [tradeTimeValue setTextColor:[UIColor colorWithRed:103.0/255.0 green:125.0/255.0 blue:140.0/255.0 alpha:1.0]];
    [tradeTimeValue setText:_confirmPay.orderDate];
    maximumLabelSize = CGSizeMake(_mainScrollView.frame.size.width-goodsNameLabel.frame.origin.x-goodsNameLabel.frame.size.width, font_size);
    titleSize = [tradeTimeValue.text sizeWithFont:tradeTimeValue.font constrainedToSize:maximumLabelSize
                                     lineBreakMode:NSLineBreakByTruncatingTail];
    [tradeTimeValue setFrame:CGRectMake(goodsNameLabel.frame.origin.x+goodsNameLabel.frame.size.width, h+sp_margin, titleSize.width, titleSize.height)];
    [_mainScrollView addSubview:tradeTimeValue];
    h = tradeTimeValue.frame.origin.y+tradeTimeValue.frame.size.height;
    
    // 支付卡列表项
    _itemPayController = [[TItemAllscoPayController alloc]initWithAllscoList:_allscoList];
    rect = CGRectMake(left_margin, h+3*sp_margin, _mainScrollView.frame.size.width-2*left_margin, 0);
    [_itemPayController setTheFrame:rect];
    _itemPayController.confirmPay = _confirmPay;
    [_mainScrollView addSubview:_itemPayController.view];
    h = _itemPayController.view.frame.origin.y+_itemPayController.tableView.frame.size.height;
    
    
    // 验证码
    _validataView = [[TAllScoValidataView alloc]initWithFrame:CGRectMake(left_margin, h+3*sp_margin, _mainScrollView.frame.size.width-2*left_margin, allsco_validata_height)];
    [_validataView setTargetForView:self];
    [_mainScrollView addSubview:_validataView];
    h = _validataView.frame.origin.y+_validataView.frame.size.height;

    // 支付按钮
    _tradeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_tradeBtn  setFrame:CGRectMake(left_margin, h+5*sp_margin, _mainScrollView.frame.size.width-2*left_margin, allsco_choice_height)];
    [_tradeBtn setImage:[UIImage imageNamed:@"AllScoPay_PayBtn.png"] forState:UIControlStateNormal];
    [_tradeBtn setImage:[UIImage imageNamed:@"AllScoPay_PayBtn_Clicked.png"] forState:UIControlStateHighlighted];
    [_mainScrollView addSubview:_tradeBtn];
    [_tradeBtn addTarget:self action:@selector(doPayButtonActon:) forControlEvents:UIControlEventTouchUpInside];
    h = _tradeBtn.frame.origin.y+_tradeBtn.frame.size.height;

    if (h>_mainScrollView.frame.size.height) {
        [_mainScrollView setContentSize:CGSizeMake(_mainScrollView.frame.size.width, h)];
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationSetStatusBar" object:@"0"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hasEnablePay:) name:@"Notification_hasEnablePay" object:nil];
}

/**
 * 支付表单退出按钮被点击
 */
- (void)exitPayAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.allscoPayDelegate allscoPaySuccess:NO];
}

/**
 * 验证码按钮被点击
 */
- (void)theValidaBtnClicked:(UITapGestureRecognizer *)sender {
    [[TUtilities getInstance]popTarget:_mainScrollView status:@"加载中..."];
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    [[TServerFactory getServerInstance:@"TAllScoServer"]getValidataByPhoneNumber:dbuyerUser.name
                                                                     andCallback:^(NSString *resp) {
                                                                         [[TUtilities getInstance]dismiss];
                                                                         [_validataView updateValidataBlock];
                                                                     } failureCallback:^(NSString *resp) {
                                                                         [[TUtilities getInstance]popMessageError:@"加载失败" target:_mainScrollView delayTime:1.0f];
                                                                     }];
    
    
    
}

/**
 * 支付按钮被点击
 */
- (void)doPayButtonActon:(id)sender {
    [self.view endEditing:YES];
    // 判断验证码是否为空
    NSString *validata = [_validataView getValidataNum];
    if (validata.length == 0) {
        [[TUtilities getInstance]popMessageError:@"验证码不能为空" target:self.contentView delayTime:1.0];
        return;
    }
    
    // 支付接口
    NSDateFormatter *hzdateParserFormatter = [[NSDateFormatter alloc] init];
    [hzdateParserFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *orderDate = [hzdateParserFormatter stringFromDate:[NSDate date]];
    NSString *name = [[TUtilities getInstance]getDbuyerUser].name;
    NSString *validataNum = [_validataView getValidataNum];
    
    NSMutableArray *cards = [[[NSMutableArray alloc]init]autorelease];
    for (TAllScoCard *card in _itemPayController.payCardList) {
        NSDictionary *cardDict = @{@"cardNo":card.cardNumber,@"payAmount":card.payAmount};
        [cards addObject:cardDict];
    }
    
    SBJsonWriter *sbjson = [[[SBJsonWriter alloc]init]autorelease];
    NSString *orderByString = [sbjson stringWithObject:cards];
    
    [[TUtilities getInstance]popTarget:self.view status:@"正在提交..."];
    [[TServerFactory getServerInstance:@"TAllScoServer"]doPayCardByOrderNo:_confirmPay.orderIdList
                                                              andOrderDate:orderDate
                                                            andOrderAmount:_confirmPay.paidAmount
                                                                andAccount:name
                                                               andPayCards:orderByString
                                                             andVerifyCode:validataNum
                                                               andCallback:^(NSString *datas) {
                                                                   [[TUtilities getInstance]dismiss];
                                                                   [self.allscoPayDelegate allscoPaySuccess:YES];
                                                                   [self.navigationController popViewControllerAnimated:YES];
                                                               } failureCallback:^(NSString *resp) {
                                                                   [[TUtilities getInstance]popMessageError:resp target:self.view delayTime:2.0];
                                                               }];
}


/**
 * 重写导航栏右按钮布局
 */
- (void)setNavigationRightButton {
    float x = self.navigationBar.frame.size.width-right_btn_size_width-10;
    float y = (self.navigationBar.frame.size.height - right_btn_size_height)/2;
    UIButton *exitBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, right_btn_size_width, right_btn_size_height)];
    [exitBtn setImage:[UIImage imageNamed:@"AllScoPay_ExitBtn"] forState:UIControlStateNormal];
    [exitBtn setImage:[UIImage imageNamed:@"AllScoPay_ExitBtn_Clicked"] forState:UIControlStateHighlighted];
    [exitBtn addTarget:self action:@selector(exitPayAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationBar addSubview:exitBtn];
    [exitBtn release];
}

/**
 * 重写导航栏 设置背景颜色
 */
- (void)setNavigationBar {
    float navi_h = 50;
    CGRect navigationRect = CGRectMake(0, 0, self.view.frame.size.width, navi_h);
    
    self.navigationBar=[[UIView alloc]initWithFrame:navigationRect];
    self.navigationBar.backgroundColor=[UIColor colorWithRed:58.0/255 green:106.0/255.0 blue:91.0/255.0 alpha:1.f];
    self.navigationBar.userInteractionEnabled=YES;
    [self.view addSubview:self.navigationBar];
    
    float y = (self.navigationBar.frame.size.height-allscoLogo_size_height)/2;
    UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, y, allscoLogo_size_width, allscoLogo_size_height)];
    [imageLogo setImage:[UIImage imageNamed:@"AllScoPay_Logo.png"]];
    [self.navigationBar addSubview:imageLogo];
    [imageLogo release];
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ApplicationSetStatusBar"object:@"1"];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardWillShow:(NSNotification*)notification {
    if (keyboardShown) return;
    
    /*NSDictionary *info = [notification userInfo];
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    float H = keyboardSize.height;*/
    
    NSTimeInterval animationDuration = 0.300000011920929;
    CGRect frame = self.contentView.frame;
    frame.origin.y -= _itemPayController.view.frame.origin.y+self.navigationBar.frame.size.height-10;
    frame.size.height += _itemPayController.view.frame.origin.y-self.navigationBar.frame.size.height+10;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.contentView.frame = frame;
    [UIView commitAnimations];
    
    viewMoved = YES;
    
    keyboardShown = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_validataView cancelBoard];
}

- (void)keyboardWillHide:(NSNotification*)notification {
    if ( viewMoved) {
        /*NSDictionary *info = [notification userInfo];
        NSValue *aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [aValue CGRectValue].size;*/
        
        NSTimeInterval animationDuration = 0.300000011920929;
        CGRect frame = self.contentView.frame;
        frame.origin.y += (_itemPayController.view.frame.origin.y+self.navigationBar.frame.size.height-10);
        frame.size.height -= (_itemPayController.view.frame.origin.y-self.navigationBar.frame.size.height+10);
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        self.contentView.frame = frame;
        [UIView commitAnimations];
        
        viewMoved = NO;
    }
    
    keyboardShown = NO;
}

- (void)hasEnablePay:(NSNotification*)notification {
    NSString *value = [notification object];
    if([value isEqualToString:@"0"]) { // 需求置灰
        _tradeBtn.enabled = NO;
    } else {
        _tradeBtn.enabled = YES;
    }
}


- (void)dealloc {
    [super dealloc];
    
    [_mainScrollView release];
    _mainScrollView = nil;
    
    [_itemPayController release];
    _itemPayController = nil;
    
    [_validataView release];
    _validataView = nil;
    
    [_tradeBtn release];
    _tradeBtn = nil;
    
    [_confirmPay release];
    _confirmPay = nil;
    
    [_allscoList release];
    _allscoList = nil;
}



@end