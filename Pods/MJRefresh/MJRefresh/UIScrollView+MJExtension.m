//
// UIScrollView+MJExtension.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UIScrollView+MJExtension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (MJExtension)

static BOOL gt_ios_11_;
+ (void)load
{
    // 缓存判断值
    gt_ios_11_ = [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending;
}

- (UIEdgeInsets)mj_inset
{
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setMj_insetT:(CGFloat)mj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_insetT;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetT
{
    return self.mj_inset.top;
}

- (void)setMj_insetB:(CGFloat)mj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_insetB;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetB
{
    return self.mj_inset.bottom;
}

- (void)setMj_insetL:(CGFloat)mj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_insetL;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetL
{
    return self.mj_inset.left;
}

- (void)setMj_insetR:(CGFloat)mj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_insetR;
#ifdef __IPHONE_11_0
    if (gt_ios_11_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)mj_insetR
{
    return self.mj_inset.right;
}

- (void)setMj_offsetX:(CGFloat)mj_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = mj_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetX
{
    return self.contentOffset.x;
}

- (void)setMj_offsetY:(CGFloat)mj_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = mj_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)mj_offsetY
{
    return self.contentOffset.y;
}

- (void)setMj_contentW:(CGFloat)mj_contentW
{
    CGSize size = self.contentSize;
    size.width = mj_contentW;
    self.contentSize = size;
}

- (CGFloat)mj_contentW
{
    return self.contentSize.width;
}

- (void)setMj_contentH:(CGFloat)mj_contentH
{
    CGSize size = self.contentSize;
    size.height = mj_contentH;
    self.contentSize = size;
}

- (CGFloat)mj_contentH
{
    return self.contentSize.height;
}
@end
#pragma clang diagnostic pop
