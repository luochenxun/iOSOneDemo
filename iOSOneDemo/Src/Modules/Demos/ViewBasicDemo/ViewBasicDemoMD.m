//
// ViewBasicDemoMD.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ViewBasicDemoMD.h"

@interface ViewBasicDemoMD ()

@end

@implementation ViewBasicDemoMD

+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewBasicDemoMD.class];
}

+ (NSString *)displayName {
    return @"View 基础说明";
}

+ (NSString *)name {
    return @"ViewBasicDemoMD";
}

+ (NSString *)parentName {
    return @"ViewBasicDemo";
}

+ (NSString *)prioritySerial {
    return @"1.0";
}


- (void)viewDidLoad {
    self.demoName = @"ViewBasicDemoMD.md";
    self.demoDesName = @"View基础说明";
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
