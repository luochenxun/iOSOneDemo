//
// AnimationBasicMD.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "AnimationBasicMD.h"

@interface AnimationBasicMD ()

@end

@implementation AnimationBasicMD

+ (void)load {
    [[DemoManager sharedManager] registerDemo:AnimationBasicMD.class];
}

+ (NSString *)displayName {
    return @"动画 - 概述";
}

+ (NSString *)name {
    return @"AnimationBasicMD";
}

+ (NSString *)parentName {
    return @"AnimationDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1.0";
}


- (void)viewDidLoad {
    self.demoName = @"AnimationBasicMD.md";
    self.demoDesName = AnimationBasicMD.displayName;
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
