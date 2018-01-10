//
//  UIButton+EnlargeEdge.h
//  jiayoubao
//
//  Created by yuanzhiyun on 14-8-1.
//  Copyright (c) 2014年 jtjr99. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeEdge)

- (void)setEnlargeEdgeWithSize:(CGFloat)size;
- (void)setEnlargeEdgeWithTop:(CGFloat)top withLeft:(CGFloat)left withBottom:(CGFloat)bottom withRight:(CGFloat)right;

@end
