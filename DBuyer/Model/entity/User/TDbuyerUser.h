//
//  TDbuyerUser.h
//  DBuyer
//
//  Created by dilei liu on 14-3-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TRecord.h"


@interface TDbuyerUser : TRecord

@property (nonatomic,retain) NSString *qRCodeURL;
@property (nonatomic,retain) NSString *cardno;
@property (nonatomic,retain) NSString *date;
@property (nonatomic,retain) NSString *email;
@property (nonatomic,retain) NSString *hTcodeURL;
@property (nonatomic,retain) NSString *headPic;
@property (nonatomic,retain) NSString *idNum;
@property (nonatomic,retain) NSString *integral;
@property (nonatomic,retain) NSString *loginName;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *password;
@property (nonatomic,retain) NSString *phone;
@property (nonatomic,retain) NSString *qrcodeURL;
@property (nonatomic,retain) NSString *sex;
@property (nonatomic,retain) NSString *userlevel;


@end
