//
// UIActivityIndicatorView+AFNetworking.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS || TARGET_OS_TV

#import <UIKit/UIKit.h>

/**
 This category adds methods to the UIKit framework's `UIActivityIndicatorView` class. The methods in this category provide support for automatically starting and stopping animation depending on the loading state of a session task.
 */
@interface UIActivityIndicatorView (AFNetworking)

///----------------------------------
/// @name Animating for Session Tasks
///----------------------------------

/**
 Binds the animating state to the state of the specified task.

 @param task The task. If `nil`, automatic updating from any previously specified operation will be disabled.
 */
- (void)setAnimatingWithStateOfTask:(nullable NSURLSessionTask *)task;

@end

#endif
