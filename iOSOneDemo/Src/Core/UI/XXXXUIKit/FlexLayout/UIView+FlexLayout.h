//
//  UIView+FlexLayout.h
//  TestProj
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlexlayoutMacro.h"



@interface UIView (FlexLayout)

/**
 *  The layout size of the view.
 */
@property (nonatomic , assign) CGFloat flex_layoutWidth;
@property (nonatomic , assign) CGFloat flex_layoutHeigh;

/**
 *  The total size calculate by layoutSize and marginSize
 */
@property (nonatomic , readonly, assign) CGFloat flex_totalWidth;
@property (nonatomic , readonly, assign) CGFloat flex_totalHeigh;

/**
 当参数数组为一个值时，此margin设为所有边的Margin；2个值时，第一个设为水平方向两边的Margin，第二个为垂直方向两边的Margin；为4个值时分别为“左上右下（顺时针）”四个方向的边距
 example:
 
 - view.flex_margin = @[@(1)]
 - view.flex_margin = @[@(1),@(2)]
 - view.flex_margin = @[@(1),@(1),@(1),@(1)]
 */
@property (nonatomic , copy) NSArray<NSNumber *> *flex_margin;
/**
 *  Margin is the distance between two views.
 */
@property (nonatomic , assign) CGFloat flex_marginTop;
@property (nonatomic , assign) CGFloat flex_marginLeft;
@property (nonatomic , assign) CGFloat flex_marginBottom;
@property (nonatomic , assign) CGFloat flex_marginRight;

/**
 *  Set the inset of the text (mainly in label/button)
 */
@property (nonatomic , assign) CGFloat flex_textInsetHorizon;
@property (nonatomic , assign) CGFloat flex_textInsetVertical;

/**
 *  Set the flex-rate of the view when the layout's JustContent is FlexJustityContent_flex
 */
@property (nonatomic , assign) CGFloat flex_flex;

@property (nonatomic , assign) FlexAlignSelf flex_alignSelf;


#pragma mark - < Interface Methods >

/**
 *  Common init method category by flexLayout
 */
+ (instancetype)viewWithFlexSize:(CGSize)aSize;
- (instancetype)initWithFlexSize:(CGSize)aSize;

@property (nonatomic , assign) CGSize flexSize;
- (void)setFlexSize:(CGSize)aSize;


/**
 更新布局（如果布局内控件发生改变时，如Label长度发生变化等）
 */
- (void)flex_updateLayout;

/**
 设置 View的 Margin边距，参数为数组。 <p>
 Usage:                                   <br>
 [view setMargin:@[@(1)]]                 <br>
 [view setMargin:@[@(1),@(2)]]            <br>
 [view setMargin:@[@(1),@(1),@(1),@(1)]]  <br>
 
 @param marginValue 当参数数组为一个值时，此margin设为所有边的Margin；2个值时，第一个设为水平方向两边的Margin，第二个为垂直方向两边的Margin；为4个值时分别为“左上右下（顺时针）”四个方向的边距
 */
- (void)setFlexMargin:(NSArray<NSNumber *> *)marginValue;
/** Set the margin of the view */
- (void)setFlexMarginTop:(CGFloat)marginTop
                    left:(CGFloat)marginLeft
                   right:(CGFloat)marginRight
                  bottom:(CGFloat)marginBottom;

/**
 *  estimate the flex-layout-height of the given text,( often use in label or button );
 */
- (CGFloat)flex_estimateWidthWithContent;
- (CGFloat)flex_estimateHeightWithContent;

/**
 *  estimate the flex-layout-width of the given text,( often use in label or button );
 */
- (CGFloat)flex_estimateTotalWithContent;
- (CGFloat)flex_estimateTotalHeightWithContent;


@end
