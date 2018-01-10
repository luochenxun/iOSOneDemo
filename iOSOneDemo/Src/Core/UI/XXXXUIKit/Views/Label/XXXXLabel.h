//
//  XXXXLabel.h
//  jiayoubao
//
//  Created by luochenxun on 2017/6/28.
//  Copyright © 2017年 jiayoubao. All rights reserved.
//
//    Label 套件
//
//    Usage：
//    XXXXLabel *label = [XXXXLabel labelWithType:XXXXLabelTypeDefault
//                                       text:@"tet"
//                                       font:kAppTheme.fontStyle.h5
//                                      color:kAppTheme.colorStyle.h2];
//    label.multipleOfLineSpace = 1.0; // 指定1倍行间距


#import <UIKit/UIKit.h>
#import "XXXXViewProtocal.h"


/**
 系统支持的按钮风格
 */
typedef NS_ENUM(NSInteger,XXXXLabelType) {
    XXXXLabelTypeDefault = 1,     // 默认样式按钮
    XXXXLabelTypeHTML  = 2,       // 显示HTML的Label
};


/**
 可以控制Label竖直对齐
 */
typedef NS_ENUM(NSInteger,XXXXLabelVerticalAlignment) {
    XXXXLabelVerticalAlignmentMiddle = 0, // default
    XXXXLabelVerticalAlignmentTop,
    XXXXLabelVerticalAlignmentBottom,
};


@interface XXXXLabel : UILabel <XXXXViewProtocal>


#pragma mark - < properties >


/** 主题风格对象，每个控件必须持有 */
@property (nonatomic , strong) XXXXBaseTheme * theme;


/**
 可以控制Label内文字竖直方向的对齐
 */
@property (nonatomic , assign) XXXXLabelVerticalAlignment verticalAlignment;


/** 行间距(距离，pt为单位, 默认为0使用行间距倍数multipleOfLineSpace，不为0时以lineSpace为准) */
@property (nonatomic , assign) CGFloat lineSpace;

/** 行间距(单行的倍数，默认为0.5倍行距) */
@property (nonatomic , assign) CGFloat multipleOfLineSpace;


#pragma mark - < Interface >


/** 快速创建一个指定风格的按钮 */
+ (instancetype)labelWithType:(XXXXLabelType)type;
/** 快速创建一个指定风格的按钮, 不需要设的可以不设 */
+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText;
+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText
                         font:(UIFont *)font;
+ (instancetype)labelWithType:(XXXXLabelType)type
                         text:(NSString *)aText
                         font:(UIFont *)font
                        color:(UIColor *)color;

- (void)setText:(NSString *)text
           font:(UIFont *)font
          color:(UIColor *)color;

@end
