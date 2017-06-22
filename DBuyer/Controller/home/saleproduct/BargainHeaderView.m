//
//  BargainHeaderView.m
//  DBuyer
//
//  Created by liuxiaodan on 14-3-31.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "BargainHeaderView.h"

@implementation BargainHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(id)initHeaderViewWith:(BargainHeaderModel *)BHModel
{
    CGRect frame;
    if(BHModel.isActivHasData == YES && BHModel.isAoskHasData == YES)
    {
        //如果活动跟奥斯卡都有数据的情况下
        frame = CGRectMake(0, 0, WindowWidth, 300);
    }
    else if(BHModel.isActivHasData == YES && BHModel.isAoskHasData == NO)
    {
        //活动有数据，奥斯卡没有数据的情况下
        frame = CGRectMake(0, 0, WindowWidth, 180);
    }
    else if(BHModel.isActivHasData == NO && BHModel.isAoskHasData == YES)
    {
        //活动没有数据，奥斯卡有数据的情况下
        frame = CGRectMake(0, 0, WindowWidth, 120);
    }
    else if(BHModel.isActivHasData == NO && BHModel.isAoskHasData == NO)
    {
        //两者都没有数据的情况下
        frame = CGRectMake(0, 0, 0, 0);
    }
    if(self = [super initWithFrame:frame]){
        self.userInteractionEnabled = YES;
        float activHeight = (BHModel.isActivHasData == YES)?180:0;
        UIImageView *activImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowWidth, activHeight)];
        activImageView.tag = 0;
        activImageView.hidden = !BHModel.isActivHasData;
        activImageView.userInteractionEnabled = YES;
        [activImageView setImageWithURL:[NSURL URLWithString:BHModel.activPicUrl]placeholderImage:[UIImage imageNamed:@"placeHolerImageBanner" ]];
        UITapGestureRecognizer *activTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [activImageView addGestureRecognizer:activTap];
        [self addSubview:activImageView];
        float aoskHeight = (BHModel.isAoskHasData == YES)?120:0;
        UIImageView *aoskImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, activHeight, WindowWidth, aoskHeight)];
        [aoskImageView setImageWithURL:[NSURL URLWithString:BHModel.aoskPicUrl]placeholderImage:[UIImage imageNamed:@"placeHolerImageBanner" ]];
        aoskImageView.tag = 1;
        aoskImageView.hidden = !BHModel.isAoskHasData;
        aoskImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *aoskTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [aoskImageView addGestureRecognizer:aoskTap];
        [self addSubview:aoskImageView];
    }
    return self;
}
-(void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.deleagate bargainHeaderViewDidClick:sender.view.tag];
}
@end
