//
//  TabBarView.m
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import "TabBarView.h"
#import <CLOCommon/CLOCommonUI.h>
#import "TabBarEntity.h"
#import "ButtonView.h"

#define kTabBarView_Line_Height 1.0

@interface TabBarView ()

@property (strong, nonatomic) CALayer *mLineLayer;
@property (strong, nonatomic) NSArray<TabBarEntity *> *mEntities;

@end
@implementation TabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kCLOColor(247, 247, 247, 1);
        [self fAddLine];
    }
    return self;
}

- (void)fSetupEntities:(NSArray<TabBarEntity *> *)entities
{
    for (UIView *v in self.subviews) {
        
        [v removeFromSuperview];
    }
    
    _mEntities = entities;
    
    CGFloat y = kTabBarView_Line_Height;
    CGFloat w = self.bounds.size.height - y - [CLOPositionHelper sGetiPhoneXBottomHeight];
    CGFloat dis = (self.bounds.size.width - w * self.mEntities.count) / (self.mEntities.count + 1);
    for (int i = 0; i < self.mEntities.count; ++i) {
        
        TabBarEntity *entity = self.mEntities[i];
        ButtonView *btn = [[ButtonView alloc] initWithFrame:CGRectMake((i + 1) * dis + i * w, y, w, w)];
        btn.backgroundColor = [UIColor yellowColor];
        btn.mBlock_TouchUpInside = entity.mBlock;
        [self addSubview:btn];
    }
}

- (void)fAddLine
{
    // 画一根黑细线
    if (!self.mLineLayer) {
        
        CALayer *line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, 0, self.bounds.size.width, kTabBarView_Line_Height);
        line.backgroundColor = kCLOColor(178, 178, 178, 1).CGColor;
        self.mLineLayer = line;
    }
    
    [self.layer addSublayer:self.mLineLayer];
}
@end
