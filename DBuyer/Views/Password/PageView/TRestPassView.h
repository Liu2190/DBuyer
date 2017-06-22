//
//  TRestPassView.h
//  DBuyer
//
//  Created by dilei liu on 14-3-15.
//  Copyright (c) 2014年 liuxiaodan. All rights reserved.
//

#import "TBasePassView.h"
#import "TDbuyerFieldController.h"

@interface TRestPassView : TBasePassView {
    TDbuyerFieldController *_passwordController;
    TDbuyerFieldController *_rePasswordController;
}

- (UITextField *)getPasswordTextField;
- (UITextField *)getRePasswordTextField;

- (void)cancelKeyboard;

@end
