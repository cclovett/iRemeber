//
//  ButtonView.m
//  iRemeber
//
//  Created by TT on 2018/4/11.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:self action:@selector(onClick_TouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)onClick_TouchUpInside:(id)sender
{
    if (self.mBlock_TouchUpInside) {
        
        self.mBlock_TouchUpInside(sender);
    }
}


- (void)dealloc
{
    self.mBlock_TouchUpInside = nil;
}


@end
