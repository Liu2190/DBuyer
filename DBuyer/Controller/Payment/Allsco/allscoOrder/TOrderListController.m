//
//  TOrderListController.m
//  DBuyer
//
//  Created by Dbuyer mac1 on 14-5-9.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TOrderListController.h"
#import "DemoTableFooterView.h"

@implementation TOrderListController

- (id)init {
    self = [super init];
    self.pullToRefreshEnabled = NO;
    self.pageNum = 1;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:self.frame];
}

- (void)addTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.tableView setBackgroundColor:[UIColor redColor]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:235.0/255.0 blue:233.0/255 alpha:1.0f]];
    [self.view addSubview:self.tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName=@"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count>0?self.datas.count:0;
}

- (void) loadMoreCompleted {
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    _distance = scrollView.contentOffset.y - _startY;
    
    ScrollDirection direction = direction_up;
    if (_distance < 0) direction = direction_down;
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    if (y > h) direction = direction_bottom;
    
    if (scrollView.contentOffset.y < 0) {
        direction = direction_top;
    }

    [self.allscoOrderDelegate scrollHidenTabBarByDistance:fabs(_distance)  andDirection:direction];
    
    _startY = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    int move = 45;
    
    ScrollDirection direction = direction_up_none;
    if (_distance < 0) {
        direction = direction_down_none;
        move = 0;
    }
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    if (y > h) direction = direction_bottom;
    
    if (scrollView.contentOffset.y < 0) {
        direction = direction_top;
    }
    
    [self.allscoOrderDelegate scrollHidenTabBarByDistance:fabs(move)  andDirection:direction];
}


@end
