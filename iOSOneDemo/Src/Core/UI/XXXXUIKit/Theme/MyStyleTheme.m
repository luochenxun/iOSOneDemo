//
//  MyStyleTheme.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/8.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "MyStyleTheme.h"


#pragma mark - < 子类定义 >


@implementation MyStyleColorStyle

// modify baseTheme
@synthesize buttonLight = _buttonLight;
// modify demoModule
@synthesize demoSectionBg = _demoSectionBg;
@synthesize demoCategoryBg = _demoCategoryBg;
@synthesize demoControllerBg = _demoControllerBg;

- (instancetype)init {
    self = [super init];
    if (self) {
        // base Theme
        _buttonLight = XXXX_COLOR_HEX(0xFFFF00);
        // demo module
        _demoSectionBg = XXXX_COLOR_HEX(0xe7e700);
        _demoCategoryBg = XXXX_COLOR_HEX(0xf7f700);
        _demoControllerBg = [UIColor whiteColor];
    }
    return self;
}

@end


#pragma mark - < 主类定义 >


@interface MyStyleTheme()

@end

@implementation MyStyleTheme

@synthesize colorStyle = _colorStyle;

- (instancetype)init {
    self = [super init];
    if (self) {
        _colorStyle = [[MyStyleColorStyle alloc] init];
    }
    return self;
}

@end
