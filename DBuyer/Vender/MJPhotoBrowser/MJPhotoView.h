//
//  MJZoomingScrollView.h
//
//  Created by liuxiaodan on 13-3-4.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJPhotoBrowser, MJPhoto, MJPhotoView;

@protocol MJPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(MJPhotoView *)photoView;
- (void)photoViewSingleTap:(MJPhotoView *)photoView;
- (void)photoViewDidEndZoom:(MJPhotoView *)photoView;
@end

@interface MJPhotoView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) MJPhoto *photo;
// 代理
@property (nonatomic, assign) id<MJPhotoViewDelegate> photoViewDelegate;
@end