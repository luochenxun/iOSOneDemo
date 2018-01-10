//
//  UIKitButtonDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/3.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "UIKITButtonDemo.h"


@interface UIKitButtonDemo ()

#pragma mark - < Private properties >

#pragma mark - < UI Controls >

@end

@implementation UIKitButtonDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIKitButtonDemo.class];
}

+ (NSString *)displayName {
    return @"Button";
}

+ (NSString *)name {
    return @"UIKitButtonDemo";
}

+ (NSString *)parentName {
    return @"XXXXUIKitDemo";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEnvironment];
    [self initWindow];
    [self initUI];
    [self initAction];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = @"自定义Button控件 ";
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
    
//    XXXXButton *secondBtn = [XXXXButton buttonWithType:XXXXButtonTypeCheckbox];
//    secondBtn.flexSize = CGSizeMake(220, 40);
//    [secondBtn setButtonText:@"次级按钮" onPressBlock:^(id btn) {
//        NSLog(@"Click secondary button");
//    }];
//    [buttonBox flex_addSubview:secondBtn];
    
    [buttonBox adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

- (void)loadData {
    
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >


@end



