//
//  TItemAllscoPayController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TItemAllscoPayController.h"
#import "TPayItemTableCell.h"
#import "TCardItemTableCell.h"
#import "TAllScoCard.h"
#import "THeaderPayView.h"
#import "THeaderItemView.h"


#define headerview_height   40

@implementation TItemAllscoPayController

- (id)initWithAllscoList:(NSMutableArray*)allscoList {
    self = [super init];
    _cardList = allscoList;
    _payCardList = [[NSMutableArray alloc]init];
    _headerPayEnity = [[THeaderPayEnity alloc]init];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sortAll]; // 排序
    [self computeHeight]; // 计算显示高度
    
    [self startPay];
    [self.tableView reloadData];
}

/**
 * 支付规则重整。
 * 通过当前sender Button获取用户是对本卡做支付还是取消支付功能
 * 如果是做支付，则把本卡放入_payCardList数组中，并重新调用startPay方法
 * 如果是做取消，则把_payCardList对应的数组元素删除，并重新调用startPay方法
 */
- (void)doClickBoxBtn:(id)sender {
    UIButton *btn = (UIButton*)sender;
    [btn setSelected:!btn.isSelected];
    TAllScoCard *card = [_cardList objectAtIndex:btn.tag];
    
    if (btn.isSelected) { // 加入本次支付
        [self addCardPay:card andWillPayAmount:[_headerPayEnity.willPayMoney floatValue]];
        [self willPayAmountAt:YES and:card];
    } else { // 本卡在本次支付中取消
        [_payCardList removeObject:card];
        [self willPayAmountAt:NO and:card];
        card.payAmount = @"0";
        card.payResidual = @"0";
    }
    
    [self setNeedPayAmount];
    [self.tableView reloadData];
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = nil;
    
    if (headerView == nil) {
        if (section == 0) {
            headerView = [[THeaderPayView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
            [headerView setBackgroundColor:[UIColor colorWithRed:62.0/255 green:133.0/255.0 blue:181.0/255.0 alpha:1]];
        }
        
        if (section == 0) {
            [((THeaderPayView*)headerView) setValueForBlockViews:_headerPayEnity];
        }
    }
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cardList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return headerview_height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TCardItemTableCell heightForCell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify_pay = @"UITableViewCell_Pay";
    //static NSString *reuseIdetify_me = @"UITableViewCell_Me";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify_pay];
    
    if (cell == nil) {
        cell = [[TCardItemTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify_pay];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    TAllScoCard *card = [_cardList objectAtIndex:indexPath.row];
    [((TCardItemTableCell*)cell) setDataForCell:card andHeaderPayInfo:_headerPayEnity andIndex:indexPath.row];
    [((TCardItemTableCell*)cell) setTargetForAction:self];
    
    return cell;
}

/**
 * 支付数据处理
 */
- (void) startPay {
    [self computePayAmount]; // 计算支付信息
    [self restHeaderPayEnity:YES]; // 重置表头实体信息
}

/**
 * 计算table高度，通过用户卡数得到的高度
 */
- (void)computeHeight {
    float H = 0;
    H += _cardList.count*[TCardItemTableCell heightForCell]+headerview_height;
    
    [self.tableView setFrame:CGRectMake(_theFrame.origin.x, _theFrame.origin.y, _theFrame.size.width, H)];
}

/**
 * 重置表视图HeaderView的实体信息
 */
- (void)restHeaderPayEnity:(BOOL)operation {
    [self setAllMoney];
    [self setWillPayAmount:operation];
    [self setNeedPayAmount];
    [self setPayCardNum];
}

/**
 * 根据卡余额对卡列表进行排序，以小到大的顺序
 */
- (void)sortAll {
    NSArray *sortArray = [_cardList sortedArrayUsingSelector:@selector(compare:)];
    [_cardList removeAllObjects];
    for (TAllScoCard *card in sortArray) {
        [_cardList addObject:card];
    }
}

/**
 * 通过订单金额，计算前多少张奥斯卡会作为支出卡，并计算其它相应的金额和卡相关信息
 */
- (void)computePayAmount {
    float payAmount = 0;
    for (TAllScoCard *card in _cardList) {
        if([self addCardPay:card andWillPayAmount:payAmount]) {
            payAmount += [card.payAmount floatValue];
            return;
        } else {
            payAmount += [card.payAmount floatValue];
            continue;
        }
    }
    
}

- (BOOL)addCardPay:(TAllScoCard*)card andWillPayAmount:(float)payAmount{
    float orderAmount = [_confirmPay.paidAmount floatValue]; // 订单金额
    float residual = [card.residual floatValue]; // 卡可用余额
    payAmount += residual; // 加入本卡支付累积支付了多少金额
    
    if (payAmount < orderAmount) { // 全部支付，但未达到订单金额数
        card.payAmount = [NSString stringWithFormat:@"%.2f",residual];
        card.payResidual = @"0";
        [_payCardList addObject:card];
        return NO;
    } else if(payAmount == orderAmount){ // 本卡全部支付，正好支付订单
        card.payAmount = [NSString stringWithFormat:@"%.2f",residual];
        card.payResidual = @"0";
        [_payCardList addObject:card];
        return YES;
    } else { // 全卡部分支付，还有余额
        float _residual = payAmount - orderAmount;
        float _payAmount = residual - _residual;
        card.payResidual = [NSString stringWithFormat:@"%.2f",_residual];
        card.payAmount = [NSString stringWithFormat:@"%.2f",_payAmount];
        [_payCardList addObject:card];
        return YES;
    }
}

/**
 * 根据用户卡数与余额，计算出用户的可用金额
 */
- (void)setAllMoney {
    float allAmount = 0.f;
    for (TAllScoCard *card in _cardList) {
        float payAmount = [card.residual floatValue];
        allAmount += payAmount;
    }
    
    _headerPayEnity.allMoney = [NSString stringWithFormat:@"%.2f",allAmount];
}

/**
 * 用户订单购买将支付的金额
 */
- (void)setWillPayAmount:(BOOL)operation {
    for (TAllScoCard *card in _payCardList) {
        [self willPayAmountAt:operation and:card];
    }
}

- (void)willPayAmountAt:(BOOL)operation and:(TAllScoCard*)card {
    float willPayAmount = [_headerPayEnity.willPayMoney floatValue];
    float payAmount = [card.payAmount floatValue];
    if (operation) {
        willPayAmount += payAmount;
    } else {
        willPayAmount -= payAmount;
    }
    
    _headerPayEnity.willPayMoney = [NSString stringWithFormat:@"%.2f",willPayAmount];
}



/**
 * 当前时刻用户还需支付多少金额才能支付这笔订单，根据订单金额与将支付金额的差值
 */
- (void)setNeedPayAmount {
    float orderAmount = [_confirmPay.paidAmount floatValue];
    float willAmount = [_headerPayEnity.willPayMoney floatValue];
    float needPayAmount = orderAmount - willAmount;
    _headerPayEnity.needPayMoney = [NSString stringWithFormat:@"%.2f",needPayAmount];
    
    if (needPayAmount > 0) { // 需要置灰
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_hasEnablePay" object:@"0"];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_hasEnablePay" object:@"1"];
    }
}
/**
 * 用户购买时用多少笔奥斯卡支付
 */
- (void)setPayCardNum {
    _headerPayEnity.hadPayCardNum = [NSString stringWithFormat:@"%i",_payCardList.count];
}

- (void)dealloc {
    [super dealloc];
    
    [_cardList release];
    _cardList = nil;
    
    [_payCardList release];
    _payCardList = nil;

    [_headerPayEnity release];
    _headerPayEnity = nil;
    
    [_confirmPay release];
    _confirmPay = nil;
}

@end
