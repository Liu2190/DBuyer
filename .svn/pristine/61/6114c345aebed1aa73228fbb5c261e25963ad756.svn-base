//
//  UserFeedbackViewController.m
//  DBuyer
//
//  Created by liuxiaodan on 14-4-4.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "UserFeedbackViewController.h"
#import "StartPoint.h"
#import "UserFBContactCell.h"
#import "UserFBContentCell.h"
#import "keyBoardView.h"
@interface UserFeedbackViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) UserFBContactCell *contactCell;
@property (nonatomic,retain) UserFBContentCell *contentCell;
@end

@implementation UserFeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.leveyTabBarController hidesTabBar:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.leveyTabBarController hidesTabBar:NO animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;//隐藏标题栏
    self.view.backgroundColor = BACKCOLOR;
    [self setNavigationBarWithContent:@"用户反馈" WithLeftButton:[UIImage imageNamed:@"Image_HomeView_back"] AndRightButton:[UIImage imageNamed:@"global_right_button"]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [StartPoint startPoint], WindowWidth, WindowHeight-[StartPoint startPoint]) style:UITableViewStylePlain];
    self.tableView.backgroundColor = BACKCOLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
/**
 *返回按钮事件
 */
-(void)leftButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
/**
 *提交按钮事件
 */
-(void)rightButtonClick:(UIButton *)button
{
    //将意见提交到服务器
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if([self.contentCell.contentTextView.text length]==0 )
    {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写反馈内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
        return;
    }
    HttpDownload *hd = [[HttpDownload alloc]init];
    hd.delegate = self;
    hd.method = @selector(downloadComplete:);
    NSString *versionString= [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"versionNum"]];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",@"type",self.contentCell.contentTextView.text,@"content",versionString,@"version",nil];
    if([self.contactCell.userFBContanctTextField.text length]!=0)
    {
        [dict setValue:self.contactCell.userFBContanctTextField.text forKey:@"contact"];
    }
    else
    {
        if([self isAlreadyLogined])
        {
            [dict setValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"userName"] forKey:@"contact"];
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"%@interface/userHelpView/insertToView",serviceHost];
    [hd getResultData:dict baseUrl:urlString];
}
-(void)downloadComplete:(HttpDownload *)hd
{
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:hd.downloadData options:NSJSONReadingMutableContainers error:nil];
    if(dict)
    {
        UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的反馈已提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [al show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - tabelview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 )
    {
        return [UserFBContactCell userFBContactCellHeight];
    }
    return [UserFBContentCell userFBContentCellHeight];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.contactCell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    self.contactCell.selected = NO;
    self.contactCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentCell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
    self.contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentCell.selected = NO;
    if(indexPath.row == 0)
    {
        self.contactCell = [[[NSBundle mainBundle]loadNibNamed:@"UserFBContactCell" owner:self options:nil]lastObject];
        self.contactCell.userFBContanctTextField.delegate = self;
        keyBoardView  *keyBoard = [[[NSBundle mainBundle]loadNibNamed:@"keyBoardView" owner:self options:nil] lastObject];
        keyBoard.frame =CGRectMake(0, 0, WindowWidth, [keyBoardView keyBoardViewHeight]);
        [keyBoard addTarget:self finishAction:@selector(keyBoardFinish:) cancelAction:@selector(keyBoardCancel:)];
        keyBoard.userInteractionEnabled = YES;
        self.contactCell.userFBContanctTextField.inputAccessoryView.userInteractionEnabled = YES;
        self.contactCell.userFBContanctTextField.inputAccessoryView =keyBoard;
        return self.contactCell;
    }
    else
    {
        self.contentCell = [[[NSBundle mainBundle]loadNibNamed:@"LUserFBNameCell" owner:self options:nil]lastObject];
        keyBoardView  *keyBoard = [[[NSBundle mainBundle]loadNibNamed:@"keyBoardView" owner:self options:nil] lastObject];
        keyBoard.frame =CGRectMake(0, 0, WindowWidth, [keyBoardView keyBoardViewHeight]);
        [keyBoard addTarget:self finishAction:@selector(keyBoardFinishAction:) cancelAction:@selector(keyBoardCancelAction:)];
        keyBoard.userInteractionEnabled = YES;
        self.contentCell.contentTextView.inputAccessoryView.userInteractionEnabled = YES;
        self.contentCell.contentTextView.inputAccessoryView =keyBoard;
        [self.contentCell.contentTextView.layer setCornerRadius:10];
        self.contentCell.contentTextView.delegate = self;
    }
    return self.contentCell;
}
#pragma mark - textFieldDelegate
-(void)keyBoardFinish:(UIButton *)button
{
    [self.contactCell.userFBContanctTextField resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)keyBoardCancel:(UIButton *)button
{
    [self.contactCell.userFBContanctTextField resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)keyBoardFinishAction:(UIButton *)button
{
    [self.contentCell.contentTextView resignFirstResponder];
   // [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)keyBoardCancelAction:(UIButton *)button
{
    [self.contentCell.contentTextView resignFirstResponder];
  //  [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
