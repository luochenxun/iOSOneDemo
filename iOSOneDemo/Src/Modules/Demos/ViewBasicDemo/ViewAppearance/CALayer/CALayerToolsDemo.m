//
// CALayerToolsDemo.m
// iOSOneDemo
//
// Created by luochenxun(luochenxn@gmail.com) on 2019-06-11
// Copyright (c) 2019年 airone. All rights reserved.

#import "CALayerToolsDemo.h"



@interface CALayerToolsDemo ()

@end

@implementation CALayerToolsDemo


+ (void)load {
    [[DemoManager sharedManager] registerDemo:CALayerToolsDemo.class];
}

+ (NSString *)displayName {
    return @"各种专用图层";
}

+ (NSString *)name {
    return [CALayerToolsDemo className];
}

+ (NSString *)parentName {
    return @"CALayerDemo";
}

+ (NSString *)prioritySerial {
    return @"1.3.0";
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
    self.title = [CALayerToolsDemo displayName];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initEnvironment {

}

- (void)initUI {
    // -------  textLayer
    FlexLinearLayout *demo1 = [self addDemoBoxWithTitle:@" CATextLayer "];

    CATextLayer *tLayer =[CATextLayer layer];
    tLayer.contentsScale = [UIScreen mainScreen].scale;
    tLayer.string = @"CATextLayer 测试一下";
    tLayer.bounds = CGRectMake(0, 0, 300, 20);
    tLayer.fontSize = 14.f; //字体的大小
    tLayer.font = (__bridge CFTypeRef _Nullable)(@"HelveticaNeue-BoldItalic"); //字体的名字 不是 UIFont
    tLayer.alignmentMode = kCAAlignmentCenter; //字体的对齐方式
    tLayer.position = CGPointMake(150, 0);
    tLayer.foregroundColor =[UIColor redColor].CGColor; //字体的颜色
    
    UIView *layerFrame = [UIView new];
    [layerFrame.layer addSublayer:tLayer];
    layerFrame.flexSize = CGSizeMake(300, 200);
    [self addDescriptionOnView:demo1 withText:@"使用 CATextLayer 输出文字："];
    [demo1 flex_addSubview:layerFrame];
    
    
    // -------  shapeLayer
    FlexLinearLayout *demo2 = [self addDemoBoxWithTitle:@" CAShapeLayer "];
    
    [self addDescriptionOnView:demo2 withText:@"使用 CAShapeLayer 在黄色区域中画一个矩形（蓝边框、红填充、上方下圆角）："];
    // CAShapeLayer
    CAShapeLayer *sLayer = [CAShapeLayer layer];
    sLayer.contentsScale = [UIScreen mainScreen].scale;
    sLayer.frame = CGRectMake(0, 0, 150, 150);
    sLayer.backgroundColor = [UIColor yellowColor].CGColor; // 设置 layer背景色
    sLayer.strokeColor = [UIColor blueColor].CGColor; // 设置描边色
    sLayer.fillColor = [UIColor redColor].CGColor; //设置填充色
    sLayer.lineJoin = kCALineJoinRound;
    sLayer.lineCap = kCALineCapRound;
    sLayer.lineWidth = 4;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 10, 100, 100)
                                               byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(10, 10)];
    sLayer.path = path.CGPath;
    
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:sLayer];
    layerFrame.flexSize = CGSizeMake(200, 200);
    [demo2 flex_addSubview:layerFrame];
    
    // -------  gradientLayer
    FlexLinearLayout *demo3 = [self addDemoBoxWithTitle:@"CAGradientLayer"];
    
    // CAGradientLayer
    CAGradientLayer *gLayer = [CAGradientLayer new];
    gLayer.contentsScale = [UIScreen mainScreen].scale;
    gLayer.frame = CGRectMake(0, 0, 100, 100);
    gLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor redColor].CGColor];
    gLayer.type = kCAGradientLayerAxial;
    gLayer.locations = @[@0.0f, @1.0f];
    layerFrame = [UIView new];
    [layerFrame.layer addSublayer:gLayer];
    layerFrame.flexSize = CGSizeMake(100, 100);
    
    [self addDescriptionOnView:demo3 withText:@"使用 CAGradientLayer 画一个渐变图层："];
    [demo3 flex_addSubview:layerFrame];
    
    
    
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












