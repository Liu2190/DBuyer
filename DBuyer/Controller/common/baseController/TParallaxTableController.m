//
//  TImagePullTableController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TParallaxTableController.h"
#import "UIImageView+WebCache.h"
#import "TUtilities.h"


@implementation TParallaxTableController

static CGFloat WindowHeight_ = 170;
static CGFloat ImageHeight  = 200;

#define Customer_Scale_V    .5

- (id)initWithImageUrls:(NSArray *)imageUrls {
    self = [super init];
    _imageScroller = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _imageScroller.backgroundColor = [UIColor whiteColor];
    _imageScroller.showsHorizontalScrollIndicator = NO;
    _imageScroller.showsVerticalScrollIndicator = NO;
    
    _transparentScroller = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _transparentScroller.backgroundColor = [UIColor clearColor];
    // _transparentScroller.alpha = 0.0f;
    _transparentScroller.delegate = self;
    _transparentScroller.bounces = NO;
    _transparentScroller.pagingEnabled = YES;
    _transparentScroller.showsVerticalScrollIndicator = NO;
    _transparentScroller.showsHorizontalScrollIndicator = NO;
    
    NSMutableArray *imageViews = [NSMutableArray arrayWithCapacity:[imageUrls count]];
    UIImageView *imageView  = [[[UIImageView alloc] init] autorelease];
    imageView.image = [UIImage imageNamed:@"UserCenter_Image.png"];
    [imageViews addObject:imageView];
    [_imageScroller addSubview:imageView];
    _imageViews = [imageViews retain];

    return self;
}

- (void)addTableView {
    [_imageScroller setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
    [self.contentView addSubview: _imageScroller];
    
    float w = self.contentView.frame.size.width;
    float h = self.contentView.frame.size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView addSubview:self.tableView];
    
}



- (void)updateOffsets {
    CGFloat yOffset = self.tableView.contentOffset.y;
    CGFloat xOffset = _transparentScroller.contentOffset.x;
    CGFloat threshold = ImageHeight - WindowHeight_;
    
    if (yOffset > -threshold && yOffset < 0) {
        _imageScroller.contentOffset = CGPointMake(xOffset, floorf(yOffset / 2.0));
        
    } else if (yOffset < 0) {
        UIImageView *imageView = [_imageViews objectAtIndex:0];
        CGSize imageSize = [[TUtilities getInstance]scaleImage:imageView.image.size reference:_transparentScroller.frame.size.height-yOffset isWidth:NO];
        
        imageView.bounds = CGRectMake(0,(ImageHeight-WindowHeight_)/2,imageSize.width, _transparentScroller.frame.size.height-yOffset);
        imageView.center = CGPointMake(self.view.frame.size.width/2, (_transparentScroller.frame.size.height-yOffset-ImageHeight+WindowHeight_)/2);
        
    } else {
        _imageScroller.contentOffset = CGPointMake(xOffset, yOffset*Customer_Scale_V);
    }
}


- (void)layoutImages {
    CGFloat imageWidth   = _imageScroller.frame.size.width;
    CGFloat imageYOffset = floorf((WindowHeight_  - ImageHeight) / 2.0);
    CGFloat imageXOffset = 0.0;
    
    _imageScroller.contentSize = CGSizeMake([_imageViews count]*imageWidth, self.contentView.bounds.size.height);
    _imageScroller.contentOffset = CGPointMake(0.0, 0);
    
    _transparentScroller.contentSize = CGSizeMake([_imageViews count]*imageWidth, WindowHeight_);
    _transparentScroller.contentOffset = CGPointMake(0.0, 0);
    
    for (UIImageView *imageView in _imageViews) {
        imageView.frame = CGRectMake(imageXOffset, imageYOffset, self.view.frame.size.width, ImageHeight);
        imageXOffset += imageWidth;
        if(!imageView.image) {
            // CGRect rect = CGRectMake(0, 0, _transparentScroller.frame.size.width, _transparentScroller.frame.size.width);
            // _activeView = [[[TActivityView alloc]initWithFrame:rect]autorelease];
            // [imageView addSubview:_activeView];
            // [_activeView startAnimation];
        }
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 1;
    return self.datas.count>0?self.datas.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *windowReuseIdentifier = @"TParallaxTableViewWindow";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:windowReuseIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:windowReuseIdentifier] autorelease];
        
        if (indexPath.section == 0) {
            [cell.contentView addSubview:_transparentScroller];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return WindowHeight_;
    return 40;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    CGRect bounds = self.view.bounds;
    _imageScroller.frame = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height);
    _transparentScroller.frame = CGRectMake(0.0, 0.0, bounds.size.width, WindowHeight_);
    
    [self layoutImages];
}


// --------------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateOffsets];
}


- (void)dealloc {
    [super dealloc];
    
    [_imageViews release];
    _imageViews = nil;
    
    [_imageScroller release];
    _imageScroller = nil;
    
    [_transparentScroller release];
    _transparentScroller = nil;
}

@end
