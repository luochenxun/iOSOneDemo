//
//  SystemDebugInfo.h
//  kidme
//
//  Created by luochenxun on 15-04-28.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//

#ifndef SystemDebugInfo_h
#define SystemDebugInfo_h

#ifdef IS_DEBUG

#define Logger(format, ...)                                                                        \
    do {                                                                                           \
        fprintf(stderr, "<%s : %d> %s\n",                                                          \
                [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],         \
                __LINE__, __func__);                                                               \
        NSLog((format), ##__VA_ARGS__);                                                            \
        fprintf(stderr, "-------\n");                                                              \
    } while (0)
    

#else

#define Logger(format, ...) ""

#endif

#endif


#define _LOG_DEBUG_ 1
#define _LOG_INFO_  1
#define _LOG_ERROR_ 1


#if _LOG_ERROR_
    #define LogDebug(fmt, ...) ;
    #define LogInfo(fmt, ...) ;
    #define LogError(fmt, ...) NSLog((@"%s [ERROR] " fmt), __FUNCTION__, ##__VA_ARGS__)
#elif _LOG_INFO_
    #define LogDebug(fmt, ...) ;
    #define LogInfo(fmt, ...) NSLog((@"%s [INFO] " fmt), __FUNCTION__, ##__VA_ARGS__)
    #define LogError(fmt, ...) NSLog((@"%s [ERROR] " fmt), __FUNCTION__, ##__VA_ARGS__)
#elif _LOG_DEBUG_
    #define LogDebug(fmt, ...) NSLog((@"%s [DEBUG] " fmt), __FUNCTION__, ##__VA_ARGS__)
    #define LogInfo(fmt, ...) NSLog((@"%s [INFO] " fmt), __FUNCTION__, ##__VA_ARGS__)
    #define LogError(fmt, ...) NSLog((@"%s [ERROR] " fmt), __FUNCTION__, ##__VA_ARGS__)
#else
    #define LogDebug(fmt, ...) ;
    #define LogInfo(fmt, ...) ;
    #define LogError(fmt, ...) ;
#endif
