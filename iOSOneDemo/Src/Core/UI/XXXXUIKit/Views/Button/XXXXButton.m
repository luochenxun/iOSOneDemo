//
//  XXXXButton.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/23.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXButton.h"
#import "XXXXDefaultButton.h"
#import "XXXXSecondaryButton.h"
#import "XXXXImageButton.h"
#import "XXXXTextButton.h"
#import "XXXXCheckbox.h"
#import "XXXXLinkButton.h"

@implementation XXXXButton


- (instancetype)init{
    return [self initWithTheme:nil];
}

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super init]) {
        if(theme) {
            _theme = theme;
        }else{
            _theme = kAppTheme;
        }
        [self addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


+ (instancetype)buttonWithType:(XXXXButtonType)type{
    return [XXXXButton buttonWithType:type theme:nil];
}

+ (instancetype)buttonWithType:(XXXXButtonType)type theme:(XXXXAppTheme *)theme{
    XXXXButton *button = nil;
        switch (type) {
        case XXXXButtonTypeDefault: {
            button = [[XXXXDefaultButton alloc] initWithTheme:theme];
            break;
        }
        case XXXXButtonTypeSecondary: {
            button = [[XXXXSecondaryButton alloc] initWithTheme:theme];
            break;
        }
        case XXXXButtonTypeFloatButton:{
            
        }
        case XXXXButtonTypeTextButton: {
            button = [[XXXXTextButton alloc] initWithTheme:theme];
            break;
        }
        case XXXXButtonTypeImageButton: {
            button = [[XXXXImageButton alloc] initWithTheme:theme];
            break;
        }
        case XXXXButtonTypeCheckbox: {
            button = [[XXXXCheckbox alloc] initWithTheme:theme];
            break;
        }
        case XXXXButtonTypeLinkButton: {
            button = [[XXXXLinkButton alloc] initWithTheme:theme];
            break;
        }
        default: {
            button = [[XXXXDefaultButton alloc] initWithTheme:theme];
            break;
        }
    }
    
    button.type = type;
    return button;
}


+ (instancetype)buttonWithType:(XXXXButtonType)type
                          text:(NSString *)aText{
    return [self buttonWithType:type
                          theme:nil
                           text:aText
                        onPress:nil];
}

+ (instancetype)buttonWithType:(XXXXButtonType)type
                          text:(NSString *)aText
                       onPress:(XXXXButtonBlock)block{
    return [self buttonWithType:type
                          theme:nil
                           text:aText
                        onPress:block];
}

+ (instancetype)buttonWithType:(XXXXButtonType)type
                         theme:(XXXXAppTheme *)theme
                          text:(NSString *)aText
                       onPress:(XXXXButtonBlock)block{
    XXXXButton *button = [XXXXButton buttonWithType:type theme:theme];
    button.type = type;
    [button setButtonText:aText onPressBlock:block];
    return button;
}

#pragma mark - < Interface Method >

- (void)changeButtonType:(XXXXButtonType)type{
    _type = type;
    switch (type) {
        case XXXXButtonTypeDefault: {
            [XXXXDefaultButton resetUIOfButton:self];
            break;
        }
        case XXXXButtonTypeSecondary: {
            [XXXXSecondaryButton resetUIOfButton:self];
            break;
        }
        default:
            return ;
    }
}

- (void)onPressBlock:(XXXXButtonBlock)block{
    self.block = block;
}

- (void)setButtonText:(NSString *)aText{
    [self setButtonText:aText font:nil textColor:nil textHighlight:nil onPress:nil];
}

- (void)setButtonText:(NSString *)aText onPressBlock:(XXXXButtonBlock)block{
    [self setButtonText:aText font:nil textColor:nil textHighlight:nil onPress:block];
}

- (void)setButtonText:(NSString *)aText
                font:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight{
    [self setButtonText:aText font:aFont textColor:aTextColor textHighlight:aTextHighlight onPress:nil];
}

- (void)setButtonText:(NSString *)aText
                font:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight
             onPress:(XXXXButtonBlock)block{
    if(aFont) self.titleLabel.font = aFont;
    if(aTextColor) [self setTitleColor:aTextColor forState:UIControlStateNormal];
    if(aTextColor) [self setTitleColor:aTextColor forState:UIControlStateDisabled];
    if(aTextHighlight) [self setTitleColor:aTextHighlight forState:UIControlStateHighlighted];
    if (aText) {
        [self setTitle:aText forState:UIControlStateNormal];
        [self setTitle:aText forState:UIControlStateHighlighted];
        [self setTitle:aText forState:UIControlStateDisabled];
    }
    if (block) {
        [self onPressBlock:block];
    }
}

- (void)setButtonFont:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight
             onPress:(XXXXButtonBlock)block {
    [self setButtonText:nil font:aFont textColor:aTextColor textHighlight:aTextHighlight onPress:block];
}

- (void)setButtonFont:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight{
   [self setButtonFont:aFont textColor:aTextColor textHighlight:aTextHighlight onPress:nil];
}

/**
 *  设置按钮的可拉伸的背景
 */
- (void)setStretchBackground:(UIImage *)aNormalImage
                  hightLight:(UIImage *)aHightLightImage
                disableImage:(UIImage *)disableImage{
    // 拉伸Image
    if(aNormalImage) {
        UIImage *buttonBackgroundImage = [aNormalImage
                                          stretchableImageWithLeftCapWidth:floorf(aNormalImage.size.width / 2)
                                          topCapHeight:floorf(aNormalImage.size.height / 2)];
        [self setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    }
    
    if(aHightLightImage) {
        UIImage * buttonBackgroundImage = [aHightLightImage
                                           stretchableImageWithLeftCapWidth:floorf(aHightLightImage.size.width / 2)
                                           topCapHeight:floorf(aHightLightImage.size.height / 2)];
        [self setBackgroundImage:buttonBackgroundImage forState:UIControlStateHighlighted];
    }
    
    // disable
    if(disableImage) {
        UIImage *buttonBackgroundImage = [disableImage
                                          stretchableImageWithLeftCapWidth:floorf(disableImage.size.width / 2)
                                          topCapHeight:floorf(disableImage.size.height / 2)];
        [self setBackgroundImage:buttonBackgroundImage forState:UIControlStateDisabled];
    }
}

- (void)setButtonImageWithNormalImage:(UIImage *)normalImage
                       highlightImage:(UIImage *)highlightImage
                        selectedImage:(UIImage *)selectedImage
                         disableImage:(UIImage *)disableImage{
    if(normalImage) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if(highlightImage) {
        [self setImage:highlightImage forState:UIControlStateHighlighted];
    }
    if(selectedImage) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
    if(disableImage) {
        [self setImage:disableImage forState:UIControlStateDisabled];
    }
}

- (void)setButtonBackImageWithNormalImage:(UIImage *)normalImage
                           highlightImage:(UIImage *)highlightImage
                            selectedImage:(UIImage *)selectedImage
                             disableImage:(UIImage *)disableImage{
    if(normalImage) {
        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    }
    if(highlightImage) {
        [self setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    }
    if(selectedImage) {
        [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    }
    if(disableImage) {
        [self setBackgroundImage:disableImage forState:UIControlStateDisabled];
    }
}

/**
 *  设置按钮的纯色背景
 */
- (void)setButtonColor:(UIColor *)aNormalColor
       hightLightColor:(UIColor *)aHightLightColor
     disableImageColor:(UIColor *)disableColor{
    [self setButtonImageWithNormalImage:[self imageWithColor:aNormalColor size:self.flexSize]
                         highlightImage:[self imageWithColor:aHightLightColor size:self.flexSize]
                          selectedImage:[self imageWithColor:aHightLightColor size:self.flexSize]
                           disableImage:[self imageWithColor:disableColor size:self.flexSize]];
}

- (void)setButtonBackgroundColor:(UIColor *)aNormalColor
                 hightLightColor:(UIColor *)aHightLightColor
               disableImageColor:(UIColor *)disableColor{
    [self setButtonBackImageWithNormalImage:[self imageWithColor:aNormalColor size:self.flexSize]
                             highlightImage:[self imageWithColor:aHightLightColor size:self.flexSize]
                              selectedImage:[self imageWithColor:aHightLightColor size:self.flexSize]
                               disableImage:[self imageWithColor:disableColor size:self.flexSize]];
}

#pragma mark - < 透明点击效果 >

- (void)setEnableTouchEffest:(BOOL)touchEnable
{
    _enableTouchEffest = touchEnable;
    if (!touchEnable)
    {
        [self removeTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self removeTarget:self action:@selector(onTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self removeTarget:self action:@selector(onTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
        [self removeTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        [self addTarget:self action:@selector(onTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
        [self addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)onTouchDown:(UIControl *)sender
{
    self.alpha = 0.7;
    self.highlighted = YES;
}


- (void)onTouchCancel:(UIControl *)sender
{
    self.alpha = 1;
    self.highlighted = NO;
}

- (void)onTouchUpInside:(UIControl *)sender
{
    self.alpha = 1;
    self.highlighted = NO;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event])
    {
        return self;
    }
    
    return [super hitTest:point withEvent:event];;
}


#pragma mark - < Private Method >

- (void)buttonTarget:(XXXXButton *)button {
    if(self.block) {
        dispatch_main_async_safe(^{
            self.block(button);
        });
    }
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    // param check
    if(!color) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
