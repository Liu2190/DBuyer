//
//  TKQPayInfo.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-17.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"

@interface TKQPayInfo : TRecord

@property (nonatomic,retain)NSString *bankId;
@property (nonatomic,retain)NSString *bgUrl;
@property (nonatomic,retain)NSString *cardNum;
@property (nonatomic,retain)NSString *ext1;
@property (nonatomic,retain)NSString *ext2;
@property (nonatomic,assign)int inputCharset;
@property (nonatomic,assign)int language;
@property (nonatomic,retain)NSString *merchantAcctId;
@property (nonatomic,retain)NSString *orderAmount;
@property (nonatomic,retain)NSString *orderId;
@property (nonatomic,retain)NSString *orderTime;
@property (nonatomic,retain)NSString *pageUrl;
@property (nonatomic,retain)NSString *payType;
@property (nonatomic,retain)NSString *payerContact;
@property (nonatomic,assign)int payerContactType;
@property (nonatomic,retain)NSString *payerId;
@property (nonatomic,assign)int payerIdType;
@property (nonatomic,retain)NSString *payerName;
@property (nonatomic,assign)int pid;
@property (nonatomic,retain)NSString *productDesc;
@property (nonatomic,retain)NSString *productId;
@property (nonatomic,retain)NSString *productName;
@property (nonatomic,retain)NSString *goodName;
@property (nonatomic,retain)NSString *productNum;
@property (nonatomic,assign)int redoFlag;
@property (nonatomic,retain)NSString *remitCode;
@property (nonatomic,retain)NSString *remitType;
@property (nonatomic,retain)NSString *signMsg;
@property (nonatomic,retain)NSString *signMsgVal;
@property (nonatomic,assign)int signType;
@property (nonatomic,retain)NSString *submitType;
@property (nonatomic,retain)NSString *version;

@end
