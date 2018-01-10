//
//  XXTextAlertView.m
//  XXXX
//
//  Created by luochenxun on 15/12/31.
//  Copyright © 2015年 Kacha-Mobile. All rights reserved.
//

#import "XXTextAlertView.h"

#define kXXTextAlertViewWidth 210
#define kXXTextAlertViewTextViewHeight 78
#define kXXTextAlertViewTextViewWidth kXXTextAlertViewWidth

@implementation XXTextAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil] ) {
    
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kXXTextAlertViewTextViewWidth, kXXTextAlertViewTextViewHeight)];
        [self addSubview:_textView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]] ||
            [view isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
            CGRect btnBounds = view.frame;
            btnBounds.origin.y = kXXTextAlertViewTextViewHeight + 7;
            view.frame = btnBounds;
        }
    }
    
    // 定义AlertView的大小
    CGRect bounds = self.frame;
    bounds.size.height = 260;
    self.frame = bounds;
}

@end
