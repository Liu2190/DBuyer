//
//  GiftCell.m
//  DBuyer
//
//  Created by lu gang on 13-12-9.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "GiftCell.h"

@implementation GiftCell

- (id)initWithDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.title = [dic valueForKey:@"title"];
        self.tpye = [dic valueForKey:@"findType"] != nil ? [[dic valueForKey:@"findType"] intValue] : 0;
//        self.price = [dic valueForKey:@"price"] != nil ? [[dic valueForKey:@"price"] floatValue] : 0.0f;
        self.boxDescription = [dic valueForKey:@"description"];
        self.gid = [dic valueForKey:@"goodsID"];
        self.boxPicUrl = [dic valueForKey:@"attrValue"];
//        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"findType"]) {
        self.tpye = [value intValue];
    }
    else if ([key isEqualToString:@"description"]) {
        self.boxDescription = value;
    }
    else if ([key isEqualToString:@"goodsID"]) {
        self.gid = value;
    }
    else if ([key isEqualToString:@"attrValue"]) {
        self.boxPicUrl = value;
    }
}

+ (id)giftCellWithDictionary:(NSDictionary *)dic
{
    return [[[self alloc] initWithDictionary:dic] autorelease];
}
-(void)getDataFromHomeDict:(NSDictionary *)dict
{
    self.boxPicUrl = [self notEmptyOfString:[dict objectForKey:@"boxPicUrl"]]?[dict objectForKey:@"boxPicUrl"]:@"";
    self.gid = [self notEmptyOfString:[dict objectForKey:@"gid"]]?[dict objectForKey:@"gid"]:@"";
    self.title = [self notEmptyOfString:[dict objectForKey:@"title"]]?[dict objectForKey:@"title"]:@"";
    self.tpye = [self notEmptyOfString:[dict objectForKey:@"type"]]?[[dict objectForKey:@"type"] intValue]:0;
    self.price = [self notEmptyOfString:[dict objectForKey:@"price"]]?[[dict objectForKey:@"price"] floatValue]:0;
    self.savePrice = [self notEmptyOfString:[dict objectForKey:@"savePrice"]]?[[dict objectForKey:@"savePrice"] floatValue]:0;
}
-(BOOL)notEmptyOfString:(id)item
{
    if(!(item==nil||item ==NULL) &&(![item isKindOfClass:[NSNull class]]))
    {
        return YES;
    }
    return NO;
}
@end
