//
//  FlexLayout.m
//  TestProj
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import "FlexLayout.h"

@interface FlexLayout ()

@end

@implementation FlexLayout

#pragma mark - < Life circle >

+ (FlexLinearLayout *)LinearLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align
{
    FlexLinearLayout *wrapperLayout =
    [FlexLinearLayout LayoutWithFrame:frame direction:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexLinearLayout *)LinearLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align
{
    FlexLinearLayout *wrapperLayout =
    [FlexLinearLayout LayoutWithDirection:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexScrollLayout *)ScrollLayoutWithDirection:(FlexDirection)direction
                                 justityContent:(FlexJustityContent)content
                                     alignItems:(FlexAlignItems)align
{
    FlexScrollLayout *wrapperLayout =
    [FlexScrollLayout LayoutWithDirection:direction justityContent:content alignItems:align];
    return wrapperLayout;
}

+ (FlexScrollLayout *)ScrollLayoutWithFrame:(CGRect)frame
                                  direction:(FlexDirection)direction
                             justityContent:(FlexJustityContent)content
                                 alignItems:(FlexAlignItems)align
{
    FlexScrollLayout *wrapperLayout =
    [FlexScrollLayout LayoutWithFrame:frame direction:direction justityContent:content alignItems:align];
    return wrapperLayout;
}


#pragma mark - < Static methods >

+ (BOOL)isFlexLayout:(UIView *)view
{
    if ([view isKindOfClass:[FlexLinearLayout class]]) {
        return YES;
    }
    else if ([view isKindOfClass:[FlexScrollLayout class]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isLinePx:(CGFloat)length
{
    if (length >= 0.3 && length < 0.6) { // 2x、3x 单象素大小
        return YES;
    }
    return NO;
}

+ (void)updateRootLayout:(UIView *)view
{
    UIView *parent = view.superview;
    UIView *rootLayout = nil;
    while (parent && ![parent isKindOfClass:[UIWindow class]]) {
        if ([FlexLayout isFlexLayout:parent]) {
            rootLayout = parent;
        }
        parent = parent.superview;
    }
    if (rootLayout) {
        [rootLayout performSelector:@selector(flex_updateLayout)];
    }
}

#pragma mark - < Interface >

- (void)adjustLayoutSizeBySubviews
{
    [self adjustLayoutHeightBySubviews];
    [self adjustLayoutWidthBySubviews];
}

- (void)adjustLayoutHeightBySubviews
{
    CGFloat heightOfLayout = [self estimateLayoutHeightBySubviews];
    
    CGRect frame = _delegateView.frame;
    frame.size.height = [FlexLayout isLinePx:heightOfLayout] ? XXXX_SIZE_LINE : roundf(heightOfLayout);
    _delegateView.frame = frame;
    
    _delegateView.flex_layoutHeigh = [FlexLayout isLinePx:heightOfLayout] ? XXXX_SIZE_LINE : roundf(heightOfLayout);
}

- (CGFloat)estimateLayoutHeightBySubviews
{
    CGFloat heightOfLayout = 0;
    // If the direction of the layout is row , use the most-height-one's height as the layout's height
    if (_flexDirection == FlexDirection_row) {
        for (UIView *subview in self.flex_subViews) {
            heightOfLayout = _delegateView.frame.size.height ?: _delegateView.flex_layoutHeigh;
            
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            CGFloat childHeight = 0;
            if (subview.flex_totalHeigh > 0) {
                childHeight = subview.flex_totalHeigh;
            } else if ([FlexLayout isFlexLayout:subview]) {
                childHeight = [(FlexLayout *)[subview valueForKey:@"concreteLayout"] estimateLayoutHeightBySubviews];
            }
            childHeight = (childHeight + _paddingTop + _paddingBottom);
            
            if (childHeight > heightOfLayout) {
                heightOfLayout = childHeight;
            }
        }
    }
    // If the direction of the layout is column , add up all the subview's height as the layout's height
    else {
        for (UIView *subview in self.flex_subViews) {
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            CGFloat childHeight = 0;
            if (subview.flex_totalHeigh > 0) {
                childHeight = subview.flex_totalHeigh;
            } else if ([FlexLayout isFlexLayout:subview]) {
                childHeight = [(FlexLayout *)[subview valueForKey:@"concreteLayout"] estimateLayoutHeightBySubviews];
            }
            
            heightOfLayout += childHeight;
        }
        heightOfLayout = (heightOfLayout + _paddingTop + _paddingBottom);
    }
    
    return roundf(heightOfLayout);
}

- (void)adjustLayoutWidthBySubviews
{
    CGFloat widthOfLayout = [self estimateLayoutWidthBySubviews];
    
    CGRect frame = _delegateView.frame;
    frame.size.width = [FlexLayout isLinePx:widthOfLayout] ? XXXX_SIZE_LINE : roundf(widthOfLayout);
    _delegateView.frame = frame;
    
    _delegateView.flex_layoutWidth = [FlexLayout isLinePx:widthOfLayout] ? XXXX_SIZE_LINE : roundf(widthOfLayout);
}

- (CGFloat)estimateLayoutWidthBySubviews
{
    CGFloat widthOfLayout = 0;
    
    // If the direction of the layout is column , use the most-height-one's height as the layout's height
    if (_flexDirection == FlexDirection_column) {
        widthOfLayout = _delegateView.frame.size.width ?: _delegateView.flex_layoutWidth;
        for (UIView *subview in self.flex_subViews) {
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            CGFloat childWidth = 0;
            if (subview.flex_totalWidth > 0) {
                childWidth = subview.flex_totalWidth;
            } else if ([FlexLayout isFlexLayout:subview]) {
                childWidth = [(FlexLayout *)[subview valueForKey:@"concreteLayout"] estimateLayoutWidthBySubviews];
            }
            childWidth = (childWidth + _paddingLeft + _paddingRight);
            
            if (childWidth > widthOfLayout) {
                widthOfLayout = childWidth;
            }
        }
    }
    // If the direction of the layout is row , add up all the subview's height as the layout's height
    else {
        for (UIView *subview in self.flex_subViews) {
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            CGFloat childWidth = 0;
            if (subview.flex_totalWidth > 0) {
                childWidth = subview.flex_totalWidth;
            } else if ([FlexLayout isFlexLayout:subview]) {
                childWidth = [(FlexLayout *)[subview valueForKey:@"concreteLayout"] estimateLayoutWidthBySubviews];
            }
            
            widthOfLayout += childWidth;
        }
        widthOfLayout = (widthOfLayout + _paddingLeft + _paddingRight);
    }
    
    return roundf(widthOfLayout);
}

- (void)flex_addSubview:(UIView *)view
{
    [self.flex_subViews addObject:view];
    [_delegateView addSubview:view];
}

- (void)flex_insertSubView:(UIView *)view atIndex:(NSInteger)index
{
    [self.flex_subViews insertObject:view atIndex:index];
    [_delegateView insertSubview:view atIndex:index];
}

- (void)flex_insertSubView:(UIView *)view aboveSubview:(UIView *)subview
{
    NSInteger subViewIndex = [self.flex_subViews indexOfObject:subview];
    subViewIndex ++;
    if (subViewIndex < 0 || subViewIndex > self.flex_subViews.count - 1) {
        return [self flex_addSubview:view];
    }
    [self.flex_subViews insertObject:view atIndex:subViewIndex];
    [_delegateView insertSubview:view aboveSubview:subview];
}

- (void)flex_insertSubView:(UIView *)view belowSubview:(UIView *)subview
{
    NSInteger subViewIndex = [self.flex_subViews indexOfObject:subview];
    if (subViewIndex < 0 || subViewIndex > self.flex_subViews.count - 1) {
        return [self flex_addSubview:view];
    }
    [self.flex_subViews insertObject:view atIndex:subViewIndex];
    [_delegateView insertSubview:view belowSubview:subview];
}

- (void)flex_removeSubview:(UIView *)subView
{
    [self.flex_subViews removeObject:subView];
    [subView removeFromSuperview];
}

- (void)flex_removeSubviewAtIndex:(NSInteger)index
{
    UIView *subview = [self.flex_subViews objectAtIndex:index];
    [self flex_removeSubview:subview];
}

- (void)flex_clearSubviews
{
    for (NSInteger i = self.flex_subViews.count - 1 ; i >= 0 ; i -- ) {
        UIView *subView = [self.flex_subViews objectAtIndex:i];
        [self flex_removeSubview:subView];
    }
}

- (void)setPaddingTop:(CGFloat)paddingTop left:(CGFloat)paddingLeft right:(CGFloat)paddingRight bottom:(CGFloat)paddingBottom
{
    self.paddingLeft = paddingLeft;
    self.paddingTop = paddingTop;
    self.paddingRight = paddingRight;
    self.paddingBottom = paddingBottom;
}

- (void)setPadding:(NSArray<NSNumber *> *)padding
{
    // param check
    if (!padding || padding.count < 1) {
        return ;
    }
    
    if (padding.count == 1) {
        CGFloat paddingF = [padding[0] floatValue];
        [self setPaddingTop:paddingF left:paddingF right:paddingF bottom:paddingF];
    }
    
    if (padding.count == 2) {
        CGFloat paddingHorizon = [padding[0] floatValue];
        CGFloat paddingVertical = [padding[1] floatValue];
        [self setPaddingTop:paddingVertical left:paddingHorizon right:paddingHorizon bottom:paddingVertical];
    }
    
    if (padding.count == 4) {
        self.paddingLeft = [padding[0] floatValue];
        self.paddingTop = [padding[1] floatValue];
        self.paddingRight = [padding[2] floatValue];
        self.paddingBottom = [padding[3] floatValue];
    }
}

#pragma mark - < Lazy Initialization >

- (NSMutableArray<UIView *> *)flex_subViews
{
    if (!_flex_subViews) {
        _flex_subViews = [NSMutableArray arrayWithCapacity:10];
    }
    return _flex_subViews;
}

@end
