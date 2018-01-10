//
//  XXXXBaseTheme.h
//  jiayoubao
//
//  Created by luochenxun on 2017/6/13.
//  strongright © 2017年 jiayoubao. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - < 子类定义 >


/**
 字体大小风格基类
 */
@interface XXXXBaseFontStyle : NSObject

/** 字号  */
@property (readonly, nonatomic , strong) UIFont * h1;   // 20
@property (readonly, nonatomic , strong) UIFont * h2;   // 18
@property (readonly, nonatomic , strong) UIFont * h3;   // 17
@property (readonly, nonatomic , strong) UIFont * h4;   // 15
@property (readonly, nonatomic , strong) UIFont * h5;   // 13
@property (readonly, nonatomic , strong) UIFont * h6;   // 10

- (UIFont *)fontOfSize:(CGFloat)size;

@end


@interface UIFont (BoldFontStyle)

//ultraLight
//thin
//light
//regular
//medium
//semibold
//bold
//heavy
//black

- (UIFont *)medium;

- (UIFont *)bold;

@end





/**
 颜色风格基类
 */
@interface XXXXBaseColorStyle : NSObject

/** 主色  */
@property (readonly, nonatomic , strong) UIColor *main;                     // 0xff6e34
@property (readonly, nonatomic , strong) UIColor *disable;                  // 0xcccccc
/** 辅助色  */
@property (readonly, nonatomic , strong) UIColor *s1;
@property (readonly, nonatomic , strong) UIColor *s2;                       // 0x0183ff
@property (readonly, nonatomic , strong) UIColor *s3;
/** 背景色  */
@property (readonly, nonatomic , strong) UIColor *bg;
/** 亮背景 - 一般为白色 */
@property (readonly, nonatomic , strong) UIColor *brightBg;
@property (readonly, nonatomic , strong) UIColor *brightBgHighLight;
/** 分割线  */
@property (readonly, nonatomic , strong) UIColor *divider;                  // 0xe6e6e6
@property (readonly, nonatomic , strong) UIColor *dividerDark;
/** 一级文字  */
@property (readonly, nonatomic , strong) UIColor *h1;                       // 0x333333
/** 二级文字  */
@property (readonly, nonatomic , strong) UIColor *h2;                       // 0x999999
/** 正文  */
@property (readonly, nonatomic , strong) UIColor *content;                  // 0x666666
/** 说明文字  */
@property (readonly, nonatomic , strong) UIColor *tips;
/** 导航文字  */
@property (readonly, nonatomic , strong) UIColor *navi;                     // 0x515151
/** 反色  */
@property (readonly, nonatomic , strong) UIColor *inverse;
/**  阴影 */
@property (readonly, nonatomic , strong) UIColor *shadow;


/** 按钮颜色  */
@property (readonly, nonatomic , strong) UIColor *buttonDefault;
@property (readonly, nonatomic , strong) UIColor *buttonDefaultPress;
@property (readonly, nonatomic , strong) UIColor *buttonDefaultText;
@property (readonly, nonatomic , strong) UIColor *buttonDefaultTextPress;
@property (readonly, nonatomic , strong) UIColor *buttonLight;
@property (readonly, nonatomic , strong) UIColor *buttonLightPress;
@property (readonly, nonatomic , strong) UIColor *buttonLightText;
@property (readonly, nonatomic , strong) UIColor *buttonLightTextPress;
@property (readonly, nonatomic , strong) UIColor *buttonDark;
@property (readonly, nonatomic , strong) UIColor *buttonDarkPress;
@property (readonly, nonatomic , strong) UIColor *buttonDarkText;
@property (readonly, nonatomic , strong) UIColor *buttonDarkTextPress;

/** alertView颜色  */
@property (readonly, nonatomic , strong) UIColor *alertViewBg;
@property (readonly, nonatomic , strong) UIColor *alertMainBtnColor;
@property (readonly, nonatomic , strong) UIColor *alertMainBtnPreColor;
@property (readonly, nonatomic , strong) UIColor *alertMainBtnTxtColor;
@property (readonly, nonatomic , strong) UIColor *alertMainBtnTxtPreColor;
@property (readonly, nonatomic , strong) UIColor *alertDefaultBtnColor;
@property (readonly, nonatomic , strong) UIColor *alertDefaultBtnPreColor;
@property (readonly, nonatomic , strong) UIColor *alertDefaultBtnTxtColor;
@property (readonly, nonatomic , strong) UIColor *alertDefaultBtnTxtPreColor;

/** 默认图背景  */
@property (readonly, nonatomic , strong) UIColor *blockBgColor;

- (UIColor *)colorWithValue:(long long)value;

@end


/**
 屏幕尺寸风格基类
 */
static const CGFloat kBaseScreenWidth = 375.0;

@interface XXXXBaseDimensionStyle : NSObject

@property (readonly, nonatomic, assign) CGFloat screenWidth;            // 屏幕宽度
@property (readonly, nonatomic, assign) CGFloat screenHeight;           // 屏幕高度
@property (readonly, nonatomic, assign) CGFloat statusBarHeight;        // 状态栏
@property (readonly, nonatomic, assign) CGFloat navigationBarHeight;    // 导航栏
@property (readonly, nonatomic, assign) CGFloat tabBarHeight;           // tabbar
@property (readonly, nonatomic, assign) CGFloat indicatorHeight;
    // iPhoneX 底部系统功能区 34px

@property (readonly, nonatomic, assign) CGFloat contentWidth;           // 内容区宽度（除去左右边距）
@property (readonly, nonatomic, assign) CGFloat contentHeight;          // 内容区高度 (除去状态栏和导航栏)
@property (readonly, nonatomic, assign) CGFloat tabbarContentHeight;    // 内容区高度 (除去状态栏、导航栏和tabbar)

@property (readonly, nonatomic, assign) CGFloat marginLeftRight;        // 左右边距-15
@property (readonly, nonatomic, assign) CGFloat cornerRadius;           // 圆角-3
@property (readonly, nonatomic, assign) CGFloat lineWidth;              // 单像素线宽

@property (readonly, nonatomic, assign) CGFloat buttonHeight;           // 按钮高度-50
@property (readonly, nonatomic, assign) CGFloat bottomButtonHeight;     // 底部悬浮按钮高度-56
@property (readonly, nonatomic, assign) CGFloat listItemHeight;         // 列表项高度-52

@end


#pragma mark - < 主类定义 >


/**
 主题基类
 */
@interface XXXXBaseTheme : NSObject

@property (readonly, nonatomic , strong) XXXXBaseFontStyle  *baseFontStyle;
@property (readonly, nonatomic , strong) XXXXBaseColorStyle *baseColorStyle;
@property (readonly, nonatomic , strong) XXXXBaseDimensionStyle *baseDimensionStyle;

+ (instancetype)sharedInstance;

/** 将Color对象转成16进制表示的色值 */
- (NSString *)hexWithColor:(UIColor *)color;

@end
