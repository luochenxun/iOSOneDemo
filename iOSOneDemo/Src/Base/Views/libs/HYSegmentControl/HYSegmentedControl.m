//
// HYSegmentedControl.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "HYSegmentedControl.h"

#define HYSegmentedControl_Height 40.0
#define HYSegmentedControl_Width ([UIScreen mainScreen].bounds.size.width)
#define Min_Width_4_Button 80.0

#define Define_Tag_add 1000

#define UIColorFromRGBValue(rgbValue)                                                                                  \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
                    alpha:1.0]
                    
@interface HYSegmentedControl ()

@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) NSMutableArray *array4Btn;
@property(strong, nonatomic) UIImageView *bottomLineView;

@end

@implementation HYSegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithOriginY:(CGFloat)y Titles:(NSArray *)titles delegate:(id)delegate {
    CGRect rect4View = CGRectMake(.0f, y, HYSegmentedControl_Width, HYSegmentedControl_Height);
    if (self = [super initWithFrame:rect4View]) {
    
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        [self setUserInteractionEnabled:YES];
        
        self.delegate = delegate;
        
        //
        //  array4btn
        //
        _array4Btn = [[NSMutableArray alloc] initWithCapacity:[titles count]];
        
        //
        //  set button
        //
        CGFloat width4btn = rect4View.size.width / [titles count];
        if (width4btn < Min_Width_4_Button) {
            width4btn = Min_Width_4_Button;
        }
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.contentSize = CGSizeMake([titles count] * width4btn, HYSegmentedControl_Height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        for (int i = 0; i < [titles count]; i++) {
        
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i * width4btn, .0f, width4btn, HYSegmentedControl_Height);
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = Define_Tag_add + i;
            [_scrollView addSubview:btn];
            [_array4Btn addObject:btn];
            
            if (i == 0) {
                btn.selected = YES;
            }
        }
        
        //
        //  lineView
        //
        CGFloat height4Line = HYSegmentedControl_Height / 3.0f;
        CGFloat originY = (HYSegmentedControl_Height - height4Line) / 2;
        for (int i = 1; i < [titles count]; i++) {
            UIView *lineView =
                [[UIView alloc] initWithFrame:CGRectMake(i * width4btn - 1.0f, originY, 1.0f, height4Line)];
            lineView.backgroundColor = UIColorFromRGBValue(0xcccccc);
            [_scrollView addSubview:lineView];
        }
        
        //
        //  bottom lineView
        //
        _bottomLineView = [[UIImageView alloc]
            initWithFrame:CGRectMake(5.0f, HYSegmentedControl_Height - 5, width4btn - 10.0f, 5.0f)];
        //        _bottomLineView.backgroundColor = [UIColor yellowColor];
        _bottomLineView.image = [UIImage imageNamed:@"usercenter_userlist_ic_choose"];
        _bottomLineView.contentMode = UIViewContentModeCenter;
        [_scrollView addSubview:_bottomLineView];
        
        [self addSubview:_scrollView];
    }
    return self;
}

//
//  btn clicked
//
- (void)segmentedControlChange:(UIButton *)btn {
    btn.selected = YES;
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    
    CGRect rect4boottomLine = self.bottomLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x + 5;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 &&
        [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        pt.x = btn.frame.origin.x - Min_Width_4_Button * 1.5f;
        canScrolle = YES;
    } else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]) {
        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    } else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2) {
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3
            animations:^{
                _scrollView.contentOffset = pt;
            }
            completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.bottomLineView.frame = rect4boottomLine;
                                 }];
            }];
    } else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.bottomLineView.frame = rect4boottomLine;
                         }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hySegmentedControlSelectAtIndex:)]) {
        [self.delegate hySegmentedControlSelectAtIndex:btn.tag - 1000];
    }
}

- (void)segmentedControlChange:(UIButton *)btn isCallDelegate:(BOOL)isCallDelegate {
    btn.selected = YES;
    for (UIButton *subBtn in self.array4Btn) {
        if (subBtn != btn) {
            subBtn.selected = NO;
        }
    }
    
    CGRect rect4boottomLine = self.bottomLineView.frame;
    rect4boottomLine.origin.x = btn.frame.origin.x + 5;
    
    CGPoint pt = CGPointZero;
    BOOL canScrolle = NO;
    if ((btn.tag - Define_Tag_add) >= 2 && [_array4Btn count] > 4 &&
        [_array4Btn count] > (btn.tag - Define_Tag_add + 2)) {
        pt.x = btn.frame.origin.x - Min_Width_4_Button * 1.5f;
        canScrolle = YES;
    } else if ([_array4Btn count] > 4 && (btn.tag - Define_Tag_add + 2) >= [_array4Btn count]) {
        pt.x = (_array4Btn.count - 4) * Min_Width_4_Button;
        canScrolle = YES;
    } else if (_array4Btn.count > 4 && (btn.tag - Define_Tag_add) < 2) {
        pt.x = 0;
        canScrolle = YES;
    }
    
    if (canScrolle) {
        [UIView animateWithDuration:0.3
            animations:^{
                _scrollView.contentOffset = pt;
            }
            completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     self.bottomLineView.frame = rect4boottomLine;
                                 }];
            }];
    } else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.bottomLineView.frame = rect4boottomLine;
                         }];
    }
    
    if (isCallDelegate && self.delegate &&
        [self.delegate respondsToSelector:@selector(hySegmentedControlSelectAtIndex:)]) {
        [self.delegate hySegmentedControlSelectAtIndex:btn.tag - 1000];
    }
}

// delegete method
- (void)changeSegmentedControlWithIndex:(NSInteger)index isCallDelegate:(BOOL)isCallDelegate {
    if (index > [_array4Btn count] - 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"index 超出范围"
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"ok", nil];
        [alertView show];
        return;
    }
    
    UIButton *btn = [_array4Btn objectAtIndex:index];
    [self segmentedControlChange:btn isCallDelegate:isCallDelegate];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
