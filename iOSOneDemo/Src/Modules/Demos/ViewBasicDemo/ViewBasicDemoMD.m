//
//  ViewBasicDemoMD.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/10.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

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

+ (DemoPriority)priority {
    return DemoPriorityHight;
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
