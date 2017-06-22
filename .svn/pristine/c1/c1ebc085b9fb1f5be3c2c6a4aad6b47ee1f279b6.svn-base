//
//  ChooseAddressCell.m
//  DBuyer
//
//  Created by lixinda on 13-11-22.
//  Copyright (c) 2013年 liuxiaodan. All rights reserved.
//

#import "ChooseAddressCell.h"
#import "BtnDelegate.h"

@implementation ChooseAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _addressItem = [[AddressItem alloc]init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyAddressItem:(AddressItem *)addressItem{
    _addressItem = addressItem;
    self.addressTextView.text =_addressItem.address;
    self.addressTextView.backgroundColor = [UIColor clearColor];
    self.nameLabel.text = _addressItem.name;
    
    
    if (1==addressItem.isDefault) {
//        self.checkboxBtn.enabled = NO;
        [self.checkboxBtn setTitle:@"(默认)" forState:UIControlStateNormal];
    }else{
        [self.checkboxBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        
        //        self.checkboxBtn.enabled = YES;
    }
}
- (void)dealloc {
    [_nameLabel release];
    [_checkboxBtn release];
    [_addressTextView release];
    [_backGroundView release];
    [super dealloc];
}
- (IBAction)btnClick:(id)sender {
    [self.delegate pushDetail:sender];
}
@end
