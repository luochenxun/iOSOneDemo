//
// XXXXLinkButton.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXLinkButton.h"

@implementation XXXXLinkButton

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [self setButtonFont:kAppFont.h5
                  textColor:kAppColor.s2
              textHighlight:XXXX_COLOR_HEX(0x0000cc)];
    }
    return self;
}

- (void)setButtonText:(NSString *)aText
                font:(UIFont *)aFont
           textColor:(UIColor *)aTextColor
       textHighlight:(UIColor *)aTextHighlight
             onPress:(XXXXButtonBlock)block {
    
    [super setButtonText:aText font:aFont textColor:aTextColor textHighlight:aTextHighlight onPress:block];
    
    if (aText.length > 0) {
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:aText];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName
                      value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSFontAttributeName value:aFont range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:aTextColor range:titleRange];
        [self setAttributedTitle:title
                        forState:UIControlStateNormal];
        [self setAttributedTitle:title
                        forState:UIControlStateHighlighted];
    }
}

@end
