//
//  XXXXAppTheme.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/13.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXAppTheme.h"



#pragma mark - < 子类实现 >



@implementation XXXXAppFontStyle

//@synthesize h1 = _h1;
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _h1 = XXXX_SYS_FONT(15);   // 如果需要改BaseStyle的属性的示例
//    }
//    return self;
//}

@end

@implementation XXXXAppColorStyle

- (instancetype)init {
    if (self = [super init]) {
        _demoSectionBg = XXXX_COLOR_HEX(0xe7e7e7);
        _demoCategoryBg = XXXX_COLOR_HEX(0xf7f7f7);
        _demoControllerBg = [UIColor whiteColor];
    }
    return self;
}

@end

@implementation XXXXAppDimensionStyle

@end


#pragma mark - < 主类实现 >

@implementation XXXXAppTheme

- (instancetype)init {
    self = [super init];
    if (self) {
        _fontStyle = [XXXXAppFontStyle new];
        _colorStyle = [XXXXAppColorStyle new];
        _dimensionStyle = [XXXXAppDimensionStyle new];
    }
    return self;
}

- (void)switchAppThemeWithComplete:(void (^)(void))block{
    UIView *rootView = APP_DELEGATE.window.rootViewController.view;
    [self walkToChangeTheme:self ofView:rootView];
    if (block) {
        block();
    }
}

- (void)walkToChangeTheme:(XXXXAppTheme *)theme ofView:(UIView *)view {
    if ([view respondsToSelector:@selector(setTheme:)]) {
        [view performSelector:@selector(setTheme:) withObject:theme];
    }
    if (view.subviews.count > 0) {
        for (UIView * viewItem in view.subviews) {
            [self walkToChangeTheme:theme ofView:viewItem];
        }
    }
}

@end
