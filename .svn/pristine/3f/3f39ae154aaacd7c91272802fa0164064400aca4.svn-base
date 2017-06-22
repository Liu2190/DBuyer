//
//  TAllscoBuyerFormController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-29.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllscoBuyerFormController.h"
#import "TAllscoBuyerElement.h"
#import "SBJsonWriter.h"
#import "TUtilities.h"
#import "TDbuyerUser.h"
#import "TAllscoGoodPayForm.h"

@implementation TAllscoBuyerFormController

- (id)initWithAllscoGoodsForm:(NSArray*)goodItems andDelegate:(id)delObj {
    self = [super init];
    self.goodItems = goodItems;
    self.delObj = delObj;
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    
    return self;
}

- (int)getTotalMoneySize {
    int totalMoney = 0;
    
    for(TAllscoGoodsForm *goodForm in self.goodItems) {
        if (goodForm.sellNumber > 0) {
            int sellPrice = [goodForm.sellPrice intValue];
            totalMoney += goodForm.sellNumber*sellPrice;
        }
    }
    
    return totalMoney;
}

- (id)init {
    self = [super init];
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    QSection *phoneSection = [[[QSection alloc]init]autorelease];
    phoneSection.footer = @"发卡后该手机用来接收储值卡卡号和验证码";
    [self.root addSection:phoneSection];
    
    QEntryElement *cardElement = [[[QEntryElement alloc]initWithTitle:@"手机号" Value:@"" Placeholder:@"请输入收取验证码的手机号"]autorelease];
    cardElement.keyboardType = UIKeyboardTypeNumberPad;
    [cardElement setKey:@"phoneAccountElement"];
    [phoneSection addElement:cardElement];
    cardElement.appearance.labelFont = [UIFont systemFontOfSize:17];
    cardElement.appearance.valueFont = [UIFont systemFontOfSize:15];
    
    QSection *productListSection = [[[QSection alloc]initWithTitle:@"商品列表"]autorelease];
    [self.root addSection:productListSection];
    
    for (TAllscoGoodsForm *goodForm in self.goodItems) {
        TAllscoBuyerElement *chargeElement = [[[TAllscoBuyerElement alloc]initWithGoodForm:goodForm]autorelease];
        [chargeElement setKey:@"chargeElement"];
        [productListSection addElement:chargeElement];
    }
    
    NSString *totalValue = [NSString stringWithFormat:@"%i",[self getTotalMoneySize]];
    QLabelElement *statementElement = [[[QLabelElement alloc]initWithTitle:@"总计：" Value:totalValue]autorelease];
    [statementElement setKey:@"residualChargeElement"];
    [productListSection addElement:statementElement];

    QSection *payWaySection = [[[QRadioSection alloc]initWithItems:[NSArray arrayWithObjects:@"银联支付", @"快钱支付",nil] selected:0 title:@""]autorelease];
    [payWaySection setKey:@"payWaySection"];
    payWaySection.title = @"支付方式";
    payWaySection.footer = @"支付成功一个工作日内完成发卡,发卡进度请咨询400";
    [self.root addSection:payWaySection];
    
    QSection *actionSection = [[[QSection alloc]init]autorelease];
    [self.root addSection:actionSection];
    QButtonElement *buyerBtnElement = [[[QButtonElement alloc]initWithTitle:@"立即结算"]autorelease];
    buyerBtnElement.appearance.buttonAlignment = NSTextAlignmentCenter;
    buyerBtnElement.appearance.actionColorEnabled = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    [buyerBtnElement setControllerAction:@"doBuyerAllsco:"];
    [actionSection addElement:buyerBtnElement];
}

- (void)doBuyerAllsco:(id)element {
    
    QEntryElement *phoneAccountElement = (QEntryElement*)[self.root elementWithKey:@"phoneAccountElement"];
    NSString *phoneAccount = phoneAccountElement.textValue;
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *tempDatas = [[NSMutableArray alloc]init];
    for (TAllscoGoodsForm *goodForm in self.goodItems) {
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:goodForm.sellNumber],@"count",goodForm.sellPrice,@"faceAmt",nil];
        [datas addObject:dict];
        
        dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:goodForm.sellNumber],@"count",goodForm.sellPrice,@"faceAmt",goodForm.serverId,@"commodId",nil];
        [tempDatas addObject:dict];
    }
    SBJsonWriter *sbjson = [[[SBJsonWriter alloc]init]autorelease];
    NSString *purchasesByString = [sbjson stringWithObject:datas];
    NSString *tempPurchasesByString = [sbjson stringWithObject:tempDatas];
    QRadioSection *radioSection = (QRadioSection*)[self.root sectionWithKey:@"payWaySection"];
    NSString *payIndex = [NSString stringWithFormat:@"%i",radioSection.selected];
    
    TAllscoGoodPayForm *goodPayForm = [[TAllscoGoodPayForm alloc]init];
    goodPayForm.phoneNum = phoneAccount;
    goodPayForm.amount = [self getTotalMoneySize];
    goodPayForm.payFlag = [payIndex intValue];
    goodPayForm.purchases = purchasesByString;
    goodPayForm.tempPurchases = tempPurchasesByString;
    [self.delObj allscoBuyerByPayForm:goodPayForm];
}

@end
