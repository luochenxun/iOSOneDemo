//
// NSDataHelper.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

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
