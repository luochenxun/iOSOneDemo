//
//  FlexLinearLayout.m
//
//  Created by luochenxun on 16/5/9.
//  Copyright © 2016年 luochenxun. All rights reserved.
//

#import "FlexLinearLayout.h"

@interface FlexLinearLayout () {
    CGFloat _x;
    CGFloat _y;
    CGFloat _spacePadding;
}

#pragma mark - < Private Members >

@property(nonatomic, readonly) CGFloat layoutWidth;
@property(nonatomic, readonly) CGFloat layoutHeigh;

@end

@implementation FlexLinearLayout


#pragma mark - < Life circle >

+ (instancetype)LayoutWithFrame:(CGRect)frame direction:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align
{
    FlexLinearLayout * layout = [[FlexLinearLayout alloc] initWithDirection:direction justityContent:content alignItems:align];
    return layout;
}

+ (instancetype)LayoutWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align
{
    return [FlexLinearLayout LayoutWithFrame:CGRectZero direction:direction justityContent:content alignItems:align];
}

- (instancetype)initWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align
{
    if ( self = [super initWithFrame:CGRectZero] ) {
        self.concreteLayout = [FlexLayout new];
        self.concreteLayout.delegateView = self;
        self.concreteLayout.flexDirection = direction;
        self.concreteLayout.justityContent = content;
        self.concreteLayout.alignItems = align;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        self.isTestMode = NO;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero]) {
        
    }
    return self;
}

- (void)dealloc
{
    [self.flex_subViews removeAllObjects];
}


#pragma mark - < Interface >

- (void)flex_updateLayout
{
    //    NSLog(@"[FlexLayout] call layoutSubViews %@", self);
    
    // param check
    if ([self.flex_subViews count] <= 0) {
        return;
    }
    
    if (self.flexDirection == FlexDirection_row) {
        [self _layoutRow];
    } else {
        [self _layoutColumn];
    }
 
#pragma mark testMode
    // testMode
    if (self.isTestMode) {
        for (UIView *viewItem in self.flex_subViews) {
            if ([FlexLayout isFlexLayout:viewItem]) {
                [viewItem setValue:@YES forKey:@"isTestMode"];
            }
            
        }
        self.backgroundColor = XXXX_RANDOM_COLOR();
    }
    
    // layout subLayout
    for (UIView *viewItem in self.flex_subViews) {
        if ([FlexLayout isFlexLayout:viewItem] && [viewItem respondsToSelector:@selector(flex_updateLayout)]) {
            [viewItem performSelector:@selector(flex_updateLayout)];
        }
    }
}

- (void)attachView:(UIView *)parentView {
    self.frame = parentView.bounds;
    [parentView addSubview:self];
}

#pragma mark - < layout methods >

- (void)_layoutRow
{
    // init position
    _x = self.paddingLeft;
    _y = self.paddingTop;
    _spacePadding = 0;
    CGFloat totalFlex = 0;
    
    // Adjust by JustityContent
#pragma mark Adjust by JustityContent-calculate<row>
    if ([self _subViewsTotalWidthWithoutMargin] <= self.layoutWidth ) {
        switch (self.justityContent) {
            case FlexJustityContent_flexStart: {
                // default
                break;
            }
            case FlexJustityContent_flexEnd: {
                _x = self.layoutWidth - self.paddingRight - [self _subViewsTotalWidth];
                break;
            }
            case FlexJustityContent_center: {
                _x = (self.layoutWidth - [self _subViewsTotalWidth]) / 2;
                break;
            }
            case FlexJustityContent_spaceBetween: {
                _spacePadding = (self.layoutWidth - self.paddingLeft - self.paddingRight - [self _subViewsTotalWidthWithoutMargin]) / ([self.flex_subViews count] - 1)?:1;
                _x = self.paddingLeft;
                break;
            }
            case FlexJustityContent_spaceAround: {
                _spacePadding = (self.layoutWidth - self.paddingLeft - self.paddingRight - [self _subViewsTotalWidthWithoutMargin]) / ([self.flex_subViews count] * 2)?:1;
                _x = self.paddingLeft;
                break;
            }
            case FlexJustityContent_spaceAverage: {
                _spacePadding = (self.layoutWidth - self.paddingLeft - self.paddingRight - [self _subViewsTotalWidthWithoutMargin]) / ([self.flex_subViews count] + 1);
                _x = self.paddingLeft;
                break;
            }
            case FlexJustityContent_stretch:{
                // do nothing, we just stretch the last item
                break;
            }
            case FlexJustityContent_flex:{
                _spacePadding = (self.layoutWidth - self.paddingLeft - self.paddingRight - [self _subViewsTotalMarginWidth]);
                _x = self.paddingLeft;
                totalFlex = [self _subViewsTotalFlex];
                break;
            }
        }
    }
    
    // walk and layout the subViews
    for (UIView *viewItem in self.flex_subViews) {
        
        if (viewItem.hidden) {
            continue;
        }
        
        CGFloat left , top , width , heigh;
                
        // normal alignment
        left = _x + viewItem.flex_marginLeft;
        width = viewItem.flex_layoutWidth;
        heigh = viewItem.flex_layoutHeight;
        
        // Adjust by AlignItems
#pragma mark Adjust by AlignItems<row>
        switch (self.alignItems) {
            case FlexAlignItems_flexStart: {
                top = _y + viewItem.flex_marginTop;
                break;
            }
            case FlexAlignItems_flexEnd: {
                top = self.layoutHeigh - viewItem.flex_layoutHeight - viewItem.flex_marginBottom - self.paddingBottom;
                break;
            }
            case FlexAlignItems_center: {
                top = (self.layoutHeigh - viewItem.flex_layoutHeight) / 2 + viewItem.flex_marginTop;
                break;
            }
            case FlexAlignItems_stretch: {
                top = self.paddingTop + viewItem.flex_marginTop;
                heigh = self.layoutHeigh - self.paddingTop - self.paddingBottom - viewItem.flex_marginTop - viewItem.flex_marginBottom;
                break;
            }
        }
        
        // Adjust by AlignSelf
#pragma mark Adjust by AlignSelf<row>
        switch (viewItem.flex_alignSelf) {
            case FlexAlignSelf_none:{
                break;
            }
            case FlexAlignSelf_flexStart: {
                top = _y + viewItem.flex_marginTop;
                break;
            }
            case FlexAlignSelf_flexEnd: {
                top = self.layoutHeigh - viewItem.flex_layoutHeight - viewItem.flex_marginBottom - self.paddingBottom;
                break;
            }
            case FlexAlignSelf_center: {
                top = (self.layoutHeigh - viewItem.flex_layoutHeight) / 2;
                break;
            }
            case FlexAlignSelf_stretch: {
                top = viewItem.flex_marginTop;
                heigh = self.layoutHeigh - viewItem.flex_marginTop - viewItem.flex_marginBottom;
                break;
            }
        }
        
        // Adjust by JustityContent-spacePadding
#pragma mark Adjust by JustityContent-spacePadding<row>
        if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceBetween) {
            left = _x; // spaceBetween do not consider the mergin on the flexDirection
            _x = _x + _spacePadding + viewItem.flex_layoutWidth;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAround) {
            left = _x + _spacePadding;
            _x = _x + _spacePadding * 2 + viewItem.flex_layoutWidth;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAverage) {
            left = _x + _spacePadding;
            _x = _x + _spacePadding + viewItem.flex_layoutWidth;
        }else if ( viewItem == [self.flex_subViews lastObject] && self.justityContent == FlexJustityContent_stretch && _x < self.layoutWidth) {
            width = self.layoutWidth - left - viewItem.flex_marginRight - self.paddingRight;
            _x += viewItem.flex_totalWidth;
        }else if ( _spacePadding > 0 && self.justityContent == FlexJustityContent_flex ) {
            width = _spacePadding * (viewItem.flex_flex / totalFlex);
            left = _x + viewItem.flex_marginLeft;
            _x += (viewItem.flex_marginRight + width + viewItem.flex_marginLeft);
        }else {
            _x += viewItem.flex_totalWidth;
        }
        
        
        // set frame finally
        width = ([FlexLayout isLinePx:width]) ? XXXX_SIZE_LINE : roundf(width);
        heigh = ([FlexLayout isLinePx:heigh]) ? XXXX_SIZE_LINE : roundf(heigh);
        viewItem.frame = CGRectMake(roundf(left), roundf(top), width, heigh);
        
        if ([viewItem isKindOfClass:[UILabel class]]) {
            [viewItem sizeToFit];
        }
    }
}

- (void)_layoutColumn{
    // init position
    _x = self.paddingLeft;
    _y = self.paddingTop;
    _spacePadding = 0;
    CGFloat totalFlex = 0;
    
    // Adjust by JustityContent
#pragma mark Adjust by JustityContent-calculate<column>
    if ([self _subViewsTotalHeighWithoutMargin] <= self.layoutHeigh ) {
        switch (self.justityContent) {
            case FlexJustityContent_flexStart: {
                // default
                break;
            }
            case FlexJustityContent_flexEnd: {
                _y = self.layoutHeigh - self.paddingBottom - [self _subViewsTotalHeigh];
                break;
            }
            case FlexJustityContent_center: {
                _y = (self.layoutHeigh - [self _subViewsTotalHeigh]) / 2;
                break;
            }
            case FlexJustityContent_spaceBetween: {
                _spacePadding = (self.layoutHeigh - self.paddingTop - self.paddingBottom - [self _subViewsTotalHeighWithoutMargin]) / ([self.flex_subViews count] - 1)?:1;
                _y = self.paddingTop;
                break;
            }
            case FlexJustityContent_spaceAround: {
                _spacePadding = (self.layoutHeigh - self.paddingTop - self.paddingBottom - [self _subViewsTotalHeighWithoutMargin]) / ([self.flex_subViews count] * 2)?:1;
                _y = self.paddingTop;
                break;
            }
            case FlexJustityContent_spaceAverage:{
                _spacePadding = (self.layoutHeigh - self.paddingTop - self.paddingBottom - [self _subViewsTotalHeighWithoutMargin]) / ([self.flex_subViews count] + 1);
                _y = self.paddingTop;
                break;
            }
            case FlexJustityContent_stretch:{
                // do nothing
                break;
            }
            case FlexJustityContent_flex:{
                _spacePadding = (self.layoutHeigh - self.paddingTop - self.paddingBottom - [self _subViewsTotalMarginHeight]);
                _y = self.paddingTop;
                totalFlex = [self _subViewsTotalFlex];
                break;
            }
        }
    }
    
    // walk and layout the subViews
    for (UIView *viewItem in self.flex_subViews) {
        
        if (viewItem.hidden) {
            continue;
        }
        
        CGFloat left , top , width , heigh;
        
        // normal alignment
        top = _y + viewItem.flex_marginTop;
        width = viewItem.flex_layoutWidth;
        heigh = viewItem.flex_layoutHeight;
        
        // Adjust by AlignItems
#pragma mark Adjust by AlignItems<Column>
        switch (self.alignItems) {
            case FlexAlignItems_flexStart: {
                left = _x + viewItem.flex_marginLeft;
                break;
            }
            case FlexAlignItems_flexEnd: {
                left = self.layoutWidth - viewItem.flex_layoutWidth - viewItem.flex_marginRight - self.paddingRight;
                break;
            }
            case FlexAlignItems_center: {
                left = (self.layoutWidth - viewItem.flex_layoutWidth) / 2 + viewItem.flex_marginLeft + self.paddingLeft;
                break;
            }
            case FlexAlignItems_stretch: {
                left = self.paddingLeft + viewItem.flex_marginLeft;
                width = self.layoutWidth - self.paddingLeft - self.paddingRight - viewItem.flex_marginLeft - viewItem.flex_marginRight;
                break;
            }
        }
        
        // Adjust by AlignSelf
#pragma mark Adjust by AlignSelf<Column>
        switch (viewItem.flex_alignSelf) {
            case FlexAlignSelf_none:{
                break;
            }
            case FlexAlignSelf_flexStart: {
                left = _x + viewItem.flex_marginLeft;
                break;
            }
            case FlexAlignSelf_flexEnd: {
                left = self.layoutWidth - viewItem.flex_layoutWidth - viewItem.flex_marginRight - self.paddingRight;
                break;
            }
            case FlexAlignSelf_center: {
                left = (self.layoutWidth - viewItem.flex_layoutWidth) / 2;
                break;
            }
            case FlexAlignSelf_stretch: {
                left = viewItem.flex_marginLeft;
                width = self.layoutWidth - viewItem.flex_marginLeft - viewItem.flex_marginRight;
                break;
            }
        }
        
        // --- Update the rootLayout when it has a subView that need to be render twice
        // optimize toward label
        if ([viewItem isKindOfClass:[UILabel class]]) {
            CGFloat viewItemTempWidth = viewItem.flex_layoutWidth;
            viewItem.flex_layoutWidth = width;
            heigh = viewItem.flex_layoutHeight;
            // 更新父容器
            if (roundf(viewItemTempWidth) != roundf(width)) {
                [FlexLayout updateRootLayout:viewItem];
                return;
            }
        }
        
        // adjust flexLayout's size
        if ([FlexLayout isFlexLayout:viewItem] && width == 0) {
            width = [(FlexLayout *)[viewItem valueForKey:@"concreteLayout"] estimateLayoutWidthBySubviews];
        }
        if ([FlexLayout isFlexLayout:viewItem] && heigh == 0) {
            heigh = [(FlexLayout *)[viewItem valueForKey:@"concreteLayout"] estimateLayoutHeightBySubviews];
            _y += heigh;
        }
        
        // Adjust by JustityContent-spacePadding
#pragma mark Adjust by JustityContent-spacePadding<Column>
        if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceBetween) {
            top = _y; // spaceBetween do not consider the mergin on the flexDirection,return the normal scroll y back to origin value
            _y = _y + _spacePadding + viewItem.flex_layoutHeight;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAround) {
            top = _y + _spacePadding;
            _y = _y + _spacePadding * 2 + viewItem.flex_layoutHeight;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAverage) {
            top = _y + _spacePadding;
            _y = _y + _spacePadding + viewItem.flex_layoutHeight;
        }else if ( viewItem == [self.flex_subViews lastObject] && self.justityContent == FlexJustityContent_stretch && _y < self.layoutHeigh) {
            heigh = self.layoutHeigh - top - viewItem.flex_marginBottom - self.paddingBottom;
            _y += viewItem.flex_totalHeight;
        }else if ( _spacePadding > 0 && self.justityContent == FlexJustityContent_flex ) {
            heigh = _spacePadding * (viewItem.flex_flex / totalFlex);
            top = _y + viewItem.flex_marginTop;
            _y += (viewItem.flex_marginTop + heigh + viewItem.flex_marginBottom);
        } else {
            _y += viewItem.flex_totalHeight;
        }
        
        // set frame finally
        width = ([FlexLayout isLinePx:width]) ? XXXX_SIZE_LINE : roundf(width);
        heigh = ([FlexLayout isLinePx:heigh]) ? XXXX_SIZE_LINE : roundf(heigh);
        viewItem.frame = CGRectMake(roundf(left), roundf(top), width, heigh);
        
        if ([viewItem isKindOfClass:[UILabel class]]) {
            [viewItem sizeToFit];
        }
    }
}


#pragma mark - < FlexLayout agent methods >

- (NSMutableArray<UIView *> *)flex_subViews{
    return _concreteLayout.flex_subViews;
}

- (FlexDirection)flexDirection
{
    return _concreteLayout.flexDirection;
}

- (void)setFlexDirection:(FlexDirection)flexDirection
{
    _concreteLayout.flexDirection = flexDirection;
}

- (FlexJustityContent)justityContent
{
    return _concreteLayout.justityContent;
}

- (void)setJustityContent:(FlexJustityContent)justityContent
{
    _concreteLayout.justityContent = justityContent;
}

- (FlexAlignItems)alignItems
{
    return _concreteLayout.alignItems;
}

- (void)setAlignItems:(FlexAlignItems)alignItems
{
    _concreteLayout.alignItems = alignItems;
}


- (CGFloat)paddingTop
{
    return _concreteLayout.paddingTop;
}

- (void)setPaddingTop:(CGFloat)paddingTop
{
    _concreteLayout.paddingTop = paddingTop;
}

- (CGFloat)paddingLeft
{
    return _concreteLayout.paddingLeft;
}

- (void)setPaddingLeft:(CGFloat)paddingLeft
{
    _concreteLayout.paddingLeft = paddingLeft;
}

- (CGFloat)paddingRight
{
    return _concreteLayout.paddingRight;
}

- (void)setPaddingRight:(CGFloat)paddingRight
{
    _concreteLayout.paddingRight = paddingRight;
}

- (CGFloat)paddingBottom
{
    return _concreteLayout.paddingBottom;
}

- (void)setPaddingBottom:(CGFloat)paddingBottom
{
    _concreteLayout.paddingBottom = paddingBottom;
}

- (void)setPaddingTop:(CGFloat)paddingTop left:(CGFloat)paddingLeft right:(CGFloat)paddingRight bottom:(CGFloat)paddingBottom
{
    self.paddingLeft = paddingLeft;
    self.paddingTop = paddingTop;
    self.paddingRight = paddingRight;
    self.paddingBottom = paddingBottom;
}

- (void)setPadding:(NSArray<NSNumber *> *)padding {
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

- (BOOL)isTestMode
{
    return _concreteLayout.isTestMode;
}

- (void)setIsTestMode:(BOOL)isTestMode
{
    _concreteLayout.isTestMode = isTestMode;
}


- (void)adjustLayoutSizeBySubviews
{
    [_concreteLayout adjustLayoutSizeBySubviews];
}

- (void)adjustLayoutHeightBySubviews
{
    [_concreteLayout adjustLayoutHeightBySubviews];
}

- (CGFloat)estimateLayoutHeightBySubviews
{
    return [_concreteLayout estimateLayoutHeightBySubviews];
}

- (void)adjustLayoutWidthBySubviews
{
    [_concreteLayout adjustLayoutWidthBySubviews];
}

- (CGFloat)estimateLayoutWidthBySubviews
{
    return [_concreteLayout estimateLayoutWidthBySubviews];
}

- (void)flex_addSubview:(UIView *)view
{
    [_concreteLayout flex_addSubview:view];
}

- (void)flex_insertSubView:(UIView *)view atIndex:(NSInteger)index
{
    [_concreteLayout flex_insertSubView:view atIndex:index];
}

- (void)flex_insertSubView:(UIView *)view aboveSubview:(UIView *)subview
{
    [_concreteLayout flex_insertSubView:view aboveSubview:subview];
}

- (void)flex_insertSubView:(UIView *)view belowSubview:(UIView *)subview
{
    [_concreteLayout flex_insertSubView:view belowSubview:subview];
}

- (void)flex_removeSubview:(UIView *)subView
{
    [_concreteLayout flex_removeSubview:subView];
}

- (void)flex_removeSubviewAtIndex:(NSInteger)index
{
    [_concreteLayout flex_removeSubviewAtIndex:index];
}

- (void)flex_clearSubviews
{
    [_concreteLayout flex_clearSubviews];
}


#pragma mark - < Private methods >

- (CGFloat)layoutHeigh
{
    if (self.flex_layoutHeight > 0) {
        return self.flex_layoutHeight;
    }
    else if (self.frame.size.height > 0) {
        return self.frame.size.height;
    }
    else {
        return [self estimateLayoutHeightBySubviews];
    }
}

- (CGFloat)layoutWidth
{
    if (self.flex_layoutWidth > 0) {
        return self.flex_layoutWidth;
    }
    else if (self.frame.size.width > 0) {
        return self.frame.size.width;
    }
    else {
        return [self estimateLayoutWidthBySubviews];
    }
}

- (CGFloat)_subViewsTotalWidth
{
    CGFloat totalWidth = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalWidth += viewItem.flex_totalWidth;
    }
    return totalWidth;
}

- (CGFloat)_subViewsTotalHeigh
{
    CGFloat totalHeigh = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalHeigh += viewItem.flex_totalHeight;
    }
    return totalHeigh;
}

- (CGFloat)_subViewsTotalMarginWidth
{
    CGFloat totalMargin = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalMargin += (viewItem.flex_marginLeft + viewItem.flex_marginRight);
    }
    return totalMargin;
}

- (CGFloat)_subViewsTotalMarginHeight
{
    CGFloat totalMargin = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalMargin += (viewItem.flex_marginTop + viewItem.flex_marginBottom);
    }
    return totalMargin;
}

- (CGFloat)_subViewsTotalFlex
{
    CGFloat totalFlex = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalFlex += (viewItem.flex_flex);
    }
    return totalFlex;
}

- (CGFloat)_subViewsTotalWidthWithoutMargin
{
    CGFloat totalWidth = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalWidth += viewItem.flex_layoutWidth;
    }
    return totalWidth;
}

- (CGFloat)_subViewsTotalHeighWithoutMargin
{
    CGFloat totalHeigh = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalHeigh += viewItem.flex_layoutHeight;
    }
    return totalHeigh;
}

@end
