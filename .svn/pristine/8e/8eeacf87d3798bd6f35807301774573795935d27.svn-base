//
//  TBaseTableController.m
//  DBuyer
//
//  Created by dilei liu on 14-3-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBaseTableController.h"

@implementation TBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datas = [[NSMutableArray alloc]initWithCapacity:1];
    [self addTableView];
}

- (void)addTableView {
    float w = self.contentView.frame.size.width;
    float h = self.contentView.frame.size.height;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.contentView addSubview:_tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
}

- (void)dealloc {
    [super dealloc];
    
    [_tableView release];
    _tableView = nil;
}



@end
