//
//  FlexLayout.h
//  TestProj
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+FlexLayout.h"
#import "FlexlayoutMacro.h"
#import "FlexScrollLayout.h"
#import "FlexLinearLayout.h"

@interface FlexLayout : NSObject

#pragma mark - < Factory methods >

/**
 *  Common init method , return a FlexLinearLayout
 */
+ (FlexLinearLayout *)LinearLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align;
+ (FlexLinearLayout *)LinearLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align;

/**
 *  Scrollable factory methods
 */
+ (FlexScrollLayout *)ScrollLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align;
+ (FlexScrollLayout *)ScrollLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align;


#pragma mark - < Static methods >

/**
 *  Check if a view is a FlexLayout
 *  <p>
 *  检查一个View是否是FlexLayout
 */
+ (BOOL)isFlexLayout:(UIView *)view;

/**
 *  Check if px value is in a line's range in screen
 *  <p>
 *  检查一个象素值是否是能在屏幕上显示为一条线
 */
+ (BOOL)isLinePx:(CGFloat)length;

/**
 *  Update the root layout of a layout hierarchy
 *  <p>
 *  更新一个View的最上层Layout
 */
+ (void)updateRootLayout:(UIView *)view;


#pragma mark - < Interface Members >

@property (nonatomic, strong) NSMutableArray<UIView *> *flex_subViews;
@property (nonatomic, weak) UIView *delegateView;

@property (nonatomic, assign) FlexDirection flexDirection;
@property (nonatomic, assign) FlexJustityContent justityContent;
@property (nonatomic, assign) FlexAlignItems alignItems;

@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) CGFloat paddingLeft;
@property (nonatomic, assign) CGFloat paddingBottom;
@property (nonatomic, assign) CGFloat paddingRight;

/**
 *  If isTestMode is YES, the layout will draw all the subViews a random color
 */
@property (nonatomic, assign) BOOL isTestMode;



#pragma mark - < Interface Methods >

/**
 *  adjust the size of the layout by its flex_subviews
 *  <p>
 *  根据Layout的子View调整Layout的大小
 */
- (void)adjustLayoutSizeBySubviews;
- (void)adjustLayoutHeightBySubviews;
- (void)adjustLayoutWidthBySubviews;

/**
 *  estimate the width of the layout by its flex_subviews
 *  <p>
 *  根据Layout的子View估算Layout的宽
 */
- (CGFloat)estimateLayoutWidthBySubviews;

/**
 *  estimate the height of the layout by its flex_subviews
 *  <p>
 *  根据Layout的子View估算Layout的高
 */
- (CGFloat)estimateLayoutHeightBySubviews;

/**
 *  Add a subView in the layout. Use this method to replace the addSubview method
 */
- (void)flex_addSubview:(UIView *)view;
- (void)flex_insertSubView:(UIView *)view atIndex:(NSInteger)index;
- (void)flex_insertSubView:(UIView *)view aboveSubview:(UIView *)subview;
- (void)flex_insertSubView:(UIView *)view belowSubview:(UIView *)subview;

/** remove a subView from the layout */
- (void)flex_removeSubview:(UIView *)subview;
- (void)flex_removeSubviewAtIndex:(NSInteger)index;

/** remove all the subViews from the layout */
- (void)flex_clearSubviews;

/**
 设置 layout的 Padding 内边距，参数为数组。 <p>
 Usage:                                   <br>
 [view setPadding:@[@(1)]]                 <br>
 [view setPadding:@[@(1),@(2)]]            <br>
 [view setPadding:@[@(1),@(1),@(1),@(1)]]  <br>
 
 @param setPadding 当参数数组为一个值时，此padding设为所有边的padding；2个值时，第一个设为水平方向两边的padding，第二个为垂直方向两边的padding；为4个值时分别为“左上右下（顺时针）”四个方向的边距
 */
- (void)setPadding:(NSArray<NSNumber *> *)padding;
- (void)setPaddingTop:(CGFloat)paddingTop
                 left:(CGFloat)paddingLeft
                right:(CGFloat)paddingRight
               bottom:(CGFloat)paddingBottom;

@end
