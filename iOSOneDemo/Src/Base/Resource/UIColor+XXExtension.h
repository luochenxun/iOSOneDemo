//
//  UIColor+XXExtension.h
//  XXXX
//
//  Created by luochenxun on 16/4/29.
//  Copyright © 2016年 Kacha-Mobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XXExtension)

/**
 *  用16进制数获得相应的UIColor
 *  @param 如：0xF0F0F0
 */
+ (UIColor *)XX_colorWithHex:(NSInteger)hex;

/**
 *  用16进制数获得相应的UIColor
 *  @param hex: 0xF0F0F0 alpha : 0.0 - 1.0
 */
+ (UIColor *)XX_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/**
 *  用16进制数获得相应的UIColor
 *  @param hex:@"#FF0000"
 */
+ (UIColor *)XX_colorWithHexString:(NSString *)hex;

@end
