//
//  TabBarEntity.h
//  iRemeber
//
//  Created by TT on 2018/4/9.
//  Copyright © 2018年 Cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ButtonView.h"

@interface TabBarEntity : NSObject

@property (strong, nonatomic) NSString *mImage_Nor;
@property (strong, nonatomic) NSString *mImage_Pre;
@property (strong, nonatomic) NSString *mTitle;
@property (copy, nonatomic) bButtonViewBlock_TouchUpInside mBlock;

@end
