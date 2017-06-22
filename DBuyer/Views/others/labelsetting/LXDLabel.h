//
//  LXDLabel.h
//  DBuyer
//
//  Created by liuxiaodan on 13-10-10.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXDLabel : UILabel{
    CGFloat charSpace_;
    CGFloat lineSpace_;
}
@property(nonatomic, assign) CGFloat charSpace;
@property(nonatomic, assign) CGFloat lineSpace;
@end
