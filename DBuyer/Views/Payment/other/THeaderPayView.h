//
//  THeaderPayView.h
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-4-21.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THeaderPayEnity.h"

@interface THeaderPayView : UIView {
    
}

@property (nonatomic,retain)NSMutableArray *blockViews;

- (void)setValueForBlockViews:(THeaderPayEnity*)headerPayEntity;



@end
