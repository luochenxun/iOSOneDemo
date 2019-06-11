//
// ViewHierarchyDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#define ABC @"1"

#import "ViewHierarchyDemo.h"

@interface ViewHierarchyDemo ()

@end

@implementation ViewHierarchyDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewHierarchyDemo.class];
}

+ (NSString *)displayName {
    return @"View 层次";
}

+ (NSString *)name {
    return @"ViewHierarchyDemo";
}

+ (NSString *)parentName {
    return @"UIViewDemo";
}

+ (NSString *)prioritySerial {
    return @"1.2";
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
    self.title = @"View 层次";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
    FlexLinearLayout *showBox = [self addDemoBoxWithTitle:@"View层次关系示例"];
    showBox.alignItems = FlexAlignSelf_center;
    
    UIView *view1 = [UIView new];
    view1.flex_layoutHeight = 100;
    view1.flex_margin = @[@50,@30];
    view1.backgroundColor = XXXX_COLOR_HEX(0xff0000);
    [self addLabelOnView:view1 withText:@"view1"];
    [showBox flex_addSubview:view1];
    
    UIView *view2 = [UIView new];
    view2.frame = CGRectMake(-20, 60, 50, 50);
    view2.backgroundColor = XXXX_COLOR_HEX(0xffff00);
    [self addLabelOnView:view2 withText:@"view2"];
    [view1 addSubview:view2];
    
    UIView *view3 = [UIView new];
    view3.frame = CGRectMake(20, 30, 70, 70);
    view3.backgroundColor = XXXX_COLOR_HEX(0x0000ff);
    [self addLabelOnView:view3 withText:@"view3" color:[UIColor whiteColor]];
    [view2 addSubview:view3];
    
    UIView *view4 = [UIView new];
    view4.frame = CGRectMake(30, 60, 50, 60);
    view4.backgroundColor = XXXX_COLOR_HEX(0x2246ff);
    [self addLabelOnView:view4 withText:@"view4" color:[UIColor whiteColor]];
    [view2 addSubview:view4];
    
    [self addDividerOnView:showBox withMargin:@[@15,@60,@15,@0]];
    [self addDescriptionOnView:showBox withText:@"在上面的示例中，View2是View1的subview，View3、View4是View2的subview。"];
    [self addButtonOnView:showBox withText:@"隐藏/显示view2" block:^(id btn) {
        view2.hidden = !view2.isHidden;
        NSLog(@"ABC is ===> %@", ABC);
    }];
    
    [self addButtonOnView:showBox withText:@"toggle view2 clipsToBounds" block:^(id btn) {
        view2.clipsToBounds = !view2.clipsToBounds;
    }];
    
    [self addButtonOnView:showBox withText:@"修改View3的order到最上层" block:^(id btn) {
        [view2 bringSubviewToFront:view3];
    }];
    
    [self addButtonOnView:showBox withText:@"修改View4的order到最上层" block:^(id btn) {
        [view2 bringSubviewToFront:view4];
    }];
    
    [self addButtonOnView:showBox withText:@"修改View2的透明度" block:^(id btn) {
        view2.alpha = (view2.alpha <= 0.5)? 1: 0.5;
    }];
    
    [self addButtonOnView:showBox withText:@"修改View3的透明度" block:^(id btn) {
        view3.alpha = (view3.alpha <= 0.5)? 1: 0.5;
    }];
    
    [self addButtonOnView:showBox withText:@"修改View1的frame" block:^(id btn) {
        CGRect frame1 = view1.frame;
        frame1.size.width = (frame1.size.width / 2);
        frame1.size.height = (frame1.size.height / 2);
        frame1.origin.x += 50;
        view1.frame = frame1;
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












