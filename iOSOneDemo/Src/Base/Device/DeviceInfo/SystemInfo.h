//
//  SystemInfo.h
//  WishBid
//
//  Created by  on 13-10-26.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#ifndef DEVICEINFO_FOR_IOS
#define DEVICEINFO_FOR_IOS

// OS version
#define IOS_VERSION     ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS11_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 11.0 )
#define IOS10_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0 )
#define IOS9_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0 )
#define IOS8_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0 )
#define IOS7_OR_LATER    ( [[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0 )

#define IS_IPHONE_X         (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)812.0) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS    (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)736.0) < DBL_EPSILON)
#define IS_IPHONE_6         (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)667.0) < DBL_EPSILON)
#define IS_IPHONE_5         (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)568.0) < DBL_EPSILON)
#define IS_IPHONE_4S        (fabs((double)[UIScreen mainScreen].bounds.size.height - (double)480.0) < DBL_EPSILON)

#define GET_SIMPLE_WIDTH (320)
#define GET_SIMPLE_HEIGHT (568)
#define GET_SIMPLE_NAVIGATE (IS_IPHONE6PLUS ? 30 : 44)
#define GET_SIMPLE_STATUS_BAR (IS_IPHONE6PLUS ? 13 : (IS_IOS7 ? 20 : 0))

#define GET_DEVICE_WIDTH                                                                           \
    (([[UIScreen mainScreen] bounds].size.width) > 0 ? ([[UIScreen mainScreen] bounds].size.width) \
                                                     : 320)
#define GET_DEVICE_HEIGHT                                                                          \
    (IS_IOS7 ? (([[UIScreen mainScreen] bounds].size.height) > 0                                   \
                    ? ([[UIScreen mainScreen] bounds].size.height)                                 \
                    : 568)                                                                         \
             : (([[UIScreen mainScreen] bounds].size.height) -                                     \
                ([[UIApplication sharedApplication] isStatusBarHidden] ? 0 : 20)))
                
//#define GET_STATE_BAR_HEIGHT (IS_IPHONE6PLUS ? 30 : (IS_IOS7 ? 20 : 0))
//#define GET_NAV_BAR_HEIGHT (IS_IPHONE6PLUS ? 66 : 44)
#define GET_STATE_BAR_HEIGHT (IS_IOS7 ? 20 : 0)
#define GET_NAV_BAR_HEIGHT (44)
#define GET_TAB_BAR_HEIGHT (48)

#define GET_AD_HEIGHT (IS_IPHONE5 ? 171 : 137)

#define GET_GAP (2)

#define COLOR_FOR_GENERAL_TXT ([UIColor blackColor])
#define COLOR_RENDER_FOR_SPECIAL                                                                   \
    ([UIColor colorWithRed:248.f / 255 green:96.f / 255 blue:30.f / 255 alpha:1.0])
#define COLOR_FOR_SIGN_TXT                                                                         \
    ([UIColor colorWithRed:1.0 * 0x5f / 255 green:1.0 * 0x5f / 255 blue:1.0 * 0x5f / 255 alpha:1.0])
    
#define COLOR_OF_ORANGE                                                                            \
    ([UIColor colorWithRed:1.0 * 0xfe / 255 green:1.0 * 0x76 / 255 blue:1.0 * 0x39 / 255 alpha:1.0])
#define COLOR_OF_WHITE                                                                             \
    ([UIColor colorWithRed:1.0 * 0xfc / 255 green:1.0 * 0xfc / 255 blue:1.0 * 0xfc / 255 alpha:1.0])
#define COLOR_OF_GRAY                                                                              \
    ([UIColor colorWithRed:1.0 * 0xb4 / 255 green:1.0 * 0xb4 / 255 blue:1.0 * 0xb4 / 255 alpha:1.0])
#define COLOR_OF_RED ([UIColor colorWithRed:255 / 255.0 green:0 / 255.0 blue:88 / 255.0 alpha:1.0])
#define COLOR_OF_WORD_GRAY                                                                         \
    ([UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0])
    
#define FONT_18 [UIFont systemFontOfSize:18]
#define FONT_16 [UIFont systemFontOfSize:16]
#define FONT_15 [UIFont systemFontOfSize:15]
#define FONT_14 [UIFont systemFontOfSize:14]
#define FONT_13 [UIFont systemFontOfSize:13]
#define FONT_12 [UIFont systemFontOfSize:12]
#define FONT_11 [UIFont systemFontOfSize:11]
#define FONT_10 [UIFont systemFontOfSize:10]

#define SCREENBOUNDS [[UIScreen mainScreen] bounds]

#define string(...) [NSString stringWithFormat:__VA_ARGS__]
#define sysFont(num) [UIFont systemFontOfSize:num]
#define COLOR(r, g, b, aph) [Utility colorWithRGB:r green:g blue:b alpha:aph]

#define isIos7OrAfter [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

#define FONT_SIGN FONT_11
#define FONT_TXT FONT_13
#define FONT_LOGIN FONT_15
#define FONT_TITLE_LARGE FONT_18

#define FONT_SIGN_WIDTH 11
#define FONT_TXT_WIDTH 13
#define FONT_LOGIN_WIDTH 15
#define FONT_TITLE_LARGE_WIDTH 18

// txt align mode
#define TEXT_ALIGN_CENTER                                                                          \
    (IS_IOS7 ? (NSInteger)NSTextAlignmentCenter : (NSInteger)UITextAlignmentCenter)
#define TEXT_ALIGN_LEFT (IS_IOS7 ? (NSInteger)NSTextAlignmentLeft : (NSInteger)UITextAlignmentLeft)
#define TEXT_ALIGN_RIGHT                                                                           \
    (IS_IOS7 ? (NSInteger)NSTextAlignmentRight : (NSInteger)UITextAlignmentRight)
    
#define TEXT_LINE_BREAK_MODE_TAIL                                                                  \
    (IS_IOS7 ? (NSInteger)NSLineBreakByTruncatingTail : (NSInteger)UILineBreakModeTailTruncation)
    
#define TEXT_LINE_BREAK_MODE_WORD                                                                  \
    (IS_IOS7 ? (NSInteger)NSLineBreakByWordWrapping : (NSInteger)UILineBreakModeWordWrap)
    
#define TEXT_LINE_BREAK_MODE_CHAR_WRAP                                                             \
    (IS_IOS7 ? (NSInteger)NSLineBreakByCharWrapping : (NSInteger)UILineBreakModeCharacterWrap)
    
#define TEXT_LINE_BREAK_MODE_CLIP                                                                  \
    (IS_IOS7 ? (NSInteger)NSLineBreakByClipping : (NSInteger)UILineBreakModeClip)
    
#define GENERATA_TABLEVIEW_BTN_TAG(Section, Row) ((Section)*100 + (Row))

/**  Sex enum <br>
 * female is : Female <br>
 * male is : Male <br>
 * unkonw is : Unkonw  <br>*/
typedef enum { Female = 0, Male, Unkonw } Sex;

#endif
