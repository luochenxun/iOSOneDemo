//
//  EncodeDemo.m
//  iOSOneDemo
//
//  Created by luochenxun on 2018/1/6.
//  Copyright © 2018年 Kacha-Mobile. All rights reserved.
//

#import "EncodeDemo.h"

@interface EncodeDemo ()

@end

@implementation EncodeDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:EncodeDemo.class];
}

+ (NSString *)displayName {
    return @"编码 Demo";
}

+ (NSString *)name {
    return @"EncodeDemo";
}

+ (NSString *)parentName {
    return @"FrameworkDemo";
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
    self.title = @"编码";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    FlexLinearLayout *box = [self addDemoBoxWithTitle:@"各数据类型转换"];
    
    NSString *aString = @"1234";
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"字符串(%@)转成 NSData",aString]];
    
    NSData *aData = [aString dataUsingEncoding: NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"输出 NSData：%@",aData]];
    
    aString = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
    [self addDescriptionOnView:box withText:[NSString stringWithFormat:@"将NSData转回NSString：%@",aString]];
    
    
    
    [box adjustLayoutHeightBySubviews];
}

- (void)initAction {
    
}

#pragma mark - < Public Methods >
#pragma mark - < Main Logic >
#pragma mark - < Delegate Methods >
#pragma mark - < Private Methods >
#pragma mark - < Lazy Initialize Methods >


@end













