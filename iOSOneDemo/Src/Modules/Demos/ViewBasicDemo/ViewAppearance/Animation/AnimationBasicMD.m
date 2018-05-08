//
//  AnimationBasicMD.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/10.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
