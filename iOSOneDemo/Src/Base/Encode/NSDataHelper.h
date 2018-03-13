//
//  NSDataHelper.h
//  iOSOneDemo
//
//  Created by luochenxun on 2018/3/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDataHelper : NSObject


/**
 将16进制数字表示的NSString转成NSData。非偶数的话会在前面补0.
 */
+ (NSData *)convertHexStrToData:(NSString *)str;

/**
 将16进制数字表示的NSData转成NSString。
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;


@end
