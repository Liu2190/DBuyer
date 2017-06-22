//
//  KQPayOrder.h
//  KQPayPlugin
//
//  Created by Hunter Li on 13-4-12.
//
//

#import <Foundation/Foundation.h>

@interface KQUserCard : NSObject
{    
    NSString    *userCardBankId;        //银行编号
    
    NSString    *userCardBankName;      //银行名称
    
    NSString    *userCardType;          //卡类型
    
    NSString    *selected;              //是否被选择
    
    NSString    *userCardShortPan;      //短卡号 前6 后4
    
    NSString    *userCardShortPhone;    //缩略手机号 前3 后4
}

@property (nonatomic, retain)NSString	*userCardBankId;

@property (nonatomic, retain)NSString    *userCardBankName;

@property (nonatomic, retain)NSString	*userCardType;

@property  (nonatomic, retain)NSString  *selected;

@property (nonatomic, retain)NSString	*userCardShortPan;

@property (nonatomic, retain)NSString   *userCardShortPhone;


@end
