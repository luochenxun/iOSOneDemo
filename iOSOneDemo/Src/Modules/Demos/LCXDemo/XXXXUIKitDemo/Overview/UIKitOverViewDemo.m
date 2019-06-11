//
// UIKitOverViewDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "UIKitOverViewDemo.h"


@interface UIKitOverViewDemo ()

#pragma mark - < Private properties >

#pragma mark - < UI Controls >

@end

@implementation UIKitOverViewDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:UIKitOverViewDemo.class];
}

+ (NSString *)displayName {
    return @"OverView";
}

+ (NSString *)name {
    return @"UIKitOverViewDemo";
}

+ (NSString *)parentName {
    return @"XXXXUIKitDemo";
}

+ (NSString *)prioritySerial {
    return @"1.1";
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
    self.title = @"自定义控件总览";
}

- (void)initEnvironment {
}

- (void)initUI {
    //---- 自定义按钮
    FlexLinearLayout *buttonBox = [self addDemoBoxWithTitle:@"按钮"];
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
    
    
    //---- 自定义Label
    FlexLinearLayout *labelBox = [self addDemoBoxWithTitle:@"Label"];
    
    NSString *longText = @"第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。第一段长文字，使用了默认的行间距，0.5倍行间距。（完）";
    XXXXLabel *defaultLabel = [XXXXLabel labelWithType:XXXXLabelTypeDefault
                                           text:longText font:kAppFont.h4 color:kAppColor.content];
    defaultLabel.backgroundColor = [UIColor yellowColor];
    defaultLabel.flex_margin = @[@15,@10];
    defaultLabel.numberOfLines = 0;
    defaultLabel.flex_alignSelf = FlexAlignSelf_stretch;
    [labelBox flex_addSubview:defaultLabel];

    // 最后更新布局
    [self.outerBox flex_updateLayout];
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



