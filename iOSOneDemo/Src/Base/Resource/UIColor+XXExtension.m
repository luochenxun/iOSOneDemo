//
// UIColor+XXExtension.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UIColor+XXExtension.h"

@implementation UIColor (XXExtension)

+ (UIColor *)XX_colorWithHex:(NSInteger)hex {
    return [UIColor XX_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)XX_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((hex & 0XFF0000) >> 16) / 255.0
                           green:((hex & 0X00FF00) >> 8) / 255.0
                            blue:(hex & 0X0000FF) / 255.0
                           alpha:alpha];
}

+ (UIColor *)XX_colorWithHexString:(NSString *)stringToConvert {
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    
    return [UIColor XX_colorWithHex:hexNum alpha:1];
}

@end
