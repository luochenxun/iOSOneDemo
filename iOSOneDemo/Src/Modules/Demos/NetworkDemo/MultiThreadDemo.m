//
//  MultiThreadDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "MultiThreadDemo.h"


@interface MultiThreadDemo ()

@end

@implementation MultiThreadDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:MultiThreadDemo.class];
}

+ (NSString *)displayName {
    return @"多线程编程技术";
}

+ (NSString *)name {
    return @"MultiThreadDemo";
}

+ (NSString *)parentName {
    return @"NetworkDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1.0";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = [MultiThreadDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    // -------  demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"demo1"];
    
    [self.outerBox flex_updateLayout];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >

#pragma mark - < Main Logic >

#pragma mark - < Delegate Methods >

#pragma mark - < Private Methods >

#pragma mark - < Lazy Initialize Methods >


@end












