//
// UIImage+ForceDecode.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.
/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImage+ForceDecode.h"
#import "SDWebImageCodersManager.h"

@implementation UIImage (ForceDecode)

+ (UIImage *)decodedImageWithImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    NSData *tempData;
    return [[SDWebImageCodersManager sharedInstance] decompressedImageWithImage:image data:&tempData options:@{SDWebImageCoderScaleDownLargeImagesKey: @(NO)}];
}

+ (UIImage *)decodedAndScaledDownImageWithImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    NSData *tempData;
    return [[SDWebImageCodersManager sharedInstance] decompressedImageWithImage:image data:&tempData options:@{SDWebImageCoderScaleDownLargeImagesKey: @(YES)}];
}

@end
