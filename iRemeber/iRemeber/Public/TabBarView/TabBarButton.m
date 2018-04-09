//
//  TabBarButton.m
//  iRemeber
//
//  Created by TT on 2018/4/9.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)onClick:(TabBarButton *)sender
{
    if (self.mBlock) {
        
        self.mBlock(sender);
    }
}
@end
