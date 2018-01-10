//
//  XXXXTextButton.m
//  jiayoubao
//
//  Created by luochenxun on 2017/7/3.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXTextButton.h"

@implementation XXXXTextButton

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [self setButtonFont:kAppFont.h5
                  textColor:kAppColor.s2
              textHighlight:XXXX_COLOR_HEX(0x0000cc)];
    }
    return self;
}

@end
