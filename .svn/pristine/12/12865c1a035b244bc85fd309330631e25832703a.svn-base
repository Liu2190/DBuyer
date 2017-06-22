//
//  AboutUSDetailViewController.m
//  DBuyer
//
//  Created by HeRongxin on 14-1-13.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "AboutUSDetailViewController.h"
#import "StartPoint.h"
#import "AboutMeFirstCell.h"

#define CONTACTTELEPHONE @"010-64322705"

@interface AboutUSDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,assign)UITableView *tabelView;
@property (nonatomic,assign)float detailHeight;

@end

@implementation AboutUSDetailViewController
@synthesize array;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.detailHeight = 0.0f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarWithContent:@"关于我们" WithLeftButton:[UIImage imageNamed:@"global_back_button"] AndRightButton:nil];
    self.detailHeight = [self heightForString:[self getStringFrom:array WithIndex:2] fontSize:12 andWidth:280];
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.backgroundColor = [UIColor clearColor];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];
}

-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        AboutMeFirstCell *inforCell = [tableView dequeueReusableCellWithIdentifier:@"AboutMeFirstCell"];
        inforCell = [[[NSBundle mainBundle]loadNibNamed:@"AboutMeFirstCell" owner:self options:nil]lastObject];
        [inforCell setFirstCellWithTelephoneNum:CONTACTTELEPHONE AndArea:[self getStringFrom:array WithIndex:0] AndDetailAddress:[self getStringFrom:array WithIndex:1]];
        [inforCell addtarget:self AndCallAction:@selector(CallUs)];
        return inforCell;
    }
        static NSString *cellIndefiter=@"cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndefiter];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiter];
            UIImageView *cellBackView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 310, self.detailHeight+10)];
            cellBackView.backgroundColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cellBackView.layer.cornerRadius = 5.0f;
            LXD *inforLabel = [[LXD alloc]initWithText:[self getStringFrom:array WithIndex:2] font:12 textAlight:NSTextAlignmentLeft frame:CGRectMake(10,10,280,self.detailHeight) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
            inforLabel.numberOfLines = 0;
            [cellBackView addSubview:inforLabel];
            [cell.contentView addSubview:cellBackView];
        }
        return cell;
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        return 220;
    }
    return self.detailHeight+20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)CallUs{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",CONTACTTELEPHONE]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
//换行
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit.height;
}
-(NSString *)getStringFrom:(NSArray *)thisArray WithIndex:(int)index
{
    if(array.count>index)
    {
        if([self IsEmptyOfString:[thisArray objectAtIndex:index]]==NO)
        {
            return [thisArray objectAtIndex:index];
        }
    }
    return @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
