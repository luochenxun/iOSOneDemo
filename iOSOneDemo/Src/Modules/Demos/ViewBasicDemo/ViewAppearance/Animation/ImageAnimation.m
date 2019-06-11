//
// ImageAnimation.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "ImageAnimation.h"


@interface ImageAnimation ()

@end

@implementation ImageAnimation


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ImageAnimation.class];
}

+ (NSString *)displayName {
    return @"图片动画 Image Animation";
}

+ (NSString *)name {
    return @"ImageAnimation";
}

+ (NSString *)parentName {
    return @"AnimationDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2.0";
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
    self.title = [ImageAnimation displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  demo1
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@"UIImageView动画(animationImages属性)"];
    
    NSMutableArray<UIImage *> *images = [NSMutableArray arrayWithCapacity:10];
    for (int i = 1; i <= 5; i ++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [images addObject:img];
    }
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_1"]];
    iv.flexSize = CGSizeMake(50, 70);
    [self addDescriptionOnView:demo1 withText:@"设置 animationImages 动画："];
    [demo1 flex_addSubview:iv];
    [self addButtonOnView:demo1 withText:@"开始UIImageView动画" block:^(UIView *btn) {
        btn.tag ^= 1;
        if (btn.tag == 1) {
            iv.animationImages = images;
            iv.animationDuration = 1;
            iv.animationRepeatCount = 0; // 无限重复
            [iv startAnimating];
        }else {
            [iv stopAnimating];
        }
    }];

    
    
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@"UIImage动画(animation Image)"];
    // animation image
    UIImage *animImg = [UIImage animatedImageWithImages:images duration:0.5];
    iv = [[UIImageView alloc] initWithImage:animImg];
    iv.flexSize = CGSizeMake(50, 70);
    [self addDescriptionOnView:demo2 withText:@"animation image 一经赋给imageView就开启无限动画："];
    [demo2 flex_addSubview:iv];
    
    
    
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












