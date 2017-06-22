//
//  TDbuyerUser.m
//  DBuyer
//
//  Created by dilei liu on 14-3-12.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TDbuyerUser.h"

@implementation TDbuyerUser

- (void)updateWithJSonDictionary:(NSDictionary *)dic {
    self.serverId = [dic objectForKey:@"ID"];
    self.qRCodeURL = [dic objectForKey:@"qRCodeURL"];
    self.cardno = [dic objectForKey:@"cardno"];
    self.date = [dic objectForKey:@"date"];
    self.email = [dic objectForKey:@"email"];
    self.hTcodeURL = [dic objectForKey:@"hTcodeURL"];
    self.headPic = [dic objectForKey:@"headPic"];
    self.idNum = [dic objectForKey:@"idNum"];
    self.integral = [dic objectForKey:@"integral"];
    self.loginName = [dic objectForKey:@"loginName"];
    self.password = [dic objectForKey:@"password"];
    self.phone = [dic objectForKey:@"phone"];
    self.qrcodeURL = [dic objectForKey:@"qrcodeURL"];
    self.sex = [dic objectForKey:@"sex"];
    self.userlevel = [dic objectForKey:@"userlevel"];
}

- (void)dealloc {
    [super dealloc];
    [_qRCodeURL release];
    _qRCodeURL = nil;
    
    [_cardno release];
    _cardno = nil;
    
    [_date release];
    _date = nil;
    
    [_email release];
    _email = nil;
    
    [_hTcodeURL release];
    _hTcodeURL = nil;
    
    [_headPic release];
    _headPic = nil;
    
    [_idNum release];
    _idNum = nil;
    
    [_integral release];
    _integral = nil;
    
    [_loginName release];
    _loginName = nil;
    
    [_password release];
    _password = nil;
    
    [_phone release];
    _phone = nil;
    
    [_qrcodeURL release];
    _qrcodeURL = nil;
    
    [_sex release];
    _sex = nil;
    
    [_userlevel release];
    _userlevel = nil;
}

@end
