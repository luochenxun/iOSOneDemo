//
// ImplicitAnimationDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ImplicitAnimationDemo.h"



@interface ImplicitAnimationDemo ()

@end

@implementation ImplicitAnimationDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ImplicitAnimationDemo.class];
}

+ (NSString *)displayName {
    return @"Layer隐式动画";
}

+ (NSString *)name {
    return [ImplicitAnimationDemo className];
}

+ (NSString *)parentName {
    return @"AnimationDemo";
}

+ (NSString *)prioritySerial {
    return @"1.4.0";
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
    self.title = [ImplicitAnimationDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@" 示例1 - 改变动画属性"];
    
    UIView *viewFrame = [UIView new];
    viewFrame.flexSize = CGSizeMake(400, 100);
    [demo1 flex_addSubview:viewFrame];
    CALayer *animLayer = [[CALayer alloc] init];
    animLayer.backgroundColor = [UIColor yellowColor].CGColor;
    animLayer.frame = CGRectMake(0, 0, 100, 100);
    [viewFrame.layer addSublayer:animLayer];
    
    [self addButtonOnView:demo1 withText:@"隐式改变view背景色与位置" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            animLayer.backgroundColor = [UIColor redColor].CGColor;
            CGPoint p = animLayer.position;
            p.x += 200;
            animLayer.position = p;
        }
        else {
            animLayer.backgroundColor = [UIColor yellowColor].CGColor;
            CGPoint p = animLayer.position;
            p.x -= 200;
            animLayer.position = p;
        }
    }];
    
    // -------  demo2
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"示例2 - 动画事务"];
    
    viewFrame = [UIView new];
    viewFrame.flexSize = CGSizeMake(400, 100);
    [demo2 flex_addSubview:viewFrame];
    animLayer = [[CALayer alloc] init];
    animLayer.backgroundColor = [UIColor yellowColor].CGColor;
    animLayer.frame = CGRectMake(0, 0, 100, 100);
    [viewFrame.layer addSublayer:animLayer];
    
    [self addButtonOnView:demo2 withText:@"修改动画事务duration为2秒" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            [CATransaction setAnimationDuration:2];
            animLayer.backgroundColor = [UIColor redColor].CGColor;
            CGPoint p = animLayer.position;
            p.x += 200;
            animLayer.position = p;
        }
        else {
            [CATransaction setAnimationDuration:2];
            animLayer.backgroundColor = [UIColor yellowColor].CGColor;
            CGPoint p = animLayer.position;
            p.x -= 200;
            animLayer.position = p;
        }
    }];
    
    [self addButtonOnView:demo2 withText:@"使用事务禁止隐式动画" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            [CATransaction setDisableActions:YES];
            animLayer.backgroundColor = [UIColor redColor].CGColor;
            CGPoint p = animLayer.position;
            p.x += 200;
            animLayer.position = p;
        }
        else {
            [CATransaction setDisableActions:YES];
            animLayer.backgroundColor = [UIColor yellowColor].CGColor;
            CGPoint p = animLayer.position;
            p.x -= 200;
            animLayer.position = p;
        }
    }];
    
    [self addButtonOnView:demo2 withText:@"使用动画事务调速Transaction Timing" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            [CATransaction setAnimationDuration:2];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            animLayer.backgroundColor = [UIColor redColor].CGColor;
            CGPoint p = animLayer.position;
            p.x += 200;
            animLayer.position = p;
        }
        else {
            [CATransaction setAnimationDuration:2];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            animLayer.backgroundColor = [UIColor yellowColor].CGColor;
            CGPoint p = animLayer.position;
            p.x -= 200;
            animLayer.position = p;
        }
    }];
    
    
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












