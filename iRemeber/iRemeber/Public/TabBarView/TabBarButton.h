//
//  TabBarButton.h
//  iRemeber
//
//  Created by TT on 2018/4/9.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarEntity.h"

@interface TabBarButton : UIButton

@property (copy, nonatomic) TabBarClickBlock mBlock;

@end
