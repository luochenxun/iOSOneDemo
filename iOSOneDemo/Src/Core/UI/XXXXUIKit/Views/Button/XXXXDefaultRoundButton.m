//
//  XXXXDefaultRoundButton.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/23.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXDefaultRoundButton.h"

@implementation XXXXDefaultRoundButton


- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        self.flex_layoutHeight = 50;
        self.flex_layoutWidth = kAppDimension.screenWidth - 30;
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
