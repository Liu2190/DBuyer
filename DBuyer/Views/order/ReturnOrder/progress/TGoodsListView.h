//
//  TGoodsListView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-24.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGoodsListView : UIView {
    float H;
}

- (id)initWithFrame:(CGRect)frame andGoods:(NSArray*)goodss;

- (float)getViewHeight;
@end
