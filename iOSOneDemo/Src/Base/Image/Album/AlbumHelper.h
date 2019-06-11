//
// AlbumHelper.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

@interface AlbumHelper : NSObject



#pragma mark - UIImage's methods

+ (UIImage *)imageFromView:(UIView *)view;


#pragma mark - 在手机相册中创建相册

+ (void)saveUIImage:(UIImage *)image inPhoneAlbum:(NSString *)albumName;



@end
