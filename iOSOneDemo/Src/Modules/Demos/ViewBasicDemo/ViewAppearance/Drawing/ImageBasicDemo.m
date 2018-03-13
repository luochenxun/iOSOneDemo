//
//  ImageBasicDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "ImageBasicDemo.h"


@interface ImageBasicDemo ()

@end

@implementation ImageBasicDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ImageBasicDemo.class];
}

+ (NSString *)displayName {
    return @"Image 基础";
}

+ (NSString *)name {
    return @"ImageBasicDemo";
}

+ (NSString *)parentName {
    return @"DrawingDemo";
}

+ (NSString *)prioritySerial {
    return @"2.4.1";
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
    self.title = @"Image 基础";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    //-------    CGImage
    FlexLinearLayout *cgImgBox = [self addDemoBoxWithTitle:@" CGImage "];
    cgImgBox.alignItems = FlexAlignItems_center;
    
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












