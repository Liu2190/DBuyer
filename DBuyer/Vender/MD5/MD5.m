//
//  MD5.m
//  DBuyer
//
//  Created by liuxiaodan on 13-10-14.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5
+(NSString *)md5{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSString * string=[NSString stringWithFormat:@"dbuyer%@",timeSp];
    const char *cStr = [string UTF8String];
    unsigned char result[32];
    
    CC_MD5( cStr, strlen(cStr), result );
    
    NSString *str=[NSString stringWithFormat:
                   
                   @"%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d",
                   result[0],result[1],result[2],result[3],
                   result[4],result[5],result[6],result[7],
                   result[8],result[9],result[10],result[11],
                   result[12],result[13],result[14],result[15],
                   result[16], result[17],result[18], result[19],
                   result[20], result[21],result[22], result[23],
                   result[24], result[25],result[26], result[27],
                   result[28], result[29],result[30], result[31]];
    return str;
}
@end
