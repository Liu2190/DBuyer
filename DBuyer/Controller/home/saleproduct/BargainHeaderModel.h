//
//  BargainHeaderModel.h
//  DBuyer
//
//  Created by liuxiaodan on 14-4-1.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BargainHeaderModel : NSObject
@property (nonatomic,assign)BOOL isActivHasData;
@property (nonatomic,retain)NSString *activPicUrl;
@property (nonatomic,retain)NSString *activInterfaceUrl;
@property (nonatomic,retain)NSString *activShareText;//跳转到网页时，应该有分享文案
@property (nonatomic,retain)NSString *activJumptype;
@property (nonatomic,assign)BOOL activFlag;
@property (nonatomic,assign)BOOL isAoskHasData;
@property (nonatomic,retain)NSString *aoskPicUrl;
@property (nonatomic,retain)NSString *aoskInterfaceUrl;
@property (nonatomic,assign)BOOL aoskFlag;
@property (nonatomic,retain)NSString *aoskJumptype;
-(void)setBargainHeaderModelWith:(NSMutableDictionary *)dict;
@end
