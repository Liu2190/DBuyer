//
//  PlanViewController.m
//  DBuyer
//
//  Created by LIUXIAODAN on 14-1-7.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "PlanViewController.h"
#import "PlanModal.h"
#import "DBManager.h"
#import "HeaderView.h"
#import "CellForPlan.h"
#import "SecondSearchNilViewController.h"
#import "CreatePlanView.h"
#import "StartPoint.h"
#import "ChangePlanImageView.h"
#import "LoginReminderView.h"
#import "TLoginController.h"
#import "PlanDatePickerView.h"
#import "PlanTotalModel.h"
#import "PlanDiscViewController.h"
#import "GuideOperationView.h"
#import "WCAlertView.h"
#define StartFrame CGRectMake(0, startPoint, WindowWidth, WindowHeight-startPoint-49)
#define middleFrame CGRectMake(0, startPoint+60, WindowWidth, WindowHeight)
#define BottomFrame CGRectMake(0, startPoint+230, WindowWidth, WindowHeight)

@interface PlanViewController ()
{
    float startPoint ;//根据系统设置起始位置
    UITableView *userTableView;
    NSArray *imageArray;
    UIImageView * tipsImageview;
    NSArray *imageIconArray;
    NSArray *titleArray;
    NSMutableString *pickRemindTime;
    NSMutableString *pickTimeStamp;
    NSInteger thisCell;
    CreatePlanView *createBackView;
    UIScrollView *planScrollView;
    HttpDownload *thisDownLoad;
}
@property (nonatomic,retain)ChangePlanImageView *iconChangeView;//修改计划icon视图
@property (nonatomic,retain)PlanDatePickerView *datePickerView;//自定义的时间选择器
@property (nonatomic,retain)PlanTotalModel *planModel;
@property (nonatomic,retain)GuideOperationView *guideView;
@end

@implementation PlanViewController
NSString * LXD_UPLOAD_IMG_PATH = @"" ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    for(UIView *v in [self.view subviews])
    {
        [v removeFromSuperview];
    }
}
-(void)iconButtonDidClick:(UIButton *)button
{
    NSArray *turnArray = [[NSArray alloc] initWithObjects:@"310",@"501",@"318",@"204",@"701",@"0206",@"323",@"0105",@"905",@"802",@"405",@"703",@"704",@"407",@"806",@"604",@"503",@"601",@"404",@"0103", nil];
    PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
    plan.type=@"1";
    plan.imageid=[turnArray objectAtIndex:(button.tag-100)];
    [plan changeThisPlan];
    [userTableView reloadSections:[NSIndexSet indexSetWithIndex:thisCell] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self mainDelegate]endLoad];
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    if ([self isAlreadyLogined])
    {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PlanViewController"]==nil)
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"PlanViewController"];
            [self firstOpenTheView];
        }
        else
        {
            [self loadPlanView];
        }
    }
    else
    {
        self.navigationController.navigationBar.hidden =YES;
        [self setNavigationBarWithContent:@"购物计划" WithLeftButton:nil AndRightButton:nil];
        //提醒用户登录
        LoginReminderView *lrView = [[[NSBundle mainBundle]loadNibNamed:@"LoginReminderView" owner:self options:nil]lastObject];
        lrView.reminderLabel.text = @"您可以制定您的购物计划，不再错过优惠信息";
        lrView.frame = CGRectMake(0, [StartPoint startPoint], WindowWidth, 70);
        [lrView addTarget:self withLoginAction:@selector(presentLoginView:)];
        [self.view addSubview:lrView];
    }
}
-(void)presentLoginView:(id)sender {
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    TLoginController *loginController = [[TLoginController alloc]initWithNavigationTitle:@"登录"];
    loginController.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginController];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}
#pragma mark - 下载数据
-(void)downloadFail
{
    [[self mainDelegate] endLoad];
}
- (void)loginSuccess:(TDbuyerUser *)dbuyerUser {
//    HttpDownload *hd2=[[HttpDownload alloc]init];
//    hd2.delegate=self;
//    hd2.type=14;
//    hd2.failMethod = @selector(downloadFail);
//    hd2.method=@selector(downloadComplete:);
//    NSMutableDictionary *dict1=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[TimeStamp timeStamp],@"stamp",[MD5 md5],@"verify",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"],@"versionNum",@"2",@"os_code",[NSString stringWithFormat:@"%d",[UIDevice currentResolution]],@"size_code",nil];
//    [hd2 downloadFromUrlWithASI:[NSString stringWithFormat:planList,serviceHost] dict:dict1];
//    [[self mainDelegate]beginLoad];
    // 登录成功以后作一个页面切换
}

-(void)loadPlanView
{
    self.navigationController.navigationBar.hidden =YES;
    [self setNavigationBarWithContent:@"购物计划" WithLeftButton:nil AndRightButton:nil];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
    planScrollView.hidden = YES;
    [self initTableView];
    [self initTimeString];
    [self initData];
    [self setCreateBackView];
    [self getDataFromDB];
}
#pragma mark - 首次打开计划页面进行的操作
-(void)guideOperationDidClick
{
    [self loadPlanView];
}
-(void)firstOpenTheView
{
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    self.navigationController.navigationBar.hidden =YES;
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"sec_introduct1.png",@"sec_introduct2.png",@"sec_introduct3.png", nil];
    self.guideView = [[GuideOperationView alloc]initGuideOperationViewWith:array];
    self.guideView.delegate = self;
    [[self mainDelegate].window addSubview:self.guideView];
}

#pragma mark - 初始化数据
-(void)initData
{
    imageIconArray=[[NSArray alloc] initWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",@"sec_box_image.png", nil];
    imageArray=[[NSArray alloc]initWithObjects:@"冲调1",@"鸡蛋1",@"巧克力1",@"干果1",@"干货1",@"母婴1",@"水果1",@"沐浴1",@"牛奶1",@"生活1",@"白酒1",@"米面1",@"粮油1",@"红酒1",@"纸品1",@"蔬菜1",@"调料1",@"速食1",@"饮料1",@"女性1",nil];
    titleArray=[[NSArray alloc] initWithObjects:@"冲调",@"鸡蛋",@"巧克力",@"干果",@"干货",@"母婴",@"水果",@"沐浴",@"牛奶",@"生活",@"白酒",@"米面",@"粮油",@"红酒",@"纸品",@"蔬菜",@"调料",@"速食",@"饮料",@"女性",nil];
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending)
    {
        //当前系统小于IOS7.0
        startPoint = 44.0f;
    }
    else
    {
        startPoint = 64.0f;
    }
    
}
#pragma mark - 初始化表视图
-(void)initTableView
{
    UIImageView * headerImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sec_slide_image.png"]];
    headerImage.frame=CGRectMake(0, 0, 320, 25);
    userTableView=[[UITableView alloc]initWithFrame:StartFrame style:UITableViewStylePlain];
    userTableView.delegate=self;
    userTableView.dataSource=self;
    userTableView.backgroundColor=[UIColor clearColor];
    userTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    userTableView.tableHeaderView=headerImage;
    [self.view addSubview:userTableView];
}
#pragma mark - 初始化时间戳和提醒时间
-(void)initTimeString
{
    pickRemindTime=[[NSMutableString alloc]init];
    pickTimeStamp=[[NSMutableString alloc]init];
}
#pragma mark - 设置创建新计划的视图
-(void)setCreateBackView
{
    createBackView=[[[NSBundle mainBundle]loadNibNamed:@"CreatePlanView" owner:self options:nil]lastObject];
    createBackView.frame=CGRectMake(0, [StartPoint startPoint]+(35-64), createBackView.frame.size.width, createBackView.frame.size.height);
    createBackView.delegate=self;
    createBackView.createTf.delegate=self;
    [createBackView setCreatePlanViewWithIcon];
    [createBackView backViewVisibleAction:self AndAction:@selector(visibleAction:)];
    [self.view addSubview:createBackView];
    createBackView.hidden=YES;
}
-(void)visibleAction:(UIButton *)sender
{
    userTableView.frame = BottomFrame;
}
-(void)finishPick:(UIButton *)button
{
    PlanModal *plan=(PlanModal *)[self.planModel.planArray objectAtIndex:thisCell];
    plan.remindtime=pickRemindTime;
    plan.comparetime=pickTimeStamp;
    [plan changeThisPlan];
    [userTableView reloadSections:[NSIndexSet indexSetWithIndex:thisCell] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)planDatePickerValueChanged:(UIDatePicker *)thisDatePicker
{
    NSDate *thisDate = [thisDatePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"MM.dd EEEE HH:mm"];
    NSString *str1=[dateFormatter stringFromDate:thisDate];
    if(str1)
    {
        [pickRemindTime deleteCharactersInRange:NSMakeRange(0, [pickRemindTime length])];
        [pickRemindTime appendString:str1];
    }
    NSString *str=[NSString stringWithFormat:@"%ld", (long)[thisDate timeIntervalSince1970]];
    [pickTimeStamp deleteCharactersInRange:NSMakeRange(0, [pickTimeStamp length])];
    [pickTimeStamp appendString:str];
}
#pragma mark - 从数据库中获取数据 创建闹钟提醒
-(void)getDataFromDB
{
    self.planModel = [[PlanTotalModel alloc]initFromDB];
    userTableView.frame=StartFrame;
    userTableView.tableHeaderView.hidden=NO;
    [userTableView reloadData];
    [self.planModel updateLocalNotification];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    tipsImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sec_slideback_image"]];
    tipsImageview.frame=CGRectMake((WindowWidth-(209/2))/2, (WindowHeight-411/2)/2, 209/2, 411/2);
    [self.view addSubview:tipsImageview];
    tipsImageview.hidden = YES;
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}

#pragma mark - tableview delegate & datasource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 63.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  60.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.planModel.planArray count]==0)
    {
        tipsImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sec_slideback_image"]];
        tipsImageview.frame=CGRectMake((WindowWidth-(209/2))/2, (WindowHeight-411/2)/2, 209/2, 411/2);
        [self.view addSubview:tipsImageview];
    }
    else
    {
        tipsImageview.hidden=YES;
    }
    return self.planModel.planArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self editPlanName];
    PlanModal *temp = [self.planModel.planArray objectAtIndex:section];
    if (!temp.isOpen)
    {
        return 0;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"CellItem";
    CellForPlan *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell==nil){
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CellForPlan" owner:self options:nil]lastObject];
    }
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeaderView *viewForHeader=[[[NSBundle mainBundle]loadNibNamed:@"HeaderView" owner:self options:nil]lastObject];
    viewForHeader.delegate=self;
    viewForHeader.planNameLabel.delegate=self;
    PlanModal *plan=[self.planModel.planArray objectAtIndex:section];
    if(plan.isOpen)
    {
        thisCell = section;
    }
    [viewForHeader setHeaderViewValue:plan WithSection:section];
    return viewForHeader;
}
- (void)buttonOnCellDidClick:(UIButton *)button
{
    self.iconChangeView=[[ChangePlanImageView alloc]initWithBackImageView:CGRectMake(0,[StartPoint startPoint], WindowWidth, WindowHeight)];
    self.iconChangeView.CPIdelegate=self;
    [self.view addSubview:self.iconChangeView];
    self.iconChangeView.userInteractionEnabled=YES;
    self.iconChangeView.hidden=NO;
    [self.view bringSubviewToFront:self.iconChangeView];
}
#pragma mark - 下拉产生创建新计划的视图
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.datePickerView !=nil)
    {
        if(self.datePickerView.hidden == NO)
        {
            self.datePickerView.hidden = YES;
        }
    }
    if (scrollView.contentOffset.y<-60.0f ){
        for(int i=0;i<[self.planModel.planArray count];i++){
            PlanModal *temp = [self.planModel.planArray objectAtIndex:i];
            temp.isOpen=NO;
            [userTableView reloadSections:[NSIndexSet indexSetWithIndex:i] withRowAnimation:UITableViewRowAnimationNone];
        }
        tipsImageview.hidden=YES;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1];
        userTableView.tableHeaderView.hidden=YES;
        userTableView.frame=middleFrame;
        [createBackView setCreatePlanViewVisible];
        [self.view bringSubviewToFront:createBackView];
        [UIView commitAnimations];
    }
}

#pragma mark - 点击视图的其他位置，保存此次编辑的计划名称
-(void)editPlanName{
    for(UIView *v in userTableView.subviews){
        if(v.tag==8877){
            [v removeFromSuperview];
        }
    }
    for(UITapGestureRecognizer * g in self.view.gestureRecognizers){
        [self.view removeGestureRecognizer:g];
    }
    UITapGestureRecognizer *tapGest=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(saveThisEditing)];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, [self.planModel.planArray count]*83+60+50, 320, 500)];
    view.tag=8877;
    view.backgroundColor=[UIColor clearColor];
    view.userInteractionEnabled=YES;
    [userTableView addSubview:view];
    [view addGestureRecognizer:tapGest];
}
-(void)saveThisEditing
{
    PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
    [plan changeThisPlan];
    for(UIView *subview in[self.view subviews]){
        if([subview isKindOfClass:[UITextField class]]){
            [subview resignFirstResponder];
            }
    }
    [self getDataFromDB];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.datePickerView.hidden = YES;
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.datePickerView.hidden = YES;
}
#pragma mark - 收键盘
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField!=createBackView.createTf){
        PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
        plan.planname=textField.text;
        [plan changeThisPlan];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField!=createBackView.createTf){
        PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
        plan.planname=textField.text;
        [plan changeThisPlan];
    }
    return YES;
}
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if ([view isKindOfClass:[UITableView class]])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)deletePlanOfFinished:(UIButton *)button
{//删除
    PlanModal *plan=[self.planModel.planArray objectAtIndex:button.tag];
    [DBManager sharedDatabase].rememberplanid=plan.planid;
    [[DBManager sharedDatabase] deleteItemFromShoppingplanWith:plan.planid];
    
    [self getDataFromDB];
}
#pragma mark - 点击每条计划的右边的按钮进行的展开收起的操作
-(void)headerPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(thisCell == button.tag)
    {
        PlanModal *temp1 = [self.planModel.planArray objectAtIndex:thisCell];
        temp1.isOpen = !temp1.isOpen;
        [userTableView reloadSections:[NSIndexSet indexSetWithIndex:thisCell] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if(thisCell < [self.planModel.planArray count])
    {
        PlanModal *temp1 = [self.planModel.planArray objectAtIndex:thisCell];
        temp1.isOpen = NO;
        [userTableView reloadSections:[NSIndexSet indexSetWithIndex:thisCell] withRowAnimation:UITableViewRowAnimationNone];
        PlanModal *temp = [self.planModel.planArray objectAtIndex:button.tag];
        temp.isOpen = !temp.isOpen;
        [userTableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    else
    {
        PlanModal *temp = [self.planModel.planArray objectAtIndex:button.tag];
        temp.isOpen = !temp.isOpen;
        [userTableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
    [self.planModel updateLocalNotification];
}
#pragma mark - 取消计划
-(void)cancelPlan
{
    [createBackView.createTf resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    createBackView.hidden=YES;
    userTableView.frame=StartFrame;
    userTableView.tableHeaderView.hidden=NO;
    [UIView commitAnimations];
    [userTableView reloadData];
}
#pragma mark - 保存新建的计划
-(void)savePlan
{
    [createBackView.createTf resignFirstResponder];
    if([createBackView.createTf.text isEqualToString:@""]==NO){
        int b=0;
        for(int i=0;i<[imageIconArray count];i++){
            if(createBackView.planImage.image==[UIImage imageNamed:[imageIconArray objectAtIndex:i]]){
                b=i;
                break;
            }
        }
        if(b==20)
        {
            b=0;
        }
        NSArray *turnArray = [[NSArray alloc] initWithObjects:@"310",@"501",@"318",@"204",@"701",@"0206",@"323",@"0105",@"905",@"802",@"405",@"703",@"704",@"407",@"806",@"604",@"503",@"601",@"404",@"0103", nil];
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:[self generateUuidString] forKey:@"planid"];
        [dict setObject:@"0" forKey:@"status"];
        [dict setObject:[turnArray objectAtIndex:b] forKey:@"imageid"];
        [dict setObject:createBackView.createTf.text forKey:@"planname"];
        [dict setObject:[self generateRemindTime] forKey:@"remindtime"];
        [dict setObject:[self generateCompareTime] forKey:@"comparetime"];
        [dict setObject:@"" forKey:@"urlimage"];
        [dict setObject:@"1" forKey:@"type"];
        [DBManager sharedDatabase].rememberplanid=[dict objectForKey:@"planid"];
        [[DBManager sharedDatabase]insertintoShoppinglist:dict];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        createBackView.hidden=YES;
        [UIView commitAnimations];
        [self getDataFromDB];
    }
    else{
        UIAlertView *alView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填入计划内容" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alView show];
    }
}
#pragma mark - 删除计划
-(void)deletePlan
{
    [WCAlertView showAlertWithTitle:@"提示"
                            message:@"确定删除计划？"
                 customizationBlock:^(WCAlertView * alertView1) {
                     alertView1.style=WCAlertViewStyleBlack;
                 }
                    completionBlock:^(NSUInteger buttonIndex,WCAlertView * alertView){
                        if(buttonIndex == 0) {
                            PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
                            [self.planModel deletePlanWith:plan];
                            [self getDataFromDB];
                        }
                    }
                  cancelButtonTitle:@"确定"
                  otherButtonTitles:@"取消",nil];
}
#pragma mark - 搜索入口
-(void)searchPlan
{
    PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
    SecondSearchNilViewController *searchVC=[[SecondSearchNilViewController alloc]init];
    searchVC.searchText=plan.planname;
    searchVC.planID=plan.planid;
    searchVC.plan=plan;
    [self.navigationController pushViewController:searchVC animated:YES];
}
#pragma mark - 计划所有按钮事件
-(void)pushDetail:(UIButton *)button
{
    if(button.tag==22)
    {
        //取消计划
        [self cancelPlan];
    }
    else if(button.tag==23)
    {
        [self savePlan];
    }
    if(button.tag == 4444)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        [sheet showInView:self.view];
        
    }
    else if(button.tag == 4445)
    {
        self.datePickerView = [[[NSBundle mainBundle]loadNibNamed:@"PlanDatePickerView" owner:self options:nil]lastObject];
        self.datePickerView.frame = CGRectMake(0, WindowHeight - 192 -49, WindowWidth, 192);
        [self.datePickerView.planDatePicker addTarget:self action:@selector(planDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.datePickerView addTarget:self WithFinishAction:@selector(finishPick:)];
        [self.view addSubview:self.datePickerView];
        self.datePickerView.hidden = NO;
        [self.datePickerView setPlanDatePickerVisible];
    }
    else if(button.tag == 4446)
    {
        [self searchPlan];
    }
    else if(button.tag == 4447)
    {
        [self deletePlan];
    }
}
#pragma mark - UIImagePickerController delegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{[self.leveyTabBarController hidesTabBar:NO animated:NO];}];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
    UIImage *newImage = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    [self saveUIImagePickerControllerImageWithImage:newImage];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    UIImage *newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveUIImagePickerControllerImageWithImage:newImage];
}
-(void)saveUIImagePickerControllerImageWithImage:(UIImage*)thisImage
{
    UIImage *newImg=[self imageWithImageSimple:thisImage scaledToSize:CGSizeMake(300, 300)];
    NSString *name=[NSString stringWithFormat:@"%@%@",[self generateUuidString],@".jpg"];
    NSData* imageData = UIImagePNGRepresentation(newImg);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:name];
    LXD_UPLOAD_IMG_PATH=fullPathToFile;
    NSArray *nameAry=[LXD_UPLOAD_IMG_PATH componentsSeparatedByString:@"/"];
    [imageData writeToFile:fullPathToFile atomically:YES];
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),[nameAry objectAtIndex:[nameAry count]-1]];
    PlanModal *plan=[self.planModel.planArray objectAtIndex:thisCell];
    [DBManager sharedDatabase].rememberplanid=plan.planid;
    [[DBManager sharedDatabase]saveimageWith:plan.planid AndWithpath:aPath3];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.leveyTabBarController hidesTabBar:NO animated:NO];}];
}
-(UIImage *)imageWithImageSimple:(UIImage*) image scaledToSize:(CGSize) newSize
{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id)self;
    picker.allowsEditing = YES;
    if (buttonIndex == 0)
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [self presentViewController:picker animated:YES completion:nil];
    }else if(buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.leveyTabBarController hidesTabBar:YES animated:NO];
        [self presentViewController:picker animated:YES completion:nil];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cuxButtonClick:(NSInteger )section//进入促销商品列表
{
    PlanModal *plan=[self.planModel.planArray objectAtIndex:section];
    HttpDownload *hd = [[HttpDownload alloc]init];
    hd.delegate = self;
    hd.failMethod = @selector(downloadFail);
    hd.type = 1;
    thisDownLoad = hd;
    hd.method = @selector(downloadComplete:);
    NSString *urlString = [NSString stringWithFormat:@"%@/interface/commodity/getPlanRecommend?groupFlag=%@",serviceHost,plan.groupFlag];
    [hd downloadFromUrl:urlString];
    [self addLoadView];
    [[self mainDelegate]beginLoad];
}
#pragma mark - Notification-pleaseCancelLoad
-(void)pleaseCancelLoad
{
    [[self mainDelegate] endLoad];
    [thisDownLoad ConnectionCanceled];
}
-(void)downloadComplete:(HttpDownload *)hd{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict){
        [[self mainDelegate] endLoad];
        {
            if(hd.type == 1)
            {
                PlanDiscViewController *planDisc = [[PlanDiscViewController alloc]init];
                planDisc.userArray = [dict objectForKey:@"result_list"];
                UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:planDisc];
                [self.navigationController presentViewController:navi animated:YES completion:nil];
            }
            if(hd.type==14){ // 查询购物计划列表
                [[DBManager sharedDatabase] getListFromNetWithDict:dict
                                                      WithUsername:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]];
                for(UIView *v in [self.view subviews])
                {
                    [v removeFromSuperview];
                }
                [self loadPlanView];
            }
        }
    }
}
@end
