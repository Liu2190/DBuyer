//
//  ShoppingCartCell.m
//  DBuyer
//
//  Created by liuxiaodan on 14-1-3.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "UIImageView+WebCache.h"
#import "Product.h"

@interface ShoppingCartCell () <UITextFieldDelegate>
// 临时变量， 保存商品个数
@property (nonatomic, assign) NSInteger tempCount;
// target action 方法
@property (nonatomic, assign) id target;
@property (nonatomic) SEL selectAction;
@property (nonatomic) SEL deleteAction;
@property (nonatomic) SEL countChangeAction;
@property (nonatomic) SEL joinPlanAction;
@property (nonatomic) SEL beginEditingAction;

@end

@implementation ShoppingCartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)shoppingCartCell
{
    // 读出xib文件
    return [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartCell" owner:nil options:nil] objectAtIndex:0];
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.productCountTextField.delegate = self;
    
    //在键盘上添加按钮视图
    UIView * keyboardView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    keyboardView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];
    self.productCountTextField.inputAccessoryView =keyboardView;
    CGRect btnRect = CGRectMake(0, 0, 40, 30);
    LXD *complate=[[LXD alloc]initWithText:@"完成" font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 8, 30, 15) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];
    
    LXD *cancel=[[LXD alloc]initWithText:@"取消" font:14 textAlight:NSTextAlignmentCenter frame:CGRectMake(0, 8, 30, 15) backColor:[UIColor clearColor] textColor:[UIColor blackColor]];

    UIButton * completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(didClickCompletedKeboard:) forControlEvents:UIControlEventTouchUpInside];
    completeBtn.bounds = btnRect;
    completeBtn.center = CGPointMake(320-20, 15);
    [completeBtn addSubview:complate];
    [keyboardView addSubview:completeBtn];
    
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.center = CGPointMake(20, 15);
    //[cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(didClickCancelKeboard:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.bounds = btnRect;
    [cancelBtn addSubview:cancel];
    [keyboardView addSubview:cancelBtn];
}


-(void)didClickCancelKeboard:(id)sender{
    //取消键盘按钮事件
    [self.productCountTextField resignFirstResponder];
    // 返回修改数据
    [self.target performSelector:self.countChangeAction
                      withObject:self
                      withObject:[NSNumber numberWithInteger:self.tempCount]];
}
-(void)didClickCompletedKeboard:(UIButton *)sender{
    //完成按钮点击事件
    [self.productCountTextField resignFirstResponder];
    // 如果输入小于1，则保存为1
    if (self.productCountTextField.text.intValue == 0) {
        self.tempCount = 1;
    } else {
        self.tempCount = self.productCountTextField.text.intValue;
    }
    // 返回修改数据
    [self.target performSelector:self.countChangeAction
                      withObject:self
                      withObject:[NSNumber numberWithInteger:self.tempCount]];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_productNameLabel release];
    [_productImageView release];
    [_productPriceLabel release];
    [_productCountTextField release];
    [_selectButton release];
    [_selectImageView release];
    [_joinPlanButton release];
    [super dealloc];
}
- (void)showWithProduct:(Product *)product
{
    // 商品图片
    [self.productImageView setImageWithURL:[NSURL URLWithString:product.attrValue]];
    // 显示商品名
    CGRect frame = self.productNameLabel.frame;
    frame.size.width = 185;
    self.productNameLabel.frame = frame;// CGRectMake(118, 14, 185, 38);
    
    self.productNameLabel.text = product.commodityName;
    self.productNameLabel.numberOfLines = 2;
//    [self.productNameLabel sizeToFit];
    // 价格
    self.productPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", product.sellPrice * product.count];
    // 数量
    self.productCountTextField.text = [NSString stringWithFormat:@"%d", product.count];
}

+ (float)heightOfCell
{
    return 100;
}

- (void)addTarget:(id)target
     selectAction:(SEL)selectAction
     deleteAction:(SEL)deleteAction
countChangeAction:(SEL)countChangeAction
   joinPlanAction:(SEL)joinPlanAction
beginEditingAction:(SEL)beginEditingAction
{
    self.target = target;
    self.selectAction = selectAction;
    self.deleteAction = deleteAction;
    self.countChangeAction = countChangeAction;
    self.joinPlanAction = joinPlanAction;
    self.beginEditingAction = beginEditingAction;
}
- (void)setSelectStatus:(BOOL)status
{
    self.selectImageView.highlighted = status;
}

- (IBAction)selectButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.selectAction withObject:self];
}

- (IBAction)deleteButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.deleteAction withObject:self];
}

- (IBAction)joinPlanButtonClicked:(UIButton *)sender
{
    [self.target performSelector:self.joinPlanAction withObject:self];
}

#pragma mark - textField代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // 保存编辑前, 商品个数
    self.tempCount = [textField.text integerValue];
    [self.target performSelector:self.beginEditingAction withObject:self];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

@end
