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

+ (instancetype)LayoutWithFrame:(CGRect)frame direction:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align{
    FlexLinearLayout * layout = [[FlexLinearLayout alloc] initWithFrame:frame];
    layout.flexDirection = direction;
    layout.justityContent = content;
    layout.alignItems = align;
    return layout;
}

+ (instancetype)LayoutWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align{
    return [FlexLinearLayout LayoutWithFrame:CGRectZero direction:direction justityContent:content alignItems:align];
}

- (instancetype)initWithDirection:(FlexDirection)direction justityContent:(FlexJustityContent)content alignItems:(FlexAlignItems)align{
    if ( self = [super initWithFrame:CGRectZero] ) {
        self.flexDirection = direction;
        self.justityContent = content;
        self.alignItems = align;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame] ) {
        self.isTestMode = NO;
    }
    return self;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
        
    }
    return self;
}

- (void)dealloc{
    [self.flex_subViews removeAllObjects];
}


#pragma mark - < Interface >

- (void)layoutSubviews {
    //    NSLog(@"[FlexLayout] call layoutSubViews %@", self);
    
    // param check
    if ([self.flex_subViews count] <= 0) {
        return;
    }
    
    if (_flexDirection == FlexDirection_row) {
        [self _layoutRow];
    } else {
        [self _layoutColumn];
    }
    
    // layout subLayout
    for (UIView *viewItem in self.flex_subViews) {
        if ([viewItem isKindOfClass:[FlexLinearLayout class]]) {
            [(FlexLinearLayout *)viewItem layoutSubviews];
        }
    }
    
#pragma mark testMode
    // testMode
    if (_isTestMode) {
        for (UIView *viewItem in self.flex_subViews) {
            if ([viewItem isKindOfClass:[FlexLinearLayout class]]) {
                ((FlexLinearLayout *)viewItem).isTestMode = YES;
            }
            viewItem.backgroundColor = XXXX_RANDOM_COLOR();
        }
    }
}

//- (CGFloat)adjustOffset:(CGFloat)offset {
//    NSInteger multiple = offset * 10;
//    NSInteger mod = multiple % 5;
//    
//    return (multiple - mod) / 10.0;
//}
//
//
//- (void)setView:(UIView *)view withFrame:(CGRect)frame {
//    
//    CGFloat x = CGRectGetMinX(frame);
//    CGFloat y = CGRectGetMinY(frame);
//    CGFloat width = CGRectGetWidth(frame);
//    CGFloat height = CGRectGetHeight(frame);
//    
//    x = [self adjustOffset:x];
//    y = [self adjustOffset:y];
//    width = [self isLine:width] ? XXXX_SIZE_LINE : [self adjustOffset:width];
//    height = [self isLine:height] ? XXXX_SIZE_LINE : [self adjustOffset:height];
//    
//    view.frame = CGRectMake(x, y, width, height);
//}



- (void)adjustLayoutSizeBySubviews{
    [self adjustLayoutHeightBySubviews];
    [self adjustLayoutWidthBySubviews];
}

- (void)adjustLayoutHeightBySubviews{
    CGFloat heightOfLayout = 0;
    // If the direction of the layout is row , use the most-height-one's height as the layout's height
    if (_flexDirection == FlexDirection_row) {
        for (UIView *subview in self.flex_subViews) {
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            if (subview.flex_totalHeigh > heightOfLayout) {
                heightOfLayout = subview.flex_totalHeigh;
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
            
            heightOfLayout += subview.flex_totalHeigh;
        }
    }
    
    // add padding
    heightOfLayout += self.paddingTop;
    heightOfLayout += self.paddingBottom;
    
    CGRect frame = self.frame;
    
    frame.size.height = [self isLine:heightOfLayout] ? XXXX_SIZE_LINE : roundf(heightOfLayout);
    self.frame = frame;
//    [self setView:self withFrame:frame];
    
    self.flex_layoutHeigh = [self isLine:heightOfLayout] ? XXXX_SIZE_LINE : roundf(heightOfLayout);
}

- (void)adjustLayoutWidthBySubviews{
    CGFloat widthOfLayout = 0;
    // If the direction of the layout is column , use the most-height-one's height as the layout's height
    if (_flexDirection == FlexDirection_column) {
        for (UIView *subview in self.flex_subViews) {
            // skip the hidden-view
            if (subview.hidden == YES) {
                continue;
            }
            
            if (subview.flex_totalWidth > widthOfLayout) {
                widthOfLayout = subview.flex_totalWidth;
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
            
            widthOfLayout += subview.flex_totalWidth;
        }
    }
    
    // add padding
    widthOfLayout += self.paddingLeft;
    widthOfLayout += self.paddingRight;
    
    CGRect frame = self.frame;
    
    frame.size.width = [self isLine:widthOfLayout] ? XXXX_SIZE_LINE : roundf(widthOfLayout);
    self.frame = frame;
//    [self setView:self withFrame:frame];
    
    self.flex_layoutWidth = [self isLine:widthOfLayout] ? XXXX_SIZE_LINE : roundf(widthOfLayout);
}

- (void)attachView:(UIView *)parentView {
    self.frame = parentView.bounds;
    [parentView addSubview:self];
}

- (void)flex_addSubview:(UIView *)view{
    [self.flex_subViews addObject:view];
    [self addSubview:view];
}

- (void)flex_insertSubView:(UIView *)view atIndex:(NSInteger)index{
    [self.flex_subViews insertObject:view atIndex:index];
    [self insertSubview:view atIndex:index];
}

- (void)flex_insertSubView:(UIView *)view aboveSubview:(UIView *)subview{
    NSInteger subViewIndex = [self.flex_subViews indexOfObject:subview];
    subViewIndex ++;
    if (subViewIndex < 0 || subViewIndex > self.flex_subViews.count - 1) {
        return [self flex_addSubview:view];
    }
    [self.flex_subViews insertObject:view atIndex:subViewIndex];
    [self insertSubview:view aboveSubview:subview];
}

- (void)flex_insertSubView:(UIView *)view belowSubview:(UIView *)subview{
    NSInteger subViewIndex = [self.flex_subViews indexOfObject:subview];
//    subViewIndex ++;
    if (subViewIndex < 0 || subViewIndex > self.flex_subViews.count - 1) {
        return [self flex_addSubview:view];
    }
    [self.flex_subViews insertObject:view atIndex:subViewIndex];
    [self insertSubview:view belowSubview:subview];
}

- (void)flex_removeSubview:(UIView *)subView{
    [self.flex_subViews removeObject:subView];
    [subView removeFromSuperview];
}

- (void)flex_removeSubviewAtIndex:(NSInteger)index{
    UIView *subview = [self.flex_subViews objectAtIndex:index];
    [self flex_removeSubview:subview];
}

- (void)flex_clearSubviews{
    for (NSInteger i = self.flex_subViews.count - 1 ; i >= 0 ; i -- ) {
        UIView *subView = [self.flex_subViews objectAtIndex:i];
        [self flex_removeSubview:subView];
    }
}

- (void)setPaddingTop:(CGFloat)paddingTop left:(CGFloat)paddingLeft right:(CGFloat)paddingRight bottom:(CGFloat)paddingBottom{
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


#pragma mark - < layout methods >

- (void)_layoutRow{
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
        //        top = _y + viewItem.flex_marginTop;
        width = viewItem.flex_layoutWidth;
        heigh = viewItem.flex_layoutHeigh;
        
        // Adjust by AlignItems
#pragma mark Adjust by AlignItems<row>
        switch (_alignItems) {
            case FlexAlignItems_flexStart: {
                top = _y + viewItem.flex_marginTop;
                break;
            }
            case FlexAlignItems_flexEnd: {
                top = self.layoutHeigh - viewItem.flex_layoutHeigh - viewItem.flex_marginBottom - self.paddingBottom;
                break;
            }
            case FlexAlignItems_center: {
                top = (self.layoutHeigh - viewItem.flex_layoutHeigh) / 2 + viewItem.flex_marginTop;
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
                top = self.layoutHeigh - viewItem.flex_layoutHeigh - viewItem.flex_marginBottom - self.paddingBottom;
                break;
            }
            case FlexAlignSelf_center: {
                top = (self.layoutHeigh - viewItem.flex_layoutHeigh) / 2;
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
        width = ([self isLine:width]) ? XXXX_SIZE_LINE : roundf(width);
        heigh = ([self isLine:heigh]) ? XXXX_SIZE_LINE : roundf(heigh);
        viewItem.frame = CGRectMake(roundf(left), roundf(top), width, heigh);
//        [self setView:viewItem withFrame:CGRectMake(left, top, width, heigh)];
        
        //NSLog(@"%@ {x=%.2f,y=%.2f,w=%.2f,h=%.2f}", viewItem, left, top, width, heigh);
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
        heigh = viewItem.flex_layoutHeigh;
        
        // Adjust by AlignItems
#pragma mark Adjust by AlignItems<Column>
        switch (_alignItems) {
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
        
        
        // Adjust by JustityContent-spacePadding
#pragma mark Adjust by JustityContent-spacePadding<Column>
        if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceBetween) {
            top = _y; // spaceBetween do not consider the mergin on the flexDirection,return the normal scroll y back to origin value
            _y = _y + _spacePadding + viewItem.flex_layoutHeigh;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAround) {
            top = _y + _spacePadding;
            _y = _y + _spacePadding * 2 + viewItem.flex_layoutHeigh;
        }else if (_spacePadding != 0 && self.justityContent == FlexJustityContent_spaceAverage) {
            top = _y + _spacePadding;
            _y = _y + _spacePadding + viewItem.flex_layoutHeigh;
        }else if ( viewItem == [self.flex_subViews lastObject] && self.justityContent == FlexJustityContent_stretch && _y < self.layoutHeigh) {
            heigh = self.layoutHeigh - top - viewItem.flex_marginBottom - self.paddingBottom;
            _y += viewItem.flex_totalHeigh;
        }else if ( _spacePadding > 0 && self.justityContent == FlexJustityContent_flex ) {
            heigh = _spacePadding * (viewItem.flex_flex / totalFlex);
            top = _y + viewItem.flex_marginTop;
            _y += (viewItem.flex_marginTop + heigh + viewItem.flex_marginBottom);
        } else {
            _y += viewItem.flex_totalHeigh;
        }
        
        // set frame finally
        width = ([self isLine:width]) ? XXXX_SIZE_LINE : roundf(width);
        heigh = ([self isLine:heigh]) ? XXXX_SIZE_LINE : roundf(heigh);
        viewItem.frame = CGRectMake(roundf(left), roundf(top), width, heigh);
//        [self setView:viewItem withFrame:CGRectMake(left, top, width, heigh)];
    }
}


- (BOOL)isLine: (CGFloat) length{
    if (length >= 0.3 && length < 0.6) {//0.334) {
        return YES;
    }
    return NO;
}

#pragma mark - < Lazy initialize & Getter/Setter >

- (NSMutableArray<UIView *> *)flex_subViews{
    if (!_flex_subViews) {
        _flex_subViews = [NSMutableArray arrayWithCapacity:10];
    }
    return _flex_subViews;
}

- (CGFloat)layoutWidth {
    return self.frame.size.width;
}

- (CGFloat)layoutHeigh {
    return self.frame.size.height;
}

- (void)setFlexDirection:(FlexDirection)flexDirection{
    _flexDirection = flexDirection;
    [self layoutSubviews];
}

- (void)setJustityContent:(FlexJustityContent)justityContent{
    _justityContent = justityContent;
    [self layoutSubviews];
}

- (void)setAlignItems:(FlexAlignItems)alignItems{
    _alignItems = alignItems;
    [self layoutSubviews];
}

#pragma mark - < Private methods >

- (CGFloat)_subViewsTotalWidth{
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

- (CGFloat)_subViewsTotalHeigh{
    CGFloat totalHeigh = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalHeigh += viewItem.flex_totalHeigh;
    }
    return totalHeigh;
}

- (CGFloat)_subViewsTotalMarginWidth{
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

- (CGFloat)_subViewsTotalMarginHeight{
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

- (CGFloat)_subViewsTotalFlex{
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

- (CGFloat)_subViewsTotalWidthWithoutMargin{
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

- (CGFloat)_subViewsTotalHeighWithoutMargin{
    CGFloat totalHeigh = 0;
    for (UIView *viewItem in self.flex_subViews) {
        // skip the hidden-view
        if (viewItem.hidden == YES) {
            continue;
        }
        totalHeigh += viewItem.flex_layoutHeigh;
    }
    return totalHeigh;
}

@end
