//
// UIImage+AFNetworking.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>

@interface UIImage (AFNetworking)

+ (UIImage*) safeImageWithData:(NSData*)data;

@end

#endif
