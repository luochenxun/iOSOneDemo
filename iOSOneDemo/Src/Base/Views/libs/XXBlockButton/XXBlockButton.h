//
// XXBlockButton.h
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import <UIKit/UIKit.h>

@class XXBlockButton;

typedef void (^LLBlockButtonBlock)(XXBlockButton *button);

@interface XXBlockButton : UIButton

@property(nonatomic, copy) LLBlockButtonBlock buttonBlock;
@property(nonatomic, copy) LLBlockButtonBlock touchBlock;

- (void)addTouchOnListenerWithBlock:(LLBlockButtonBlock)block;
- (void)addTouchEventListenerWithBlock:(LLBlockButtonBlock)block;

@end
