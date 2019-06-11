//
// UIKit+AFNetworking.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#if TARGET_OS_IOS || TARGET_OS_TV
#import <UIKit/UIKit.h>

#ifndef _UIKIT_AFNETWORKING_
    #define _UIKIT_AFNETWORKING_

#if TARGET_OS_IOS
    #import "AFAutoPurgingImageCache.h"
    #import "AFImageDownloader.h"
    #import "AFNetworkActivityIndicatorManager.h"
    #import "UIRefreshControl+AFNetworking.h"
    #import "UIWebView+AFNetworking.h"
#endif

    #import "UIActivityIndicatorView+AFNetworking.h"
    #import "UIButton+AFNetworking.h"
    #import "UIImageView+AFNetworking.h"
    #import "UIProgressView+AFNetworking.h"
#endif /* _UIKIT_AFNETWORKING_ */
#endif
