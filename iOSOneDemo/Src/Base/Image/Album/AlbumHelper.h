//
//  AlbumHelper.h
//  kidme
//
//  Created by luochenxun on 15/5/18.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumHelper : NSObject



#pragma mark - UIImage's methods

+ (UIImage *)imageFromView:(UIView *)view;


#pragma mark - 在手机相册中创建相册

+ (void)saveUIImage:(UIImage *)image inPhoneAlbum:(NSString *)albumName;



@end
