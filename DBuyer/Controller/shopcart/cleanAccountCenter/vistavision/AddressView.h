//
//  AddressView.h
//  DBuyer
//
//  Created by lixinda on 13-11-18.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView
@property (retain, nonatomic) IBOutlet UILabel *receipt;
@property (retain, nonatomic) IBOutlet UILabel *phoneNumber;
@property (retain, nonatomic) IBOutlet UILabel *address;
- (IBAction)btnClick:(id)sender;
@property(nonatomic,assign)id delegate;
@end
