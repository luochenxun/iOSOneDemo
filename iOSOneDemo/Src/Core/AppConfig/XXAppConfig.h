//
// XXAppConfig.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#ifndef xx_app_ConfigurationConst_h
#define xx_app_ConfigurationConst_h

//----------------------   Main Configuration --------------------

#pragma mark - Global Switch

/**
 *  #define MODE_DEBUG
 *  @brief  Important Marco define that if we're in Debug-Mode
 *  开关控制是否是测试环境
 */
#define MODE_DEBUG

// Host url
#ifdef MODE_DEBUG
    #define M_HOST @"http://debug.com/"
#else
    #define M_HOST @"http://release.com"
#endif


#endif
