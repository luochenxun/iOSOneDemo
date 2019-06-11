//
// FlexLinearLayout.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIView+FlexLayout.h"

@class FlexLayout;

@interface FlexLinearLayout : UIView


#pragma mark - < Interface Members >

@property(nonatomic, strong) FlexLayout *concreteLayout;

@property(nonatomic, assign) FlexDirection flexDirection;
@property(nonatomic, assign) FlexJustityContent justityContent;
@property(nonatomic, assign) FlexAlignItems alignItems;

@property(nonatomic, assign) CGFloat paddingTop;
@property(nonatomic, assign) CGFloat paddingLeft;
@property(nonatomic, assign) CGFloat paddingBottom;
@property(nonatomic, assign) CGFloat paddingRight;

/**
 *  If isTestMode is YES, the layout will draw all the subViews a random color
 */
@property(nonatomic, assign) BOOL isTestMode;


#pragma mark - < Init Methods >

/**
 *  Common init method
 */
+ (instancetype)LayoutWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align;
+ (instancetype)LayoutWithFrame:(CGRect)frame direction:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align;
- (instancetype)initWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align;


#pragma mark - < Interface Methods >

/**
 *  Attach the layout with a given view. Usually to the view of a viewController.
 */
- (void)attachView:(UIView *)parentView;

/**
 *  Update the layout of all flex_subviews
 *  <p>
 *  更新Layout容器内的所有子View
 */
- (void)flex_updateLayout;

/**
 *  adjust the size of the layout by its flex_subviews
 */
- (void)adjustLayoutSizeBySubviews;
/**  adjust the height of the layout by its flex_subviews */
- (void)adjustLayoutHeightBySubviews;
/**  adjust the width of the layout by its flex_subviews */
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
