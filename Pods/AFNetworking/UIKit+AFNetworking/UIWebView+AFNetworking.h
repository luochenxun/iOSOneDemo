//
// UIWebView+AFNetworking.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <Foundation/Foundation.h>

#import <TargetConditionals.h>

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AFHTTPSessionManager;

/**
 This category adds methods to the UIKit framework's `UIWebView` class. The methods in this category provide increased control over the request cycle, including progress monitoring and success / failure handling.

 @discussion When using these category methods, make sure to assign `delegate` for the web view, which implements `–webView:shouldStartLoadWithRequest:navigationType:` appropriately. This allows for tapped links to be loaded through AFNetworking, and can ensure that `canGoBack` & `canGoForward` update their values correctly.
 */
@interface UIWebView (AFNetworking)

/**
 The session manager used to download all requests.
 */
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

/**
 Asynchronously loads the specified request.

 @param request A URL request identifying the location of the content to load. This must not be `nil`.
 @param progress A progress object monitoring the current download progress.
 @param success A block object to be executed when the request finishes loading successfully. This block returns the HTML string to be loaded by the web view, and takes two arguments: the response, and the response string.
 @param failure A block object to be executed when the data task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a single argument: the error that occurred.
 */
- (void)loadRequest:(NSURLRequest *)request
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSString * (^)(NSHTTPURLResponse *response, NSString *HTML))success
            failure:(nullable void (^)(NSError *error))failure;

/**
 Asynchronously loads the data associated with a particular request with a specified MIME type and text encoding.

 @param request A URL request identifying the location of the content to load. This must not be `nil`.
 @param MIMEType The MIME type of the content. Defaults to the content type of the response if not specified.
 @param textEncodingName The IANA encoding name, as in `utf-8` or `utf-16`. Defaults to the response text encoding if not specified.
@param progress A progress object monitoring the current download progress.
 @param success A block object to be executed when the request finishes loading successfully. This block returns the data to be loaded by the web view and takes two arguments: the response, and the downloaded data.
 @param failure A block object to be executed when the data task finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes a single argument: the error that occurred.
 */
- (void)loadRequest:(NSURLRequest *)request
           MIMEType:(nullable NSString *)MIMEType
   textEncodingName:(nullable NSString *)textEncodingName
           progress:(NSProgress * _Nullable __autoreleasing * _Nullable)progress
            success:(nullable NSData * (^)(NSHTTPURLResponse *response, NSData *data))success
            failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#endif
