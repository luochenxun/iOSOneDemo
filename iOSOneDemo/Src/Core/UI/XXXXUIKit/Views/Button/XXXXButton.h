//
// XXXXButton.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.


#import <UIKit/UIKit.h>
#import "XXXXViewProtocal.h"


/**
 系统支持的按钮风格
 */
typedef NS_ENUM(NSInteger,XXXXButtonType) {
    XXXXButtonTypeDefault = 1,     // 默认样式按钮
    XXXXButtonTypeSecondary = 2,   // 次要按钮
    XXXXButtonTypeFloatButton = 3, // 悬浮按钮
    XXXXButtonTypeTextButton = 4,  // 纯文字按钮
    XXXXButtonTypeImageButton = 5, // 图片按钮
    XXXXButtonTypeCheckbox = 6,    // Checkbox按钮
    XXXXButtonTypeLinkButton = 7,  // 文字带下划线的按钮
};


/**
 按钮点击后的回调Block

 @param btn 被点击的按钮实例引用
 */
typedef void (^XXXXButtonBlock)(id btn);


#pragma mark - < Class Define >


@interface XXXXButton : UIButton <XXXXViewProtocal>

/** 主题风格对象，每个控件必须持有 */
@property (nonatomic, strong) XXXXAppTheme * theme;

/** 按钮类型 */
@property (nonatomic, assign) XXXXButtonType type;

@property (nonatomic , copy) XXXXButtonBlock block;

/** 按下时是否显示点击效果（透明度0.7），默认NO */
@property (nonatomic, assign) BOOL enableTouchEffest;

#pragma mark - < Generate Methods >


/** 快速创建一个指定风格的按钮 */
+ (instancetype)buttonWithType:(XXXXButtonType)type;
+ (instancetype)buttonWithType:(XXXXButtonType)type theme:(XXXXAppTheme *)theme;
/** 快速创建一个指定风格的按钮, 不需要设的可以不设 */
+ (instancetype)buttonWithType:(XXXXButtonType)type
                          text:(NSString *)aText;
+ (instancetype)buttonWithType:(XXXXButtonType)type
                          text:(NSString *)aText
                       onPress:(XXXXButtonBlock)block;
+ (instancetype)buttonWithType:(XXXXButtonType)type
                         theme:(XXXXAppTheme *)theme
                          text:(NSString *)aText
                       onPress:(XXXXButtonBlock)block;

- (instancetype)init;
- (instancetype)initWithTheme:(XXXXAppTheme *)theme;


#pragma mark - < Interface Methods >

/** 改变按钮的风格 */
- (void)changeButtonType:(XXXXButtonType)type;

/** 使用Block定义按钮事件 */
- (void)onPressBlock:(XXXXButtonBlock)block;

/** 设置按钮的显示文字 */
- (void)setButtonText:(NSString *)aText;
- (void)setButtonText:(NSString *)aText onPressBlock:(XXXXButtonBlock)block;
- (void)setButtonText:(NSString *)aText
                font:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight;
/** 便捷方法：设置按钮的属性 */
- (void)setButtonText:(NSString *)aText
                font:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight
             onPress:(XXXXButtonBlock)block;
- (void)setButtonFont:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight
             onPress:(XXXXButtonBlock)block;
- (void)setButtonFont:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight;

/**
 *  设置按钮的可拉伸的背景
 */
- (void)setStretchBackground:(UIImage *)aNormalImage
                  hightLight:(UIImage *)aHightLightImage
                disableImage:(UIImage *)disableImage;

/** 设置按钮的前景图片 */
- (void)setButtonImageWithNormalImage:(UIImage *)normalImage
                       highlightImage:(UIImage *)highlightImage
                        selectedImage:(UIImage *)selectedImage
                         disableImage:(UIImage *)disableImage;

/** 设置按钮的背景图片 */
- (void)setButtonBackImageWithNormalImage:(UIImage *)normalImage
                           highlightImage:(UIImage *)highlightImage
                            selectedImage:(UIImage *)selectedImage
                             disableImage:(UIImage *)disableImage;

/**
 *  设置按钮的纯色前景
 */
- (void)setButtonColor:(UIColor *)aNormalColor
       hightLightColor:(UIColor *)aHightLightColor
     disableImageColor:(UIColor *)disableColor;

/**
 *  设置按钮的纯色背景
 */
- (void)setButtonBackgroundColor:(UIColor *)aNormalColor
                 hightLightColor:(UIColor *)aHightLightColor
               disableImageColor:(UIColor *)disableColor;


@end
