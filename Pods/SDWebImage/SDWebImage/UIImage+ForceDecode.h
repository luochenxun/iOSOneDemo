//
// UIImage+ForceDecode.h
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

#import "SDWebImageCompat.h"

@interface UIImage (ForceDecode)

+ (nullable UIImage *)decodedImageWithImage:(nullable UIImage *)image;

+ (nullable UIImage *)decodedAndScaledDownImageWithImage:(nullable UIImage *)image;

@end
