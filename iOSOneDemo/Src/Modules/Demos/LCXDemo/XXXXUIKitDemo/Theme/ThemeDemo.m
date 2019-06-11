//
// ThemeDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ThemeDemo.h"


@interface ThemeDemo ()

#pragma mark - < Private properties >

#pragma mark - < UI Controls >

@end

@implementation ThemeDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ThemeDemo.class];
}

+ (NSString *)displayName {
    return @"多主题Demo";
}

+ (NSString *)name {
    return @"ThemeDemo";
}

+ (NSString *)parentName {
    return @"XXXXUIKitDemo";
}

+ (NSString *)prioritySerial {
    return @"1.3";
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
    FlexLinearLayout *buttonBox = [self addDemoBoxWithTitle:@"点击按钮更新主题"];
    buttonBox.alignItems = FlexAlignItems_center;
    
    XXXXButton *defaultBtn = [XXXXButton buttonWithType:XXXXButtonTypeDefault];
    defaultBtn.flexSize = CGSizeMake(220, 40);
    [defaultBtn setButtonText:@"默认样式" onPressBlock:^(id btn) {
        [XXXXAppContext sharedInstance].theme = [XXXXAppTheme sharedInstance];
        [[XXXXAppContext sharedInstance].theme switchAppThemeWithComplete:^{
            ;
        }];
    }];
    [buttonBox flex_addSubview:defaultBtn];
    
    XXXXButton *secondBtn = [XXXXButton buttonWithType:XXXXButtonTypeSecondary];
    secondBtn.flexSize = CGSizeMake(220, 40);
    secondBtn.flex_marginTop = 15;
    
    [secondBtn setButtonText:@"我的样式" onPressBlock:^(id btn) {
        [XXXXAppContext sharedInstance].theme = [MyStyleTheme sharedInstance];
        [[XXXXAppContext sharedInstance].theme switchAppThemeWithComplete:^{
            ;
        }];
    }];
    [buttonBox flex_addSubview:secondBtn];

    
    [buttonBox adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

- (void)loadData {
    
}


#pragma mark - < Public Methods >


#pragma mark - < Main Logic >

- (void)layoutSubViewsOFView:(UIView *)view {
    [view setNeedsDisplay];
    [view setNeedsLayout];
    [view layoutIfNeeded];
    if (view.subviews.count > 0) {
        for (UIView * viewItem in view.subviews) {
            [self layoutSubViewsOFView:viewItem];
        }
    }
}


#pragma mark - < Delegate Methods >


#pragma mark - < Private Methods >


#pragma mark - < Lazy Initialize Methods >


@end



