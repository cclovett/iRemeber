//
//  TabBarView.h
//  iRemeber
//
//  Created by Cc on 2018/4/8.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TabBarEntity;

@interface TabBarView : UIView

- (void)fSetupEntities:(NSArray<TabBarEntity *> *)entities;

@end
