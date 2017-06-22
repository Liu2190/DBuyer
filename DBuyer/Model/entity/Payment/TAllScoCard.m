//
//  TAllScoCard.m
//  DBuyer
//
//  Created by dilei liu on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoCard.h"

@implementation TAllScoCard

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    
    self.cardNumber = [dic objectForKey:@"cardNo"];
    
    float amount = [[dic objectForKey:@"amount"] floatValue]/100;
    NSString *residual = [NSString stringWithFormat:@"%.2f",amount];
    
    self.residual = residual;
    self.groupValue = [NSString stringWithFormat:@"%@ (%@元)",self.cardNumber,residual];
}

-(NSComparisonResult)compare:(TAllScoCard *)card{
    
    float residual = [self.residual floatValue];
    float residual_ = [card.residual floatValue];
    
    if (residual > residual_) {
        return NSOrderedDescending;
    }
    
    return NSOrderedAscending;
}

- (void)dealloc {
    [super dealloc];
}

@end
