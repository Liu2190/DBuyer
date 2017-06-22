//
//  TUserCenterCell.m
//  DBuyer
//
//  Created by dilei liu on 14-3-6.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TUserCenterCell_1.h"

@implementation TUserCenterCell_1

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    _titleLabel = [[UILabel alloc]init];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_titleLabel];
    
    _valueLabel = [[UILabel alloc]init];
    [_valueLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_valueLabel];
    
    imageSize = [self checkTmpSize];
    
    return self;
}

- (void)setDataForCell:(TRowModel *)rowModel {
    [super setDataForCell:rowModel];
    
    NSString *title = [rowModel.datas objectForKey:@"title"];
    _titleLabel.text = title;
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [_titleLabel.text sizeWithFont:_titleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    [_titleLabel setFrame:CGRectMake(20, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    
    if ([_titleLabel.text isEqualToString:@"清除缓存"]) {
        [_valueLabel setText:[NSString stringWithFormat:@"%.2fM",imageSize]];
        titleSize = [_valueLabel.text sizeWithFont:_valueLabel.font constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
        [_valueLabel setFrame:CGRectMake(self.frame.size.width-titleSize.width-30, (self.frame.size.height-titleSize.height)/2, titleSize.width, titleSize.height)];
    } else {
        _valueLabel.text = @"";
    }
    
    
}


- (float)checkTmpSize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"] retain];
    
    float totalSize = 0;
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:diskCachePath];
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [diskCachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        unsigned long long length = [attrs fileSize];
        totalSize += length / 1024.0 / 1024.0;
    }
    
    return totalSize;
}

@end
