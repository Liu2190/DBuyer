//
//  TAllscoChargeFormController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoChargeFormController.h"
#import "TAllscoChargeElement.h"
#import "SBJsonWriter.h"
#import "TUtilities.h"
#import "TDbuyerUser.h"

@implementation TAllscoChargeFormController

- (id)initWithCard:(TAllScoCard*)card {
    self = [super init];
    self.resizeWhenKeyboardPresented =YES;
    self.card = card;
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    
    _charge = [[TAllScoCharge alloc]init];
    _charge.cardNumber = card.cardNumber;
    TDbuyerUser *dbuyerUser = [[TUtilities getInstance]getDbuyerUser];
    _charge.phoneNumber = dbuyerUser.name;
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    QSection *baseSection = [[QSection alloc]init];
    baseSection.footer = @"温馨提示：电子预付卡最大限额为1000元。";
    [self.root addSection:baseSection];
    QLabelElement *cardElement = [[QLabelElement alloc]initWithTitle:@"卡号:" Value:_card.cardNumber];
    [baseSection addElement:cardElement];
    [cardElement release];
    
    NSString *residual = [NSString stringWithFormat:@"%@(元)",_card.residual];
    QLabelElement *residualElement = [[QLabelElement alloc]initWithTitle:@"当前余额:" Value:residual];
    [baseSection  addElement:residualElement];
    [residualElement release];
    
    //
    QSection *chargeSection = [[QSection alloc]initWithTitle:@"选择充值金额。"];
    [self.root addSection:chargeSection];
    TAllscoChargeElement *chargeElement = [[TAllscoChargeElement alloc]initwithCard:_card];
    [chargeElement setKey:@"chargeElement"];
    [chargeSection addElement:chargeElement];
    QLabelElement *residualChargeElement = [[QLabelElement alloc]initWithTitle:@"充值后余额：" Value:residual];
    [residualChargeElement setKey:@"residualChargeElement"];
    [chargeSection addElement:residualChargeElement];
    
    //
    QSection *payWaySection = [[QRadioSection alloc] initWithItems:[NSArray arrayWithObjects:@"银联支付", @"快钱支付",nil]
                                                          selected:0 title:@""];
    [payWaySection setKey:@"payWaySection"];
    payWaySection.footer = @"支付成功后两小时内到账。";
    [self.root addSection:payWaySection];

    //
    QSection *actionSection = [[QSection alloc]init];
    [self.root addSection:actionSection];
    QButtonElement *chargeBtn = [[[QButtonElement alloc]initWithTitle:@"立即充值"]autorelease];
    chargeBtn.appearance.buttonAlignment = NSTextAlignmentCenter;
    chargeBtn.appearance.actionColorEnabled = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    [chargeBtn setControllerAction:@"doChargeAllsco:"];
    [actionSection addElement:chargeBtn];
    
    [self updateChargeObjectByIndex:1]; // 默认充值100元
    _charge.payIndexValue = @"0";       // 默认为银联支付
    [self updateFormResidualAmount];
}

- (void)doChargeAllsco:(id)element {
    QRadioSection *radioSection = (QRadioSection*)[self.root sectionWithKey:@"payWaySection"];
    NSString *payIndex = [NSString stringWithFormat:@"%i",radioSection.selected];
    _charge.payIndexValue = payIndex;
    [self.allscoChargeController chargeAllscoByCharge:_charge];
}

- (void)doClickButton:(id)obj {
    UIButton *btn = (UIButton*)obj;
    [self updateChargeObjectByIndex:btn.tag];
    [self updateFormResidualAmount];
}

/**
 * 更新表单实体对象
 */
- (void)updateChargeObjectByIndex:(int)index_ {
    int index = index_*100;
    
    NSString *indexValue = [NSString stringWithFormat:@"%i",index];
    int indexFloat = [indexValue floatValue];
    NSString * chargeValue = [NSString stringWithFormat:@"%i",indexFloat];
    _charge.chargeAmount = chargeValue;
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:_charge.cardNumber,@"cardNo",_charge.chargeAmount,@"chargeAmt",nil];//_charge.chargeAmount
    [datas addObject:dict];
    
    SBJsonWriter *sbjson = [[[SBJsonWriter alloc]init]autorelease];
    NSString *orderByString = [sbjson stringWithObject:datas];
    _charge.chargeCards = orderByString;
    
    
    //
    TAllscoChargeElement *chargeElement = (TAllscoChargeElement*)[self.root elementWithKey:@"chargeElement"];
    chargeElement.selectIndex = (index_-1);
}

/**
 * 更新表单控件
 */
- (void)updateFormResidualAmount {
    
    //
    float chargeAmount = [_charge.chargeAmount floatValue];
    float cardResidual = [_card.residual floatValue];
    float chargeResidual = chargeAmount + cardResidual;
    
    QLabelElement *residualElement = (QLabelElement*)[self.root elementWithKey:@"residualChargeElement"];
    [residualElement setValue:[NSString stringWithFormat:@"%.2f",chargeResidual]];
    [self.quickDialogTableView reloadData];
}

@end
