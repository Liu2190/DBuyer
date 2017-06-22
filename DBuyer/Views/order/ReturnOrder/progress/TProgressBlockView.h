//
//  TProgressBlockView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-26.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TProgressBlock.h"

@interface TProgressBlockView : UIView {
    CGRect _pointRect;
}

- (id)initWithPoint:(CGPoint)point andProgressBlock:(TProgressBlock*)block;

- (CGRect)getPointRect;
@end
