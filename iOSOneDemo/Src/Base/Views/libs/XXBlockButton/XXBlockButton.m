//
//  LLBlockButton.m
//  kidme
//
//  Created by luochenxun on 15/8/12.
//  Copyright (c) 2015年 kacha-mobile. All rights reserved.
//

#import "XXBlockButton.h"

@implementation XXBlockButton

- (void)addTouchOnListenerWithBlock:(LLBlockButtonBlock)block {
     [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.buttonBlock = block;
    [self addTarget:self action:@selector(buttonTarget:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addTouchEventListenerWithBlock:(LLBlockButtonBlock)block {
    self.touchBlock = block;
    [self addTarget:self action:@selector(touchTarget:) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)buttonTarget:(XXBlockButton *)button {
    _buttonBlock(self);
}

- (void)touchTarget:(XXBlockButton *)button {
    _touchBlock(self);
}

- (void)dealloc {
    self.buttonBlock = nil;
    self.touchBlock = nil;
}

@end
