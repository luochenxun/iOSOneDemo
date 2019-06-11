//
// ChangeIconDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ChangeIconDemo.h"

@interface ChangeIconDemo ()

@end

@implementation ChangeIconDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ChangeIconDemo.class];
}

+ (NSString *)displayName {
    return @"动态替换App图标";
}

+ (NSString *)name {
    return @"ChangeIconDemo";
}

+ (NSString *)parentName {
    return @"IOSSpecialDemo";
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
    self.title = @"动态替换App图标";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    FlexLinearLayout *buttonBox = [self addDemoBoxWithTitle:@"各种样式的按钮"];
    buttonBox.alignItems = FlexAlignItems_center;
    
    XXXXButton *defaultBtn = [XXXXButton buttonWithType:XXXXButtonTypeDefault];
    defaultBtn.flexSize = CGSizeMake(220, 40);
    [defaultBtn setButtonText:@"默认样式" onPressBlock:^(id btn) {
        NSLog(@"Click default button");
    }];
    [buttonBox flex_addSubview:defaultBtn];
    
    XXXXButton *secondBtn = [XXXXButton buttonWithType:XXXXButtonTypeSecondary];
    secondBtn.flexSize = CGSizeMake(220, 40);
    secondBtn.flex_marginTop = 15;
    [secondBtn setButtonText:@"次级按钮" onPressBlock:^(id btn) {
        NSLog(@"Click secondary button");
    }];
    [buttonBox flex_addSubview:secondBtn];
    
    [buttonBox adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >

@end
