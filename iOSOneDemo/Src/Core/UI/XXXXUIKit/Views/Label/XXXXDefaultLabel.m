//
//  XXXXDefaultLabel.m
//  jiayoubao
//
//  Created by luochenxun on 2017/7/7.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//

#import "XXXXDefaultLabel.h"

@implementation XXXXDefaultLabel

- (void)setText:(NSString *)text{
    if (text.length == 0) {
        [super setText:text];
        return;
    }
    
    if(self.numberOfLines != 1) { // 对于多行文本，默认使用 0.5 倍的行间距
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paraStyle.alignment = self.textAlignment;
        // 设置行间距 (默认0.5倍行间距)
        if (self.lineSpace != 0) {
            paraStyle.lineSpacing = self.lineSpace;
        } else {
            // 公式：行间距离 = 字体高fontSize * 行间距倍数 - (字体高fontSize / 10) * 2
            //
            //        A
            //  ---------------
            //      fontPadding = fontSize / 10
            //  ===============
            //      lineSpace
            //  ================
            //      fontPadding = fontSize / 10
            //  ---------------
            //       B
            //
            // 公式如上图所示，设计图行间距由 fontPadding * 2 + lineSpace组成，所以 lineSpace = 设计图行间距 - fontPadding * 2
            CGFloat fontSize = self.font.pointSize;
            paraStyle.lineSpacing = (self.multipleOfLineSpace - 0.2) * fontSize; // 化简得此公式
        }
        NSDictionary *dic = @{
                              NSFontAttributeName:self.font,
                              NSForegroundColorAttributeName:self.textColor,
                              NSParagraphStyleAttributeName:paraStyle
                              };
        
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
        self.attributedText = attributeStr;
    }else{
        [super setText:text];
    }
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:numberOfLines];
    
    [self setText:self.text];
}

@end
