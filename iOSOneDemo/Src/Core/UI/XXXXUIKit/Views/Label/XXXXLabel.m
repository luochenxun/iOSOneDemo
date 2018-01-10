//
//  XXXXLabel.m
//  jiayoubao
//
//  Created by luochenxun on 2017/6/28.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXLabel.h"
#import "XXXXDefaultLabel.h"
#import "XXXXHTMLLabel.h"

@implementation XXXXLabel

/** 快速创建一个指定风格的按钮 */
+ (instancetype)labelWithType:(XXXXLabelType)type{
    return [XXXXLabel labelWithType:type
                             text:nil
                             font:nil
                            color:nil];
}

+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText{
    return [XXXXLabel labelWithType:type
                             text:aText
                             font:nil
                            color:nil];
}

+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText
                         font:(UIFont *)font{
    return [XXXXLabel labelWithType:type
                             text:aText
                             font:font
                            color:nil];
}

+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText
                         font:(UIFont *)font
                        color:(UIColor *)color{
    
    XXXXLabel * label = nil;
    
    switch (type) {
        case XXXXLabelTypeDefault:{
            label = [[XXXXDefaultLabel alloc] initWithTheme:kAppTheme];
        }
            break;
        case XXXXLabelTypeHTML:{
            label = [[XXXXHTMLLabel alloc] initWithTheme:kAppTheme];
        }
            break;
        default:
            label = [[XXXXLabel alloc] initWithTheme:kAppTheme];
            break;
    }
    
    [label setText:aText font:font color:color];
    
    return label;
}

- (instancetype)init{
    if (self = [super init]) {
        self.verticalAlignment = XXXXLabelVerticalAlignmentMiddle;
        self.lineSpace = 0.0;
        self.multipleOfLineSpace = 0.5;
    }
    return self;
}


#pragma mark - < XXXXViewProtocal >

- (instancetype)initWithTheme:(XXXXAppTheme *)theme {
    if (self = [self init]) {
        self.theme = theme;
    }
    return self;
}

/** 设置控件的主题 */
- (void)setTheme:(XXXXAppTheme *)theme {
    _theme = theme;
}

#pragma mark - < Interface >

- (void)setLineSpace:(CGFloat)lineSpace{
    _lineSpace = lineSpace;
    if([self isKindOfClass:XXXXDefaultLabel.class] && self.text.length > 0) {
        [(XXXXDefaultLabel *)self setText:self.text];
    }
}

- (void)setMultipleOfLineSpace:(CGFloat)multipleOfLineSpace {
    _multipleOfLineSpace = multipleOfLineSpace;
    if([self isKindOfClass:XXXXDefaultLabel.class] && self.text.length > 0) {
        [(XXXXDefaultLabel *)self setText:self.text];
    }
}

- (void)setText:(NSString *)text
          font:(UIFont *)font
         color:(UIColor *)color{
    if(text) self.text = text;
    if(font) self.font = font;
    if(color) self.textColor = color;
}

- (void)setVerticalAlignment:(XXXXLabelVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case XXXXLabelVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case XXXXLabelVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case XXXXLabelVerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
