//
//  TopBarButton.m
//  iRemeber
//
//  Created by TT on 2018/4/10.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TopBarButton.h"

@interface TopBarButton ()

@end

@implementation TopBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)onClick:(TopBarButton *)sender
{
    if (self.mBlock) {
        
        self.mBlock(sender);
    }
}

- (void)dealloc
{
    self.mBlock = nil;
}


@end
