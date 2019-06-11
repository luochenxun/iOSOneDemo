//
// XXXXCheckbox.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "XXXXCheckbox.h"
#import "UIButton+EnlargeEdge.h"

@implementation XXXXCheckbox

- (instancetype)initWithTheme:(XXXXAppTheme *)theme{
    if (self = [super initWithTheme:theme]) {
        [self setFlexSize:CGSizeMake(20.0, 20.0)];
        [self setButtonImageWithNormalImage:[UIImage imageNamed:@"UnAgree"]
                             highlightImage:[UIImage imageNamed:@"Agree"]
                              selectedImage:[UIImage imageNamed:@"Agree"]
                               disableImage:nil];
        [self setEnlargeEdgeWithTop:20 withLeft:20 withBottom:20 withRight:20];
    }
    return self;
}


- (void)buttonTarget:(XXXXButton *)button {
    self.selected = !self.selected;
    if(self.block) {
        dispatch_main_async_safe(^{
            self.block(button);
        });
    }
}

@end
