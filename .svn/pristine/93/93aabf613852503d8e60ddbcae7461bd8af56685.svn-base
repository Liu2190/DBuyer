//
//  TDbuyerTextField.m
//  DBuyer
//
//  Created by dilei liu on 14-3-11.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TDbuyerTextField.h"

@implementation TDbuyerTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _placeholder_size = 15;
    _isCenter = NO;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [[UIColor colorWithRed:176./255.0 green:176./255.0 blue:176./255.0 alpha:.5] setFill];
    rect.origin.y = 2;
    
    CGSize maximumLabelSize = CGSizeMake(200, 999);
    CGSize titleSize = [[self placeholder] sizeWithFont:[UIFont systemFontOfSize:_placeholder_size] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    
    if (_isCenter)
    rect.origin.x = (rect.size.width-titleSize.width)/2;
    
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:_placeholder_size]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text length] > 10) {
        textField.text = [textField.text substringToIndex:10-1];
        return NO;
    }
    return YES;
}



@end
