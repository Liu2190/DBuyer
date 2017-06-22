//
//  TAllScoListFormController.m
//  DBuyer
//
//  Created by dilei liu on 14-4-5.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TAllScoListFormController.h"

@implementation TAllScoListFormController

- (id)init {
    self = [super init];
    self.resizeWhenKeyboardPresented =YES;
    
    QRootElement *root = [[[QRootElement alloc] init]autorelease];
    root.grouped = YES;
    self.root = root;
    

    
    [self addStaticSection];
    return self;
}


- (void)addDataSources:(NSArray*)datas {
    for (TAllScoCard *allscoCart in datas){
        [self addSection:allscoCart];
    }
    [self.quickDialogTableView reloadData];
}

- (void)addStaticSection {
    QSection *actonSection = [[[QSection alloc]init]autorelease];
    [actonSection setKey:@"baseSection"];
    [self.root addSection:actonSection];
    
    QButtonElement *bindingBtn = [[[QButtonElement alloc]initWithTitle:@"绑定储值卡"]autorelease];
    bindingBtn.appearance.buttonAlignment = NSTextAlignmentLeft;
    bindingBtn.appearance.labelFont = [UIFont systemFontOfSize:17];
    bindingBtn.appearance.valueFont = [UIFont systemFontOfSize:15];
    bindingBtn.appearance.actionColorEnabled = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    [bindingBtn setControllerAction:@"doBindingAllsco"];
    [actonSection addElement:bindingBtn];

}

- (void)doBindingAllsco {
    [self.allscoListController doBindingAllsco];
}

- (void)doChargeAllsco:(id)element {
    TAllScoCard *card = ((QButtonElement*)element).value;
    [self.allscoListController doChargeAllsco:card];
}

- (void)addSection:(TAllScoCard*)allscoCart{
    QSection *baseSection = [[[QSection alloc]init]autorelease];
    [baseSection setKey:@"baseSection"];
    [self.root addSection:baseSection];
    
    QLabelElement *cartNumElement = [[QLabelElement alloc]initWithTitle:@"卡号:" Value:allscoCart.cardNumber];
    [baseSection addElement:cartNumElement];
    [cartNumElement setKey:@"cartNum"];
    [cartNumElement release];
    
    NSString *residual = [NSString stringWithFormat:@"%@(元)",allscoCart.residual];
    QLabelElement *amountElement = [[QLabelElement alloc]initWithTitle:@"余额:" Value:residual];
    [baseSection addElement:amountElement];
    [amountElement setKey:@"amount"];
    [amountElement release];
    
    QButtonElement *chargeBtn = [[[QButtonElement alloc]initWithTitle:@"为预付卡充值"]autorelease];
    chargeBtn.appearance.actionColorEnabled = [UIColor colorWithRed:0 green:122./255 blue:255./255.f alpha:1];
    chargeBtn.value = allscoCart;
    [chargeBtn setControllerAction:@"doChargeAllsco:"];
    // [baseSection addElement:chargeBtn];
}

- (void)removeAllSection {
    [self.root.sections removeAllObjects];
    [self addStaticSection];
    [self.quickDialogTableView reloadData];
}

- (void)setUsageForBtnSectionFooter:(NSString*)usageText {
    QSection *section = [self.root.sections objectAtIndex:0];
    section.footer = usageText;
    [self.quickDialogTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255.0 green:237.0/255.0 blue:216.0/255.0 alpha:1]];
}

@end