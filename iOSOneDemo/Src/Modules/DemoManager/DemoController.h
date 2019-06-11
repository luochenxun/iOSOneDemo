//
// DemoController.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXBaseViewController.h"

@interface DemoController : XXXXBaseViewController


@property (nonatomic, strong) FlexScrollLayout *outerBox;

/** 给当前Demo增加一个展示区域 */
- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title;
- (FlexLinearLayout *)addDemoBoxWithTitle:(NSString *)title
                                     size:(CGSize)size;

/** 给指定DemoBox添加一条分隔线 */
- (UIView *)addDividerOnView:(UIView *)view;
- (UIView *)addDividerOnView:(UIView *)view withMargin:(NSArray<NSNumber *> *)margin;

/** 给指定DemoBox添加一段文字描述 */
- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text;
- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text color:(UIColor *)color;
- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text margin:(NSArray<NSNumber *> *)margin;
- (XXXXLabel *)addDescriptionOnView:(UIView *)view withText:(NSString *)text color:(UIColor *)color margin:(NSArray<NSNumber *> *)margin;

/** 给指定DemoBox添加一个按钮 */
- (XXXXButton *)addButtonOnView:(UIView *)view withText:(NSString *)text block:(XXXXButtonBlock)block;

/** 给指定View添加一个显示Title的Label */
- (XXXXLabel *)addLabelOnView:(UIView *)view withText:(NSString *)title;
- (XXXXLabel *)addLabelOnView:(UIView *)view withText:(NSString *)title color:(UIColor *)color;




@end
