//
//  LanguageDemoMD.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/10.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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
