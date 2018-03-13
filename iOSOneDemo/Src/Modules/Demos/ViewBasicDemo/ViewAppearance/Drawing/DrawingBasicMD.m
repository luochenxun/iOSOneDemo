//
//  DrawingBasicMD.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/10.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "DrawingBasicMD.h"

@interface DrawingBasicMD ()

@end

@implementation DrawingBasicMD

+ (void)load {
    [[DemoManager sharedManager] registerDemo:DrawingBasicMD.class];
}

+ (NSString *)displayName {
    return @"2D 绘图总述";
}

+ (NSString *)name {
    return @"DrawingBasicMD";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.1.0";
}


- (void)viewDidLoad {
    self.demoName = @"DrawingBasicMD.md";
    self.demoDesName = @"2D 绘图总述";
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
