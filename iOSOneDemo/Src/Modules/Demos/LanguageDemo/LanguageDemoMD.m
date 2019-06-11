//
// LanguageDemoMD.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "LanguageDemoMD.h"

@interface LanguageDemoMD ()

@end

@implementation LanguageDemoMD

+ (void)load {
    [[DemoManager sharedManager] registerDemo:LanguageDemoMD.class];
}

+ (NSString *)displayName {
    return @"语言";
}

+ (NSString *)name {
    return @"LanguageDemoMD";
}

+ (NSString *)parentName {
    return @"LanguageDemo";
}

+ (NSString *)prioritySerial {
    return @"1.0";
}


- (void)viewDidLoad {
    self.demoName = @"LanguageDemoMD.md";
    self.demoDesName = @"语言";
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
