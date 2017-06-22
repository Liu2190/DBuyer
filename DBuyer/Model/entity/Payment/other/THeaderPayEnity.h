//
//  THeaderPayEnity.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface THeaderPayEnity : TRecord

@property (nonatomic,retain) NSString *allMoney;
@property (nonatomic,retain) NSString *willPayMoney;
@property (nonatomic,retain) NSString *needPayMoney;
@property (nonatomic,retain) NSString *hadPayCardNum;

@end
