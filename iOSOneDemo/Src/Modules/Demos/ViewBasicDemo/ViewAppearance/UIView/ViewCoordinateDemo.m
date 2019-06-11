//
// ViewCoordinateDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#define ABC @"2"

#import "ViewCoordinateDemo.h"

@interface ViewCoordinateDemo ()

@end

@implementation ViewCoordinateDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:ViewCoordinateDemo.class];
}

+ (NSString *)displayName {
    return @"View 坐标系";
}

+ (NSString *)name {
    return @"ViewCoordinateDemo";
}

+ (NSString *)parentName {
    return @"UIViewDemo";
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - < Init Methods >

- (void)initWindow {
    self.title = @"View 坐标系";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {
    
}

- (void)initUI {
//    frame & bounds & center
    FlexLinearLayout *showBox = [self addDemoBoxWithTitle:@"frame & bounds & center"];
    showBox.alignItems = FlexAlignSelf_center;
    
    UIView *stage1View = [UIView new];
    stage1View.flex_layoutHeight = 200;
    stage1View.flex_margin = @[@50,@30];
    stage1View.backgroundColor = [UIColor yellowColor];
    [self addLabelOnView:stage1View withText:@"stage1"];
    [showBox flex_addSubview:stage1View];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(20, 20, 50, 50);
    [self addLabelOnView:view1 withText:@"view1"];
    [stage1View addSubview:view1];
    
    NSMutableString *frameBoxDes = [NSMutableString stringWithFormat:@""];
    [frameBoxDes appendFormat:@"在黄色的stage1上，有一个矩形view1 \nframe: %@ \n", NSStringFromCGRect(view1.frame)];
    [frameBoxDes appendFormat:@"bounds : %@ \n", NSStringFromCGRect(view1.bounds)];
    [frameBoxDes appendFormat:@"center :%@ \n", NSStringFromCGPoint(view1.center)];
    [frameBoxDes appendString:@"这里center的值，表示了它是基于父坐标系的值，表示了View1的中心在父View的什么位置，从而定位这个View。(这里表示在父坐标系中的45,45是View1的中心)"];
    [self addDescriptionOnView:showBox withText:frameBoxDes];
    
    [self addDividerOnView:showBox];
    
//    Bounds 与 Center改变
    UIView *stage2View = [UIView new];
    stage2View.flex_layoutHeight = 200;
    stage2View.flex_margin = @[@50,@30];
    stage2View.backgroundColor = [UIColor yellowColor];
    [self addLabelOnView:stage2View withText:@"stage2"];
    [showBox flex_addSubview:stage2View];
    
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor redColor];
    view2.frame = CGRectMake(50, 50, 100, 100);
    [self addLabelOnView:view2 withText:@"view2"];
    [stage2View addSubview:view2];
    
    UIView *view3 = [UIView new];
    view3.backgroundColor = [UIColor greenColor];
    view3.frame = CGRectInset(view2.bounds, 10, 10);
    [self addLabelOnView:view3 withText:@"view3"];
    [view2 addSubview:view3];
    
    [self addButtonOnView:showBox withText:@"改变view3的bounds的size" block:^(id btn) {
        NSLog(@"ABC is ===> %@", ABC);
        if (view3.bounds.size.width < view2.bounds.size.width) {
            CGRect r = view3.bounds;
            r.size.height += 40;
            r.size.width += 40;
            view3.bounds = r;
            view3.alpha = 0.6;
        } else {
            CGRect r = view3.bounds;
            r.size.height -= 40;
            r.size.width -= 40;
            view3.bounds = r;
            view3.alpha = 1;
        }
    }];
    
    [self addButtonOnView:showBox withText:@"改变view2的bounds的origin" block:^(id btn) {
        CGRect r = view2.bounds;
        r.origin.x += 10;
        r.origin.y += 10;
        view2.bounds = r;
    }];
    [frameBoxDes appendString:@"当我对view2的bounds中origin的x&y各增加10，可以看到view3向左上移动了，因为view2的bounds决定自身的坐标轴，当view2的origin增加10，说明左上的点由(0,0)变成(10,10)，也就是在View2内部，坐标轴整体左上斜移了。因为view3的center点不变，这就会导致view3也跟着往左上斜移。"];
    
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












