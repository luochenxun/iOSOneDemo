//
//  XXXXUIKit.h
//  jiayoubao
//
//  Created by luochenxun on 2017/6/13.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//
//  Description:
//  XXXXUIKit 工具包头文件，包含此工具包需要包含的头文件及本包内通用的方法宏定义

#ifndef XXXXUIKit_h
#define XXXXUIKit_h


// ---------------------------------
//    包内通用方法宏
// ---------------------------------

// -----------  Font --------------


// 系统字体
#define XXXX_SYS_FONT(__x)      [UIFont systemFontOfSize: __x]
#define XXXX_SYS_FONT_PX(__x)   [UIFont systemFontOfSize: (__x / 1.82)]
// 使用苹方字体，因为iOS8及以下是不支持的（从iOS 9）才开始，所以使用时要使用 @try-@catch 住
#define XXXX_SYS_FONT_LIGHT(__x)    [UIFont fontWithName:@"PingFangSC-Light" size:(__x)]
#define XXXX_SYS_FONT_LIGHT_PX(__x) [UIFont fontWithName:@"PingFangSC-Light" size:(__x / 1.82)]


// -----------  Color --------------
#define XXXX_COLOR_ALPHA(r,g,b,a)   ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define XXXX_COLOR(r,g,b)           XXXX_COLOR_ALPHA(r,g,b,1.0)
#define XXXX_COLOR_HEX_ALPHA(h,a)   XXXX_COLOR_ALPHA(((h>>16)&0xFF), ((h>>8)&0xFF), (h&0xFF), a)
#define XXXX_COLOR_HEX(h)           XXXX_COLOR_HEX_ALPHA(h, 1.0)
#define XXXX_RANDOM_COLOR()         [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


// -----------  Size --------------
#define XXXX_SIZE_LINE              (1.0 / [UIScreen mainScreen].scale)



// ---------------------------------
//    导入工具包头文件
// ---------------------------------

// --- 主题类
#import "XXXXBaseTheme.h"
#import "XXXXAppTheme.h"
#import "MyStyleTheme.h"

// --- 布局 Layout
#import "FlexLayout.h"

// --- 控件
#import "XXXXButton.h"
#import "XXXXLabel.h"


// ---------------------------------
//    便利宏
// ---------------------------------

#define kAppTheme ([XXXXAppContext sharedInstance].theme)
#define kAppFont kAppTheme.fontStyle
#define kAppColor kAppTheme.colorStyle
#define kAppDimension kAppTheme.dimensionStyle


#endif /* XXXXUIKit_h */
