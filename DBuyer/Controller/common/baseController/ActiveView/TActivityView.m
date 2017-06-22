//
//  TIActivityView.m
//  componentHandler
//
//  Created by dilei liu on 12-6-30.
//  Copyright (c) 2012年 iscs. All rights reserved.
//

#import "TActivityView.h"


#define activityOpaque 0.6f

@implementation TActivityView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGRect activityFrame = CGRectMake(0.0f, 0.0f, 32.0f, 32.0f);
        activityView = [[UIActivityIndicatorView alloc]initWithFrame:activityFrame];
        [self setPropertyForActivity];
    }
    
    [self setPropertyForCurrentModel];
    
    [self addSubview:activityView];
    
    [activityView release];
    
    return self;
}

- (void) setPropertyForActivity {
    
    if (activityView != nil) {
        [activityView setCenter:self.center];
        [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    }
}

- (void) setPropertyForCurrentModel {
    
    if (self != nil) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:activityOpaque];
    }
}

- (void) startAnimation {
    self.hidden = NO;
    [activityView startAnimating];
}

- (void) stopAnimation {
    self.hidden = YES;
    [activityView stopAnimating];
}


- (void) dealloc {
    [activityView release];
    activityView = nil;
    
    [super dealloc];
}

@end
