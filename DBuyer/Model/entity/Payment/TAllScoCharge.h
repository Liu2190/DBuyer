//
//  TAllScoCharge.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-25.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TAllScoCharge : TRecord

@property (nonatomic,retain)NSString *phoneNumber;

@property (nonatomic,retain)NSString *cardNumber;
@property (nonatomic,retain)NSString *chargeAmount;
@property (nonatomic,retain)NSString *chargeCards;

/**
 * 1为银联，2为快钱
 */
@property (nonatomic,retain)NSString *payIndexValue;


@end
