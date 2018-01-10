//
//  XXXXHTMLLabel.m
//  jiayoubao
//
//  Created by luochenxun on 2017/11/29.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXHTMLLabel.h"

@interface XXXXHTMLLabel()

@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, strong) UIColor *labelColor;

@end

@implementation XXXXHTMLLabel

- (void)setText:(NSString *)text{
    [self setText:text font:self.labelFont color:self.labelColor];
}

- (void)setText:(NSString *)text
           font:(UIFont *)font
          color:(UIColor *)color {
    if (font) {
        _labelFont = font;
    }
    
    if (color) {
        _labelColor = color;
    }
    
    if (!text || text.length == 0) {
        self.attributedText = nil;
        return ;
    }
    
    @try {
        NSString *colorStr = [NSString stringWithFormat:@"<font color=%@>%@</font>",[kAppTheme hexWithColor:self.labelColor], text];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[colorStr dataUsingEncoding:NSUnicodeStringEncoding]
                                                                                     options:@{
                                                                                               NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType
                                                                                               }
                                                                          documentAttributes:nil
                                                                                       error:nil];
        [attrStr addAttribute:NSFontAttributeName value:self.labelFont range:NSMakeRange(0, attrStr.length)];
        self.attributedText = attrStr;
    } @catch (NSException *exception) {
        self.text = nil;
    }
    
   
}

# pragma mark - < Getter/Setter >

- (UIFont *)labelFont {
    if (_labelFont == nil) {
        _labelFont = kAppFont.h5;
    }
    return _labelFont;
}

- (UIColor *)labelColor {
    if (_labelColor == nil) {
        _labelColor = kAppColor.h2;
    }
    return _labelColor;
}

@end
